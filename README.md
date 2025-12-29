# SpinSnitch Mobile

SpinSnitch is your ultimate vinyl companion. Manage your collection, discover new records, and never lose track of what you're spinning.

## Features

- 📚 **Collection Management**: Keep track of every vinyl in your library.
- 🔍 **Smart Search**: Search by artist, album title, or barcode.
- 📸 **Barcode Scanning**: Quickly add new records to your library by scanning the barcode on the back of the casing.
- 🎧 **Active Listening**: Automatically identify what's currently playing via your microphone and register it to your play history.
- 📱 **Background Recognition**: (Mobile only) Continue identifying music even when the app is in the background.
- 💻 **Cross-Platform**: Support for Android, iOS, and now Linux/Web (for debugging or "listening post" setups).

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- A running instance of the SpinSnitch Backend.

### Linux System Dependencies

To enable audio recording and music recognition on Linux (e.g., Ubuntu, Raspberry Pi), you must install the following system dependencies:

```bash
# Install audio encoding/decoding tools
sudo apt-get update
sudo apt-get install fmedia ffmpeg
```

*Note: The `record` package on Linux relies on `fmedia` or `ffmpeg` to handle audio capture and encoding.*

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/spinsnitch-mobile.git
    cd spinsnitch-mobile
    ```

2.  **Install Flutter dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Configure the backend URL**:
    Update the API base URL in `lib/config.dart` (if applicable) or through your environment configuration.

4.  **Run the application**:
    ```bash
    # Run on default device
    flutter run

    # Run for Linux
    flutter run -d linux

    # Run for Web
    flutter run -d chrome
    ```

## Project Structure

- `lib/screens/`: UI screens for library, search, and scanning.
- `lib/services/`: Core logic for music recognition and background services.
- `packages/spinsnitch_api/`: Auto-generated API client for the SpinSnitch backend.

## Development

### Regenerating the API Client

If the backend API changes, you can-regenerate the Dart client using:
```bash
./generate_api.sh
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
