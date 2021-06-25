-- mybatis

create database db_school;
use db_school;
create table tbl_student(
st_num	char(8)		primary key,
st_name	varchar(20)	NOT NULL	,
st_dept	varchar(20)	NOT NULL	,
st_grade	int	NOT NULL	,
st_tel	varchar(15)	NOT NULL,	
st_addr	varchar(125)		
);

insert into tbl_student(st_num, st_name, st_dept, st_grade, st_tel)
values('20210001','손흥민','체육학과','2','010-1234-1234');

select * from tbl_student;
select * from tbl_score;
select * from tbl_subject;


create table tbl_score(
sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(8)	NOT NULL	,
sc_sbcode	char(4)	NOT NULL,	
sc_score	int	NOT NULL	
);
drop table tbl_student;



create table tbl_subject(
sb_code	char(4)		primary key,
sb_name	varchar(20)	NOT NULL	,
sb_prof	varchar(20)		
);
select * from tbl_student;

/*
tbl_subject, tbl_score table을 가지고
각 학생의 성적 리스트를 출력해보기
과목 리스트를 출력하고, 각 과목의 성적이 입력된 학생의 리스트를 확인하기

학번을 조건으로 하여 한 학생의 성적입력 여부를 확인하기
*/

-- subquery 이용 방법
select SB.sb_code, SB.sb_name, SB.sb_prof, SC.sc_stnum, SC.sc_score
from tbl_subject SB
	left join 
    (select * from tbl_score where sc_stnum = '20210001') SC
		on SC.sc_sbcode = SB.sb_code
where SC.sc_stnum = '20210001';

select SB.sb_code, SB.sb_name, SB.sb_prof, SC.sc_stnum, SC.sc_score
from tbl_subject SB
	left join tbl_score SC
		on SC.sc_sbcode = SB.sb_code
        and SC.sc_stnum = '20210001' limit 5;
        
select SB.sb_code, SB.sb_name, SB.sb_prof, SC.sc_stnum, SC.sc_score
from tbl_subject SB
	left join tbl_score SC
		on SC.sc_sbcode = SB.sb_code;
/*
과목리스트를 전체 보여주고, 학생의 성적 table을 JOIN하여
학생의 점수가 있으면 점수를 보이고
없으면 null로 보여주는 JOIN SQL 문

이 JOIN 명령문에
특정한 학번을 조건으로 부여하여
한 학생의 성적여부를 조회하는 SQL 만들기

순수한 JOIN을 사용하여 한 학생의 성적을 조회하는데
학생의 성적이 tbl_score table에 있으면 점수를 보이고
없으면 null로 표현하기 위하여 
WHERE 절에서 학번을 조건으로 부여하지 않고
JOIN문의 ON 절에 학번을 조건으로 부여한다

*/
select SB.sb_code, SB.sb_name, SB.sb_prof, SC.sc_stnum, SC.sc_score
from tbl_subject SB
	left join tbl_score SC
		on SC.sc_sbcode = SB.sb_code
        and SC.sc_stnum = '20210001' limit 5;
        
select * from tbl_student;

select count(*) from tbl_score
where sc_stnum = '1';

select * from tbl_score;















commit;