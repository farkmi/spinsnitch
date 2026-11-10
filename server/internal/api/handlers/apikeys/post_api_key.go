package apikeys

import (
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/go-openapi/swag/conv"
	"github.com/labstack/echo/v4"
)

func PostAPIKeyRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1APIKeys.POST("", postAPIKeyHandler(s))
}

func postAPIKeyHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		user := auth.UserFromEchoContext(c)

		var body types.PostAPIKeyPayload
		if err := util.BindAndValidateBody(c, &body); err != nil {
			return err
		}

		created, key, err := s.APIKeys.Create(ctx, user.ID, conv.Value(body.Name))
		if err != nil {
			return err
		}

		return util.ValidateAndReturn(c, http.StatusCreated, &types.CreatedAPIKey{
			APIKey: created.ToTypes(),
			Key:    conv.Pointer(key),
		})
	}
}
