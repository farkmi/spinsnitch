package vinyl_test

import (
	"fmt"
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
			respWriter.WriteHeader(http.StatusOK)
			_, _ = fmt.Fprintf(respWriter, `{
                "id": 12345,
                "title": "Random Access Memories",
                "artists": [{"name": "Daft Punk"}],
                "year": 2013,
                "images": [
                    {
                        "type": "primary",
                        "uri": "http://%s/cover.jpg"
                    }
                ],
                "tracklist": []
            }`, req.Host)
		}
		if strings.Contains(req.URL.Path, "/cover.jpg") {
			respWriter.WriteHeader(http.StatusOK)
			_, _ = respWriter.Write([]byte("fake-image-data"))
			return
		}
		respWriter.WriteHeader(http.StatusNotFound)
	}))
	defer discogsServer.Close()

	test.WithTestServer(t, func(s *api.Server) {
		// Setup mock service
		mockClient := discogs.NewClient("test-key", "test-secret")
		mockClient.BaseURL = discogsServer.URL
		s.Vinyl = vinyl_service.NewService(s.DB, mockClient, s.Clock)

		fix := fixtures.Fixtures()
		authHeaders := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)

		// Success Case
		payload := test.GenericPayload{"discogsId": 12345}
		res := test.PerformRequest(t, s, "POST", "/api/v1/vinyls", payload, authHeaders)
		assert.Equal(t, http.StatusOK, res.Result().StatusCode)

		var response types.VinylRecord
		test.ParseResponseAndValidate(t, res, &response)
		assert.Equal(t, int64(12345), *response.DiscogsID)
		assert.Equal(t, int64(2013), response.Year)
		// We expect the image to be downloaded and a local static path returned
		assert.Contains(t, response.CoverImage, "/assets/mnt/covers/12345.jpg")

		// Invalid Payload
		resBad := test.PerformRequest(t, s, "POST", "/api/v1/vinyls", nil, authHeaders)
		assert.Equal(t, http.StatusBadRequest, resBad.Result().StatusCode)

		// Unauthorized
		resUnauth := test.PerformRequest(t, s, "POST", "/api/v1/vinyls", payload, nil)
		test.RequireHTTPError(t, resUnauth, httperrors.NewFromEcho(echo.ErrUnauthorized))
	})
}
