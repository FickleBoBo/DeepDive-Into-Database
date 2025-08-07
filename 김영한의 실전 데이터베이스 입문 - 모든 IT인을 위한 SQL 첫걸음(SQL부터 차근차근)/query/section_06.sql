USE my_shop;

SELECT name, price, stock_quantity FROM products;

SELECT name, price, stock_quantity, price * stock_quantity FROM products;

SELECT
	name,
	price,
	stock_quantity,
	price * stock_quantity AS total_stock_value
FROM
	products;

SELECT
	name,
	price,
	stock_quantity,
	price + 3000 AS expected_price
FROM
	products;

SELECT
	name,
	price,
	stock_quantity,
	price - 1000 AS discounted_price
FROM
	products;

SELECT
	name,
	price,
	stock_quantity,
	price / 10 AS monthly_payment
FROM
	products;

SELECT name, email FROM customers;

SELECT CONCAT(name, ' - ', email) FROM customers;

SELECT CONCAT(name, ' (', email, ')') AS name_and_email FROM customers;

SELECT CONCAT_WS(' - ', name, email, address) AS customer_details FROM customers;

SELECT email, UPPER(email) AS upper_email FROM customers;

SELECT name, CHAR_LENGTH(name) AS char_length, LENGTH(name) AS byte_length FROM customers;

SELECT name, description FROM products;

SELECT
	name,
    IFNULL(description, '상품 설명 없음') AS description
FROM
	products;

SELECT
	name,
    COALESCE(description, '상품 설명 없음') AS description
FROM
	products;

-- 문제와 풀이

-- 문제 1
SELECT name, price, (price * 0.85) AS sale_price
FROM products;

-- 문제 2
SELECT CONCAT_WS(' - ', name, address) AS customer_info
FROM customers;

-- 문제 3
SELECT name, COALESCE(description, name) AS product_display_info
FROM products;

-- 문제 4
SELECT name, description, COALESCE(description, name, '정보 없음') AS display_text
FROM products;

-- 문제 5
SELECT
	email,
	SUBSTRING_INDEX(email, '@', 1) AS user_id,
	CHAR_LENGTH(SUBSTRING_INDEX(email, '@', 1)) AS id_length
FROM
	customers;
