package vinyl_test

import (
	"encoding/json"
	"net/http"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/api/httperrors"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestGetMistreated(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		authHeaders := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)

		// Success Case (Empty list initially)
		res := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/mistreated", nil, authHeaders)
		assert.Equal(t, http.StatusOK, res.Result().StatusCode)

		var response []*types.MistreatedRecord
		err := json.Unmarshal(res.Body.Bytes(), &response)
		require.NoError(t, err)
		assert.NotNil(t, response)

		// Unauthorized
		resUnauth := test.PerformRequest(t, s, "GET", "/api/v1/vinyls/mistreated", nil, nil)
		test.RequireHTTPError(t, resUnauth, httperrors.NewFromEcho(echo.ErrUnauthorized))
	})
}
