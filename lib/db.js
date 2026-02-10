import { Pool } from 'pg';

const pool = new Pool({
  user: process.env.POSTGRES_USER || 'ecommerce_user',
  host: process.env.POSTGRES_HOST || 'localhost',
  database: process.env.POSTGRES_DB || 'ecommerce_db',
  password: process.env.POSTGRES_PASSWORD || 'ecommerce_pass',
  port: process.env.POSTGRES_PORT || 5432,
});

export const query = (text, params) => pool.query(text, params);
