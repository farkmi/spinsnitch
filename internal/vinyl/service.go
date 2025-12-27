package vinyl

import (
	"context"
	"database/sql"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"time"

	"github.com/aarondl/null/v8"
	"github.com/aarondl/sqlboiler/v4/boil"
	"github.com/aarondl/sqlboiler/v4/queries/qm"
	"github.com/aarondl/sqlboiler/v4/types"
	"github.com/farkmi/spinsnitch-server/internal/data/dto"
	"github.com/farkmi/spinsnitch-server/internal/discogs"
	"github.com/farkmi/spinsnitch-server/internal/models"
	"github.com/friendsofgo/errors"
)

var (
	ErrTrackNotFound = errors.New("track not found in collection")
)

const (
	artistTitleParts = 2
	sideRegexMatches = 2
	hoursPerDay      = 24
	neglectThreshold = 30.0
)

type Service struct {
	db            *sql.DB
	discogsClient *discogs.Client
}

func NewService(db *sql.DB, discogsClient *discogs.Client) *Service {
	return &Service{
		db:            db,
		discogsClient: discogsClient,
	}
}

func (s *Service) ListVinyls(ctx context.Context) (dto.VinylRecordSlice, error) {
	records, err := models.VinylRecords().All(ctx, s.db)
	if err != nil {
		return nil, err
	}
	return dto.VinylRecordSliceFromModels(records), nil
}

func (s *Service) SearchVinyls(ctx context.Context, query string) (dto.VinylRecordSlice, error) {
	results, err := s.discogsClient.Search(ctx, query)
	if err != nil {
		return nil, err
	}

	// Map Discogs Search Results to VinylRecord DTOs
	// Note: Search results don't have full details (tracks etc), just basic info.
	// Also "Artist" field needs parsing from "Artist - Title" format usually found in Title field of search results
	// But SearchResult struct I defined has just string Title.
	// Let's do a best effort mapping.

	dtos := make(dto.VinylRecordSlice, len(results))
	for i, res := range results {
		// Simple parsing: "Artist - Title"
		parts := strings.SplitN(res.Title, " - ", artistTitleParts)
		artist := "Unknown"
		title := res.Title
		if len(parts) == artistTitleParts {
			artist = parts[0]
			title = parts[1]
		}

		dtos[i] = &dto.VinylRecord{
			DiscogsID: res.ID,
			Title:     title,
			Artist:    artist,
			// ID and CreatedAt are 0/empty as it's not in DB yet
		}
	}

	return dtos, nil
}

func (s *Service) AddVinyl(ctx context.Context, discogsID int) (*dto.VinylRecord, error) {
	// 1. Fetch from Discogs
	release, err := s.discogsClient.GetRelease(ctx, discogsID)
	if err != nil {
		return nil, errors.Wrap(err, "failed to fetch release from discogs")
	}

	// 2. Download Cover Image (Best Effort)
	coverPath := s.downloadAndSaveCover(ctx, release, discogsID)

	// 3. Map to local models
	artistName := "Unknown Artist"
	if len(release.Artists) > 0 {
		artistName = release.Artists[0].Name
	}

	tx, err := s.db.BeginTx(ctx, nil)
	if err != nil {
		return nil, errors.Wrap(err, "failed to begin transaction")
	}
	defer func() { _ = tx.Rollback() }()

	record := &models.VinylRecord{
		Title:     release.Title,
		Artist:    artistName,
		DiscogsID: discogsID,
		Year:      null.IntFrom(release.Year),
		Genres:    types.StringArray(release.Genres),
		Styles:    types.StringArray(release.Styles),
	}
	if coverPath != "" {
		record.CoverImage = null.StringFrom(coverPath)
		record.ThumbImage = null.StringFrom(coverPath) // reusing cover for thumb for now
	}

	if err := record.Insert(ctx, tx, boil.Infer()); err != nil {
		return nil, errors.Wrap(err, "failed to insert vinyl record")
	}

	// 4. Process Tracks and Sides
	// Logic to group tracks by side based on position (A1, A2, B1, etc.)
	sideMap := make(map[string]*models.VinylSide)

	sideRegex := regexp.MustCompile(`^([A-Z]+)\d*$`)

	for _, t := range release.Tracklist {
		matches := sideRegex.FindStringSubmatch(t.Position)
		if len(matches) < sideRegexMatches {
			continue
		}
		sideLabel := matches[1]

		side, exists := sideMap[sideLabel]
		if !exists {
			side = &models.VinylSide{
				VinylRecordID: record.ID,
				SideLabel:     sideLabel,
			}
			if err := side.Insert(ctx, tx, boil.Infer()); err != nil {
				return nil, errors.Wrap(err, "failed to insert vinyl side")
			}
			sideMap[sideLabel] = side
		}

		track := &models.Track{
			VinylSideID: side.ID,
			Title:       t.Title,
			Position:    t.Position,
			Duration:    null.StringFrom(t.Duration),
		}
		if err := track.Insert(ctx, tx, boil.Infer()); err != nil {
			return nil, errors.Wrap(err, "failed to insert track")
		}
	}

	if err := tx.Commit(); err != nil {
		return nil, errors.Wrap(err, "failed to commit transaction")
	}

	return dto.VinylRecordFromModel(record), nil
}

func (s *Service) RegisterPlay(ctx context.Context, artist, title string) error {
	// 1. Find the track in our DB
	track, err := models.Tracks(
		qm.InnerJoin("vinyl_sides s on s.id = tracks.vinyl_side_id"),
		qm.InnerJoin("vinyl_records r on r.id = s.vinyl_record_id"),
		qm.Where("LOWER(tracks.title) = ? AND LOWER(r.artist) = ?", strings.ToLower(title), strings.ToLower(artist)),
		qm.Load(models.TrackRels.VinylSide),
	).One(ctx, s.db)

	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return ErrTrackNotFound
		}
		return errors.Wrap(err, "failed to find track")
	}

	// 2. Update Play Count on the Side
	side := track.R.VinylSide
	side.PlayCount++
	side.LastPlayedAt = null.TimeFrom(time.Now())

	if _, err := side.Update(ctx, s.db, boil.Infer()); err != nil {
		return errors.Wrap(err, "failed to update side play stats")
	}

	return nil
}

func (s *Service) GetMistreated(ctx context.Context) (dto.MistreatedRecordSlice, error) {
	// NeglectScore = DaysOwned / (PlayCount + 1)
	// DaysOwned = Now - CreatedAt

	sides, err := models.VinylSides(
		qm.Load(models.VinylSideRels.VinylRecord),
	).All(ctx, s.db)
	if err != nil {
		return nil, err
	}

	var results dto.MistreatedRecordSlice
	now := time.Now()

	for _, side := range sides {
		if side.R == nil || side.R.VinylRecord == nil {
			continue
		}
		record := side.R.VinylRecord

		daysOwned := now.Sub(record.CreatedAt).Hours() / hoursPerDay
		if daysOwned < 1 {
			daysOwned = 1
		}

		score := daysOwned / float64(side.PlayCount+1)

		if score > neglectThreshold {
			lastPlayed := time.Time{}
			if side.LastPlayedAt.Valid {
				lastPlayed = side.LastPlayedAt.Time
			}

			results = append(results, &dto.MistreatedRecord{
				Title:        record.Title,
				Artist:       record.Artist,
				SideLabel:    side.SideLabel,
				NeglectScore: score,
				LastPlayed:   lastPlayed,
			})
		}
	}

	return results, nil
}

func (s *Service) downloadAndSaveCover(ctx context.Context, release *discogs.Release, discogsID int) string {
	if len(release.Images) == 0 {
		return ""
	}

	imageURL := release.Images[0].URI
	if imageURL == "" {
		return ""
	}

	data, err := s.discogsClient.DownloadImage(ctx, imageURL)
	if err != nil {
		return ""
	}

	// Save to /app/data/public/covers/{id}.jpg
	saveDir := "/app/data/public/covers"
	if err := os.MkdirAll(saveDir, 0755); err != nil {
		return ""
	}

	filename := fmt.Sprintf("%d.jpg", discogsID)
	fullPath := filepath.Join(saveDir, filename)

	// #nosec G306 - Publicly readable images are intended
	if err := os.WriteFile(fullPath, data, 0644); err != nil {
		return ""
	}

	return fmt.Sprintf("/static/covers/%s", filename)
}
