USE {{DB_NAME}};

-- Add phone column to users table (safe way - checks if column exists)
SET @dbname = DATABASE();
SET @tablename = 'users';
SET @columnname = 'phone';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (table_name = @tablename)
      AND (table_schema = @dbname)
      AND (column_name = @columnname)
  ) > 0,
  'SELECT 1',
  'ALTER TABLE users ADD COLUMN phone VARCHAR(20) AFTER email'
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- Optional: add some phone numbers to existing users
UPDATE users
SET phone = CASE
    WHEN id = 1 THEN '+8801700000001'
    WHEN id = 2 THEN '+8801700000002'
    WHEN id = 3 THEN '+8801700000003'
    ELSE phone
END
WHERE phone IS NULL;
