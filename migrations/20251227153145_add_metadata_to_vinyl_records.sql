-- +migrate Up
ALTER TABLE vinyl_records
    ADD COLUMN year integer;

ALTER TABLE vinyl_records
    ADD COLUMN cover_image text;

ALTER TABLE vinyl_records
    ADD COLUMN thumb_image text;

ALTER TABLE vinyl_records
    ADD COLUMN genres text[];

ALTER TABLE vinyl_records
    ADD COLUMN styles text[];

-- +migrate Down
ALTER TABLE vinyl_records
    DROP COLUMN styles;

ALTER TABLE vinyl_records
    DROP COLUMN genres;

ALTER TABLE vinyl_records
    DROP COLUMN thumb_image;

ALTER TABLE vinyl_records
    DROP COLUMN cover_image;

ALTER TABLE vinyl_records
    DROP COLUMN year;

