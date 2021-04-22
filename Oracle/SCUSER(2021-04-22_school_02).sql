- scuser 접속
SELECT * From tbl_student;
-- 데이터중에 필요한 칼럼만 나열하여 데이터 출력
Select sc_num, sc_name, sc_dept
from tbl_student;
-- 보여지는 칼럼의 순서도 바꿀수 있다
select sc_name, sc_tel, sc_dept
from tbl_student;
-- 학과가 '심리학'인 사람의 부분적 데이터 조회
-- 비록 1개의 데이터만 보여지지만
-- 2개 이상의 데이터를 가지고 있다
-- List에 담아야 한다
select sc_name, sc_dept
from tbl_student
where sc_dept = '심리학';
-- 학번이 'S0091'인 학생의 정보를 조회할 때
-- 학번은 PK(Primary Key)로 설정되어 있기 때문에
-- 1개의 학번만 조회하면
-- 이 데이터는 무조건 1개 이거나 없다
--      VO vo = new VO()에 담으면 된다
select sc_num, sc_name, sc_dept
from tbl_student
where sc_num = 'S0091';

select * from tbl_student
where sc_num = 'S0091' or sc_num = 'S0090';

select * from tbl_student
where sc_num IN('S0090','S0091','S0092','S0093','S0094');
-- DBMS에서는  char, varchar 타입의 문자열 데이터도
-- 범위를 지정하여 조회할 수 있다
-- 단, 모든데이터의 길이가 같을 때
select * from tbl_student
where sc_num > 'S0090' and sc_num < 'S0099';

select * from tbl_student
where sc_name > '기기기' and sc_name <= '촤하하';

-- 'S0010' <= sc_num <= 'S0019'
select * from tbl_student
where sc_num Between 'S0010' and 'S0019';
-- 이름이 '기'로 시작되는 모든 데이터를 조회
-- LIKE 조회 연산자는 가장 느리다
select * from tbl_student
where sc_name LIKE '기%';

-- Full Scan 검색
-- Index등의 검색 최적화 기능을 모두 사용하지 않는다
select * from tbl_student
where sc_name LIKE '%기%';--기를 포함한 모든 데이터

select * from tbl_student
where sc_addr Like '%북%';
-- 주소의 북 문자열이 포함된 모든 데이터를 보여달라
-- 조회된 데이터에서 주소 칼럼을 기준으로 오름차순 정렬하라 
-- order by 는 where 문의 가장마지막에 나온다
select * from tbl_student
where sc_addr like '%북%'
order by sc_addr;
-- desc 내림차순
select * from tbl_student
where sc_addr like '%북%'
order by sc_addr desc;











