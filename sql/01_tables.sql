-- Create ENUM types
CREATE TYPE user_role AS ENUM ('admin', 'customer');
CREATE TYPE product_status AS ENUM ('active', 'inactive');
CREATE TYPE order_status AS ENUM ('pending', 'paid', 'shipped', 'delivered', 'cancelled');
CREATE TYPE payment_status AS ENUM ('pending', 'success', 'failed');

-- Users table
CREATE TABLE users (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role user_role DEFAULT 'customer',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories
CREATE TABLE categories (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  slug VARCHAR(150) UNIQUE
);

-- Products
CREATE TABLE products (
  id BIGSERIAL PRIMARY KEY,
  category_id BIGINT,
  name VARCHAR(200) NOT NULL,
  price DECIMAL(10,2),
  stock INT DEFAULT 0,
  status product_status DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Carts
CREATE TABLE carts (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Cart Items
CREATE TABLE cart_items (
  id BIGSERIAL PRIMARY KEY,
  cart_id BIGINT,
  product_id BIGINT,
  quantity INT DEFAULT 1,
  FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Orders
CREATE TABLE orders (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  total DECIMAL(10,2),
  status order_status DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items
CREATE TABLE order_items (
  id BIGSERIAL PRIMARY KEY,
  order_id BIGINT,
  product_id BIGINT,
  price DECIMAL(10,2),
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Payments
CREATE TABLE payments (
  id BIGSERIAL PRIMARY KEY,
  order_id BIGINT,
  method VARCHAR(50),
  status payment_status DEFAULT 'pending',
    transaction_id VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Reviews table
CREATE TABLE reviews (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  product_id BIGINT,
  rating INT CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
