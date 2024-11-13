CREATE DATABASE ecommerce;

CREATE TABLE customers(
	unique_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50),
    phone_number VARCHAR(20),
    address VARCHAR(20),
    state VARCHAR(20)
);
