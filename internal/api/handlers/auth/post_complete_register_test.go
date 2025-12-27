package auth_test

import (
	"fmt"
	"net/http"
	"testing"
	"time"

	"github.com/aarondl/null/v8"
	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/api/httperrors"
	"github.com/farkmi/spinsnitch-server/internal/config"
	"github.com/farkmi/spinsnitch-server/internal/models"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestPostCompleteRegister(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		// Set mock clock to match fixtures
		fixTime, _ := time.Parse(time.RFC3339, fixtures.InitialFixtureTime)
		test.SetMockClock(t, s, fixTime)

		// Refresh fixtures to ensure clean state
		fix := fixtures.Fixtures()
		ctx := t.Context()

		res := test.PerformRequest(t, s, "POST", fmt.Sprintf("/api/v1/auth/register/%s", fix.UserRequiresConfirmationConfirmationToken.Token), nil, nil)
		require.Equal(t, http.StatusOK, res.Result().StatusCode)

		var response types.PostLoginResponse
		test.ParseResponseAndValidate(t, res, &response)

		assert.NotEmpty(t, response.AccessToken)
		assert.NotEmpty(t, response.RefreshToken)

		user, err := models.Users(
			models.UserWhere.ID.EQ(fix.UserRequiresConfirmationConfirmationToken.UserID),
		).One(ctx, s.DB)
		require.NoError(t, err)

		assert.True(t, user.IsActive)
		assert.False(t, user.RequiresConfirmation)

		// trying again with the same token should fail
		{
			res := test.PerformRequest(t, s, "POST", fmt.Sprintf("/api/v1/auth/register/%s", fix.UserRequiresConfirmationConfirmationToken.Token), nil, nil)
			test.RequireHTTPError(t, res, httperrors.NewFromEcho(echo.ErrUnauthorized))
		}
	})
}

func TestPostCompleteRegisterTokenNotFound(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		res := test.PerformRequest(t, s, "POST", "/api/v1/auth/register/e45071b7-b9a0-4ed7-a5a0-16a16413d275", nil, nil)
		test.RequireHTTPError(t, res, httperrors.NewFromEcho(echo.ErrUnauthorized))
	})
}

func TestPostCompleteRegisterTokenExpired(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		// Set mock clock to match fixtures
		fixTime, _ := time.Parse(time.RFC3339, fixtures.InitialFixtureTime)
		test.SetMockClock(t, s, fixTime)

		fix := fixtures.Fixtures()

		// Advance mock clock by 2 hours (token only valid for 1 hour from InitialFixtureTime)
		test.SetMockClock(t, s, fixTime.Add(2*time.Hour))

		res := test.PerformRequest(t, s, "POST", fmt.Sprintf("/api/v1/auth/register/%s", fix.UserRequiresConfirmationConfirmationToken.Token), nil, nil)
		test.RequireHTTPError(t, res, httperrors.NewFromEcho(echo.ErrUnauthorized))
	})
}

func TestRegistrationFlowInstantActivation(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		// SERVER_AUTH_REGISTRATION_REQUIRES_CONFIRMATION=false is the default
		ctx := t.Context()
		username := "newuser@example.com"
		password := "password1212"

		payload := test.GenericPayload{
			"username": username,
			"password": password,
		}

		res := test.PerformRequest(t, s, "POST", "/api/v1/auth/register", payload, nil)
		require.Equal(t, http.StatusOK, res.Result().StatusCode)

		var response types.PostLoginResponse
		test.ParseResponseAndValidate(t, res, &response)
		assert.NotEmpty(t, response.AccessToken)

		// Verify user is active in DB
		user, err := models.Users(models.UserWhere.Username.EQ(null.StringFrom(username))).One(ctx, s.DB)
		require.NoError(t, err)
		assert.True(t, user.IsActive)
		assert.False(t, user.RequiresConfirmation)
	})
}

func TestRegistrationFlowRequiresConfirmation(t *testing.T) {
	config := config.DefaultServiceConfigFromEnv()
	config.Auth.RegistrationRequiresConfirmation = true

	test.WithTestServerConfigurable(t, config, func(s *api.Server) {
		ctx := t.Context()
		username := "requireconf@example.com"
		password := "password1212"

		payload := test.GenericPayload{
			"username": username,
			"password": password,
		}

		res := test.PerformRequest(t, s, "POST", "/api/v1/auth/register", payload, nil)
		require.Equal(t, http.StatusAccepted, res.Result().StatusCode)

		var response types.RegisterResponse
		test.ParseResponseAndValidate(t, res, &response)
		assert.True(t, *response.RequiresConfirmation)

		// Verify user is inactive in DB
		user, err := models.Users(models.UserWhere.Username.EQ(null.StringFrom(username))).One(ctx, s.DB)
		require.NoError(t, err)
		assert.False(t, user.IsActive)
		assert.True(t, user.RequiresConfirmation)
	})
}
