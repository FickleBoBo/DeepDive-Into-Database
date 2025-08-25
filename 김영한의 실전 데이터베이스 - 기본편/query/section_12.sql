-- 12. 저장 프로시저, 함수, 트리거
-- 프로시저, 함수, 트리거 - 실습

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);



-- 프로시저 생성 (CREATE PROCEDURE)

-- 구분자를 // 로 변경
DELIMITER //

CREATE PROCEDURE sp_change_user_address(
    IN user_id_param INT,
    IN new_address_param VARCHAR(255)
)
BEGIN
    -- 1. users 테이블의 주소 업데이트
    UPDATE users SET address = new_address_param WHERE user_id = user_id_param;
    
    -- 2. logs 테이블에 변경 이력 기록
    INSERT INTO logs (description) 
    VALUES (CONCAT('User ID ', user_id_param, ' 주소 변경 ', new_address_param));
END //

-- 구분자를 다시 ; 로 원상 복구
DELIMITER ;

SELECT * FROM users WHERE user_id = 2;

CALL sp_change_user_address(2, '경기도 성남시2');

SELECT * FROM users WHERE user_id = 2;
SELECT * FROM logs;

DROP PROCEDURE IF EXISTS sp_change_user_address;

-- 저장 함수 (Stored Function) 실습

DROP TABLE IF EXISTS stored_items;

CREATE TABLE stored_items (
    item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    discount_rate DECIMAL(5, 2)
);

INSERT INTO stored_items (name, price, discount_rate) VALUES
('고성능 노트북', 1500000, 10.00),
('무선 마우스', 25000, 20.00),
('기계식 키보드', 120000, 30.00),
('4K 모니터', 450000, 40.00),
('전동 높이조절 책상', 800000, 50.00);



-- 함수 생성 (CREATE FUNCTION)

DELIMITER //

CREATE FUNCTION fn_get_final_price(
    price_param INT,
    discount_rate_param DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    -- 최종 가격을 계산 (가격 * (1 - 할인율/100))
    RETURN price_param * (1 - discount_rate_param / 100);
END //

DELIMITER ;

SELECT
	name,
    price,
    discount_rate,
    fn_get_final_price(price, discount_rate) AS final_price
FROM stored_items;

DROP FUNCTION IF EXISTS fn_get_final_price;

-- 3. 트리거 (Trigger) 실습

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



-- 트리거 생성 (CREATE TRIGGER)
DELIMITER //

CREATE TRIGGER trg_backup_user
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO retired_users (id, name, email, retired_date)
    VALUES (OLD.user_id, OLD.name, OLD.email, CURDATE());
END //

DELIMITER ;

SELECT * FROM users WHERE user_id = 5;
DELETE FROM users WHERE user_id = 5;
SELECT * FROM retired_users;

DROP TRIGGER IF EXISTS trg_backup_user;
