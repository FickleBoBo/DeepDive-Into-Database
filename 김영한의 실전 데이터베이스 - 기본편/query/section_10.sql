USE my_shop2;

INSERT INTO users (name, email) VALUES ('냐옹이', NULL);

INSERT INTO users (name, email, address) VALUES ('가짜 션', 'sean@example.com', '서울시 어딘가');

INSERT INTO users (user_id, name, email) VALUES (1, '누군가', 'someone@...');

INSERT INTO orders (user_id, product_id, quantity) VALUES (2, 2, 1);

SELECT * FROM orders ORDER BY order_id DESC LIMIT 1;

INSERT INTO orders (user_id, product_id, quantity) VALUES (999, 1, 1);

DELETE FROM users WHERE user_id = 1;

DELETE FROM orders WHERE user_id = 1;
DELETE FROM users WHERE user_id = 1;

-- 10. 데이터 무결성
-- 외래 키 제약 조건

-- 실습을 위해 기존 테이블 삭제 후 CASCADE 옵션으로 재생성
DROP TABLE orders;

CREATE TABLE orders (
    order_id BIGINT AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    quantity INT NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING',
    PRIMARY KEY (order_id),

    CONSTRAINT fk_orders_users FOREIGN KEY (user_id) 
        REFERENCES users(user_id) ON DELETE CASCADE, -- CASCADE 옵션 추가

    CONSTRAINT fk_orders_products FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- 주문 데이터 다시 입력
INSERT INTO orders(user_id, product_id, quantity, status) VALUES
(1, 1, 1, 'COMPLETED'),
(1, 4, 2, 'COMPLETED'),
(2, 2, 1, 'SHIPPED');

SELECT * FROM users WHERE user_id = 1;
SELECT * FROM orders WHERE user_id = 1;

DELETE FROM users WHERE user_id = 1;
SELECT * FROM users WHERE user_id = 1;
SELECT * FROM orders WHERE user_id = 1;

-- CHECK 제약 조건

-- 실습을 위해 기존 테이블들을 삭제한다.
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;

-- CHECK 제약 조건을 추가하여 products 테이블 재생성
CREATE TABLE products (
    product_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price INT NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    discount_rate DECIMAL(5, 2) DEFAULT 0.00 CHECK (discount_rate BETWEEN 0.00 AND 100.00)
);

INSERT INTO products (name, category, price, stock_quantity) VALUES ('오류상품', '전자기기', -5000, 10);

INSERT INTO products (name, category, price, stock_quantity, discount_rate) VALUES ('초특가상품', '패션', 50000, 20, 120.00);
