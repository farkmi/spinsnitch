package vinyl

import (
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/labstack/echo/v4"
)

func GetMistreatedRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Vinyl.GET("/mistreated", getMistreatedHandler(s))
}

func getMistreatedHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()

		mistreated, err := s.Vinyl.GetMistreated(ctx, auth.UserFromContext(ctx).ID)
		if err != nil {
			return err
		}

		return c.JSON(http.StatusOK, mistreated.ToTypes())
	}
}
