-- 
INSERT INTO tbl_score(st_num, st_kor, st_eng, st_math)
values('S0100',90,100,100);

SELECT * from tbl_score
where st_num = 'S0100';

-- SQL Developer에서
-- 데이터를 INSERT(추가), UPDATE(변경), DELETE(삭제) 명령을 수행하면
-- Oracle Server와 SQL Developer 사이에서 중간에
-- 임시로 데이터가 보관되는 상태가 된다
-- 이 상태는 아직 Oracle Server의 저장소에 확정이 안된상태이다
-- 확정이 안된 상태에서 
-- Rollback 명령을 수행하면 모든 CUD(Insert, Update, Delete)가 취소된다
-- CUD를 수행하여 데이터에 변화가 발생하면
--      명령을 완료한 후에 반드시 확정을 지어야 한다
--      이때 사용하는 명령이 COMMIT
-- COMMIT이 실행되어야만 저장소에 데이터가 확정된다

Rollback;

delete from tbl_score;-- tbl_score에 있는 모든 데이터 삭제
select * from tbl_score; -- 리스트 없음
rollback; -- Delete 명령을 취소
select *from tbl_score; -- 다시 리스트가 나타났다

update tbl_score set st_kor = 100;

-- 데이터의 무결성, 일관성을 유지하고, 갱신이상, 삭제이상을 방지하는 유일한 방법
-- Delete, Update 명령을 수행할 때는
-- 옵션항목인 where 절을 반드시 포함하자
-- 그렇지 않으면 데이터 전부가 삭제, 갱신 될 수 있다
-- 또한 특별하게 필요한 경우가 아니면
-- where 절에 포함하는 조건은 PK 칼럼을 기준으로 하자

-- Delete와 Update를 수해한 후 실수를 발견했을 때
-- 즉시 Rollback을 수행하면 명령을 취소할 수 있다
-- 하지만 Production(실무)환경에서는
-- DBMS의 명령을 수행하는 사용자가 혼자가 아니기 때문에
-- Rollback 명령도 매우 신중하게 사용해야 한다

SELECT * from view_score;

-- view를 만들때 설정한 as값들이 칼럼이름으로 사용된다
select * from view_score
where 총점 < 200;

select * from view_score
where 총점 < 200
order by 총점;

-- 총점이 200 미만인 학생들 리스트를
-- 먼저 국어점수 순으로 오름차순 정렬하고
-- 국어점수가 같으면 영어점수로 오름차순 정렬하고
-- 국어점수와 영어점수가 같으면 수학점수로 오름차순 정렬하는 것
select * from view_score
where 총점 < 200
order by 국어, 영어, 수학;

select * from view_score;
desc tbl_score;

-- 150 < 총점 < 200 의 값을 보여주는 것
select * from view_score
where 총점 > 150 and 총점 < 200;
-- 150 <= 총점 <= 200 의 값을 보여주는 것
select * from view_score
where 총점 >= 150 and 총점 <= 200;

-- 조건값이 포함된 범위를 조회(검색)할 때
select * from view_score
where 총점 between 150 and 200;

-- 총점이 150이상 200이하인 데이터 중에
-- 국어점수가 70이상인 데이터
select * from view_score
where 총점 between 150 and 200 and 국어 >= 70;

-- 전체 데이터의 총점을 구하는 것
-- project 항목에 사용하는 함수
-- 총점 칼럼에 저장된 모든 데이터의 합을 구하는 것
select sum(총점)
from view_score;

select AVG(총점)
from view_score;

select Max(총점)
from view_score;

-- 총점은 MAX() 함수로 감쌌는데
-- 학번은 단독으로 사용되었다
-- 이러한 데이터를 출력하려면
-- 함수로 감싸지 않은 칼럼들을 GROUP BY에 나열해 줘야 한다
select 학번, max(총점)
from view_score
Group by 학번;

-- GROUP BY :  같은 값을 갖는 데이터들끼리 묶어서 한번만 출력하라
-- 
select 총점
from view_score
group by 총점;

--  SQL 통계함수
-- sum(), avg(), max(), min(), count()
-- 총점, 평균, 최댓값, 최솟값, 개수를 계산하는 

select count(*) from view_score;

-- 같은 총점끼리 묶고
-- 총점이 같은 데이터가 몇개씩 인지 총점 오름차순으로 보여준것
select 총점, count(*)
from view_score
Group by 총점
order by 총점;























