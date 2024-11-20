CREATE DATABASE ecommerce;

CREATE TABLE customers(
	customers_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    phone_number VARCHAR(20),
    address VARCHAR(20),
    state VARCHAR(20)
);

CREATE TABLE products(
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(20),
    product_descript VARCHAR(100),
    price FLOAT(50),
    stock_quantity VARCHAR(20),
    product_date TIMESTAMP
);

CREATE TABLE orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
order_date VARCHAR(20),
order_status VARCHAR(20),
order_amount VARCHAR(20),
customers_id INT,
FOREIGN KEY (customers_id) REFERENCES customers(customers_id),
);
-- right click on a table, click SQL editor to insert faster
CREATE TABLE order_details(
	order_details_id INT AUTO_INCREMENT PRIMARY KEY,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    quantity_order INT
    
    
);
