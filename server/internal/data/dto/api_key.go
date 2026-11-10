package dto

import (
	"time"

	"github.com/aarondl/null/v8"
	"github.com/farkmi/spinsnitch-server/internal/models"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag/conv"
)

type APIKey struct {
	ID         string
	Name       string
	KeyPrefix  string
	LastUsedAt null.Time
	CreatedAt  time.Time
}

func APIKeyFromModel(model *models.APIKey) *APIKey {
	return &APIKey{
		ID:         model.ID,
		Name:       model.Name,
		KeyPrefix:  model.KeyPrefix,
		LastUsedAt: model.LastUsedAt,
		CreatedAt:  model.CreatedAt,
	}
}

func (k *APIKey) ToTypes() *types.APIKey {
	result := &types.APIKey{
		ID:        conv.Pointer(strfmt.UUID4(k.ID)),
		Name:      conv.Pointer(k.Name),
		KeyPrefix: conv.Pointer(k.KeyPrefix),
		CreatedAt: conv.Pointer(strfmt.DateTime(k.CreatedAt)),
	}
	if k.LastUsedAt.Valid {
		result.LastUsedAt = strfmt.DateTime(k.LastUsedAt.Time)
	}
	return result
}
