package vinyl_test

import (
	"net/http"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/api/httperrors"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
)

func TestPostPlay(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		authHeaders := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)

		// We need a record to play.
		// Can import one or insert directly to DB.
		// For unit test isolation, inserting to DB via models is faster/cleaner but service AddVinyl is also fine.
		// Let's assume we test the "Not Found" case first as it requires no setup.

		// Not Found
		payload := test.GenericPayload{"artist": "NonExistent", "title": "Nothing"}
		resNF := test.PerformRequest(t, s, "POST", "/api/v1/vinyls/play", payload, authHeaders)
		assert.Equal(t, http.StatusNotFound, resNF.Result().StatusCode)

		// Invalid Payload
		resBad := test.PerformRequest(t, s, "POST", "/api/v1/vinyls/play", nil, authHeaders)
		assert.Equal(t, http.StatusBadRequest, resBad.Result().StatusCode)

		// Unauthorized
		resUnauth := test.PerformRequest(t, s, "POST", "/api/v1/vinyls/play", payload, nil)
		test.RequireHTTPError(t, resUnauth, httperrors.NewFromEcho(echo.ErrUnauthorized))
	})
}
