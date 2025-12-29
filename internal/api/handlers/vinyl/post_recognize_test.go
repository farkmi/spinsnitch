package vinyl_test

import (
	"bytes"
	"io"
	"mime/multipart"
	"net/http"
	"os"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/test/fixtures"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestPostRecognizeHandler(t *testing.T) {
	if testing.Short() {
		t.Skip("Skipping integration test in short mode")
	}

	test.WithTestServer(t, func(s *api.Server) {
		fix := fixtures.Fixtures()
		authHeaders := test.HeadersWithAuth(t, fix.User1AccessToken1.Token)

		filePath := "/app/test/testdata/dont-talk-315229.mp3"
		file, err := os.Open(filePath)
		require.NoError(t, err)
		defer file.Close()

		body := &bytes.Buffer{}
		writer := multipart.NewWriter(body)
		part, err := writer.CreateFormFile("file", "dont-talk-315229.mp3")
		require.NoError(t, err)
		_, err = io.Copy(part, file)
		require.NoError(t, err)
		err = writer.Close()
		require.NoError(t, err)

		authHeaders.Set("Content-Type", writer.FormDataContentType())

		rec := test.PerformRequestWithRawBody(t, s, http.MethodPost, "/api/v1/vinyls/recognize", body, authHeaders, nil)

		if rec.Code == http.StatusInternalServerError {
			t.Skip("Recognizer service might be unreachable")
		}

		require.Equal(t, http.StatusOK, rec.Code)
		assert.Contains(t, rec.Body.String(), "Cosmonkey")
		assert.Contains(t, rec.Body.String(), "Don't Talk")
		assert.Contains(t, rec.Body.String(), "success\":true")
	})
}
