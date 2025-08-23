USE my_shop2;

SELECT
	order_id,
	user_id,
	product_id,
	quantity,
	status,
    CASE status
		WHEN 'PENDING' THEN '주문 대기'
        WHEN 'COMPLETED' THEN '결제 완료'
        WHEN 'SHIPPED' THEN '배송'
        WHEN 'CANCELLED' THEN '주문 취소'
        ELSE '알 수 없음'
	END AS status_korean
FROM orders;

SELECT
	name,
    price,
    CASE
		WHEN price >= 100000 THEN '고가'
        WHEN price >= 30000 THEN '중가'
        ELSE '저가'
	END AS price_label
FROM products;

SELECT
	name,
    price,
    CASE
		WHEN price >= 30000 THEN '중가'
		WHEN price >= 100000 THEN '고가'
        ELSE '저가'
	END AS price_label
FROM products;

SELECT
	name,
    price,
    CASE
		WHEN price >= 100000 THEN '고가'
        WHEN price >= 30000 THEN '중가'
        ELSE '저가'
	END AS price_label,
        CASE
		WHEN price >= 100000 THEN 1
        WHEN price >= 30000 THEN 2
        ELSE 3
	END AS sort
FROM products
ORDER BY
    CASE
		WHEN price >= 100000 THEN 1
        WHEN price >= 30000 THEN 2
        ELSE 3
	END ASC,
    price DESC;

SELECT
    CASE
		WHEN YEAR(birth_date) >= 1990 THEN '1990년대생'
        WHEN YEAR(birth_date) >= 1980 THEN '1980년대생'
        ELSE '그 이전 출생'
	END AS birth_decade,
    COUNT(*) AS customer_count
FROM users
GROUP BY
    CASE
		WHEN YEAR(birth_date) >= 1990 THEN '1990년대생'
        WHEN YEAR(birth_date) >= 1980 THEN '1980년대생'
        ELSE '그 이전 출생'
	END;

SELECT
    CASE
		WHEN YEAR(birth_date) >= 1990 THEN '1990년대생'
        WHEN YEAR(birth_date) >= 1980 THEN '1980년대생'
        ELSE '그 이전 출생'
	END AS birth_decade,
    COUNT(*) AS customer_count
FROM users
GROUP BY birth_decade;

SELECT 'Total' AS catagory, COUNT(*) AS total_orders FROM orders
UNION
SELECT status, COUNT(*)
FROM orders
GROUP BY status;

SELECT
	(SELECT COUNT(*) FROM orders) AS total_orders,
	(SELECT COUNT(*) FROM orders WHERE status = 'COMPLETED') AS completed_orders,
    (SELECT COUNT(*) FROM orders WHERE status = 'PENDING') AS pending_orders,
    (SELECT COUNT(*) FROM orders WHERE status = 'SHIPPED') AS shipped_orders;

SELECT
	COUNT(*) AS total_orders,
	SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN status = 'SHIPPED' THEN 1 ELSE 0 END) AS shipped_orders
FROM orders;

SELECT
	p.category,
	COUNT(*) AS total_orders,
	SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN status = 'PENDING' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN status = 'SHIPPED' THEN 1 ELSE 0 END) AS shipped_orders
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

# 문제와 풀이

## 문제 1

SELECT
	name,
    category,
    CASE category
		WHEN '전자기기' THEN 'Electronics'
        WHEN '도서' THEN 'Books'
        WHEN '패션' THEN 'Fashion'
	END AS category_english
FROM products;

## 문제 2

SELECT
	order_id,
    quantity,
    CASE
		WHEN quantity > 1 THEN '다량 주문'
        WHEN quantity = 1 THEN '단일 주문'
	END AS order_type
FROM orders
ORDER BY
    CASE
		WHEN quantity > 1 THEN 1
        WHEN quantity = 1 THEN 2
	END;

## 문제 3

SELECT
	CASE
		WHEN stock_quantity >= 50 THEN '재고 충분'
        WHEN stock_quantity >= 20 THEN '재고 보통'
        ELSE '재고 부족'
	END AS stock_level,
    COUNT(*) AS product_count
FROM products
GROUP BY stock_level;

## 문제 4

SELECT
	u.name AS user_name,
    COUNT(*) AS total_orders,
    COUNT(CASE p.category WHEN '전자기기' THEN 1 END) AS electronics_orders,
    COUNT(CASE p.category WHEN '도서' THEN 1 END) AS book_orders,
    COUNT(CASE p.category WHEN '패션' THEN 1 END) AS fashion_orders
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id
GROUP BY user_name;
