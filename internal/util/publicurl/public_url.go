package publicurl

import (
	"net/url"
	"path"
	"strings"
)

// Enrich prepends the baseURL to the relativePath if it's not already an absolute URL.
func Enrich(baseURL string, relativePath string) string {
	if relativePath == "" {
		return ""
	}

	// If it's already an absolute URL (starts with http:// or https://), return as is
	if strings.HasPrefix(relativePath, "http://") || strings.HasPrefix(relativePath, "https://") {
		return relativePath
	}

	u, err := url.Parse(baseURL)
	if err != nil {
		return relativePath
	}

	u.Path = path.Join(u.Path, relativePath)

	return u.String()
}
