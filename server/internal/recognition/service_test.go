package recognition_test

import (
	"context"
	"os"
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/config"
	"github.com/farkmi/spinsnitch-server/internal/recognition"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestService_Recognize(t *testing.T) {
	if testing.Short() {
		t.Skip("Skipping integration test in short mode")
	}

	cfg := config.DefaultServiceConfigFromEnv().Recognizer
	service := recognition.NewService(cfg)

	filePath := "/app/test/testdata/dont-talk-315229.mp3"
	file, err := os.Open(filePath)
	require.NoError(t, err)
	defer file.Close()

	ctx := context.Background()
	result, err := service.Recognize(ctx, file, "dont-talk-315229.mp3")
	if err != nil {
		t.Skipf("Recognizer service might be unreachable: %v", err)
	}

	assert.True(t, result.Success)
	assert.Equal(t, "Cosmonkey", result.Artist)
	assert.Equal(t, "Don't Talk", result.Title)
}
