-- Add phone column to users table (SQLite version)
-- Note: SQLite doesn't natively support IF NOT EXISTS for ADD COLUMN in all versions.
-- We use a standard ALTER TABLE.
ALTER TABLE users ADD COLUMN phone TEXT;

-- Optional: add some phone numbers to existing users
UPDATE users
SET phone = CASE
    WHEN id = 1 THEN '+8801700000001'
    WHEN id = 2 THEN '+8801700000002'
    WHEN id = 3 THEN '+8801700000003'
    ELSE phone
END
WHERE phone IS NULL;
