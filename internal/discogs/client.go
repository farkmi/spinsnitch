package discogs

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

const (
	baseURL        = "https://api.discogs.com"
	userAgent      = "VinylAccountant/0.1 +http://spinsnitch.farkmi.com" // Recommended by Discogs
	defaultTimeout = 10 * time.Second
)

type Client struct {
	httpClient *http.Client
	token      string
	BaseURL    string
}

func NewClient(token string) *Client {
	return &Client{
		httpClient: &http.Client{
			Timeout: defaultTimeout,
		},
		token:   token,
		BaseURL: baseURL,
	}
}

type Release struct {
	ID        int      `json:"id"`
	Title     string   `json:"title"`
	Artists   []Artist `json:"artists"`
	Tracklist []Track  `json:"tracklist"`
	Year      int      `json:"year"`
	Genres    []string `json:"genres"`
	Styles    []string `json:"styles"`
	Images    []Image  `json:"images"`
}

type Image struct {
	Type   string `json:"type"` // primary, secondary
	URI    string `json:"uri"`  // full url
	URI150 string `json:"uri150"`
}

type Artist struct {
	Name string `json:"name"`
}

type Track struct {
	Position string `json:"position"`
	Title    string `json:"title"`
	Duration string `json:"duration"`
}

type SearchResponse struct {
	Results []SearchResult `json:"results"`
}

type SearchResult struct {
	ID    int    `json:"id"`
	Title string `json:"title"`
	// Artist info is usually embedded in title "Artist - Title" in search results
	// But sometimes separate. For simple search, Title and ID is enough.
	Thumb string `json:"thumb"`
}

func (c *Client) Search(ctx context.Context, query string) ([]SearchResult, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, fmt.Sprintf("%s/database/search", c.BaseURL), nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	q := req.URL.Query()
	q.Add("q", query)
	q.Add("type", "release")
	req.URL.RawQuery = q.Encode()

	req.Header.Set("User-Agent", userAgent)
	if c.token != "" {
		req.Header.Set("Authorization", fmt.Sprintf("Discogs token=%s", c.token))
	}

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to execute request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("discogs api returned status: %d", resp.StatusCode)
	}

	var searchResp SearchResponse
	if err := json.NewDecoder(resp.Body).Decode(&searchResp); err != nil {
		return nil, fmt.Errorf("failed to decode response: %w", err)
	}

	return searchResp.Results, nil
}

func (c *Client) GetRelease(ctx context.Context, id int) (*Release, error) {
	url := fmt.Sprintf("%s/releases/%d", c.BaseURL, id)
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Set("User-Agent", userAgent)
	if c.token != "" {
		req.Header.Set("Authorization", fmt.Sprintf("Discogs token=%s", c.token))
	}

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to execute request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("discogs api returned status: %d", resp.StatusCode)
	}

	var release Release
	if err := json.NewDecoder(resp.Body).Decode(&release); err != nil {
		return nil, fmt.Errorf("failed to decode response: %w", err)
	}

	return &release, nil
}

func (c *Client) DownloadImage(ctx context.Context, url string) ([]byte, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Set("User-Agent", userAgent)
	// Discogs images often require appropriate handling, sometimes auth if sensitive,
	// but generally public URLs work with UA.

	resp, err := c.httpClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to execute request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("image download failed with status: %d", resp.StatusCode)
	}

	// In a real app we might stream this to file directly to avoid memory pressure of large images
	// But covers are usually small (<1MB)
	var buf []byte
	// 5MB limit
	const (
		maxImageSize = 5 * 1024 * 1024
		bufSize      = 1024 * 1024
		chunkSize    = 1024
	)

	buf = make([]byte, 0, bufSize)

	// ReadAll with limit
	r := http.MaxBytesReader(nil, resp.Body, maxImageSize)
	// We read it all
	data := make([]byte, chunkSize)
	for {
		n, err := r.Read(data)
		if n > 0 {
			buf = append(buf, data[:n]...)
		}
		if err != nil {
			if err.Error() == "EOF" {
				break
			}
			return nil, fmt.Errorf("failed to read image body: %w", err)
		}
	}

	return buf, nil
}
