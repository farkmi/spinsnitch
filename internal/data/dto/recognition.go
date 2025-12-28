package dto

import (
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/farkmi/spinsnitch-server/internal/util/publicurl"
)

type RecognitionResult struct {
	Artist    string
	Title     string
	ShazamURL string
	CoverArt  string
	Success   bool
}

func (r *RecognitionResult) ToTypes(baseURL string) *types.RecognitionResult {
	return &types.RecognitionResult{
		Artist:    r.Artist,
		Title:     r.Title,
		ShazamURL: r.ShazamURL,
		CoverArt:  publicurl.Enrich(baseURL, r.CoverArt),
		Success:   r.Success,
	}
}
