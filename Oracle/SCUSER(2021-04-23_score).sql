-- 2021-04-23(scuser)
drop table tbl_score;
-- 학생의 점수를 저장할 table 생성하기 
-- 학번, 국어, 영어, 수학 항목을 저장
-- tbl_score 생성
CREATE TABLE tbl_score(
    st_num char(5) primary key,
    st_kor NUMBER NOT NULL,
    st_eng NUMBER NOT NULL,
    st_math NUMBER NOT NULL
    );
INSERT INTO tbl_score(st_num)
values ('00001');

select * from tbl_score;

INSERT into tbl_score(st_num, st_kor,st_eng,st_math)
values ('00002',50,60,70);
INSERT into tbl_score(st_num, st_kor,st_eng,st_math)
values ('00003',50,60,70);
INSERT into tbl_score(st_num, st_kor,st_eng,st_math)
values ('00004',50,60,70);

select * from tbl_score;

desc tbl_score;
------------------------------------
drop table tbl_score_2;
CREATE table tbl_score_2 (
    sc_num char(5),
    sc_kor number,
    sc_eng number,
    sc_math number
    );
-- CREATE 로 작성한 칼럼의 순서대로 모든 데이터를 포함하여
-- INSERT 수행하기
-- 항상 CREATE로 작성한 칼럼의 순서를 기억해야 하고
-- 모든 칼럼에 데이터를 포함해야 한다
insert into tbl_score_2
values('00001',90,80,70);
-- INSERT를 수행할 때 데이터 칼럼을 나열하면
-- 순서를 몰라도 상관없고, 필요한 칼럼만 데이터를 포함하여 수행할 수 있다
INSERT into tbl_score_2(sc_kor, sc_eng, sc_math, sc_num)
values(90,80,70,'00002');
select * from tbl_score_2;

-- 위에서 생선한 tbl_score_2는
-- 중복된 학번의 점수가 INSERT될 수 있다
-- 제약조건 부여
-- 1. 학번은 중복될 수 없고 절대 null값이면 안된다
--      NOT NULL & UNIQUE = PK(Primary Key)
-- 2. 점수가 없는 학생의 데이터는 이후에 연산을 수행할 때
--      문제를 일으킬수 있기 때문에 null값이 없도록 하자
CREATE TABLE tbl_score_02(
    sc_num char(5) primary key,
    sc_kor number not null,
    sc_eng number not null,
    sc_math number not null
    -- primary key(sc_num) << 이렇게 마지막에 선언을 할 수도 있다
    );

CREATE TABLE tbl_score_03(
    sc_num	CHAR(5)	primary Key,
    sc_kor	NUMBER	NOT NULL	,
    sc_eng	NUMBER	NOT NULL	,
    sc_math	NUMBER	NOT NULL	
);

select * from tbl_score;

-- 국어점수가 90점 이상인 리스트 
select*from tbl_score
where sc_kor >= 90;

-- 데이터를 보여줄 때 머릿글( 칼럼제목)을 바꾸어서 보이기
-- AS(Alieas 별명)

select st_num as 학번, st_kor as 국어, st_eng as 영어, st_math as 수학,st_kor + st_eng + st_math as 총점
from tbl_score;

select st_num as 학번, st_kor as 국어, st_eng as 영어, st_math as 수학,st_kor + st_eng + st_math as 총점
from tbl_score
where(st_kor + st_eng + st_math) >= 250;

select st_num as 학번, st_kor as 국어, st_eng as 영어, st_math as 수학,st_kor + st_eng + st_math as 총점
from tbl_score
where(st_kor + st_eng + st_math) <= 250 and (st_kor + st_eng + st_math) >= 150;

-- SELECT를 사용하여 데이터를 조회하는데
-- 계산하는 칼럼도 있고
-- 자꾸 문법이 복잡해 지려고 한다
-- SELECT된 명령문을 VIEW 객체로 생성을 해둔다
-- VIEW는 사용법이 TABLE과 같다
-- 단, SELECT만 된다.
CREATE VIEW view_score
AS
(
    select st_num as 학번, st_kor as 국어, st_eng as 영어, st_math as 수학,st_kor + st_eng + st_math as 총점
    from tbl_score
);
select * from view_score
where 총점 >= 150 and 총점 <= 250;

-- 영어선생님에게 전체학생의 정보를 보여줘야 한다
-- 다른과목의 점수는 감추고 싶다
-- 보안적인 측면에서 사용자별로 
-- 보여줄항목, 보이지 않을 항목을 선별하여 VIEW를 작성해 두면 
-- 불필요한 정보가 노출되는 것을 최소화 할 수 있다
create view veiw_영어점수
as
(
select st_num as 학번, st_eng as 영어
from tbl_score
);

create view view_1반학생
as
(
select st_num as 학번, 
    st_eng as 영어,
    st_kor as 국어,
    st_math as 수학
from tbl_score
where st_num >= 'S0010' and st_num <= 'S0020'
);
select * from view_1반학생;










