-- Полная установка БД одной командой (запускать из папки sql/):
--   psql -d bakery_store -f install.sql
-- \ir — путь относительно этого файла
\set ON_ERROR_STOP on
\ir 01_schema.sql
\ir 02_seed.sql
