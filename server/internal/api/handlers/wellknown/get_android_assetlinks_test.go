package wellknown_test

import (
	"path/filepath"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/api/httperrors"
	"github.com/farkmi/spinsnitch-server/internal/config"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/labstack/echo/v4"
)

func TestGetAndroidWellKnown(t *testing.T) {
	config := config.DefaultServiceConfigFromEnv()
	config.Paths.AndroidAssetlinksFile = filepath.Join(util.GetProjectRootDir(), "test", "testdata", "android-assetlinks.json")

	testGetWellKnown(t, config, "/.well-known/assetlinks.json")
}

func TestGetAndroidWellKnownNotFound(t *testing.T) {
	config := config.DefaultServiceConfigFromEnv()
	config.Paths.AndroidAssetlinksFile = ""

	test.WithTestServerConfigurable(t, config, func(s *api.Server) {
		res := test.PerformRequest(t, s, "GET", "/.well-known/assetlinks.json", nil, nil)
		test.RequireHTTPError(t, res, httperrors.NewFromEcho(echo.ErrNotFound))
	})
}
