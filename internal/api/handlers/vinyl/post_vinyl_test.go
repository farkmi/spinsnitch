package vinyl_test

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/api/httperrors"
	"github.com/farkmi/spinsnitch-server/internal/discogs"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/farkmi/spinsnitch-server/internal/types"
	vinyl_service "github.com/farkmi/spinsnitch-server/internal/vinyl"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
)

func TestPostVinyl(t *testing.T) {
	// Mock Server setup (Common for most tests)
	discogsServer := httptest.NewServer(http.HandlerFunc(func(respWriter http.ResponseWriter, req *http.Request) {
		if strings.Contains(req.URL.Path, "/releases/12345") {
			respWriter.Header().Set("Content-Type", "application/json")
			respWriter.WriteHeader(http.StatusOK)
			_, _ = respWriter.Write([]byte(`{
                "id": 12345,
                "title": "Random Access Memories",
                "artists": [{"name": "Daft Punk"}],
                "tracklist": []
            }`))
			return
		}
		respWriter.WriteHeader(http.StatusNotFound)
	}))
	defer discogsServer.Close()

	test.WithTestServer(t, func(s *api.Server) {
		// Setup mock service
		mockClient := discogs.NewClient("test")
		mockClient.BaseURL = discogsServer.URL
		s.Vinyl = vinyl_service.NewService(s.DB, mockClient)

		fix := fixtures.Fixtures()
		authHeaders := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)

		// Success Case
		payload := test.GenericPayload{"discogsId": 12345}
		res := test.PerformRequest(t, s, "POST", "/api/v1/vinyls", payload, authHeaders)
		assert.Equal(t, http.StatusOK, res.Result().StatusCode)

		var response types.VinylRecord
		test.ParseResponseAndValidate(t, res, &response)
		assert.Equal(t, int64(12345), *response.DiscogsID)

		// Invalid Payload
		resBad := test.PerformRequest(t, s, "POST", "/api/v1/vinyls", nil, authHeaders)
		assert.Equal(t, http.StatusBadRequest, resBad.Result().StatusCode)

		// Unauthorized
		resUnauth := test.PerformRequest(t, s, "POST", "/api/v1/vinyls", payload, nil)
		test.RequireHTTPError(t, resUnauth, httperrors.NewFromEcho(echo.ErrUnauthorized))
	})
}
