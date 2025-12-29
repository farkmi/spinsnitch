# ShazamIO Microservice Specification

## Overview
This document serves as a complete specification for building a standalone **Music Recognition Microservice**. The service exposes a lightweight HTTP API that accepts audio files, identifies them using the unofficial Shazam API (via the `shazamio` Python library), and returns track metadata. It is designed to be deployed as a Docker container.

## Architecture
*   **Language:** Python 3.10+
*   **Framework:** FastAPI (High performance, easy async support)
*   **Core Library:** `shazamio` (Maintained unofficial Shazam wrapper)
*   **Infrastructure:** Docker (Alpine or Slim variant with `ffmpeg` installed)

## API Contract

### Endpoint: `POST /recognize`
*   **Description:** Upload an audio file for recognition.
*   **Content-Type:** `multipart/form-data`
*   **Parameter:** `file` (Binary audio file: .mp3, .wav, .ogg, .pcm)
*   **Response (JSON):**
    ```json
    {
      "status": "success",
      "track": {
        "title": "Song Title",
        "subtitle": "Artist Name",
        "shazam_url": "https://www.shazam.com/track/...",
        "cover_art": "https://is1-ssl.mzstatic.com/image/..."
      },
      "matches": [ ... ]
    }
    ```

## File Structure & Implementation Details

### 1. `requirements.txt`
Dependencies required for the Python environment.
```text
fastapi>=0.100.0
uvicorn>=0.20.0
shazamio>=0.5.0
python-multipart>=0.0.6
aiofiles>=23.1.0
```

### 2. `main.py`
The application entry point.

**Key Implementation Logic:**
*   Initialize `Shazam()` instance.
*   Define a global `shazam` object (or instantiate per request depending on concurrency needs - `ShazamIO` is async-native).
*   **Handler Logic:**
    1.  Read the incoming upload file bytes.
    2.  Pass bytes directly to `shazam.recognize_song(file_bytes)`.
    3.  Extract relevant fields (Title, Subtitle, Share URL, Images) from the raw payload to return a clean JSON response.
    4.  Handle `JSONDecodeError` or network timeouts gracefully.

### 3. `Dockerfile`
A production-ready Dockerfile. Critical requirement: **ffmpeg must be installed**.

```dockerfile
# Use generic python slim image
FROM python:3.11-slim

# CRITICAL: Install ffmpeg (required by shazamio for audio processing)
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Run the application
# Host 0.0.0.0 is required for Docker networking
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Setup & Verification Instructions

### Local Development
1.  **Install:** `pip install -r requirements.txt` (Ensure `ffmpeg` is in your system PATH).
2.  **Run:** `uvicorn main:app --reload`.
3.  **Test:** Use Postman or Curl to send a sample `.mp3` to `http://127.0.0.1:8000/recognize`.

### Docker Deployment
1.  **Build:** `docker build -t shazam-service .`
2.  **Run:** `docker run -d -p 8000:8000 --name shazam-svc shazam-service`
3.  **Verify:** `curl -X POST -F "file=@/path/to/sample.mp3" http://localhost:8000/recognize`
