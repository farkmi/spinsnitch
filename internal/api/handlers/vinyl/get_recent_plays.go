package vinyl

import (
	"net/http"
	"strconv"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/labstack/echo/v4"
)

func GetRecentPlaysRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Vinyl.GET("/recent-plays", getRecentPlaysHandler(s))
}

func getRecentPlaysHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		user := auth.UserFromContext(ctx)
		if user == nil {
			return echo.ErrUnauthorized
		}

		limit := 10
		if lStr := c.QueryParam("limit"); lStr != "" {
			if l, err := strconv.Atoi(lStr); err == nil {
				limit = l
			}
		}

		response, err := s.Vinyl.GetRecentPlays(ctx, user.ID, limit)
		if err != nil {
			return err
		}

		return util.ValidateAndReturn(c, http.StatusOK, response.ToTypes())
	}
}
