# 🛒 E-Commerce Database with Docker & PostgreSQL

A complete e-commerce database setup using **Docker**, **PostgreSQL 15**, and **Adminer** for database management. This project includes a fully structured database schema with tables for users, products, orders, payments, and reviews.

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

- 🐳 **Dockerized PostgreSQL 15** - Fully containerized database
- 🎨 **Adminer Web UI** - Database management interface
- 📊 **Complete E-Commerce Schema** - Users, Products, Categories, Orders, Payments, Reviews
- 🔄 **Auto-initialization** - Database and tables created automatically on first start
- 🌱 **Seed Data** - Pre-populated sample data for testing
- 📝 **Migration Support** - Automated SQL update scripts via `run_sql.sh`
- 🔒 **Secure Configuration** - Environment-based credentials

---

## 🛠 Tech Stack

- **Database**: PostgreSQL 15
- **Container**: Docker & Docker Compose
- **Admin Tool**: Adminer
- **Language**: SQL (PostgreSQL Syntax)

---

## 📁 Project Structure

```
docker-db-mysql-postgresql-sqlite/
├── docker-compose.yml          # Docker services configuration
├── .env                        # Environment variables (credentials)
├── run_sql.sh                  # Script to run SQL files in PostgreSQL container
├── Readme.md                   # This file
├── sql/                        # Initial database setup (auto-runs on first start)
│   ├── 01_tables.sql          # Table definitions (PostgreSQL schema)
│   ├── 02_indexes.sql         # Database indexes
│   └── 03_seed_data.sql       # Sample data
└── updates/                    # Database migration scripts
    ├── 05_add_user_phone.sql  # Add phone column to users table
    └── 06_add_product_updated_at.sql # Add updated_at to products
```

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **Docker** (v20.10+)
- **Docker Compose** (v2.0+)

---

## 🚀 Quick Start

### 1. Start the Database

```bash
docker-compose up -d
```

This will:

- ✅ Pull PostgreSQL 15 and Adminer images
- ✅ Create `ecommerce_db` database
- ✅ Execute all SQL files in `sql/` directory (tables, indexes, seed data)
- ✅ Start Adminer web interface

### 2. Verify Services are Running

```bash
docker-compose ps
```

You should see:

```
NAME                  STATUS    PORTS
ecommerce-postgres    Up        0.0.0.0:5432->5432/tcp
ecommerce-adminer     Up        0.0.0.0:8080->8080/tcp
```

### 3. Access Adminer (Web UI)

Open your browser and go to: **http://localhost:8080**

**Login credentials:**

- **System**: `PostgreSQL`
- **Server**: `postgres`
- **Username**: `ecommerce_user` (from .env)
- **Password**: `ecommerce_pass` (from .env)
- **Database**: `ecommerce_db` (from .env)

---

## 📖 Usage Guide

### Access PostgreSQL from Command Line

#### Option 1: Using Docker Exec (Recommended)

```bash
# Interactive psql shell
docker exec -it ecommerce-postgres psql -U ecommerce_user -d ecommerce_db

# Execute a single query
docker exec -it ecommerce-postgres psql -U ecommerce_user -d ecommerce_db -c "SELECT * FROM users;"
```

#### Option 2: Using Local psql Client

```bash
psql -h localhost -p 5432 -U ecommerce_user -d ecommerce_db
```

---

## 🔄 Running Database Migrations

The project includes a helper script `run_sql.sh` to execute migration files easily.

### Execute Update Scripts

```bash
# Make script executable (first time only)
chmod +x run_sql.sh

# Run any SQL file (e.g., adding phone column)
./run_sql.sh updates/05_add_user_phone.sql
```

**Benefits:**

- ✅ Automatically loads credentials from `.env`
- ✅ Uses `PGPASSWORD` for non-interactive execution
- ✅ No need to remember complex `docker exec` syntax

---

## 🐛 Troubleshooting

### Port Already in Use

If port 5432 or 8080 is already in use:

```bash
# Change port in docker-compose.yml
ports:
  - "5433:5432"  # Use 5433 instead
```

### Database Not Initialized

If tables are missing, you may need to clear the volume and restart:

```bash
docker-compose down -v
docker-compose up -d
```

---

## 🔐 Environment Variables

The `.env` file contains database credentials:

```env
POSTGRES_USER=ecommerce_user
POSTGRES_PASSWORD=ecommerce_pass
POSTGRES_DB=ecommerce_db
```

> 🔒 **Security Note**: Never commit `.env` to version control!
