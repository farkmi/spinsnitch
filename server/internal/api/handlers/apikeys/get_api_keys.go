package apikeys

import (
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/labstack/echo/v4"
)

func GetAPIKeysRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1APIKeys.GET("", getAPIKeysHandler(s))
}

func getAPIKeysHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		user := auth.UserFromEchoContext(c)

		keys, err := s.APIKeys.List(ctx, user.ID)
		if err != nil {
			return err
		}

		result := make([]*types.APIKey, len(keys))
		for i, k := range keys {
			result[i] = k.ToTypes()
		}

		return c.JSON(http.StatusOK, result)
	}
}
