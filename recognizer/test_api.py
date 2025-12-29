import requests
import sys

def test_recognition(file_path, url="http://localhost:8000/recognize"):
    print(f"Testing recognition for {file_path} at {url}...")
    try:
        with open(file_path, 'rb') as f:
            files = {'file': f}
            response = requests.post(url, files=files)
            
        if response.status_code == 200:
            print("Success!")
            print(response.json())
        else:
            print(f"Error: {response.status_code}")
            print(response.text)
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python test_api.py <path_to_audio_file>")
    else:
        test_recognition(sys.argv[1])
