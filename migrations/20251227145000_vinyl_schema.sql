-- +migrate Up
CREATE TABLE vinyl_records (
    id serial PRIMARY KEY,
    title text NOT NULL,
    artist text NOT NULL,
    discogs_id integer NOT NULL UNIQUE,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone NOT NULL DEFAULT NOW()
);

CREATE TABLE vinyl_sides (
    id serial PRIMARY KEY,
    vinyl_record_id integer NOT NULL REFERENCES vinyl_records (id) ON DELETE CASCADE,
    side_label text NOT NULL, -- "A", "B", etc.
    play_count integer NOT NULL DEFAULT 0,
    last_played_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone NOT NULL DEFAULT NOW(),
    UNIQUE (vinyl_record_id, side_label)
);

CREATE INDEX idx_vinyl_sides_vinyl_record_id ON vinyl_sides (vinyl_record_id);

CREATE TABLE tracks (
    id serial PRIMARY KEY,
    vinyl_side_id integer NOT NULL REFERENCES vinyl_sides (id) ON DELETE CASCADE,
    title text NOT NULL,
    position text NOT NULL, -- "A1", "B2", etc.
    duration text,
    created_at timestamp with time zone NOT NULL DEFAULT NOW(),
    updated_at timestamp with time zone NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_tracks_vinyl_side_id ON tracks (vinyl_side_id);

-- +migrate Down
DROP INDEX idx_tracks_vinyl_side_id;

DROP TABLE tracks;

DROP INDEX idx_vinyl_sides_vinyl_record_id;

DROP TABLE vinyl_sides;

DROP TABLE vinyl_records;

