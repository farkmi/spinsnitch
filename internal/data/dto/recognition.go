package dto

import (
	"github.com/farkmi/spinsnitch-server/internal/types"
)

type RecognitionResult struct {
	Artist    string
	Title     string
	ShazamURL string
	CoverArt  string
	Success   bool
}

func (r *RecognitionResult) ToTypes() *types.RecognitionResult {
	return &types.RecognitionResult{
		Artist:    r.Artist,
		Title:     r.Title,
		ShazamURL: r.ShazamURL,
		CoverArt:  r.CoverArt,
		Success:   r.Success,
	}
}
