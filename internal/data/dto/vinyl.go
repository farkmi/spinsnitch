package dto

import (
	"time"

	"github.com/farkmi/spinsnitch-server/internal/models"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/farkmi/spinsnitch-server/internal/util/publicurl"
	"github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag"
)

type VinylRecord struct {
	ID         int
	Title      string
	Artist     string
	DiscogsID  int
	CreatedAt  time.Time
	Year       int
	CoverImage string
	ThumbImage string
	Genres     []string
	Styles     []string
}

func (v *VinylRecord) ToTypes(baseURL string) *types.VinylRecord {
	return &types.VinylRecord{
		ID:         swag.Int64(int64(v.ID)),
		Title:      swag.String(v.Title),
		Artist:     swag.String(v.Artist),
		DiscogsID:  swag.Int64(int64(v.DiscogsID)),
		CreatedAt:  strfmt.DateTime(v.CreatedAt),
		Year:       int64(v.Year),
		CoverImage: publicurl.Enrich(baseURL, v.CoverImage),
		ThumbImage: publicurl.Enrich(baseURL, v.ThumbImage),
		Genres:     v.Genres,
		Styles:     v.Styles,
	}
}

// Slice wrapper for converting multiple records
type VinylRecordSlice []*VinylRecord

func (s VinylRecordSlice) ToTypes(baseURL string) []*types.VinylRecord {
	result := make([]*types.VinylRecord, len(s))
	for i, v := range s {
		result[i] = v.ToTypes(baseURL)
	}
	return result
}

func (s VinylRecordSlice) ToSearchTypes(baseURL string) []*types.VinylSearchResult {
	result := make([]*types.VinylSearchResult, len(s))
	for i, vinyl := range s {
		result[i] = &types.VinylSearchResult{
			DiscogsID:  swag.Int64(int64(vinyl.DiscogsID)),
			Title:      swag.String(vinyl.Title),
			Artist:     swag.String(vinyl.Artist),
			CoverImage: publicurl.Enrich(baseURL, vinyl.CoverImage),
			ThumbImage: publicurl.Enrich(baseURL, vinyl.ThumbImage),
			Year:       int64(vinyl.Year),
			Genres:     vinyl.Genres,
			Styles:     vinyl.Styles,
		}
	}
	return result
}

// FromModel converts a SQLBoiler model to a DTO
func VinylRecordFromModel(model *models.VinylRecord) *VinylRecord {
	return &VinylRecord{
		ID:         model.ID,
		Title:      model.Title,
		Artist:     model.Artist,
		DiscogsID:  model.DiscogsID,
		CreatedAt:  model.CreatedAt,
		Year:       model.Year.Int,
		CoverImage: model.CoverImage.String,
		ThumbImage: model.ThumbImage.String,
		Genres:     model.Genres,
		Styles:     model.Styles,
	}
}

// FromModelSlice converts a slice of SQLBoiler models
func VinylRecordSliceFromModels(ms models.VinylRecordSlice) VinylRecordSlice {
	result := make(VinylRecordSlice, len(ms))
	for i, m := range ms {
		result[i] = VinylRecordFromModel(m)
	}
	return result
}

type MistreatedRecord struct {
	Title        string
	Artist       string
	SideLabel    string
	NeglectScore float64
	LastPlayed   time.Time
}

func (m *MistreatedRecord) ToTypes() *types.MistreatedRecord {
	return &types.MistreatedRecord{
		Title:        m.Title,
		Artist:       m.Artist,
		SideLabel:    m.SideLabel,
		NeglectScore: float32(m.NeglectScore),
		LastPlayed:   strfmt.DateTime(m.LastPlayed),
	}
}

type MistreatedRecordSlice []*MistreatedRecord

func (s MistreatedRecordSlice) ToTypes() []*types.MistreatedRecord {
	result := make([]*types.MistreatedRecord, len(s))
	for i, m := range s {
		result[i] = m.ToTypes()
	}
	return result
}

type TrackPlay struct {
	ID       int
	Title    string
	Artist   string
	PlayedAt time.Time
}

func (p *TrackPlay) ToTypes() *types.TrackPlay {
	return &types.TrackPlay{
		ID:       int64(p.ID),
		Title:    p.Title,
		Artist:   p.Artist,
		PlayedAt: strfmt.DateTime(p.PlayedAt),
	}
}

type RecentPlaysResponse struct {
	Plays []TrackPlay
}

func (r *RecentPlaysResponse) ToTypes() *types.RecentPlaysResponse {
	plays := make([]*types.TrackPlay, len(r.Plays))
	for i, p := range r.Plays {
		plays[i] = p.ToTypes()
	}
	return &types.RecentPlaysResponse{
		Plays: plays,
	}
}
