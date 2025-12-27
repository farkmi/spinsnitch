package vinyl

import (
	"errors"
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/farkmi/spinsnitch-server/internal/vinyl"
	"github.com/go-openapi/swag"
	"github.com/labstack/echo/v4"
)

func PostPlayRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Vinyl.POST("/play", postPlayHandler(s))
}

func postPlayHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		var body types.PlayPayload
		if err := util.BindAndValidateBody(c, &body); err != nil {
			return err
		}

		err := s.Vinyl.RegisterPlay(ctx, swag.StringValue(body.Artist), swag.StringValue(body.Title))
		if err != nil {
			if errors.Is(err, vinyl.ErrTrackNotFound) {
				return echo.NewHTTPError(http.StatusNotFound, err.Error())
			}
			return err
		}

		return c.NoContent(http.StatusNoContent)
	}
}
