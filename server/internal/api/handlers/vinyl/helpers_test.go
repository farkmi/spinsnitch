package vinyl_test

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"mime/multipart"
	"net/http"
	"slices"
	"testing"

	"github.com/aarondl/sqlboiler/v4/boil"
	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/data/dto"
	"github.com/farkmi/spinsnitch-server/internal/models"
	"github.com/farkmi/spinsnitch-server/internal/test"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/stretchr/testify/require"
)

type stubRecognizer struct {
	result *dto.RecognitionResult
	err    error
}

func (r stubRecognizer) Recognize(_ context.Context, file io.ReadCloser, _ string) (*dto.RecognitionResult, error) {
	_ = file.Close()
	return r.result, r.err
}

// insertRecord adds a record to the user's collection. sides maps side labels to track titles;
// positions are numbered per side ("A1", "A2", ...).
func insertRecord(t *testing.T, s *api.Server, userID, artist, title string, discogsID int, sides map[string][]string) *models.VinylRecord {
	t.Helper()
	ctx := t.Context()

	record := &models.VinylRecord{UserID: userID, Artist: artist, Title: title, DiscogsID: discogsID}
	require.NoError(t, record.Insert(ctx, s.DB, boil.Infer()))

	labels := make([]string, 0, len(sides))
	for label := range sides {
		labels = append(labels, label)
	}
	slices.Sort(labels)

	for _, label := range labels {
		side := &models.VinylSide{VinylRecordID: record.ID, SideLabel: label}
		require.NoError(t, side.Insert(ctx, s.DB, boil.Infer()))
		for i, trackTitle := range sides[label] {
			track := &models.Track{VinylSideID: side.ID, Title: trackTitle, Position: fmt.Sprintf("%s%d", label, i+1)}
			require.NoError(t, track.Insert(ctx, s.DB, boil.Infer()))
		}
	}

	return record
}

// createAPIKey creates an API key through the API, authenticated by a session access token.
func createAPIKey(t *testing.T, s *api.Server, accessToken string) string {
	t.Helper()
	res := test.PerformRequest(t, s, http.MethodPost, "/api/v1/api-keys", test.GenericPayload{"name": "test"}, test.HeadersWithAuth(t, accessToken))
	require.Equal(t, http.StatusCreated, res.Code, res.Body.String())

	var created types.CreatedAPIKey
	test.ParseResponseAndValidate(t, res, &created)
	return *created.Key
}

// performAudioUpload posts a dummy audio clip to the recognize webhook.
func performAudioUpload(t *testing.T, s *api.Server, headers http.Header) *http.Response {
	t.Helper()
	body := &bytes.Buffer{}
	writer := multipart.NewWriter(body)
	part, err := writer.CreateFormFile("file", "clip.webm")
	require.NoError(t, err)
	// Binary content without a recognisable signature is sniffed as application/octet-stream.
	_, err = part.Write([]byte{0x00, 0x01, 0x02, 0x03, 0xfe, 0xff, 0x00, 0x10})
	require.NoError(t, err)
	require.NoError(t, writer.Close())

	headers = headers.Clone()
	if headers == nil {
		headers = http.Header{}
	}
	headers.Set("Content-Type", writer.FormDataContentType())
	return test.PerformRequestWithRawBody(t, s, http.MethodPost, "/api/v1/webhooks/recognize", body, headers, nil).Result()
}
