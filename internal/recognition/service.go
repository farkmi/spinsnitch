package recognition

import (
	"context"
	"fmt"
	"io"
	"net/url"

	"github.com/farkmi/spinsnitch-server/internal/config"
	"github.com/farkmi/spinsnitch-server/internal/data/dto"
	"github.com/farkmi/spinsnitch-server/internal/recognizer/client"
	"github.com/farkmi/spinsnitch-server/internal/recognizer/client/operations"
	"github.com/go-openapi/runtime"
	httptransport "github.com/go-openapi/runtime/client"
	"github.com/go-openapi/strfmt"
	"github.com/rs/zerolog/log"
)

type Service struct {
	config config.Recognizer
}

func NewService(cfg config.Recognizer) *Service {
	return &Service{
		config: cfg,
	}
}

func (s *Service) Recognize(ctx context.Context, file io.ReadCloser, filename string) (*dto.RecognitionResult, error) {
	u, err := url.Parse(s.config.BaseURL)
	if err != nil {
		log.Error().Err(err).Msg("Failed to parse recognizer base URL")
		return nil, fmt.Errorf("failed to parse recognizer base URL: %w", err)
	}

	transport := httptransport.New(u.Host, u.Path, []string{u.Scheme})
	c := client.New(transport, strfmt.Default)

	params := operations.NewRecognizeSongRecognizePostParamsWithContext(ctx)
	params.File = runtime.NamedReader(filename, file)

	resp, err := c.Operations.RecognizeSongRecognizePost(params)
	if err != nil {
		log.Error().Err(err).Msg("Recognition request failed")
		return nil, fmt.Errorf("recognition request failed: %w", err)
	}

	payload := resp.GetPayload()
	if payload == nil || payload.Status != "success" || payload.Track == nil {
		log.Debug().Msg("Recognition failed or returned no track")
		return &dto.RecognitionResult{
			Success: false,
		}, nil
	}

	log.Info().
		Str("artist", payload.Track.Subtitle).
		Str("title", payload.Track.Title).
		Msg("Song recognized successfully")

	return &dto.RecognitionResult{
		Artist:    payload.Track.Subtitle,
		Title:     payload.Track.Title,
		ShazamURL: payload.Track.ShazamURL,
		CoverArt:  payload.Track.CoverArt,
		Success:   true,
	}, nil
}
