USE {{DB_NAME}};

-- ==========================================
-- Users
-- ==========================================
INSERT INTO users (name, email, password, role)
VALUES
('Admin', 'admin@shop.com', 'hashed_password', 'admin'),
('John Doe', 'john@example.com', 'hashed_password', 'customer'),
('Jane Smith', 'jane@example.com', 'hashed_password', 'customer');

-- ==========================================
-- Categories
-- ==========================================
INSERT INTO categories (name, slug)
VALUES
('Electronics', 'electronics'),
('Fashion', 'fashion'),
('Home & Kitchen', 'home-kitchen'),
('Books', 'books');

-- ==========================================
-- Products
-- ==========================================
INSERT INTO products (category_id, name, price, stock, status)
VALUES
(1, 'Laptop', 1200.00, 10, 'active'),
(1, 'Smartphone', 800.00, 25, 'active'),
(2, 'T-Shirt', 25.00, 50, 'active'),
(2, 'Jeans', 45.00, 40, 'active'),
(3, 'Coffee Maker', 99.00, 15, 'active'),
(3, 'Vacuum Cleaner', 150.00, 10, 'active'),
(4, 'Book: Learn SQL', 30.00, 20, 'active'),
(4, 'Book: React Guide', 35.00, 15, 'active');

-- ==========================================
-- Carts
-- ==========================================
INSERT INTO carts (user_id, created_at)
VALUES
(2, NOW()),
(3, NOW());

-- ==========================================
-- Cart Items
-- ==========================================
INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES
(1, 1, 1), -- John added Laptop
(1, 3, 2), -- John added T-Shirt x2
(2, 2, 1), -- Jane added Smartphone
(2, 4, 1); -- Jane added Jeans

-- ==========================================
-- Orders
-- ==========================================
INSERT INTO orders (user_id, total, status, created_at)
VALUES
(2, 1250.00, 'pending', NOW()), -- John
(3, 845.00, 'paid', NOW());     -- Jane

-- ==========================================
-- Order Items
-- ==========================================
INSERT INTO order_items (order_id, product_id, price, quantity)
VALUES
(1, 1, 1200.00, 1), -- Laptop
(1, 3, 25.00, 2),   -- T-Shirt x2
(2, 2, 800.00, 1),  -- Smartphone
(2, 4, 45.00, 1);   -- Jeans

-- ==========================================
-- Payments
-- ==========================================
INSERT INTO payments (order_id, method, status, transaction_id, created_at)
VALUES
(1, 'Credit Card', 'pending', 'TXN12345', NOW()),
(2, 'PayPal', 'success', 'TXN54321', NOW());

-- ==========================================
-- Reviews
-- ==========================================
INSERT INTO reviews (user_id, product_id, rating, comment)
VALUES
(2, 1, 5, 'Great laptop! Fast and reliable.'),
(3, 2, 4, 'Smartphone works well, battery could be better.'),
(2, 3, 5, 'T-Shirt quality is excellent.'),
(3, 4, 3, 'Jeans fit is okay, material average.');
