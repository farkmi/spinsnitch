package vinyl

import (
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/labstack/echo/v4"
)

func GetVinylsRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Vinyl.GET("", getVinylsHandler(s))
}

func getVinylsHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()

		records, err := s.Vinyl.ListVinyls(ctx)
		if err != nil {
			return err
		}

		return c.JSON(http.StatusOK, records.ToTypes(s.Config.Echo.BaseURL))
	}
}
