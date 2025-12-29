# Spinsnitch Server

Spinsnitch is a self-hosted vinyl collection management and play-tracking server. It enables users to maintain a digital inventory of their vinyl records and track individual track plays for detailed listening history.

## Features

- **Discogs Integration**: Seamlessly search for and import vinyl releases directly from the Discogs database.
- **Collection Management**: Organize records by sides (A, B, etc.) and tracks.
- **Track Play Tracking**: Record exactly when you listen to a track with a built-in **30-minute debouncing window** to prevent accidental duplicates.
- **Listening Insights**: 
  - **Recent Plays**: Get a history of your latest listening sessions.
  - **Mistreated Records**: Identify records in your collection that haven't been played lately.
- **Cover Art Storage**: Automatically downloads and serves high-quality cover art for your collection.
- **Secure API**: Full user authentication and profile management via a RESTful API.

## Setup Requirements

### 1. Discogs API Credentials

To fetch data from Discogs, you need to create an application in your Discogs account:
1. Log into your [Discogs account](https://www.discogs.com/).
2. Go to **Settings** -> **Developers**.
3. Click on **"Create an application"**.
4. Note down your **Consumer Key** and **Consumer Secret**.

### 2. Environment Variables

The service is configured via environment variables. Create a `.env` file (or provide them via Docker) with the following:

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVER_DISCOGS_KEY` | Your Discogs Consumer Key | (Required) |
| `SERVER_DISCOGS_SECRET` | Your Discogs Consumer Secret | (Required) |
| `PGHOST` | Postgres Database Host | `postgres` |
| `PGPORT` | Postgres Database Port | `5432` |
| `PGDATABASE` | Postgres Database Name | `spinsnitch` |
| `PGUSER` | Postgres Database User | `dbuser` |
| `PGPASSWORD` | Postgres Database Password | (Required) |
| `SERVER_ECHO_BASE_URL` | Public URL of the server | `http://localhost:8080` |

## Deployment

Spinsnitch is designed to run in Docker. Below is a standard `docker-compose.yml` configuration:

```yaml
services:
  spinsnitch_db:
    image: postgres:17-alpine
    container_name: spinsnitch_db
    restart: always
    volumes:
      - ./postgres_data:/var/lib/postgresql/data
    env_file:
      - ./.spinsnitch.env

  spinsnitch:
    image: ghcr.io/farkmi/spinsnitch-server:latest
    container_name: spinsnitch
    restart: always
    ports:
      - 8350:8080
    volumes:
      - ./assets:/app/assets/mnt
    env_file:
      - ./.spinsnitch.env
    depends_on:
      - spinsnitch_db
```

### Volume Mapping
- **Database**: Ensure you map `/var/lib/postgresql/data` to a persistent volume.
- **Assets**: Map `/app/assets/mnt` to a local folder to persist downloaded cover images and other dynamic assets.

## Development

The project uses a standard Go toolchain with SQLBoiler for the database layer and go-swagger for API definitions.

- **Build**: `make build`
- **Test**: `make test`
- **Lint**: `make lint`
- **Full Chain**: `make all`

For detailed information on the underlying starter kit, see [README-go-starter.md](README-go-starter.md).