# Spinsnitch Monorepo

Welcome to the **Spinsnitch** monorepo! This project is a comprehensive solution for vinyl collection management and play-tracking, featuring a mobile app, a backend server, and a music recognition service.

## Project Structure

This monorepo consists of three main components:

- **[mobile/](file:///home/farkmi/github/spinsnitch/mobile)**: A Flutter-based mobile application for managing your vinyl collection, scanning barcodes, and identifying music.
- **[server/](file:///home/farkmi/github/spinsnitch/server)**: A Go-based RESTful API server that handles collection data, Discogs integration, and user authentication.
- **[recognizer/](file:///home/farkmi/github/spinsnitch/recognizer)**: A Python/FastAPI microservice powered by `shazamio` and `ffmpeg` for high-performance music recognition.

## Getting Started

To get the entire system running locally, you can use the Docker Compose setup provided in the `server` directory.

### Quick Start (Development)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/farkmi/spinsnitch.git
   cd spinsnitch
   ```

2. **Configure Environment**:
   Follow the configuration instructions in the [server README](file:///home/farkmi/github/spinsnitch/server/README.md) to set up your Discogs API credentials and database settings.

3. **Launch the backend services**:
   ```bash
   cd server
   docker compose up --build
   ```

4. **Run the mobile app**:
   Follow the instructions in the [mobile README](file:///home/farkmi/github/spinsnitch/mobile/README.md) to set up Flutter and run the application on your preferred platform.

## Features

- **Discogs Integration**: Import your vinyl collection directly from Discogs.
- **Music Recognition**: Identify what's playing using your device's microphone.
- **Play Tracking**: Log your listening history with ease.
- **Cross-Platform**: Available on Android, iOS, and Linux/Web.

## Documentation

For detailed information on each component, please refer to their respective documentation:

- [Mobile Documentation](file:///home/farkmi/github/spinsnitch/mobile/README.md)
- [Server Documentation](file:///home/farkmi/github/spinsnitch/server/README.md)
- [Recognizer Documentation](file:///home/farkmi/github/spinsnitch/recognizer/README.md)

## CI/CD

This project uses GitHub Actions for continuous integration and delivery. Workflows are centrally managed in the [.github/workflows/](file:///home/farkmi/github/spinsnitch/.github/workflows) directory.

## License

This project is licensed under the MIT License.
