-- DDL

CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    email VARCHAR(100) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL, 
    address VARCHAR(255) NOT NULL, 
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    description TEXT, 
    price INT NOT NULL, 
    stock_quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY, 
    customer_id INT NOT NULL, 
    product_id INT NOT NULL, 
    quantity INT NOT NULL, 
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    status VARCHAR(20) NOT NULL DEFAULT '주문접수', 
    
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id), 
    CONSTRAINT fk_orders_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 컬럼 추가
ALTER TABLE customers
ADD COLUMN point INT NOT NULL DEFAULT 0;

DESC customers;

SELECT * FROM customers;

-- 컬럼 변경
ALTER TABLE customers
MODIFY COLUMN address VARCHAR(500) NOT NULL;

DESC customers;

-- 컬럼 삭제
ALTER TABLE customers
DROP COLUMN point;

DESC customers;

-- 외래키 제약조건 때문에 삭제 안됨
DROP TABLE products;

-- 외래키 제약조건 때문에 삭제 안됨
TRUNCATE TABLE products;

-- 외래키 체크 비활성화하면 외래키 제약조건을 무시 가능(세션동안만 유지)
SET FOREIGN_KEY_CHECKS = 0;  -- 비활성화
TRUNCATE TABLE products;
SET FOREIGN_KEY_CHECKS = 1;  -- 활성화

-- DML

INSERT INTO customers
VALUES (NULL, '강감찬', 'kang@example.com', 'hashed_password_123', '서울시 관악구', '2025-06-11 10:30:00');
INSERT INTO customers
VALUES (NULL, '이순신', 'lee@example.com', 'hashed_password_123', '서울시 관악구', '2025-06-12 10:30:00');

SELECT * FROM customers;

INSERT INTO customers (name, email, password, address)
VALUES ('세종대왕', 'sejong@example.com', 'hashed_password_456', '서울시 종로구');

SELECT * FROM customers;

INSERT INTO products (name, price, stock_quantity)
VALUES ('베이직 반팔 티셔츠', 19900, 200);
INSERT INTO products (name, price, stock_quantity)
VALUES ('초록색 긴팔 티셔츠', 30000, 50);

SELECT * FROM products;

INSERT INTO products (name, price, stock_quantity) VALUES 
('검정 양말', 5000, 100), 
('갈색 양말', 5000, 150), 
('흰색 양말', 5000, 200);

SELECT * FROM products;

UPDATE products
SET price = 9800, stock_quantity = 580
WHERE product_id = 1;

UPDATE products
SET price = 990; -- WHERE product_id = 1; -- 실수로 생략 -- 안전 업데이트 모드로 수정 방지

-- 기본값은 1 (MySQL이 제공하는 안전 업데이트 모드는 기본이 비활성화인데 MySQL 워크벤치는 안전 업데이트 설정을 활성화함)
SELECT @@SQL_SAFE_UPDATES;

DELETE FROM products
WHERE product_id = 1;

SELECT * FROM products;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE customers;
TRUNCATE TABLE products;
TRUNCATE TABLE orders;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO customers (email, password, address)
VALUES ('noname@example.com', 'password_123', '서울시 마포구');

INSERT INTO customers (name, email, password, address)
VALUES ('강감찬', 'kang@example.com', 'new_password_789', '서울시 강남구');

SELECT * FROM customers;

INSERT INTO customers (name, email, password, address)
VALUES ('홍길동', 'kang@example.com', 'new_password_789', '서울시 송파구');

INSERT INTO products (name, price, stock_quantity)
VALUES ('베이직 반팔 티셔츠', 19900, 200);

SELECT * FROM products;

INSERT INTO orders(customer_id, product_id, quantity)
VALUES (1, 1, 1);

SELECT * FROM orders;

INSERT INTO orders(customer_id, product_id, quantity)
VALUES (999, 1, 1);

DELETE FROM products
WHERE product_id = 1;

-- 문제와 풀이

-- 문제 1
CREATE DATABASE my_test;
USE my_test;

CREATE TABLE members (
	id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    join_date DATE
);

DESC members;

-- 문제2
INSERT INTO members (id, name, join_date) VALUES 
(1, '션', '2025-01-10'), 
(2, '네이트', '2025-02-15');

SELECT * FROM members;

-- 문제3
UPDATE members
SET name = '네이트2'
WHERE id = 2;

DELETE FROM members
WHERE id = 1;

SELECT * FROM members;

-- 문제4
CREATE TABLE products (
	product_id INT AUTO_INCREMENT PRIMARY KEY, 
    product_name VARCHAR(100) NOT NULL, 
    product_code VARCHAR(20) UNIQUE, 
    price INT NOT NULL, 
    stock_quantity INT NOT NULL DEFAULT 0
);

DESC products;

-- 문제 5
CREATE TABLE customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY, 
    customer_id INT NOT NULL, 
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (name)
VALUES ('홍길동');

INSERT INTO orders (customer_id)
VALUES (1);

SELECT * FROM customers;
SELECT * FROM orders;
