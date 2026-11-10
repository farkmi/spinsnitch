-- +migrate Up
-- Collections become per-user: every record (and with it its sides, tracks and play counts)
-- belongs to exactly one user.
ALTER TABLE vinyl_records
    ADD COLUMN user_id uuid;

-- Existing records predate multi-user support and were implicitly owned by the first user.
UPDATE
    vinyl_records
SET
    user_id = (
        SELECT
            id
        FROM
            users
        WHERE
            is_active
        ORDER BY
            created_at
        LIMIT 1);

-- Without any active user there is nobody to own them.
DELETE FROM vinyl_records
WHERE NOT EXISTS (
        SELECT
            1
        FROM
            users
        WHERE
            is_active);

ALTER TABLE vinyl_records
    ALTER COLUMN user_id SET NOT NULL;

ALTER TABLE vinyl_records
    ADD CONSTRAINT vinyl_records_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE vinyl_records
    DROP CONSTRAINT vinyl_records_discogs_id_key;

ALTER TABLE vinyl_records
    ADD CONSTRAINT vinyl_records_user_id_discogs_id_key UNIQUE (user_id, discogs_id);

CREATE INDEX idx_vinyl_records_fk_user_id ON vinyl_records USING btree (user_id);

-- +migrate Down
DROP INDEX idx_vinyl_records_fk_user_id;

ALTER TABLE vinyl_records
    DROP CONSTRAINT vinyl_records_user_id_discogs_id_key;

-- Only one copy per release can survive the old global uniqueness.
DELETE FROM vinyl_records a USING vinyl_records b
WHERE a.discogs_id = b.discogs_id
    AND a.id > b.id;

ALTER TABLE vinyl_records
    ADD CONSTRAINT vinyl_records_discogs_id_key UNIQUE (discogs_id);

ALTER TABLE vinyl_records
    DROP COLUMN user_id;

