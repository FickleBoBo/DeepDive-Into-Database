DROP VIEW IF EXISTS v_category_order_status;

CREATE VIEW v_category_order_status AS
SELECT
	p.category,
	COUNT(*) AS total_orders,
	SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN status = 'SHIPPED' THEN 1 ELSE 0 END) AS shipped_orders
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

SELECT * FROM v_category_order_status;

ALTER VIEW v_category_order_status AS
SELECT
	p.category,
    SUM(p.price * o.quantity) AS total_sales,
	COUNT(*) AS total_orders,
	SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN status = 'SHIPPED' THEN 1 ELSE 0 END) AS shipped_orders
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

SELECT * FROM v_category_order_status;

DROP VIEW v_category_order_status;

# 문제와 풀이

## 문제 1

DROP VIEW v_customer_email_list;
CREATE VIEW v_customer_email_list AS
SELECT user_id, name AS '고객명', email AS '이메일'
FROM users;

SELECT * FROM v_customer_email_list;

## 문제 2

DROP VIEW v_order_summary;
CREATE VIEW v_order_summary AS
SELECT o.order_id, u.name AS 고객명, p.name AS 상품명, o.quantity AS 주문수량, o.status AS 주문상태
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id;

SELECT * FROM v_order_summary;

## 문제 3

CREATE VIEW v_electronics_sales_status AS
SELECT p.category, COUNT(*) AS total_orders, SUM(p.price * o.quantity) AS total_salse
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE p.category = '전자기기';

SELECT * FROM v_electronics_sales_status;

## 문제 4

ALTER VIEW v_electronics_sales_status AS
SELECT
	p.category,
    COUNT(*) AS total_orders,
    SUM(p.price * o.quantity) AS total_salse,
    AVG(p.price * o.quantity) AS average_order_value
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE p.category = '전자기기';

SELECT * FROM v_electronics_sales_status;
