CREATE DATABASE IF NOT EXISTS my_shop2;
USE my_shop2;

-- 테이블이 존재하면 삭제 (실습을 위해 초기화)
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS sellers;

-- 판매자 테이블 생성
CREATE TABLE sellers (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(100) UNIQUE NOT NULL,
    registered_date DATE NOT NULL
);

-- 상품 테이블 생성
CREATE TABLE items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_id INT NOT NULL,
    item_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    stock_quantity INT NOT NULL,
    registered_date DATE NOT NULL,
    is_active BOOLEAN NOT NULL,

    CONSTRAINT fk_items_sellers FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- 판매자 데이터 입력
INSERT INTO sellers (seller_id, seller_name, registered_date) VALUES
(1, '행복쇼핑', '2020-01-15'),
(2, '스마트상점', '2021-03-22'),
(3, '글로벌셀러', '2019-11-01'),
(4, '에코마켓', '2022-07-10'),
(5, '베스트딜', '2020-05-30'),
(6, '패션리더', '2023-01-05'),
(7, '리빙스타', '2021-09-12'),
(8, '테크월드', '2022-04-18'),
(9, '북스토리', '2020-08-25'),
(10, '헬스앤뷰티', '2023-03-01');

-- 상품 데이터 입력
INSERT INTO items (item_id, seller_id, item_name, category, price, stock_quantity, registered_date, is_active) VALUES
(1, 1, '무선 기계식 키보드', '전자기기', 120000, 100, '2022-01-20', TRUE),
(2, 1, '4K UHD 모니터', '전자기기', 450000, 50, '2022-02-15', TRUE),
(3, 2, '프리미엄 게이밍 마우스', '전자기기', 80000, 200, '2021-11-10', TRUE),
(4, 3, '관계형 데이터베이스 입문', '도서', 30000, 500, '2020-05-01', TRUE),
(5, 4, '친환경 세제', '생활용품', 15000, 300, '2023-08-01', FALSE),
(6, 5, '고급 가죽 지갑', '패션', 70000, 120, '2022-06-25', TRUE),
(7, 1, '스마트 워치', '전자기기', 250000, 80, '2023-03-10', TRUE),
(8, 6, '캐시미어 스웨터', '패션', 95000, 70, '2023-10-05', FALSE),
(9, 7, '아로마 디퓨저', '생활용품', 40000, 150, '2022-09-01', TRUE),
(10, 8, '게이밍 노트북', '전자기기', 1500000, 30, '2023-01-30', TRUE),
(11, 9, 'SQL 마스터 가이드', '도서', 35000, 400, '2021-04-12', TRUE),
(12, 10, '유기농 비누 세트', '헬스/뷰티', 20000, 250, '2023-02-20', FALSE),
(13, 1, '노이즈 캔슬링 헤드폰', '전자기기', 300000, 90, '2023-07-01', TRUE),
(14, 2, '인체공학 키보드', '전자기기', 90000, 110, '2022-05-05', TRUE),
(15, 3, '파이썬 프로그래밍 가이드', '도서', 28000, 600, '2021-01-01', FALSE),
(16, 4, '재활용 쇼핑백', '생활용품', 5000, 1000, '2023-09-15', TRUE),
(17, 5, '빈티지 가죽 백팩', '패션', 180000, 60, '2022-08-01', TRUE),
(18, 6, '여름용 린넨 셔츠', '패션', 45000, 180, '2023-04-20', TRUE),
(19, 7, '친환경 주방 세트', '생활용품', 60000, 130, '2022-10-10', FALSE),
(20, 8, '고성능 그래픽 카드', '전자기기', 800000, 40, '2023-06-01', TRUE),
(21, 9, '어린이를 위한 그림책', '도서', 18000, 700, '2022-03-01', TRUE),
(22, 10, '천연 에센셜 오일', '헬스/뷰티', 25000, 200, '2023-05-10', TRUE),
(23, 1, '휴대용 빔 프로젝터', '전자기기', 350000, 70, '2023-02-01', TRUE),
(24, 2, '게이밍 의자', '전자기기', 200000, 90, '2022-07-20', TRUE),
(25, 3, '세계사 탐험', '도서', 22000, 350, '2021-02-28', FALSE);

SELECT * FROM sellers;
SELECT * FROM items;

CREATE INDEX idx_items_item_name ON items(item_name);

SHOW INDEX FROM items;
SHOW INDEX FROM sellers;

DROP INDEX idx_items_item_name ON items;

EXPLAIN SELECT * FROM items WHERE item_name = '게이밍 노트북';

EXPLAIN SELECT * FROM items WHERE price BETWEEN 50000 AND 100000;

CREATE INDEX idx_items_price ON items(price);

SELECT * FROM items WHERE price BETWEEN 50000 AND 100000;

SELECT * FROM items WHERE item_name LIKE '게이밍%';

EXPLAIN SELECT * FROM items WHERE item_name LIKE '게이밍%';

EXPLAIN SELECT * FROM items WHERE item_name LIKE '%게이밍';
EXPLAIN SELECT * FROM items WHERE item_name LIKE '%게이밍%';

EXPLAIN SELECT * FROM items ORDER BY stock_quantity;

EXPLAIN SELECT * FROM items WHERE price BETWEEN 50000 AND 100000 ORDER BY price;

EXPLAIN SELECT * FROM items WHERE price BETWEEN 50000 AND 100000 ORDER BY price DESC;

DROP INDEX idx_items_price ON items;
CREATE INDEX idx_items_price ON items(price DESC);

EXPLAIN SELECT * FROM items WHERE price BETWEEN 50000 AND 100000 ORDER BY price;
EXPLAIN SELECT * FROM items WHERE price BETWEEN 50000 AND 100000 ORDER BY price DESC;
