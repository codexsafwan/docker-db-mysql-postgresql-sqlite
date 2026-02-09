# 🛒 E-Commerce Database with Docker & MySQL

A complete e-commerce database setup using **Docker**, **MySQL 8.0**, and **Adminer** for database management. This project includes a fully structured database schema with tables for users, products, orders, payments, and more.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Database Schema](#-database-schema)
- [Usage Guide](#-usage-guide)
- [Database Operations](#-database-operations)
- [Troubleshooting](#-troubleshooting)
- [Environment Variables](#-environment-variables)

---

## ✨ Features

- 🐳 **Dockerized MySQL 8.0** - Fully containerized database
- 🎨 **Adminer Web UI** - Database management interface
- 📊 **Complete E-Commerce Schema** - Users, Products, Orders, Payments, Carts
- 🔄 **Auto-initialization** - Database and tables created automatically
- 🌱 **Seed Data** - Pre-populated sample data for testing
- 📝 **Migration Support** - Organized SQL update scripts
- 🔒 **Secure Configuration** - Environment-based credentials

---

## 🛠 Tech Stack

- **Database**: MySQL 8.0
- **Container**: Docker & Docker Compose
- **Admin Tool**: Adminer
- **Language**: SQL

---

## 📁 Project Structure

```
docker-db-mysql-postgresql-sqlite/
├── docker-compose.yml          # Docker services configuration
├── .env                        # Environment variables (credentials)
├── run_sql.sh                  # Script to run SQL files with dynamic DB name from .env
├── Readme.md                   # This file
├── sql/                        # Initial database setup (auto-runs on first start)
│   ├── 01_tables.sql          # Table definitions (uses {{DB_NAME}} placeholder)
│   ├── 02_indexes.sql         # Database indexes (uses {{DB_NAME}} placeholder)
│   └── 03_seed_data.sql       # Sample data (uses {{DB_NAME}} placeholder)
└── updates/                    # Database migration scripts
    └── 05_add_user_phone.sql  # Add phone column to users table

**Note**: All SQL files use `{{DB_NAME}}` placeholder which is dynamically replaced with the value from `.env` file's `MYSQL_DATABASE` variable when using `run_sql.sh`.
```

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **Docker** (v20.10+)
- **Docker Compose** (v2.0+)

Check your installation:

```bash
docker --version
docker-compose --version
```

---

## 🚀 Quick Start

### 1. Clone or Navigate to Project Directory

```bash
cd /path/to/docker-db-mysql-postgresql-sqlite
```

### 2. Start the Database

```bash
docker-compose up -d
```

This will:

- ✅ Pull MySQL 8.0 and Adminer images
- ✅ Create `ecommerce_db` database
- ✅ Execute all SQL files in `sql/` directory (tables, indexes, seed data)
- ✅ Start Adminer web interface

### 3. Verify Services are Running

```bash
docker-compose ps
```

You should see:

```
NAME                  STATUS    PORTS
ecommerce-mysql       Up        0.0.0.0:3306->3306/tcp
ecommerce-adminer     Up        0.0.0.0:8080->8080/tcp
```

### 4. Access Adminer (Web UI)

Open your browser and go to: **http://localhost:8080**

**Login credentials:**

- **System**: `MySQL`
- **Server**: `db`
- **Username**: `root`
- **Password**: `rootpassword`
- **Database**: `ecommerce_db`

---

## 🗄 Database Schema

The database includes the following tables:

### Core Tables

| Table         | Description                                        |
| ------------- | -------------------------------------------------- |
| `users`       | User accounts (admin/customer) with authentication |
| `categories`  | Product categories                                 |
| `products`    | Product catalog with pricing and stock             |
| `carts`       | Shopping carts for users                           |
| `cart_items`  | Items in shopping carts                            |
| `orders`      | Customer orders with status tracking               |
| `order_items` | Individual items in orders                         |
| `payments`    | Payment transactions                               |

### Entity Relationship Diagram

```
users (1) ──→ (N) carts ──→ (N) cart_items ──→ (1) products
  │                                                    │
  │                                                    │
  └──→ (N) orders ──→ (N) order_items ─────────────────┘
         │
         └──→ (N) payments

categories (1) ──→ (N) products
```

---

## 📖 Usage Guide

### Access MySQL from Command Line

#### Option 1: Using Docker Exec (Recommended)

```bash
# Interactive MySQL shell
docker exec -it ecommerce-mysql mysql -uroot -prootpassword ecommerce_db

# Execute a single query
docker exec -i ecommerce-mysql mysql -uroot -prootpassword -e "SELECT * FROM users;" ecommerce_db
```

#### Option 2: Using Local MySQL Client

```bash
mysql -h 127.0.0.1 -P 3306 -uroot -prootpassword ecommerce_db
```

### Common SQL Queries

```sql
-- View all users
SELECT * FROM users;

-- View products with categories
SELECT p.name, p.price, c.name as category
FROM products p
JOIN categories c ON p.category_id = c.id;

-- View orders with user details
SELECT o.id, u.name, o.total, o.status
FROM orders o
JOIN users u ON o.user_id = u.id;

-- View cart contents
SELECT u.name, p.name as product, ci.quantity
FROM cart_items ci
JOIN carts c ON ci.cart_id = c.id
JOIN users u ON c.user_id = u.id
JOIN products p ON ci.product_id = p.id;
```

---

## 🔧 Database Operations

### Stop the Database

```bash
docker-compose down
```

### Stop and Remove All Data (Fresh Start)

```bash
docker-compose down -v
```

> ⚠️ **Warning**: This will delete all data in the database!

### Restart the Database

```bash
docker-compose restart
```

### View Database Logs

```bash
docker-compose logs db
```

### Backup Database

```bash
docker exec ecommerce-mysql mysqldump -uroot -prootpassword ecommerce_db > backup_$(date +%Y%m%d).sql
```

### Restore Database

```bash
docker exec -i ecommerce-mysql mysql -uroot -prootpassword ecommerce_db < backup_20260209.sql
```

---

## 🔄 Running Database Migrations

### Dynamic Database Name Support

All SQL files in this project use the `{{DB_NAME}}` placeholder instead of hardcoded database names. This allows you to change the database name in `.env` without modifying SQL files.

### Execute Update Scripts

The `updates/` folder contains migration scripts for schema changes.

#### Method 1: Using run_sql.sh Script (Recommended) ⭐

This script automatically loads the database name from `.env` and replaces `{{DB_NAME}}` placeholder:

```bash
# Make script executable (first time only)
chmod +x run_sql.sh

# Run any SQL file
./run_sql.sh updates/05_add_user_phone.sql

# Run initialization scripts
./run_sql.sh sql/01_tables.sql
./run_sql.sh sql/02_indexes.sql
./run_sql.sh sql/03_seed_data.sql
```

**Benefits:**

- ✅ Automatically uses database name from `.env`
- ✅ No need to hardcode database names
- ✅ Easy to switch between different databases
- ✅ Consistent execution across environments

#### Method 2: Manual Execution with sed

```bash
# Load .env variables
export $(cat .env | grep -v '^#' | xargs)

# Execute with placeholder replacement
sed "s/{{DB_NAME}}/$MYSQL_DATABASE/g" updates/05_add_user_phone.sql | \
    docker exec -i ecommerce-mysql mysql -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"
```

#### Method 3: From MySQL Shell

```bash
# Enter MySQL shell
docker exec -it ecommerce-mysql mysql -uroot -prootpassword ecommerce_db

# Run migration (note: {{DB_NAME}} won't be replaced)
source /docker-entrypoint-updates.d/05_add_user_phone.sql
```

> ⚠️ **Note**: This method requires the database to already be selected or you need to manually replace `{{DB_NAME}}` with the actual database name.

#### Method 4: Using Adminer

1. Go to http://localhost:8080
2. Login with credentials
3. Click **SQL command**
4. Paste SQL from `updates/05_add_user_phone.sql`
5. Manually replace `{{DB_NAME}}` with `ecommerce_db` (or your database name)
6. Click **Execute**

---

## 🐛 Troubleshooting

### Port Already in Use

If port 3306 or 8080 is already in use:

```bash
# Check what's using the port
lsof -i :3306
lsof -i :8080

# Option 1: Stop the conflicting service
# Option 2: Change port in docker-compose.yml
ports:
  - "3307:3306"  # Use 3307 instead
```

### Container Won't Start

```bash
# View detailed logs
docker-compose logs db

# Remove and recreate containers
docker-compose down
docker-compose up -d
```

### Permission Denied Errors

```bash
# Fix file permissions
chmod -R 755 sql/
chmod -R 755 updates/
```

### Database Not Initialized

```bash
# Remove volume and restart (will re-run initialization)
docker-compose down -v
docker-compose up -d
```

### Can't Connect to MySQL

```bash
# Check if container is running
docker ps

# Check MySQL is ready
docker exec ecommerce-mysql mysqladmin -uroot -prootpassword ping

# View MySQL error logs
docker logs ecommerce-mysql
```

---

## 🔐 Environment Variables

The `.env` file contains database credentials:

```env
MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_DATABASE=ecommerce_db
MYSQL_USER=ecommerce_user
MYSQL_PASSWORD=ecommerce_pass
```

> 🔒 **Security Note**: Change these values in production and never commit `.env` to version control!

### Using Custom Credentials

1. Edit `.env` file with your credentials
2. Restart containers:
   ```bash
   docker-compose down -v
   docker-compose up -d
   ```

---

## 📊 Sample Data

The database comes pre-populated with:

- ✅ **4 Users** (1 admin, 3 customers)
- ✅ **4 Categories** (Electronics, Fashion, Home & Kitchen, Books)
- ✅ **8 Products** with stock and pricing
- ✅ **2 Shopping Carts** with items
- ✅ **2 Orders** (1 pending, 1 paid)
- ✅ **2 Payments** (1 pending, 1 success)

---

## 🎯 Next Steps

- [ ] Connect your application to the database
- [ ] Add more migration scripts to `updates/`
- [ ] Implement backup automation
- [ ] Set up database monitoring
- [ ] Configure replication for production

---

## 📝 License

This project is open-source and available for educational purposes.

---

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

---

**Happy Coding! 🚀**
