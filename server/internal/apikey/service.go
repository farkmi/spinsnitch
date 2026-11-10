// Package apikey manages long-lived per-user API keys for integrations such as Home Assistant.
//
// Keys are random, prefixed with "ssk_" so they are recognisable (and greppable in leaked
// configs), and only stored as a SHA-256 hash. Unlike passwords they carry 256 bits of entropy,
// so a fast hash is sufficient and allows looking a key up by its hash directly.
package apikey

import (
	"context"
	"crypto/rand"
	"crypto/sha256"
	"database/sql"
	"encoding/base64"
	"encoding/hex"
	"errors"
	"fmt"
	"strings"
	"time"

	"github.com/aarondl/null/v8"
	"github.com/aarondl/sqlboiler/v4/boil"
	"github.com/aarondl/sqlboiler/v4/queries/qm"
	"github.com/dropbox/godropbox/time2"
	"github.com/farkmi/spinsnitch-server/internal/data/dto"
	"github.com/farkmi/spinsnitch-server/internal/models"
)

const (
	KeyPrefix = "ssk_"

	keyRandomBytes = 32
	// Length of the visible prefix stored for display: "ssk_" plus 5 characters.
	displayPrefixLen = len(KeyPrefix) + 5
	// last_used_at is only refreshed when older than this, so frequent callers (e.g. a listening
	// tablet every 40 seconds) don't turn every request into a write.
	lastUsedResolution = 5 * time.Minute
)

var (
	ErrNotFound = errors.New("api key not found")

	// base64url without padding of 32 bytes is 43 characters.
	keyLen = len(KeyPrefix) + base64.RawURLEncoding.EncodedLen(keyRandomBytes)
)

type Service struct {
	db    *sql.DB
	clock time2.Clock
}

func NewService(db *sql.DB, clock time2.Clock) *Service {
	return &Service{db: db, clock: clock}
}

// IsWellFormed reports whether key has the shape of an API key, without looking it up.
func IsWellFormed(key string) bool {
	if len(key) != keyLen || !strings.HasPrefix(key, KeyPrefix) {
		return false
	}
	_, err := base64.RawURLEncoding.DecodeString(key[len(KeyPrefix):])
	return err == nil
}

func hashKey(key string) string {
	sum := sha256.Sum256([]byte(key))
	return hex.EncodeToString(sum[:])
}

func generateKey() (string, error) {
	b := make([]byte, keyRandomBytes)
	if _, err := rand.Read(b); err != nil {
		return "", fmt.Errorf("failed to generate key: %w", err)
	}
	return KeyPrefix + base64.RawURLEncoding.EncodeToString(b), nil
}

// Create generates a new key for the user. The returned plain key is not stored and cannot be
// retrieved again.
func (s *Service) Create(ctx context.Context, userID string, name string) (*dto.APIKey, string, error) {
	key, err := generateKey()
	if err != nil {
		return nil, "", err
	}

	apiKey := &models.APIKey{
		UserID:    userID,
		Name:      name,
		KeyHash:   hashKey(key),
		KeyPrefix: key[:displayPrefixLen],
	}
	if err := apiKey.Insert(ctx, s.db, boil.Infer()); err != nil {
		return nil, "", err
	}

	return dto.APIKeyFromModel(apiKey), key, nil
}

func (s *Service) List(ctx context.Context, userID string) ([]*dto.APIKey, error) {
	keys, err := models.APIKeys(
		models.APIKeyWhere.UserID.EQ(userID),
		qm.OrderBy(models.APIKeyColumns.CreatedAt),
	).All(ctx, s.db)
	if err != nil {
		return nil, err
	}

	result := make([]*dto.APIKey, len(keys))
	for i, k := range keys {
		result[i] = dto.APIKeyFromModel(k)
	}
	return result, nil
}

// Delete revokes one of the user's keys. Keys of other users are reported as not found.
func (s *Service) Delete(ctx context.Context, userID string, id string) error {
	deleted, err := models.APIKeys(
		models.APIKeyWhere.ID.EQ(id),
		models.APIKeyWhere.UserID.EQ(userID),
	).DeleteAll(ctx, s.db)
	if err != nil {
		return err
	}
	if deleted == 0 {
		return ErrNotFound
	}
	return nil
}

// Authenticate resolves a plain key to its owner.
func (s *Service) Authenticate(ctx context.Context, key string) (*models.User, error) {
	apiKey, err := models.APIKeys(
		models.APIKeyWhere.KeyHash.EQ(hashKey(key)),
		qm.Load(qm.Rels(models.APIKeyRels.User, models.UserRels.AppUserProfile)),
	).One(ctx, s.db)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, ErrNotFound
		}
		return nil, err
	}

	now := s.clock.Now()
	if !apiKey.LastUsedAt.Valid || now.Sub(apiKey.LastUsedAt.Time) > lastUsedResolution {
		apiKey.LastUsedAt = null.TimeFrom(now)
		if _, err := apiKey.Update(ctx, s.db, boil.Whitelist(models.APIKeyColumns.LastUsedAt, models.APIKeyColumns.UpdatedAt)); err != nil {
			return nil, err
		}
	}

	return apiKey.R.User, nil
}
