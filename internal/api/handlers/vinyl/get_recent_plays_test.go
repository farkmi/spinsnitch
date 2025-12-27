package vinyl_test

import (
	"net/http"
	"testing"
	"time"

	"github.com/aarondl/sqlboiler/v4/boil"
	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/models"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestRecentPlaysAndDebouncing(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		authHeaders := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)

		// 1. Setup a vinyl record and tracks in the database
		ctx := t.Context()
		record := &models.VinylRecord{
			Title:     "Test Vinyl",
			Artist:    "Test Artist",
			DiscogsID: 12345,
		}
		err := record.Insert(ctx, s.DB, boil.Infer())
		require.NoError(t, err)

		side := &models.VinylSide{
			VinylRecordID: record.ID,
			SideLabel:     "A",
		}
		err = side.Insert(ctx, s.DB, boil.Infer())
		require.NoError(t, err)

		track := &models.Track{
			VinylSideID: side.ID,
			Title:       "Test Track",
			Position:    "1",
		}
		err = track.Insert(ctx, s.DB, boil.Infer())
		require.NoError(t, err)

		// 2. Control time
		fixTime, _ := time.Parse(time.RFC3339, fixtures.InitialFixtureTime)
		test.SetMockClock(t, s, fixTime)

		// 3. Register first play
		payload := test.GenericPayload{"artist": record.Artist, "title": track.Title}
		res1 := test.PerformRequest(t, s, "POST", "/api/v1/vinyls/play", payload, authHeaders)
		assert.Equal(t, http.StatusNoContent, res1.Result().StatusCode)

		// 4. Check recent plays - should have 1 entry
		resRecent1 := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/recent-plays", nil, authHeaders)
		assert.Equal(t, http.StatusOK, resRecent1.Result().StatusCode)
		var response1 types.RecentPlaysResponse
		test.ParseResponseAndValidate(t, resRecent1, &response1)
		assert.Len(t, response1.Plays, 1)
		assert.Equal(t, track.Title, response1.Plays[0].Title)

		// 5. Register second play within 30 minutes (debounced)
		test.SetMockClock(t, s, fixTime.Add(20*time.Minute))
		res2 := test.PerformRequest(t, s, "POST", "/api/v1/vinyls/play", payload, authHeaders)
		assert.Equal(t, http.StatusNoContent, res2.Result().StatusCode)

		// Check recent plays - should still have 1 entry
		resRecent2 := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/recent-plays", nil, authHeaders)
		var response2 types.RecentPlaysResponse
		test.ParseResponseAndValidate(t, resRecent2, &response2)
		assert.Len(t, response2.Plays, 1)

		// 6. Register third play after 30 minutes
		test.SetMockClock(t, s, fixTime.Add(31*time.Minute))
		res3 := test.PerformRequest(t, s, "POST", "/api/v1/vinyls/play", payload, authHeaders)
		assert.Equal(t, http.StatusNoContent, res3.Result().StatusCode)

		// Check recent plays - should have 2 entries
		resRecent3 := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/recent-plays", nil, authHeaders)
		var response3 types.RecentPlaysResponse
		test.ParseResponseAndValidate(t, resRecent3, &response3)
		assert.Len(t, response3.Plays, 2)
	})
}
