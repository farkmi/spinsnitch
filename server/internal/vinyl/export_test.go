package vinyl

// Exports for tests in package vinyl_test.
var (
	NormalizeTitle = normalizeTitle
	ArtistsMatch   = artistsMatch
	MatchScore     = matchScore
)

const (
	ScoreNoMatch               = scoreNoMatch
	ScoreTitleOnVariousArtists = scoreTitleOnVariousArtists
	ScoreTitleAndArtist        = scoreTitleAndArtist
)
