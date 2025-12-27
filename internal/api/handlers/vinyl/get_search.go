package vinyl

import (
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/labstack/echo/v4"
)

func GetVinylSearchRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Vinyl.GET("/search", getVinylSearchHandler(s))
}

func getVinylSearchHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		query := c.QueryParam("q")

		if query == "" {
			return c.JSON(http.StatusBadRequest, map[string]string{"error": "query parameter 'q' is required"})
		}

		records, err := s.Vinyl.SearchVinyls(ctx, query)
		if err != nil {
			return err
		}

		return c.JSON(http.StatusOK, records.ToSearchTypes())
	}
}
