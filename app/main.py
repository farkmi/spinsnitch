from fastapi import FastAPI, UploadFile, File, HTTPException
from shazamio import Shazam
import uvicorn

app = FastAPI(title="ShazamIO Microservice")
shazam = Shazam()

@app.post("/recognize")
async def recognize_song(file: UploadFile = File(...)):
    """
    Upload an audio file for recognition.
    """
    try:
        # Read file bytes
        content = await file.read()
        
        # Recognize song
        out = await shazam.recognize_song(content)
        
        # Check if any track was found
        if not out.get('track'):
            return {
                "status": "success",
                "message": "No match found",
                "track": None,
                "matches": out.get('matches', [])
            }
        
        track = out['track']
        
        # Extract relevant fields
        response_data = {
            "status": "success",
            "track": {
                "title": track.get('title'),
                "subtitle": track.get('subtitle'),
                "shazam_url": track.get('share', {}).get('href'),
                "cover_art": track.get('images', {}).get('coverart')
            },
            "matches": out.get('matches', [])
        }
        
        return response_data

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
