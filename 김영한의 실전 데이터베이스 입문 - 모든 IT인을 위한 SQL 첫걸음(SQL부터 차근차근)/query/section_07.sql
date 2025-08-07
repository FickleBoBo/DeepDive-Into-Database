CREATE TABLE order_stat (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    category VARCHAR(50),
    product_name VARCHAR(100),
    price INT,
    quantity INT,
    order_date DATE
);

INSERT INTO order_stat (customer_name, category, product_name, price, quantity, order_date) VALUES
('이순신', '전자기기', '프리미엄 기계식 키보드', 150000, 1, '2025-05-10'),
('세종대왕', '도서', 'SQL 마스터링', 35000, 2, '2025-05-10'),
('신사임당', '가구', '인체공학 사무용 의자', 250000, 1, '2025-05-11'),
('이순신', '전자기기', '고성능 게이밍 마우스', 80000, 1, '2025-05-12'),
('세종대왕', '전자기기', '4K 모니터', 450000, 1, '2025-05-12'),
('장영실', '도서', '파이썬 데이터 분석', 40000, 3, '2025-05-13'),
('이순신', '문구', '고급 만년필 세트', 200000, 1, '2025-05-14'),
('세종대왕', '가구', '높이조절 스탠딩 데스크', 320000, 1, '2025-05-15'),
('신사임당', '전자기기', '노이즈캔슬링 블루투스 이어폰', 180000, 1, '2025-05-15'),
('장영실', '전자기기', '보조배터리 20000mAh', 50000, 2, '2025-05-16'),
('홍길동', NULL, 'USB-C 허브', 65000, 1, '2025-05-17'); -- 카테고리가 NULL인 데이터 추가

SELECT * FROM order_stat;

SELECT COUNT(*) FROM order_stat;

SELECT COUNT(category) FROM order_stat;

SELECT
	SUM(price * quantity) AS `총 매출액`,
    AVG(price * quantity) AS `평균 주문 금액`
FROM
	order_stat;

SELECT
	SUM(quantity) AS `총 판매 수량`,
    AVG(quantity) AS `주문당 평균 수량`
FROM
	order_stat;

SELECT
	MAX(price) AS 최고가,
    MIN(price) AS 최저가
FROM
	order_stat;

SELECT
	MIN(order_date) AS `최초 주문일`,
    MAX(order_date) AS `최근 주문일`
FROM
	order_stat;

SELECT
	COUNT(customer_name) AS `총 주문 건수`,
    COUNT(DISTINCT customer_name) AS `순수 고객 수`
FROM
	order_stat;

SELECT
	category, 
    COUNT(*) AS `카테고리별 주문 건수`
FROM
	order_stat
GROUP BY
	category;

SELECT
	customer_name, 
    COUNT(*) AS `주문 횟수`
FROM
	order_stat
GROUP BY
	customer_name;

SELECT
	customer_name, 
    COUNT(*) AS `총 주문 횟수`, 
    SUM(quantity) AS `총 구매 수량`,
    SUM(price * quantity) AS `총 구매 금액`
FROM
	order_stat
GROUP BY
	customer_name
ORDER BY
	`총 구매 금액` DESC;

SELECT
	customer_name,
    category,
    SUM(price * quantity) AS `카테고리별 구매 금액`
FROM
	order_stat
GROUP BY
	customer_name, category
ORDER BY
	customer_name, `카테고리별 구매 금액` DESC;

SELECT
	category,
    COUNT(*)
FROM
	order_stat
GROUP BY
	category;

SELECT
	category,
    SUM(price * quantity) AS total_sales
FROM
	order_stat
GROUP BY
	category
HAVING
	SUM(price * quantity) >= 500000;

SELECT
	customer_name,
	COUNT(*) AS order_count
FROM
	order_stat
GROUP BY
	customer_name
HAVING
	order_count >= 3;

SELECT
	category,
    COUNT(*) AS premium_order_count
FROM
	order_stat
WHERE
	price >= 100000
GROUP BY
	category
HAVING
	premium_order_count >= 2;

SELECT
	customer_name,
    SUM(price * quantity) AS total_purchase
FROM
	order_stat
WHERE
	total_purchase >= 400000
GROUP BY
	customer_name;

SELECT
	customer_name,
    SUM(price * quantity) AS total_purchase
FROM
	order_stat
WHERE
	order_date < '2025-05-14'
GROUP BY
	customer_name
HAVING
	COUNT(*) >= 2
ORDER BY
	total_purchase DESC
LIMIT 1;

-- 문제와 풀이

-- 문제 1
SELECT COUNT(*) AS `총 주문 건수`, COUNT(category) AS `카테고리 보유 건수`
FROM order_stat;

-- 문제 2
SELECT SUM(price * quantity) AS `총 매출액`, AVG(price * quantity) AS `평균 주문 금액`, MAX(price) AS `최고 단가`, MIN(price) AS `최저 단가`
FROM order_stat;

-- 문제 3
SELECT
	category,
    COUNT(*) AS `카테고리별 총 판매 수량`,
    SUM(price * quantity) AS `카테고리별 총 매출액`
FROM
	order_stat
GROUP BY
	category
ORDER BY
	`카테고리별 총 매출액` DESC;

-- 문제 4
SELECT
	customer_name,
    COUNT(*) AS `총 주문 횟수`,
    SUM(quantity) AS `총 구매 수량`
FROM
	order_stat
GROUP BY
	customer_name
ORDER BY
	`총 주문 횟수` DESC, `총 구매 수량` DESC;

-- 문제 5
SELECT customer_name, SUM(price * quantity) AS `총 구매 금액`
FROM order_stat
GROUP BY customer_name
HAVING `총 구매 금액` >= 400000
ORDER BY `총 구매 금액` DESC;

-- 문제 6
SELECT
	customer_name,
    COUNT(*) AS `주문 횟수`,
    SUM(price * quantity) AS `총 사용 금액`
FROM
	order_stat
WHERE
	category != '도서'
GROUP BY
	customer_name
HAVING
	`주문 횟수` >= 2
ORDER BY
	`총 사용 금액` DESC;
