-- Add updated_at column to products table
ALTER TABLE products ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Update existing records to sets updated_at to created_at
UPDATE products SET updated_at = created_at WHERE updated_at IS NULL;
