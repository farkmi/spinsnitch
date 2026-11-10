package vinyl

import (
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/labstack/echo/v4"
)

// Audio MIME types accepted for recognition uploads.
var allowedAudioMIMETypes = []string{
	"audio/mpeg",
	"audio/x-wav",
	"audio/wav",
	"audio/ogg",
	"audio/mp4",
	"audio/aac",
	"audio/flac",
	"audio/webm",
	"video/webm",
	"application/octet-stream", // some clients send octet-stream
}

func PostRecognizeRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Vinyl.POST("/recognize", postRecognizeHandler(s))
}

func postRecognizeHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		log := util.LogFromEchoContext(c)

		fileHeader, file, _, err := util.ParseFileUpload(c, "file", allowedAudioMIMETypes)
		if err != nil {
			return err
		}
		defer file.Close()

		result, err := s.Recognition.Recognize(ctx, file, fileHeader.Filename)
		if err != nil {
			log.Error().Err(err).Msg("Song recognition failed")
			return err
		}

		return util.ValidateAndReturn(c, http.StatusOK, result.ToTypes(s.Config.Echo.BaseURL))
	}
}
