package router_test

import (
	"net/http"
	"os"
	"path/filepath"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestAssetsServing(t *testing.T) {
	test.WithTestServer(t, func(s *api.Server) {
		// 1. Setup Test Assets
		// We can't easily rely on pre-existing files in the Docker container for unit tests running elsewhere,
		// but since we are running in the container environment where /app/assets exists (or we create it),
		// we will explicitly create test files to be sure.

		// Define paths
		assetsDir := "/app/assets"
		staticFile := "static-test.txt"
		mntDir := filepath.Join(assetsDir, "mnt", "covers")
		dynamicFile := "dynamic-test.txt"

		// Create static file (simulating baked-in asset)
		err := os.MkdirAll(assetsDir, 0755)
		require.NoError(t, err)
		// #nosec G306 - Test file intended to be readable
		err = os.WriteFile(filepath.Join(assetsDir, staticFile), []byte("static content"), 0644)
		require.NoError(t, err)
		defer os.Remove(filepath.Join(assetsDir, staticFile))

		// Create dynamic file (simulating mounted volume asset)
		err = os.MkdirAll(mntDir, 0755)
		require.NoError(t, err)
		// #nosec G306 - Test file intended to be readable
		err = os.WriteFile(filepath.Join(mntDir, dynamicFile), []byte("dynamic content"), 0644)
		require.NoError(t, err)
		// Clean up dynamic file after test, but leave dir as it might be used by others
		defer os.Remove(filepath.Join(mntDir, dynamicFile))

		// 2. Test Static Asset Serving
		resStatic := test.PerformRequest(t, s, "GET", "/assets/"+staticFile, nil, nil)
		assert.Equal(t, http.StatusOK, resStatic.Result().StatusCode)
		assert.Equal(t, "static content", resStatic.Body.String())

		// 3. Test Dynamic Asset Serving
		// URL should be /assets/mnt/covers/dynamic-test.txt
		resDynamic := test.PerformRequest(t, s, "GET", "/assets/mnt/covers/"+dynamicFile, nil, nil)
		assert.Equal(t, http.StatusOK, resDynamic.Result().StatusCode)
		assert.Equal(t, "dynamic content", resDynamic.Body.String())

		// 4. Test Not Found
		resNotFound := test.PerformRequest(t, s, "GET", "/assets/non-existent.txt", nil, nil)
		assert.Equal(t, http.StatusNotFound, resNotFound.Result().StatusCode)
	})
}
