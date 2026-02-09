USE {{DB_NAME}};

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
