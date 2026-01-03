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

func PostWebhookPlayRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Webhook.POST("/play", postWebhookPlayHandler(s))
}

func postWebhookPlayHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		var body types.PlayPayload
		if err := util.BindAndValidateBody(c, &body); err != nil {
			return err
		}

		// Pick the first active user to log the play for
		user, err := s.Auth.GetFirstActiveUser(ctx)
		if err != nil {
			return err
		}

		_, err = s.Vinyl.RegisterPlay(ctx, user.ID, swag.StringValue(body.Artist), swag.StringValue(body.Title))
		if err != nil {
			if errors.Is(err, vinyl.ErrTrackNotFound) {
				return echo.NewHTTPError(http.StatusNotFound, err.Error())
			}
			return err
		}

		return c.NoContent(http.StatusNoContent)
	}
}
