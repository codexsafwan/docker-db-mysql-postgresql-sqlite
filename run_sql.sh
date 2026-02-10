#!/bin/bash

# Script to run SQL files with dynamic database name from .env
# Usage: ./run_sql.sh <sql_file_path>

set -e

# Load environment variables from .env
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "Error: .env file not found"
    exit 1
fi

# Check if SQL file is provided
if [ -z "$1" ]; then
    echo "Usage: ./run_sql.sh <sql_file_path>"
    echo "Example: ./run_sql.sh updates/05_add_user_phone.sql"
    exit 1
fi

SQL_FILE=$1

# Check if file exists
if [ ! -f "$SQL_FILE" ]; then
    echo "Error: SQL file '$SQL_FILE' not found"
    exit 1
fi

echo "📊 Executing SQL file: $SQL_FILE"
echo "🗄️  Database: $DB_NAME"
echo "🐳 Container: ecommerce-sqlite"
echo ""

# Execute SQL file using sqlite3 in the sqlite container
# We pipe the SQL file into the sqlite3 command
docker exec -i ecommerce-sqlite sqlite3 "$SQLITE_PATH" < "$SQL_FILE"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SQL file executed successfully!"
else
    echo ""
    echo "❌ Error executing SQL file"
    exit 1
fi
