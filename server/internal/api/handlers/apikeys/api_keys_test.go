package apikeys_test

import (
	"encoding/json"
	"net/http"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestAPIKeyLifecycle(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		user1 := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)
		user2 := test.HeadersWithAuth(t, fix.User2AccessToken1.Token)

		// Create: the full key is returned once.
		res := test.PerformRequest(t, s, http.MethodPost, "/api/v1/api-keys", test.GenericPayload{"name": "Home Assistant"}, user1)
		require.Equal(t, http.StatusCreated, res.Code, res.Body.String())
		var created types.CreatedAPIKey
		test.ParseResponseAndValidate(t, res, &created)
		key := *created.Key
		assert.Regexp(t, `^ssk_[A-Za-z0-9_-]{43}$`, key)
		assert.Equal(t, "Home Assistant", *created.APIKey.Name)
		assert.Equal(t, key[:9], *created.APIKey.KeyPrefix)

		// List: only metadata, never the key.
		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/api-keys", nil, user1)
		require.Equal(t, http.StatusOK, res.Code)
		assert.NotContains(t, res.Body.String(), key)
		var keys []*types.APIKey
		require.NoError(t, json.Unmarshal(res.Body.Bytes(), &keys))
		require.Len(t, keys, 1)
		assert.Equal(t, *created.APIKey.ID, *keys[0].ID)

		// Other users neither see nor revoke it.
		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/api-keys", nil, user2)
		require.NoError(t, json.Unmarshal(res.Body.Bytes(), &keys))
		assert.Empty(t, keys)
		res = test.PerformRequest(t, s, http.MethodDelete, "/api/v1/api-keys/"+created.APIKey.ID.String(), nil, user2)
		assert.Equal(t, http.StatusNotFound, res.Code)

		// Using the key records when it was last used.
		keyAuth := test.HeadersWithAuth(t, key)
		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", test.GenericPayload{"artist": "Nobody", "title": "Nothing"}, keyAuth)
		assert.Equal(t, http.StatusNotFound, res.Code) // authenticated, just no such track
		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/api-keys", nil, user1)
		require.NoError(t, json.Unmarshal(res.Body.Bytes(), &keys))
		assert.False(t, keys[0].LastUsedAt.IsZero())

		// Revoke: the key stops working.
		res = test.PerformRequest(t, s, http.MethodDelete, "/api/v1/api-keys/"+created.APIKey.ID.String(), nil, user1)
		assert.Equal(t, http.StatusNoContent, res.Code)
		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", test.GenericPayload{"artist": "Nobody", "title": "Nothing"}, keyAuth)
		assert.Equal(t, http.StatusUnauthorized, res.Code)

		// Validation and auth.
		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/api-keys", test.GenericPayload{"name": ""}, user1)
		assert.Equal(t, http.StatusBadRequest, res.Code)
		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/api-keys", nil, nil)
		assert.Equal(t, http.StatusUnauthorized, res.Code)
	})
}
