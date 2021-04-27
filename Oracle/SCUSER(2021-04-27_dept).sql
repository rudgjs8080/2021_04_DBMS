-- 2021-04-27

Create table tbl_dept(
    dp_code char(3) primary key,
    dp_name nVarchar2(20) not null,
    dp_prof nvarchar2(20) not null

);

select * from tbl_dept;

delete tbl_dept;

insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('001','컴퓨터공학','토발즈');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('002','전자공학','이철기');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('003','법학','킹스필드');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('004','관광학','이한우');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('005','국어국문','백석기');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('006','영어영문','권오순');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('007','무역학','심하군');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('008','미술학','필리스');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('009','고전음악학','파파로티');
insert into tbl_dept(dp_code, dp_name, dp_prof)
values ('010','정보통신공학','최양록');
-- 지금 수행한 insert 명령으로 추가된 데이터를
-- 실제 storage에 반영하라
commit;

-- 여러개의 데이터를 동시에 insert하기
-- 다른 테이블로부터 데이터를 복사할 때 사용하는 방식
insert all
into tbl_dept(dp_code, dp_name, dp_prof) values ('001','컴퓨터공학','토발즈')
into tbl_dept(dp_code, dp_name, dp_prof) values ('002','전자공학','이철기')
into tbl_dept(dp_code, dp_name, dp_prof) values ('003','법학','킹스필드')
into tbl_dept(dp_code, dp_name, dp_prof) values ('004','관광학','이한우')
into tbl_dept(dp_code, dp_name, dp_prof) values ('005','국어국문','백석기')
into tbl_dept(dp_code, dp_name, dp_prof) values ('006','영어영문','권오순')
into tbl_dept(dp_code, dp_name, dp_prof) values ('007','무역학','심하군')
into tbl_dept(dp_code, dp_name, dp_prof) values ('008','미술학','필리스')
into tbl_dept(dp_code, dp_name, dp_prof) values ('009','고전음악학','파파로티')
into tbl_dept(dp_code, dp_name, dp_prof) values ('010','정보통신공학','최양록')
select * from dual;
commit;

drop table tbl_student;

CREATE table tbl_student(
    st_num	CHAR(5)	Primary Key,
    st_name	nVARCHAR2(20) NOT NULL,	
    st_dcode CHAR(3) NOT NULL	,
    st_grade CHAR(1) NOT NULL	,
    st_tel	VARCHAR(20)	NOT NULL	,
    st_addr	nVARCHAR2(125)		
);
select count(*) from tbl_student;

select * from tbl_student;

-- 학생테이블과, 학과 테이블을
-- 학생의  st_dcode 칼럼과, 학과의 dp_code 칼럼을 연관지어
-- JOIN을 수행하라
-- 학생테이블의 모든데이터를 나열하고
-- 학과테이블에서 일치하는 데이터를 가져와서 연관하여 보여라
CREATE VIEW view_학생정보 AS
(
select ST.st_num 학번,
        ST.st_name 학생이름,
        ST.st_dcode 학과코드,
        DP.dp_name 학과명,
        DP.dp_prof 담당교수,
        ST.st_grade 학년,
        ST.st_tel 전화번호,
        ST.st_addr 주소
from tbl_student ST
    left join tbl_dept DP
        on st.st_dcode = DP.dp_code
        );
        
select * from view_학생정보
order by 학번;

-- 학생정보 테이블에서 학과별로 몇명의 학생이 재학중인지
-- 학과코드 = 학과명은 항상 같은 값이 되므로
-- 학과코드, 학과명으로 group by 를 하면
-- 학과별로 묶음이 이뤄진다
-- 학과별로 묶음을 만들고 묶은 학과에 포함된 레코드가 몇개인가
-- 세어보면, 학과별 학생 인원수가 조회된다
select 학과코드, 학과명, count(*) 인원수
from view_학생정보
group by 학과코드, 학과명
order by 학과코드;

select * from tbl_score;
drop view view_성적일람표;
create view view_성적일람표 as
(
select SC.sc_num 학번, 
    ST.st_name 이름, 
    ST.st_dcode 학과코드, 
    DP.dp_name 학과명,
    DP.dp_prof 교수명,
    ST.st_tel 전화번호,
        SC.sc_kor 국어, SC.sc_eng 영어, SC.sc_math 수학,
        (SC.sc_kor + SC.sc_eng + SC.sc_math) 총점,
        round((SC.sc_kor + SC.sc_eng + SC.sc_math)/3,1) 평균
from tbl_score SC
    left join tbl_student ST
        on SC.sc_num = ST.st_num
    left join tbl_dept DP
        on ST.st_dcode = DP.dp_code
);

select * from view_성적일람표
order by 학번;

-- 생성된 view_성적일람표를 사용하여
-- 1. 총점이 200점 이상인 학생은 몇명?
-- 2. 평균이 75점 이상인 학생들의 평균점수는?
-- 3. 각 학과별로 총점과 평균점수는?

select count(*)
from view_성적일람표
where 총점 >= 200;

select round(avg(평균),2)
from view_성적일람표
where 평균 >= 75;

select 학과코드, 학과명, sum(총점), round(avg(평균),1)
from view_성적일람표
group by 학과코드, 학과명
order by 학과코드;

select 학과코드, 학과명,
        count(*) 인원수,
        sum(총점) 학과총점,
        round(avg(평균),1) as 학과평균,
        max(평균) 최고점,
        min(평균) 최저점
from view_성적일람표
group by 학과코드, 학과명
order by 학과코드;
















