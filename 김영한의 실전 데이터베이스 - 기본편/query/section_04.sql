USE my_shop2;

SELECT AVG(price) FROM products;

SELECT name, price
FROM products
WHERE price > 167166.6667;

SELECT name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

SELECT u.address
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE o.order_id = 1;

SELECT name, address
FROM users
WHERE address = '서울시 강남구';

SELECT name, address
FROM users
WHERE address = (SELECT u.address
				 FROM orders o
				 JOIN users u ON o.user_id = u.user_id
				 WHERE o.order_id = 1);

SELECT product_id FROM products WHERE category = '전자기기'
ORDER BY product_id;

SELECT * FROM orders
WHERE product_id IN (1, 2, 3, 6)
ORDER BY order_id;

SELECT * FROM orders
WHERE product_id IN (SELECT product_id
					 FROM products
                     WHERE category = '전자기기')
ORDER BY order_id;

SELECT name, price
FROM products
WHERE price > ANY (SELECT price
				   FROM products
				   WHERE category = '전자기기');

SELECT name, price
FROM products
WHERE price > ALL (SELECT price
				   FROM products
				   WHERE category = '전자기기');

SELECT name, price
FROM products
WHERE price > (SELECT MIN(price)
			   FROM products
			   WHERE category = '전자기기');

SELECT name, price
FROM products
WHERE price > (SELECT MAX(price)
			   FROM products
			   WHERE category = '전자기기');

SELECT user_id, status FROM orders WHERE order_id = 3;

SELECT *
FROM orders
WHERE (user_id, status) = (2, 'SHIPPED');

SELECT *
FROM orders
WHERE (user_id, status) = (SELECT user_id, status FROM orders WHERE order_id = 3);

SELECT user_id, MIN(order_date)
FROM orders
GROUP BY user_id;

SELECT
	o.order_id,
    o.user_id,
    o.order_date,
    u.name,
    p.name AS product_name
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN products p ON o.product_id = p.product_id
WHERE (o.user_id, o.order_date) IN (SELECT user_id, MIN(order_date) 
									FROM orders
									GROUP BY user_id);

SELECT *
FROM products p1
WHERE price >= (SELECT AVG(p2.price) FROM products p2 WHERE p2.category = p1.category);

SELECT product_id, name, price
FROM products
WHERE product_id IN (SELECT DISTINCT product_id FROM orders);

SELECT product_id, name, price
FROM products p
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.product_id = p.product_id);

SELECT product_id, name, price
FROM products p
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.product_id = p.product_id);

SELECT name, price, (SELECT AVG(price) FROM products) AS avg_price
FROM products;

SELECT
	p.product_id,
    p.name,
    p.price,
    (SELECT COUNT(*) FROM orders o WHERE o.product_id = p.product_id) AS order_count
FROM products p;

SELECT p.product_id, p.name, p.price, COUNT(o.order_id) AS order_count
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_id, p.name, p.price;

SELECT category, MAX(price) AS max_price
FROM products
GROUP BY category;

SELECT
	p.product_id,
    p.name,
    p.category,
    p.price
FROM products p
JOIN (
	SELECT category, MAX(price) AS max_price
	FROM products
	GROUP BY category) AS cmp
ON p.category = cmp.category AND p.price = cmp.max_price;

SELECT o.order_id, o.user_id, o.product_id, o.order_date
FROM orders o
WHERE o.user_id IN (SELECT user_id FROM users WHERE address LIKE '서울%');

SELECT o.order_id, o.user_id, o.product_id, o.order_date
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE u.address LIKE '서울%';

# 문제와 풀이

## 문제 1

SELECT product_id, name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

## 문제 2

SELECT order_id, user_id, order_date
FROM orders
WHERE product_id = (SELECT product_id FROM orders WHERE order_id = 1) AND order_id != 1;

## 문제 3

SELECT (SELECT name FROM users WHERE user_id = o.user_id) AS '고객명', COUNT(*) AS '총주문횟수'
FROM orders o
GROUP BY user_id;
