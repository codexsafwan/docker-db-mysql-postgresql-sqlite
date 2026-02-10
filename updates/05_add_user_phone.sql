-- Add phone column to users table (PostgreSQL version)
ALTER TABLE users ADD COLUMN IF NOT EXISTS phone VARCHAR(20);

-- Optional: add some phone numbers to existing users
UPDATE users
SET phone = CASE
    WHEN id = 1 THEN '+8801700000001'
    WHEN id = 2 THEN '+8801700000002'
    WHEN id = 3 THEN '+8801700000003'
    ELSE phone
END
WHERE phone IS NULL;
