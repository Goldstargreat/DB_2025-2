CREATE TABLE 고객(
    고객아이디 VARCHAR(20) NOT NULL PRIMARY KEY,
    고객이름 VARCHAR(10) NOT NULL,
    나이 INT,
    등급 VARCHAR(10) NOT NULL,
    직업 VARCHAR(20),
    적립금 INT DEFAULT 0
);

CREATE TABLE 제품(
    제품번호 VARCHAR(5) NOT NULL,
    제품명 VARCHAR(20),
    재고량 INT,
    단가 INT,
    제조업체 VARCHAR(20),
    PRIMARY KEY(제품번호),
    CHECK(재고량 >= 0 AND 재고량 <= 10000)
);

CREATE TABLE 주문(
    주문번호 VARCHAR(5) NOT NULL,
    주문고객 VARCHAR(20),
    주문제품 VARCHAR(5),
    수량   INT,
    배송지 VARCHAR(30), 
    주문일자 DATE,   
    PRIMARY KEY(주문번호),
    FOREIGN KEY(주문고객) REFERENCES 고객(고객아이디),
    FOREIGN KEY(주문제품) REFERENCES 제품(제품번호)
);

CREATE TABLE 배송업체(
    업체번호 VARCHAR(5) NOT NULL PRIMARY KEY,
    업체명 VARCHAR(20),
    주소 VARCHAR(100),
    전화번호 VARCHAR(20)
);

--테이블 변경

ALTER TABLE 고객 
ADD 가입날짜 DATE;

--테이블 삭제 
ALTER TABLE 고객 
                DROP COLUMN 가입날짜;
                
-- 테이블 변경: 체크 제약조건의 추가
ALTER TABLE 고객 
                ADD CONSTRAINT CHECK_AGE CHECK(나이 >= 20);
                
-- 테이블 변경: 체크 제약 조건 삭제
ALTER table 고객
                drop CONSTRAINT CHECK_AGE;

--테이블 삭제 
drop TABLE 배송업체;

-- DML(데이터 조작어)

-- 고객 테이블에 행 삽입 (추가) 
INSERT INTO 고객 VALUES('apple', '정소화', 20, 'gold', '학생', 1000);
INSERT INTO 고객 VALUES('banana', '김선우', 25, 'vip', '간호사', 2500);
INSERT INTO 고객 VALUES('carrot', '고명서', 28, 'gold', '교사', 4500);
INSERT INTO 고객 VALUES('orange', '김용욱', 22, 'silver', '학생', 0);
INSERT INTO 고객 VALUES('melon', '성원용', 35, 'gold', '회사원', 5000);
INSERT INTO 고객(고객아이디, 고객이름, 등급, 직업, 적립금) VALUES('peach', '오형준', 'gold', '교사', 4500);
INSERT INTO 고객 VALUES('pear', '최광주', 31, 'silver', '회사원', 500);

-- 고객 테이블의 전체 행을 조회(검색)
SELECT * FROM 고객;
