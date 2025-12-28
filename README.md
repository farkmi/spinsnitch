# Spinsnitch Recognizer

A lightweight FastAPI-based microservice for music recognition, powered by `shazamio` and `ffmpeg`.

## Features
- **Fast & Accurate**: Uses the unofficial Shazam API for high-performance song identification.
- **RESTful API**: Simple POST endpoint for audio file uploads.
- **Dockerized**: Easy deployment with a pre-configured Docker environment.
- **CI/CD Ready**: Automated tests and GHCR image publishing via GitHub Actions.

## API Specification
The API follows the OpenAPI 3.1 standard. You can find the static specification in `openapi.json` or access the interactive docs at `/docs` when the service is running.

### Endpoint: `POST /recognize`
Upload an audio file to identify the track.

**Request:**
- `Content-Type: multipart/form-data`
- `file`: The audio file (mp3, wav, etc.)

**Example Response:**
```json
{
  "status": "success",
  "track": {
    "title": "Song Title",
    "subtitle": "Artist Name",
    "shazam_url": "https://www.shazam.com/...",
    "cover_art": "https://..."
  }
}
```

## Quick Start

### Local Development (Python)
1. Install `ffmpeg` on your system.
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
3. Run the service:
   ```bash
   uvicorn app.main:app --reload
   ```

### Docker
1. Build the image:
   ```bash
   docker build -t spinsnitch-recognizer .
   ```
2. Run the container:
   ```bash
   docker run -p 8000:8000 spinsnitch-recognizer
   ```

## Development

### Running Tests
```bash
PYTHONPATH=. pytest tests/
```

### Exporting OpenAPI Spec
```bash
PYTHONPATH=. python3 generate_openapi.py
```

## License
MIT
