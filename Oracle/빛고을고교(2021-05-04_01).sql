-- 2021-05-04 빛고을 고교
drop table tbl_student;
create table tbl_student(
    st_num	char(5)	primary key,
    st_name	nvarchar2(10) not null,	
    st_tel	varchar2(20) not null,	
    st_addr	nvarchar2(125),	
    st_grade number	not null,
    st_dpcode char(4) not null	
);

create table tbl_dept(
    dp_code	char(4) primary key,
    dp_name	nvarchar2(20) not null,	
    dp_pro	nvarchar2(20) not null,	
    dp_tel	varchar2(5)
);

create table tbl_subject(
    sb_code	char(5)	primary key,
    sb_name	nvarchar2(20) not null,	
    sb_prof	nvarchar2(20)
);

create table tbl_score(
    sc_seq	number primary key,
    sc_stnum char(5) not null,
    sc_sbcode char(5) not null,
    sc_score number	
);

select count(*) from tbl_subject;
-- LEFT JOIN을 하여 import 된 두 테이블간의 데이터 유효성 검증
-- 학생 table에 없는 학과 코드가 있는지 검증하기
-- 학생 table과 학과 table 간의 FK 설정을 하기 위한 검증
-- 결과 LIST에서 절대 NULL 값이 없어야 한다
select ST.st_num as 학번,
        ST.st_name as 이름,
        ST.st_dpcode as 학과코드,
        DP.dp_name as 학과명,
        ST.st_tel as 연락처,
        ST.st_addr as 주소
from tbl_student ST
    left join tbl_dept DP
        on ST.st_dpcode = DP.dp_code;
        
drop view view_성적정보;
create view view_성적정보 as 
(
select SC.sc_seq  일련번호,
        SC.sc_stnum  학번,
        ST.st_name 학생이름,
        ST.st_tel 전화번호,
        SC.sc_sbcode 과목코드,
        SB.sb_name 과목명,
        SC.sc_score 점수,
        SB.sb_prof 담당교수
from tbl_score SC
    left join tbl_student ST
        on SC.sc_stnum = ST.st_num
    left join tbl_subject SB
        on SC.sc_sbcode = SB.sb_code);

select * from view_성적정보;

-- 학생별 총점
-- 학번, 과목, 점수 형태로 저장된 제2정규화 테이블
-- 제2정규화 된 테이블에는 통계함수를 적용할 수 있다
select 학번, 학생이름, sum(점수) as 총점, round(avg(점수),1) as 평균 
from view_성적정보
group by 학번, 학생이름
order by 총점 desc;

-- DECODE() IF와 유사한 조건검색함수
-- DECODE(칼럼명,값,return)
--      칼럼명에 '값'이 담겨있으면 return명령을 수행하라
-- 과목명 칼럼에 국어 문자열이 담겨 있으면 해당 레코드의
--      점수 칼럼 값을 표시하고
--      그렇지 않으면 null값으로 표시하라
select 학번, 
    decode(과목명,'국어',점수) as 국어점수,
    decode(과목명,'영어',점수) as 영어점수,
    decode(과목명,'수학',점수) as 수학점수
from view_성적정보;

-- 위의 SQL을 학번으로 Grouping 하고
-- 각 점수를 합산(SUM())하면
-- DBMS의 SQL에서는 (null) + 숫자 = 0 + 숫자와 같다
-- SUM(null, null, null, null, 63, null, null) = 63
create view view_성적보고서 as(
select 학번,
    sum(decode(과목명,'국어',점수)) as 국어점수,
    sum(decode(과목명,'영어',점수)) as 영어점수,
    sum(decode(과목명,'수학',점수)) as 수학점수,
    sum(decode(과목명,'미술',점수)) as 미술점수,
    sum(decode(과목명,'음악',점수)) as 음악점수,
    sum(decode(과목명,'소프트웨어공학',점수)) as SW점수,
    sum(decode(과목명,'데이터베이스',점수)) as DB점수,
    sum(점수) as 총점,
    round(avg(점수),1) as 평균
from view_성적정보
group by 학번);
--order by 학번;
drop view view_성적보고서;
-- 위와 같은 view를 피벗 view라고 한다
-- 제2정규화가 되어있는 Table의 데이터를 
-- Pivot하여 일반적인 보고서 LIST를 만드는 형태
select * from view_성적보고서
order by 학번;

select SC.학번,
        ST.st_name as 학생이름,
        ST.st_tel as 전화번호,
        SC.국어점수,
        SC.영어점수,
        SC.수학점수
from view_성적보고서 SC
    Left join tbl_student ST
        on SC.학번 = ST.st_num;
        
-- table 과 view의 join














alter table tbl_score
drop constraint fk_stnum;

alter table tbl_score
add constraint fk_stnum
foreign key (sc_stnum)
references tbl_student(st_num);

alter table tbl_score
add constraint fk_sbcode
foreign key(sc_sbcode)
REFERENCES tbl_subject(sb_code);

create SEQUENCE seq_score
start with 1
INCREMENT by 1;




