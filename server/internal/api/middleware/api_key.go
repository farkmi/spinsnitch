package middleware

import (
	"errors"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/apikey"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/farkmi/spinsnitch-server/internal/data/mapper"
	"github.com/labstack/echo/v4"
	"github.com/rs/zerolog/log"
)

// APIKeyAuth authenticates requests with a per-user API key ("Authorization: Bearer ssk_...")
// instead of a session access token. Handlers see the key's owner as the authenticated user.
func APIKeyAuth(s *api.Server) echo.MiddlewareFunc {
	c := DefaultAuthConfig
	c.S = s
	c.FormatValidator = apikey.IsWellFormed
	c.TokenValidator = APIKeyTokenValidator
	return AuthWithConfig(c)
}

func APIKeyTokenValidator(c echo.Context, config AuthConfig, token string) (auth.Result, error) {
	user, err := config.S.APIKeys.Authenticate(c.Request().Context(), token)
	if err != nil {
		if errors.Is(err, apikey.ErrNotFound) {
			log.Trace().Msg("API key not found in database")
			return auth.Result{}, ErrAuthTokenValidationFailed
		}

		log.Error().Err(err).Msg("Failed to look up API key, aborting request")
		return auth.Result{}, echo.ErrInternalServerError
	}

	// API keys don't expire; they are revoked by deleting them.
	return auth.Result{
		Token: token,
		User:  mapper.LocalUserToDTO(user).Ptr(),
	}, nil
}
