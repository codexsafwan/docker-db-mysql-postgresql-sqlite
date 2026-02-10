# 🛒 E-Commerce Database with Docker & SQLite

A lightweight e-commerce database setup using **Docker**, **SQLite 3**, and **Adminer** for database management. This project stores all data in a local file (`sqlite/ecommerce.db`), making it extremely portable and easy to set up.

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

- 🐳 **Dockerized SQLite 3** - Lightweight, file-based database
- 📊 **Complete E-Commerce Schema** - Users, Products, Categories, Orders, Payments, Reviews
- 🌱 **Seed Data** - Pre-populated sample data for testing
- 📝 **Migration Support** - Automated SQL update scripts via `run_sql.sh`
- 🔒 **Secure Configuration** - Environment-based credentials

---

## 🛠 Tech Stack

- **Database**: SQLite 3
- **Container**: Docker (using `keinos/sqlite3`)
- **Admin Tool**: Adminer
- **Language**: SQL (SQLite Syntax)

---

## 📁 Project Structure

```
docker-db-mysql-postgresql-sqlite/
├── docker-compose.yml          # Docker services configuration
├── .env                        # Environment variables
├── run_sql.sh                  # Script to run SQL files in SQLite container
├── Readme.md                   # This file
├── sqlite/                     # Directory for SQLite database file
│   └── ecommerce.db           # The actual database file
├── sql/                        # Initial database setup
│   ├── 01_tables.sql          # Table definitions
│   ├── 02_indexes.sql         # Database indexes
│   └── 03_seed_data.sql       # Sample data
└── updates/                    # Database migration scripts
```

---

## 📦 Prerequisites

- **Docker** and **Docker Compose** installed on your system.

---

## 🚀 Quick Start

### 1. Start the Containers

```bash
docker-compose up -d
```

### 2. Initialize the Database

SQLite requires manual initialization of the database file from the scripts:

```bash
# Make script executable
chmod +x run_sql.sh

# Run initialization scripts
./run_sql.sh sql/01_tables.sql
./run_sql.sh sql/02_indexes.sql
./run_sql.sh sql/03_seed_data.sql

# Run updates
./run_sql.sh updates/05_add_user_phone.sql
./run_sql.sh updates/06_add_product_updated_at.sql
```

---

## 📖 Usage Guide

### Access SQLite CLI

```bash
docker exec -it ecommerce-sqlite sqlite3 /db/ecommerce.db
```

---

## 🔐 Environment Variables

The `.env` file should contain:

```env
DB_NAME=ecommerce.db
SQLITE_PATH=/db/ecommerce.db
```
