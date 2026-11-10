package apikeys

import (
	"errors"
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/apikey"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/farkmi/spinsnitch-server/internal/types/api_keys"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/labstack/echo/v4"
)

func DeleteAPIKeyRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1APIKeys.DELETE("/:id", deleteAPIKeyHandler(s))
}

func deleteAPIKeyHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		user := auth.UserFromEchoContext(c)

		params := api_keys.NewDeleteAPIKeyRouteParams()
		if err := util.BindAndValidatePathParams(c, &params); err != nil {
			return err
		}

		if err := s.APIKeys.Delete(ctx, user.ID, params.ID.String()); err != nil {
			if errors.Is(err, apikey.ErrNotFound) {
				return echo.ErrNotFound
			}
			return err
		}

		return c.NoContent(http.StatusNoContent)
	}
}
