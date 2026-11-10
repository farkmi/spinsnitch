package vinyl

import (
	"regexp"
	"strings"
	"unicode"

	"golang.org/x/text/runes"
	"golang.org/x/text/transform"
	"golang.org/x/text/unicode/norm"
)

// Recognition services (Shazam) and Discogs name the same track differently: Shazam adds
// "(feat. X)", "- 2011 Remaster" and the like, Discogs numbers ambiguous artists "Artist (2)"
// or marks name variations with "*". Matching compares normalized forms of both sides.

const (
	scoreNoMatch = iota
	// Title matches on a compilation, where the record artist says nothing about the track.
	scoreTitleOnVariousArtists
	scoreTitleAndArtist
)

var (
	bracketRe       = regexp.MustCompile(`[(\[][^)\]]*[)\]]`)
	versionSuffixRe = regexp.MustCompile(`\s+-\s+[^-]*\b(remaster(ed)?|version|edit|mix|live|mono|stereo|demo|single|radio|acoustic)\b.*$`)
	featRe          = regexp.MustCompile(`\s+(feat\.?|ft\.?|featuring)\s+.*$`)
	artistSplitRe   = regexp.MustCompile(`\s*(?:,|&|\+|/|\bx\b|\band\b|\bwith\b|\bvs\.?|\bfeat\.?|\bft\.?|\bfeaturing\b)\s*`)
	nonAlnumRe      = regexp.MustCompile(`[^\p{L}\p{N}]+`)
	leadingTheRe    = regexp.MustCompile(`^the\s+`)
)

func foldDiacritics(s string) string {
	t := transform.Chain(norm.NFD, runes.Remove(runes.In(unicode.Mn)), norm.NFC)
	out, _, err := transform.String(t, s)
	if err != nil {
		return s
	}
	return out
}

func collapse(s string) string {
	return strings.Join(strings.Fields(nonAlnumRe.ReplaceAllString(s, " ")), " ")
}

func normalizeTitle(title string) string {
	title = strings.ToLower(foldDiacritics(title))
	title = bracketRe.ReplaceAllString(title, " ")
	title = versionSuffixRe.ReplaceAllString(title, "")
	title = featRe.ReplaceAllString(title, "")
	title = strings.ReplaceAll(title, "&", " and ")
	return collapse(title)
}

func normalizeArtist(s string) string {
	s = strings.ToLower(foldDiacritics(s))
	s = bracketRe.ReplaceAllString(s, " ")
	s = strings.ReplaceAll(s, "&", " and ")
	s = collapse(s)
	return leadingTheRe.ReplaceAllString(s, "")
}

// artistNames returns the normalized full artist string plus each individual artist it lists.
func artistNames(s string) []string {
	names := []string{normalizeArtist(s)}
	lowered := bracketRe.ReplaceAllString(strings.ToLower(foldDiacritics(s)), " ")
	for _, part := range artistSplitRe.Split(lowered, -1) {
		if n := normalizeArtist(part); n != "" {
			names = append(names, n)
		}
	}
	return names
}

func isVariousArtists(recordArtist string) bool {
	n := normalizeArtist(recordArtist)
	return n == "various" || n == "various artists"
}

func artistsMatch(recognized string, recordArtist string) bool {
	recordNames := artistNames(recordArtist)
	for _, a := range artistNames(recognized) {
		if a == "" {
			continue
		}
		for _, r := range recordNames {
			if a == r {
				return true
			}
		}
	}
	return false
}

// matchScore rates how well a recognized artist/title fits a track of a record in the collection.
func matchScore(recognizedArtist, recognizedTitle, trackTitle, recordArtist string) int {
	title := normalizeTitle(recognizedTitle)
	if title == "" || title != normalizeTitle(trackTitle) {
		return scoreNoMatch
	}
	if artistsMatch(recognizedArtist, recordArtist) {
		return scoreTitleAndArtist
	}
	if isVariousArtists(recordArtist) {
		return scoreTitleOnVariousArtists
	}
	return scoreNoMatch
}
