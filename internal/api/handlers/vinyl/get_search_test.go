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
	vinyl_service "github.com/farkmi/spinsnitch-server/internal/vinyl"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
)

func TestGetSearch(t *testing.T) {
	// Mock Server
	discogsServer := httptest.NewServer(http.HandlerFunc(func(respWriter http.ResponseWriter, req *http.Request) {
		if strings.Contains(req.URL.Path, "/database/search") {
			respWriter.Header().Set("Content-Type", "application/json")
			respWriter.WriteHeader(http.StatusOK)
			_, _ = respWriter.Write([]byte(`{
                "results": [
                    {
                        "id": 12345,
                        "title": "Daft Punk - Random Access Memories",
                        "thumb": "https://example.com/ram.jpg"
                    }
                ]
            }`))
			return
		}
		respWriter.WriteHeader(http.StatusNotFound)
	}))
	defer discogsServer.Close()

	test.WithTestServer(t, func(s *api.Server) {
		mockClient := discogs.NewClient("test")
		mockClient.BaseURL = discogsServer.URL
		s.Vinyl = vinyl_service.NewService(s.DB, mockClient)

		fix := fixtures.Fixtures()
		authHeaders := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)

		// Success Case
		res := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/search?q=Daft", nil, authHeaders)
		assert.Equal(t, http.StatusOK, res.Result().StatusCode)
		assert.Contains(t, res.Body.String(), "Daft Punk")

		// Missing param validation - handled by handler logic?
		// Let's check handler implementation:
		// query := c.QueryParam("q") ... if query == "" return BadRequest
		resMissing := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/search", nil, authHeaders)
		assert.Equal(t, http.StatusBadRequest, resMissing.Result().StatusCode)

		// Unauthorized
		resUnauth := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/search?q=foo", nil, nil)
		test.RequireHTTPError(t, resUnauth, httperrors.NewFromEcho(echo.ErrUnauthorized))
	})
}
