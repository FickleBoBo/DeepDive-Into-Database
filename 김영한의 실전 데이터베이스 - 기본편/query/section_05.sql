-- 5. UNION
-- UNION

-- 본 실습을 위한 탈퇴 고객 테이블 생성
DROP TABLE IF EXISTS retired_users;
CREATE TABLE retired_users (
    id BIGINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    retired_date DATE NOT NULL
);

-- 탈퇴 고객 데이터 입력
INSERT INTO retired_users (id, name, email, retired_date) VALUES
(1, '션', 'sean@example.com', '2024-12-31'),
(7, '아이작 뉴턴', 'newton@example.com', '2025-01-10');

SELECT name, email FROM users
UNION
SELECT name, email FROM retired_users;

SELECT u.name, u.email
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN products p ON o.product_id = p.product_id
WHERE p.category = '전자기기'
UNION
SELECT name, email
FROM users
WHERE address LIKE '서울%';

SELECT u.name, u.email
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN products p ON o.product_id = p.product_id
WHERE p.category = '전자기기'
UNION ALL
SELECT name, email
FROM users
WHERE address LIKE '서울%';

SELECT name, email FROM users
UNION
SELECT name, email FROM retired_users
ORDER BY name;

SELECT name, email, created_at FROM users
UNION
SELECT name, email, retired_date FROM retired_users
ORDER BY created_at;

SELECT name, email, created_at AS event_date FROM users
UNION
SELECT name, email, retired_date AS event_date FROM retired_users
ORDER BY event_date DESC;

# 문제와 풀이

## 문제 1

SELECT name, email FROM users
UNION
SELECT name, email FROM retired_users;

## 문제 2

SELECT u.name AS '고객명', u.email AS '이메일'
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN users u ON o.user_id = u.user_id
WHERE p.category = '전자기기'
UNION ALL
SELECT u.name, u.email
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE o.quantity >= 2;

## 문제 3

SELECT created_at AS '이벤트_날짜', name AS '상세_내용'
FROM users
UNION
SELECT order_date AS '이벤트_날짜', p.name AS '상세_내용'
FROM orders o
JOIN products p ON o.product_id = p.product_id
ORDER BY '이벤트_날짜' DESC;

# 문제 4

SELECT name AS '이름', '고객' AS '역할', email AS '이메일'
FROM users
UNION
SELECT name AS '이름', '직원' AS '역할', CONCAT(name, '@my-shop.com') AS '이메일'
FROM employees
ORDER BY `이름`;
