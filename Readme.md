# � E-Commerce Fullstack Showcase (Next.js + PostgreSQL)

This branch demonstrates a complete fullstack integration of a **Next.js App Router** frontend with a **PostgreSQL 15** database, all orchestrated via Docker.

> [!TIP]
> This is a specialized implementation branch. To see other database versions (MySQL, SQLite) or the comparison matrix, head back to the [**Main Hub**](https://github.com/codexsafwan/docker-db-mysql-postgresql-sqlite).

---

## ✨ Features

- ⚡ **Next.js 14 (App Router)** - Modern React server components.
- 🐘 **Direct PostgreSQL Integration** - High-performance queries using the `pg` library.
- 🎨 **Unified Dashboard** - View Products and Categories on a single, premium page.
- � **One-Command Setup** - Database and Frontend start together via Docker Compose.
- 📦 **Optimized Builds** - Multi-stage Dockerfile with standalone output support.
- 🌱 **Auto-Seeded Data** - Pre-populated inventory ready for exploration.

---

## 🛠 Tech Stack

- **Frontend**: Next.js 14, Tailwind CSS, JavaScript (`.jsx`)
- **Database**: PostgreSQL 15
- **Driver**: `pg` (Node-Postgres)
- **Orchestration**: Docker & Docker Compose

---

## 🚀 Quick Start

Ensure you have **Docker** and **Docker Compose** installed.

### 1. Launch the Stack

```bash
docker-compose up -d --build
```

This command starts:

- `ecommerce-postgres`: The persistent database.
- `next-app`: The Next.js dashboard at **http://localhost:3000**.
- `ecommerce-adminer`: Web GUI for DB management at **http://localhost:8080**.

### 2. Verify Data

Once the containers are up, visit **http://localhost:3000**. You should see a list of Categories and Products fetched directly from the database.

---

## 📁 Project Structure

```
.
├── app/                  # Next.js App Router (Layout, Page, CSS)
├── lib/                  # Database connection utilities
├── sql/                  # PostgreSQL schema and seed data
├── updates/              # Schema migration scripts
├── docker-compose.yml    # Unified stack configuration
├── Dockerfile            # Optimized Next.js build
└── .env                  # Environment variables (Credentials)
```

---

## 🔄 Database Operations

### Run Migrations

Use the helper script to apply updates to the running PostgreSQL container:

```bash
chmod +x run_sql.sh
./run_sql.sh updates/05_add_user_phone.sql
```

### Access CLI

```bash
docker exec -it ecommerce-postgres psql -U ecommerce_user -d ecommerce_db
```

---

## 🤔 Why this architecture?

By using **Next.js Server Components** and a direct **SQL Driver (`pg`)**, we eliminate the overhead of traditional REST/GraphQL layers for simple internal tools. This provides:

1. **Lower Latency**: Direct data fetching on the server.
2. **Simplified Schema**: Your SQL is the source of truth—no complex ORM mappings required.
3. **Type Safety (Optional)**: While this branch uses JS for simplicity, the pattern easily scales to TypeScript.

---

## � Back to Hub

Want to see the MySQL or SQLite version?

```bash
git checkout main
```

---

## � License

Open-source for educational purposes. 🚀
