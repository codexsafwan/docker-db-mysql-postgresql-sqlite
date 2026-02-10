-- Users table
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role TEXT DEFAULT 'customer' CHECK(role IN ('admin', 'customer')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  slug TEXT UNIQUE
);

-- Products
CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  category_id INTEGER,
  name TEXT NOT NULL,
  price DECIMAL(10,2),
  stock INTEGER DEFAULT 0,
  status TEXT DEFAULT 'active' CHECK(status IN ('active', 'inactive')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Carts
CREATE TABLE carts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Cart Items
CREATE TABLE cart_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cart_id INTEGER,
  product_id INTEGER,
  quantity INTEGER DEFAULT 1,
  FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Orders
CREATE TABLE orders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  total DECIMAL(10,2),
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'paid', 'shipped', 'delivered', 'cancelled')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items
CREATE TABLE order_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id INTEGER,
  product_id INTEGER,
  price DECIMAL(10,2),
  quantity INTEGER,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Payments
CREATE TABLE payments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id INTEGER,
  method TEXT,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'success', 'failed')),
  transaction_id TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Reviews table
CREATE TABLE reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER,
  product_id INTEGER,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);
