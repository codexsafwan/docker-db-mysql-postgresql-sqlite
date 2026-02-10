# 🛒 E-Commerce Database Showcase (Multi-DB)

Welcome to the **Multi-DB E-Commerce Showcase**. This repository demonstrates how to implement a consistent e-commerce schema across different database engines using Docker.

> [!IMPORTANT]
> This `main` branch serves as a **Documentation Hub**. To see the code and run the database, please switch to one of the dedicated branches below.

---

## 🌓 Choose Your Flavor

Each database engine has its own dedicated branch with optimized configurations and scripts.

| Branch                                                                                                 | Database Engine | Quick Link                                                                                         |
| :----------------------------------------------------------------------------------------------------- | :-------------- | :------------------------------------------------------------------------------------------------- |
| [`docker-mysql`](https://github.com/codexsafwan/docker-db-mysql-postgresql-sqlite/tree/docker-mysql)   | **MySQL 8.0**   | [View Branch](https://github.com/codexsafwan/docker-db-mysql-postgresql-sqlite/tree/docker-mysql)  |
| [`docker-psql`](https://github.com/codexsafwan/docker-db-mysql-postgresql-sqlite/tree/docker-psql)     | **PostgreSQL**  | [View Branch](https://github.com/codexsafwan/docker-db-mysql-postgresql-sqlite/tree/docker-psql)   |
| [`docker-sqlite`](https://github.com/codexsafwan/docker-db-mysql-postgresql-sqlite/tree/docker-sqlite) | **SQLite 3**    | [View Branch](https://github.com/codexsafwan/docker-db-mysql-postgresql-sqlite/tree/docker-sqlite) |

### 🔄 How to Switch

To get started, clone the repository and switch to your desired branch:

```bash
# To use MySQL
git checkout docker-mysql

# To use PostgreSQL
git checkout docker-psql

# To use SQLite
git checkout docker-sqlite
```

---

## 📊 Technical Comparison

| Feature         | MySQL                   | PostgreSQL                | SQLite                              |
| :-------------- | :---------------------- | :------------------------ | :---------------------------------- |
| **Primary Key** | `BIGINT AUTO_INCREMENT` | `BIGSERIAL`               | `INTEGER PRIMARY KEY AUTOINCREMENT` |
| **Enum Types**  | Native `ENUM(...)`      | `CREATE TYPE ... AS ENUM` | `CHECK (...)` constraints           |
| **Timestamps**  | `NOW()`                 | `CURRENT_TIMESTAMP`       | `CURRENT_TIMESTAMP`                 |
| **Port**        | `3306`                  | `5432`                    | N/A (File-based)                    |
| **Ideal For**   | Web apps, CMS           | Performance, Integrity    | Dev/Test, Mobile, IoT               |

---

## 🤔 Why, When, & How?

### 🐬 MySQL

- **Why**: The gold standard for web applications and CMS (WordPress, Laravel).
- **When**: You need a reliable, widely supported database with strong community roots.
- **How**: Focuses on performance and ease of use. Ideal for standard CRUD apps.

### 🐘 PostgreSQL

- **Why**: Known for its advanced features, extensibility, and strict data integrity.
- **When**: You need complex queries, ACID compliance, or spatial data (PostGIS).
- **How**: Enterprise-ready. Handles "relational" data with more rigor than MySQL.

### 🪶 SQLite

- **Why**: Zero-configuration, serverless, and lives in a single file.
- **When**: Prototyping, small-scale apps, mobile apps, or local development where overhead is a concern.
- **How**: Perfect for "Docker-less" local testing or IoT devices.

---

## � Database Schema

All branches implement the same core e-commerce schema:

- **users**: Authentication and roles (admin, customer)
- **categories**: Product groupings
- **products**: Inventory, pricing, and stock
- **carts & cart_items**: Shopping session management
- **orders & order_items**: Transaction history
- **payments**: Payment status and methods
- **reviews**: Customer feedback and ratings

---

## 📝 License

This project is open-source and available for educational purposes. 🚀
