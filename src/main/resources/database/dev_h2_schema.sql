-- Users
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('USER', 'ADMIN') NOT NULL DEFAULT 'USER'
);

-- Products
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    sub_category_id INT,
    era_id INT,
    date_added DATE NOT NULL,
    is_out_of_stock BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (sub_category_id) REFERENCES sub_categories(id),
    FOREIGN KEY (era_id) REFERENCES eras(id)
);

-- Product Sizes (only for clothing items)
CREATE TABLE product_sizes (
    product_id INT,
    size VARCHAR(50) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id),
    PRIMARY KEY (product_id, size)
);

-- Categories
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Sub-Categories
CREATE TABLE sub_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Eras
CREATE TABLE eras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    era_name VARCHAR(50) NOT NULL UNIQUE
);

-- Carts
CREATE TABLE carts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Cart Items
CREATE TABLE cart_items (
    cart_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    PRIMARY KEY (cart_id, product_id)
);

-- Sales
CREATE TABLE sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    quantity_sold INT NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Discounts
CREATE TABLE discounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    discount_percentage DECIMAL(5,2) NOT NULL,
    is_site_wide BOOLEAN NOT NULL DEFAULT FALSE,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Orders
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Order Items
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    PRIMARY KEY (order_id, product_id)
);
