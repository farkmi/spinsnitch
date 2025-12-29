-- +migrate Up
CREATE TABLE track_plays (
    id serial PRIMARY KEY,
    track_id integer NOT NULL REFERENCES tracks (id) ON DELETE CASCADE,
    user_id uuid NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    played_at timestamp with time zone NOT NULL DEFAULT NOW(),
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_track_plays_track_id ON track_plays (track_id);

CREATE INDEX idx_track_plays_user_id ON track_plays (user_id);

CREATE INDEX idx_track_plays_played_at ON track_plays (played_at);

-- +migrate Down
DROP INDEX idx_track_plays_played_at;

DROP INDEX idx_track_plays_user_id;

DROP INDEX idx_track_plays_track_id;

DROP TABLE track_plays;

