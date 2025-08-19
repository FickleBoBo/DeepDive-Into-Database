USE my_shop2;

SELECT
	u.user_id,
    u.name,
    o.user_id,
    o.order_id
FROM users u
JOIN orders o ON u.user_id = o.user_id
ORDER BY u.user_id;

SELECT
	u.user_id,
    u.name,
    o.user_id,
    o.order_id
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
ORDER BY u.user_id;

SELECT
	u.user_id,
    u.name,
    u.email
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL
ORDER BY u.user_id;

SELECT
	product_id,
    name,
    price
FROM products;

SELECT
	product_id,
    order_id
FROM orders
ORDER BY product_id;

SELECT
	p.product_id,
    p.name,
    p.price,
    o.product_id,
    o.order_id
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id;

SELECT
	p.product_id,
    p.name,
    p.price,
    o.product_id,
    o.order_id
FROM orders o
RIGHT JOIN products p ON o.product_id = p.product_id;

SELECT user_id, name, email
FROM users
WHERE user_id = 1;

SELECT order_id, product_id, user_id
FROM orders
WHERE user_id = 1;

SELECT
	o.order_id,
    o.product_id,
    o.user_id AS orders_user_id,
    u.user_id AS users_user_id,
    u.name,
    u.email
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE o.user_id = 1;

SELECT
	u.user_id AS users_user_id,
    u.name,
    u.email,
	o.order_id,
    o.product_id,
    o.user_id AS orders_user_id
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE u.user_id = 1;

SELECT
	o.order_id,
    o.product_id,
    o.user_id AS orders_user_id,
    u.user_id AS users_user_id,
    u.name,
    u.email
FROM orders o
JOIN users u ON o.user_id = u.user_id;

SELECT
	u.user_id AS users_user_id,
    u.name,
    u.email,
	o.order_id,
    o.product_id,
    o.user_id AS orders_user_id
FROM users u
JOIN orders o ON u.user_id = o.user_id;

SELECT *
FROM employees;

SELECT
	e.name AS employee_name,
    m.name AS manager_name
FROM employees e
JOIN employees m on e.manager_id = m.employee_id;

SELECT
	e.name AS employee_name,
    m.name AS manager_name
FROM employees e
LEFT JOIN employees m on e.manager_id = m.employee_id;

SELECT * FROM sizes;
SELECT * FROM colors;

SELECT *
FROM sizes s
CROSS JOIN colors c;

SELECT
	CONCAT('기본티셔츠-', c.color, '-', s.size) AS product_name,
    s.size,
    c.color
FROM sizes s
CROSS JOIN colors c;

CREATE TABLE product_options (
	option_id BIGINT AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    size VARCHAR(10) NOT NULL,
    color VARCHAR(20) NOT NULL,
    PRIMARY KEY (option_id)
);

INSERT INTO product_options (product_name, size, color)
SELECT
	CONCAT('기본티셔츠-', c.color, '-', s.size) AS product_name,
    s.size,
    c.color
FROM sizes s
CROSS JOIN colors c;

SELECT * FROM product_options;

SELECT
	u.name AS customer_name,
    u.email,
    o.order_date,
    p.name AS product_name,
    p.price,
    o.quantity
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id
WHERE u.address LIKE '서울%'
	AND o.order_date >= '2025-06-01' AND o.order_date < '2025-07-01'
ORDER BY o.order_date DESC;

# 문제와 풀이

## 문제 1

SELECT p.name, p.price
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE p.category = '전자기기' AND o.product_id IS NULL;

## 문제 2

SELECT u.name, COUNT(o.user_id) AS order_count
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY u.name;

## 문제 3

SELECT u.name, u.email
FROM orders o
RIGHT JOIN users u ON o.user_id = u.user_id
WHERE o.user_id IS NULL;

## 문제 4

SELECT u.name AS user_name, p.name AS product_name
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
LEFT JOIN products p ON o.product_id = p.product_id
ORDER BY user_name, product_name;

# 문제와 풀이 2

## 문제 1

SELECT e.employee_id, e.name, e.manager_id, m.name AS manager_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE m.name = '최과장';

## 문제 2

DROP TABLE materials;

CREATE TABLE materials (
    material VARCHAR(10) NOT NULL
);

INSERT INTO materials (material) VALUES ('Cotton');
INSERT INTO materials (material) VALUES ('Silk');

SELECT * FROM materials;

SELECT
	CONCAT('기본티셔츠', c.color, '-', s.size, '-', m.material) AS product_full_name,
    s.size,
    c.color,
    m.material
FROM sizes s
CROSS JOIN colors c
CROSS JOIN materials m;

## 문제 3

SELECT u.name AS customer_name, p.name AS product_name, o.order_date, o.quantity
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN products p ON o.product_id = p.product_id
WHERE u.name = '네이트'
ORDER BY o.order_date DESC;

## 문제 4

SELECT u.name AS customer_name, SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id
WHERE u.address LIKE '서울%'
GROUP BY o.user_id
ORDER BY total_spent DESC;
