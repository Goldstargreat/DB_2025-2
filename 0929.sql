SELECT * FROM 고객;
-- 고객 테이블에 고객 아이디는 strawberry, 고객 이름은 최유경, 나이 30, 등급 vip, 직업 공무원, 적립금 100원인 고객의 정보를 삽입 
-- 속성(컬럼, 필드) 리스트를 생략하여 추가 

insert into 고객(고객아이디, 고객이름, 나이, 등급, 직업, 적립금)
values('strawberry', '최유경', 30, 'vip', '공무원', 100);

-- 고객 테이블에 고객 아이디는 kiwi, 고객 이름은 김키위, 나이 25, 등급 gold, 직업 회사원, 적립금 500원인 고객의 정보를 삽입 
-- 속성(컬럼, 필드) 리스트를 생략하여 추가 

insert into 고객(고객아이디, 고객이름, 직업, 나이, 등급, 적립금)
values('kiwi', '김키위', '학생', 23, 'silver', 500);


-- 고객 테이블에 고객 아이디는 grapes, 고객 이름은 강포도, (나이 null), 등급 vip, 직업 의사, 적립금 1500원인 고객의 정보를 삽입 
-- 속성(컬럼, 필드) 리스트를 생략하여 추가 

insert into 고객(고객아이디, 고객이름, 직업, 등급, 적립금)
values('grapes', '강포도', '의사', 'vip', 1500);

insert into 고객(고객아이디, 고객이름, 나이, 직업, 등급, 적립금)
values('grapes', '강포도', '의사', NULL, 'vip', 1500);

--한빛제품 테이블
create table 한빛제품(
    제품명 VARCHAR2(20) not null, 
	재고량 NUMBER, 
	단가 NUMBER,
    primary key(제품명)
);

-- subquery를 사용하여 행 추가 
insert into 한빛제품(제품명, 재고량, 단가)
                select 제품명, 재고량, 단가 from 제품 where 제조업체 = '한빛제과';
                
select * from 한빛제품;

select * from 제품; 

-- 데이터 업데이트(수정)
-- 제품테이블에서 제품번호가 p05인 제품에 제품명을 신나라면으로, 가격은 2000원으로 수정하시오. 
-- UPDATE 테이블명 SET 컬럼명 = 값, 컬럼명 = 값 WHERE 조건절이 필요하다 

UPDATE 제품 SET 제품명 = '신나라면', 단가 = 2000 WHERE 제품번호 = 'p05';

select * from 제품;

--제품테이블에서 모든 제품의 단가를 20% 인상된 금액으로 수정하시오.

UPDATE 제품 SET 단가 = 단가 * 1.2;

select * from 제품;

-- update 조건절에 Subquery를 사용 
-- 정소화 고객이 주문한 제품의 주문 수량을 5개로 수정하시오. 

update 주문 set 수량 = 5
                where 주문고객 in(
                                    SELECT 고객아이디 FROM 고객
                                                             WHERE 고객이름 = '정소화'
                                );
                                  
select * from 주문;

-- Delete(행 삭제)
-- 한빛제품테이블에서 단가가 1000원 이상 2500원 이하인 행들을 삭제하시오. 
delete from  한빛제품 WHERE 단가 >= 1000 AND 단가 <= 2500;

select * from 주문;

-- 고객 이름이 김키위인 고객의 정보를 삭제하시오. 
DELETE FROM 고객 WHERE 고객이름 = '김키위';

select * from 고객;

-- View는 논리적인 가상테이블
-- 기존에 생성해서 사용한 테이블은 물리적 장치에 저장됨
-- View 생성 방법
-- 고객테이블 등급이 vip인 고객의 고객아이디, 고객이름, 나이, 등급으로 구성된 view를 우수고객이라는 이름으로 생성하시오. 
create View 우수고객(고객아이디, 고객이름, 나이, 등급)
        as select 고객아이디, 고객이름, 나이, 등급 from 고객
                                                   where 등급 = 'vip'
        with check option;

select * from 우수고객;

-- 제품테이블에서 제조업체별 제품수로 구성된 업체별제품수라는 이름의 View를 생성해보자. 
create View 업체별제품수(제조업체, 제품수)
        as select 제조업체, count(*) from 제품
                                     group by 제조업체
        with check option;

select * from 업체별제품수;

-- 나이가 30세 이상인 우수 고객을 검색, 조회하시오. 
select * from 우수고객
           where 나이>=30;
           
-- 제품1이라는 이름의 제품명, 재고량, 제조업체 속성을 갖는 뷰를 생성하시오. 
Create View 제품1(제품명, 재고량, 제조업체)
as select 제품명, 재고량, 제조업체 from 제품
with check option;

-- 제품2이라는 이름의 제품명, 재고량, 제조업체 속성을 갖는 뷰를 생성하시오. 
Create View 제품2(제품번호, 재고량, 제조업체)
as select 제품번호, 재고량, 제조업체 from 제품
with check option;

-- 제품1 view에 제품번호 p08, 재고량 1000, 제조업체 신선식품인 제품의 정보를 삽입하시오. 
select * from 제품1; 

insert into 제품1 values('po8', 1000,'신선식품');
insert into 제품2 values('po8', 1000,'신선식품');

select * from 제품2;
select * from 제품;

-- 가상 테이블 삭제
drop view 제품1;