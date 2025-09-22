-- 고명석 고객이 주문한 제품의 고객아이디, 제품명, 단가를 검색하시오. 

SELECT c.고객아이디, p.제품명, p.단가 from 고객 c, 주문 o, 제품 p
                                where c.고객이름 = '고명석' and c.고객아이디 = o.주문고객 and p.제품번호 = o.주문제품;
-- 자연조인
-- s나이가 30세 이상인 고객이 주문한 제품의 주문 제품과 주문일자를 검색하시오. 

SELECT 주문제품, 주문일자 from 고객, 주문
                                where 나이 >= 30 and 고객아이디 = 주문고객; 
                                
-- 내부 조인
select 주문제품, 주문일자 from 고객 inner join 주문 on 고객아이디 = 주문고객 
                            where 나이 >= 30;
                            
-- 외부 조인
-- 주문하지 않은 고객도 포함해서 고객 이름과 주문제품, 주문일자를 검색하시오.
-- 왼쪽 외부 조인(Left Outerjoin) 
SELECT 고객이름, 주문제품, 주문일자 FROM 고객 LEFT OUTER JOIN 주문 ON 고객아이디 = 주문고객;
-- 오른쪽 외부 조인(Right Outerjoin)
SELECT 고객이름, 주문제품, 주문일자 FROM 주문 right OUTER JOIN 고객 ON 고객아이디 = 주문고객;

-- Sub Query
-- 달콤비스킷을 생산한 제조업체가 만든 제품들의 제품명과 단가를 검색하시오.
  select 제조업체 from 제품
                where 제품명 = '달콤비스킷';      

select 제품명, 단가 from 제품
                        where 제조업체 = (
                                    select 제조업체 from 제품
                                                    where 제품명 = '달콤비스킷'                        
                        );
                   
select * from 주문;                        
select * from 제품;
select * from 고객;
                        
-- 주문테이블에서 쿵떡파이를 주문한 주문고객, 주문제품, 수량을 검색하시오. 
select 주문고객, 주문제품, 수량 from 주문 where 주문제품 = (
                                                            select 제품번호 from 제품
                                                                            where 제품명 = '쿵떡파이'
                                            );
                                            
-- 적립금이 가장 많은 고객의 고객 이름과 적립금을 검색하시오. 
SELECT 고객이름, 적립금 FROM 고객 WHERE 적립금 = (
                                                    Select max(적립금) FROM 고객
                                    );

-- 적립금이 가장 적은 고객의 고객 이름과 적립금을 검색하시오. 
SELECT 고객이름, 적립금 FROM 고객 WHERE 적립금 = (
                                                    Select min(적립금) FROM 고객
                                    );
              
-- 다중행 결과를 나타내는 Sub Query(비교연산자 사용불가능)    
-- banana 고객이 주문한 제품의 제품명, 제품번호, 제조업체를 검색하시오. 
select * from 주문;
select 주문제품 from 주문
                where 주문고객 = 'banana';
                
select 제품번호, 제품명, 제조업체 from 제품
                                    where 제품번호 not in(
                                        select 주문제품 from 주문
                                            where 주문고객 = 'banana'
                                    );
-- SubQuery 다중행결과에 사용하는 in 연산자 
-- 김 씨 성을 지닌 고객이 주문한 고객아이디, 나이, 적립금, 주문한 제품명, 단가를 검색하시오.
SELECT
    고객아이디,
    나이,
    적립금,
    제품명,
    단가
FROM
    고객, 제품, 주문
WHERE 고객아이디 = 주문고객
        and 제품번호 = 주문제품
            and 주문고객 in (   
                select 고객아이디 from 고객 where 고객이름 LIKE '김%'

);

-- SubQuery 다중행결과에 사용하는 NOT IN 연산자 
-- banana 고객이 주문하지 않은 제품의 제품명, 제조업체를 검색하시오.
select 주문고객, 주문제품 from 주문;
select 제품명, 제조업체 from 제품;

select 제품번호, 제품명, 제조업체 from 제품
                            where 제품번호 not in(SELECT 주문제품 
                                                    FROM 주문 
                                                    WHERE 주문고객 = 'banana');
                                                    
-- 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체를 검샋하시오. 
select 제품명, 단가, 제조업체 from 제품 where 제조업체='대한식품';

select 제품명, 단가, 제조업체 from 제품
                            where 단가 > all (SELECT 단가 
                                                    FROM 제품
                                                    WHERE 제조업체 = '대한식품');
                                                    
-- 22년 3월 15일에 제품을 주문한 고객의 고객 이름을 검색해보자. 
select * from 주문;
select * from 고객;

select 주문고객 from 주문 where 주문일자 = '2022-03-15';

select 고객이름 from 고객 
where 고객아이디 = (select 주문고객 from 주문 where 주문일자 = '2022-03-15'
                ); 
                
-- 22년 1월 1일에 제품을 주문한 고객의 고객 이름을 검색해보자.
select 고객이름 from 고객 
                    where exists (
                            select 주문고객 from 주문 where 주문일자 = '2022-01-01' and 주문고객 = 고객아이디
                ); 
-- 22년 1월 1일에 제품을 주문하지 않은 고객의 고객 이름을 검색해보자.
select 고객이름 from 고객 
                    where not exists (
                            select 주문고객 from 주문 where 주문일자 = '2022-01-01' and 주문고객 = 고객아이디
                ); 
                                                                  
-- 22년 3월 15일에 제품을 주문하지 않은 고객의 고객 이름을 검색해보자. 
select 고객이름 from 고객 
where not exists (select * from 주문 where 주문일자 = '2022-03-15'
                                            and 주문.주문고객 = 고객.고객아이디
                ); 