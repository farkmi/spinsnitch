package vinyl

import (
	"errors"
	"net/http"

	"github.com/farkmi/spinsnitch-server/internal/api"
	"github.com/farkmi/spinsnitch-server/internal/auth"
	"github.com/farkmi/spinsnitch-server/internal/types"
	"github.com/farkmi/spinsnitch-server/internal/util"
	"github.com/farkmi/spinsnitch-server/internal/vinyl"
	"github.com/go-openapi/swag/conv"
	"github.com/labstack/echo/v4"
)

func PostWebhookRecognizeRoute(s *api.Server) *echo.Route {
	return s.Router.APIV1Webhook.POST("/recognize", postWebhookRecognizeHandler(s))
}

// postWebhookRecognizeHandler is the one call a listening device makes per audio clip: identify
// the music and, if it is in the collection, register the play. Silence, unknown music and
// tracks outside the collection are expected outcomes, not errors.
func postWebhookRecognizeHandler(s *api.Server) echo.HandlerFunc {
	return func(c echo.Context) error {
		ctx := c.Request().Context()
		log := util.LogFromEchoContext(c)

		fileHeader, file, _, err := util.ParseFileUpload(c, "file", allowedAudioMIMETypes)
		if err != nil {
			return err
		}
		defer file.Close()

		recognition, err := s.Recognition.Recognize(ctx, file, fileHeader.Filename)
		if err != nil {
			log.Error().Err(err).Msg("Song recognition failed")
			return err
		}

		result := &types.RecognizeAndPlayResult{
			Recognized: conv.Pointer(recognition.Success),
			Matched:    conv.Pointer(false),
		}
		if !recognition.Success {
			return util.ValidateAndReturn(c, http.StatusOK, result)
		}

		recognized := recognition.ToTypes(s.Config.Echo.BaseURL)
		result.RecognizedArtist = recognized.Artist
		result.RecognizedTitle = recognized.Title
		result.ShazamURL = recognized.ShazamURL
		result.CoverArt = recognized.CoverArt

		play, err := s.Vinyl.RegisterPlay(ctx, auth.UserFromContext(ctx).ID, recognition.Artist, recognition.Title)
		if err != nil {
			if errors.Is(err, vinyl.ErrTrackNotFound) {
				log.Debug().Str("artist", recognition.Artist).Str("title", recognition.Title).Msg("Recognized track is not in the collection")
				return util.ValidateAndReturn(c, http.StatusOK, result)
			}
			return err
		}

		result.Matched = conv.Pointer(true)
		result.Play = play.ToTypes(s.Config.Echo.BaseURL)
		return util.ValidateAndReturn(c, http.StatusOK, result)
	}
}
