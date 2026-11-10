package vinyl_test

import (
	"testing"

	"github.com/farkmi/spinsnitch-server/internal/vinyl"
	"github.com/stretchr/testify/assert"
)

func TestNormalizeTitle(t *testing.T) {
	tests := []struct {
		in, want string
	}{
		{"Get Lucky", "get lucky"},
		{"Get Lucky (feat. Pharrell Williams & Nile Rodgers)", "get lucky"},
		{"Get Lucky - Radio Edit", "get lucky"},
		{"Here Comes the Sun - Remastered 2009", "here comes the sun"},
		{"Here Comes The Sun [2019 Mix]", "here comes the sun"},
		{"Song ft. Someone", "song"},
		{"Rock & Roll", "rock and roll"},
		{"Café del Mar", "cafe del mar"},
		{"Don't Stop Me Now", "don t stop me now"},
		// A " - " without version keywords is part of the title.
		{"Shine On You Crazy Diamond - Parts I-V", "shine on you crazy diamond parts i v"},
	}
	for _, tt := range tests {
		assert.Equal(t, tt.want, vinyl.NormalizeTitle(tt.in), tt.in)
	}
}

func TestArtistsMatch(t *testing.T) {
	tests := []struct {
		recognized, record string
		want               bool
	}{
		{"Daft Punk", "Daft Punk", true},
		{"Daft Punk", "Daft Punk (2)", true},
		{"Daft Punk feat. Pharrell Williams", "Daft Punk", true},
		{"Daft Punk & Pharrell Williams", "Daft Punk", true},
		{"Beyoncé", "Beyonce", true},
		{"The Beatles", "Beatles, The", true},
		{"Beatles", "The Beatles", true},
		{"Simon & Garfunkel", "Simon And Garfunkel", true},
		{"Prince*", "Prince", true},
		{"Pharrell Williams", "Daft Punk", false},
		{"Daft Punk", "Various", false},
	}
	for _, tt := range tests {
		assert.Equal(t, tt.want, vinyl.ArtistsMatch(tt.recognized, tt.record), "%q vs %q", tt.recognized, tt.record)
	}
}

func TestMatchScore(t *testing.T) {
	assert.Equal(t, vinyl.ScoreTitleAndArtist, vinyl.MatchScore("Daft Punk feat. Pharrell Williams", "Get Lucky (Radio Edit)", "Get Lucky", "Daft Punk"))
	assert.Equal(t, vinyl.ScoreTitleOnVariousArtists, vinyl.MatchScore("Daft Punk", "Get Lucky", "Get Lucky", "Various"))
	assert.Equal(t, vinyl.ScoreNoMatch, vinyl.MatchScore("Daft Punk", "Get Lucky", "Get Lucky", "Some Cover Band"))
	assert.Equal(t, vinyl.ScoreNoMatch, vinyl.MatchScore("Daft Punk", "Lose Yourself to Dance", "Get Lucky", "Daft Punk"))
	assert.Equal(t, vinyl.ScoreNoMatch, vinyl.MatchScore("Daft Punk", "", "", "Daft Punk"))
}
