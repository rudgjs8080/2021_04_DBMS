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

drop table tbl_score;
/*
Table에 
	insert into on duplicate key update를
    실행하기 위해서는 pk설정을 변경해야 한다
tbl_score는 두개의 칼럼을 기준으로
	insert, update를 수행하는 문제가 발생한다
가장 좋은 설계는 update, delete를 수행할 때
	한개의 칼럼으로 구성된 PK를 기준으로
    수행하는 것이다
*/
create table tbl_score(
-- sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(8)	NOT NULL	,
sc_sbcode	char(4)	NOT NULL,	
sc_score	int	NOT NULL	,
primary key(sc_stnum, sc_sbcode)
);

/*
pk는 그대로 살려두고
두개의 칼럼을 묶어 unique로 설정
두개 칼럼의 값이 동시에 같은 경우는 추가하지 말라는 제약조건 설정
*/
create table tbl_score(
sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(8)	NOT NULL	,
sc_sbcode	char(4)	NOT NULL,	
sc_score	int	NOT NULL	,
unique (sc_stnum, sc_sbcode)
);
select * from tbl_score;

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

-- 한 학생의 세과목의 점수를 개별적으로 insert 하기
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values('20210002','S001',90);
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values('20210002','S002',90);
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values('20210002','S003',90);

-- 한번의 insert 명령문으로 다수의 데이터를 insert
-- BULK insert 라고 함
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values('20210003','S001',90),
		('20210003','S002',90),
		('20210003','S003',90),
        ('20210003','S004',90),
        ('20210003','S005',90);
        
select * from tbl_student;











commit;