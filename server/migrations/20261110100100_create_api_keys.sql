-- +migrate Up
-- Long-lived per-user keys for integrations (e.g. Home Assistant). Only a SHA-256 hash of the
-- key is stored; the plain key is shown once at creation.
CREATE TABLE api_keys (
    id uuid NOT NULL DEFAULT uuid_generate_v4 (),
    user_id uuid NOT NULL,
    name text NOT NULL,
    key_hash text NOT NULL,
    key_prefix text NOT NULL,
    last_used_at timestamptz,
    created_at timestamptz NOT NULL,
    updated_at timestamptz NOT NULL,
    CONSTRAINT api_keys_pkey PRIMARY KEY (id),
    CONSTRAINT api_keys_key_hash_key UNIQUE (key_hash)
);

CREATE INDEX idx_api_keys_fk_user_id ON api_keys USING btree (user_id);

ALTER TABLE api_keys
    ADD CONSTRAINT api_keys_user_id_fkey FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;

-- +migrate Down
DROP TABLE IF EXISTS api_keys;

