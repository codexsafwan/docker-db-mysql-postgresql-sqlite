-- Add updated_at column to products table (SQLite)
-- SQLite doesn't permit non-constant defaults in ALTER TABLE
ALTER TABLE products ADD COLUMN updated_at TIMESTAMP;

-- Update existing records to set updated_at to created_at or CURRENT_TIMESTAMP
UPDATE products SET updated_at = COALESCE(created_at, CURRENT_TIMESTAMP);
