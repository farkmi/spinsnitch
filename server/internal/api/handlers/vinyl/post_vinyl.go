package vinyl

import (
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/go-openapi/swag/conv"
	"github.com/labstack/echo/v4"
)

func PostVinylRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Vinyl.POST("", postVinylHandler(s))
}

func postVinylHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		var body types.VinylPayload
		if err := util.BindAndValidateBody(c, &body); err != nil {
			return err
		}

		record, err := s.Vinyl.AddVinyl(ctx, auth.UserFromContext(ctx).ID, int(conv.Value(body.DiscogsID)))
		if err != nil {
			return err
		}

		return util.ValidateAndReturn(c, http.StatusOK, record.ToTypes(s.Config.Echo.BaseURL))
	}
}
