package vinyl_test

import (
	"encoding/json"
	"net/http"
	"testing"
	"time"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/data/dto"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestWebhooksRequireAPIKey(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		payload := test.GenericPayload{"artist": "Daft Punk", "title": "Get Lucky"}

		res := test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", payload, nil)
		assert.Equal(t, http.StatusUnauthorized, res.Code)

		// A session access token is not an API key.
		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", payload, test.HeadersWithAuth(t, fix.User1AccessToken1.Token))
		assert.Equal(t, http.StatusBadRequest, res.Code)

		// Well-formed but unknown key.
		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", payload, test.HeadersWithAuth(t, "ssk_AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"))
		assert.Equal(t, http.StatusUnauthorized, res.Code)

		// API keys don't work on session-authenticated endpoints.
		key := createAPIKey(t, s, fix.User1AccessToken1.Token)
		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/vinyls", nil, test.HeadersWithAuth(t, key))
		assert.Equal(t, http.StatusBadRequest, res.Code)
	})
}

func TestWebhookPlay(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		fixTime, _ := time.Parse(time.RFC3339, fixtures.InitialFixtureTime)
		test.SetMockClock(t, s, fixTime)

		insertRecord(t, s, fix.User1.ID, "Daft Punk", "Random Access Memories", 1, map[string][]string{
			"A": {"Give Life Back to Music", "The Game of Love"},
			"D": {"Get Lucky"},
		})
		user1Key := test.HeadersWithAuth(t, createAPIKey(t, s, fix.User1AccessToken1.Token))
		user2Key := test.HeadersWithAuth(t, createAPIKey(t, s, fix.User2AccessToken1.Token))

		// Shazam-style naming still matches the Discogs track.
		payload := test.GenericPayload{"artist": "Daft Punk feat. Pharrell Williams", "title": "Get Lucky (Radio Edit)"}

		// Another user's collection is not searched.
		res := test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", payload, user2Key)
		assert.Equal(t, http.StatusNotFound, res.Code)

		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", payload, user1Key)
		require.Equal(t, http.StatusOK, res.Code, res.Body.String())
		var first types.PlayResult
		test.ParseResponseAndValidate(t, res, &first)
		assert.Equal(t, "Get Lucky", *first.Title)
		assert.Equal(t, "Daft Punk", *first.Artist)
		assert.Equal(t, "Random Access Memories", *first.RecordTitle)
		assert.Equal(t, "D", *first.SideLabel)
		assert.Equal(t, "D1", *first.Position)
		assert.False(t, *first.Debounced)

		// Within the debounce window the earlier play is returned.
		test.SetMockClock(t, s, fixTime.Add(10*time.Minute))
		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", payload, user1Key)
		require.Equal(t, http.StatusOK, res.Code)
		var second types.PlayResult
		test.ParseResponseAndValidate(t, res, &second)
		assert.True(t, *second.Debounced)
		assert.Equal(t, *first.PlayID, *second.PlayID)
	})
}

func TestWebhookRecognize(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		insertRecord(t, s, fix.User1.ID, "Daft Punk", "Random Access Memories", 1, map[string][]string{
			"D": {"Get Lucky"},
		})
		key := test.HeadersWithAuth(t, createAPIKey(t, s, fix.User1AccessToken1.Token))

		decode := func(res *http.Response) types.RecognizeAndPlayResult {
			t.Helper()
			defer res.Body.Close()
			require.Equal(t, http.StatusOK, res.StatusCode)
			var result types.RecognizeAndPlayResult
			require.NoError(t, json.NewDecoder(res.Body).Decode(&result))
			return result
		}

		// Recognized and in the collection: play registered.
		s.Recognition = stubRecognizer{result: &dto.RecognitionResult{Success: true, Artist: "Daft Punk", Title: "Get Lucky", ShazamURL: "https://shazam.example/1"}}
		result := decode(performAudioUpload(t, s, key))
		assert.True(t, *result.Recognized)
		assert.True(t, *result.Matched)
		assert.Equal(t, "Get Lucky", result.RecognizedTitle)
		require.NotNil(t, result.Play)
		assert.Equal(t, "Random Access Memories", *result.Play.RecordTitle)

		// Recognized, but not in the collection.
		s.Recognition = stubRecognizer{result: &dto.RecognitionResult{Success: true, Artist: "Phoenix", Title: "1901"}}
		result = decode(performAudioUpload(t, s, key))
		assert.True(t, *result.Recognized)
		assert.False(t, *result.Matched)
		assert.Equal(t, "Phoenix", result.RecognizedArtist)
		assert.Nil(t, result.Play)

		// Nothing recognized (silence, talking).
		s.Recognition = stubRecognizer{result: &dto.RecognitionResult{Success: false}}
		result = decode(performAudioUpload(t, s, key))
		assert.False(t, *result.Recognized)
		assert.False(t, *result.Matched)

		res := performAudioUpload(t, s, nil)
		defer res.Body.Close()
		assert.Equal(t, http.StatusUnauthorized, res.StatusCode)
	})
}

func TestPlayPrefersRecordOnTurntable(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		fixTime, _ := time.Parse(time.RFC3339, fixtures.InitialFixtureTime)
		test.SetMockClock(t, s, fixTime)
		key := test.HeadersWithAuth(t, createAPIKey(t, s, fix.User1AccessToken1.Token))

		insertRecord(t, s, fix.User1.ID, "Daft Punk", "Random Access Memories", 1, map[string][]string{
			"D": {"Get Lucky"},
		})
		insertRecord(t, s, fix.User1.ID, "Daft Punk", "Random Access Memories (10th Anniversary Edition)", 2, map[string][]string{
			"A": {"Horizon"},
			"D": {"Get Lucky"},
		})

		// A track only the anniversary edition has puts that record on the turntable...
		res := test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", test.GenericPayload{"artist": "Daft Punk", "title": "Horizon"}, key)
		require.Equal(t, http.StatusOK, res.Code)

		// ...so the shared track is attributed to it, not to the original pressing.
		test.SetMockClock(t, s, fixTime.Add(5*time.Minute))
		res = test.PerformRequest(t, s, http.MethodPost, "/api/v1/webhooks/play", test.GenericPayload{"artist": "Daft Punk", "title": "Get Lucky"}, key)
		require.Equal(t, http.StatusOK, res.Code)
		var play types.PlayResult
		test.ParseResponseAndValidate(t, res, &play)
		assert.Equal(t, "Random Access Memories (10th Anniversary Edition)", *play.RecordTitle)
	})
}

func TestCollectionIsPerUser(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		user1 := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)
		user2 := test.HeadersWithAuth(t, fix.User2AccessToken1.Token)

		record := insertRecord(t, s, fix.User1.ID, "Phoenix", "Wolfgang Amadeus Phoenix", 1, map[string][]string{"A": {"Lisztomania"}})

		var records []*types.VinylRecord
		res := test.PerformRequest(t, s, http.MethodGet, "/api/v1/vinyls", nil, user1)
		require.Equal(t, http.StatusOK, res.Code)
		require.NoError(t, json.Unmarshal(res.Body.Bytes(), &records))
		assert.Len(t, records, 1)

		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/vinyls", nil, user2)
		require.Equal(t, http.StatusOK, res.Code)
		require.NoError(t, json.Unmarshal(res.Body.Bytes(), &records))
		assert.Empty(t, records)

		// Long unplayed: neglected for its owner, invisible to others.
		test.SetMockClock(t, s, record.CreatedAt.Add(365*24*time.Hour))
		var mistreated []*types.MistreatedRecord
		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/vinyls/mistreated", nil, user1)
		require.Equal(t, http.StatusOK, res.Code)
		require.NoError(t, json.Unmarshal(res.Body.Bytes(), &mistreated))
		assert.Len(t, mistreated, 1)

		res = test.PerformRequest(t, s, http.MethodGet, "/api/v1/vinyls/mistreated", nil, user2)
		require.Equal(t, http.StatusOK, res.Code)
		require.NoError(t, json.Unmarshal(res.Body.Bytes(), &mistreated))
		assert.Empty(t, mistreated)
	})
}
