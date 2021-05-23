use student;
show databases;
drop table tbl_score;
drop view view_학생정보;
show tables;
select * from tbl_student;
create table tbl_student(
	st_num	char(5)		primary key,
	st_name	varchar(10)	not null	,
	st_tel	varchar(20)	not null	,
	st_addr	varchar(125)		,
	st_grade	int not null,	
	st_dpcode	char(4)	not null	
);

create table tbl_dept(
dp_code	char(4)		primary key,
dp_name	varchar(20)	not null	,
dp_pro	varchar(20)	not null	,
dp_tel	varchar(10)		
);

create table tbl_subject(
sb_code	char(5)		primary key,
sb_name	varchar(20)	not null	,
sb_prof	varchar(20)		
);

create table tbl_score(
sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(5)	not null,	
sc_sbcode	char(5)	not null,	
sc_kor	int	,
sc_eng int,
sc_math int,
sc_music int,
sc_art int,
sc_sw int,
sc_db int
);
create view view_학생정보 as
(
select st.st_num as 학번,
		st.st_name as 이름,
		st.st_tel as 전화번호,
		st.st_addr as 주소,
        st.st_grade as 학년,
        dp.dp_code as 학과코드,
        dp.dp_name as 학과명,
        dp.dp_pro as 교수명,
        dp.dp_tel as 학과내선번호
from tbl_student as st
	left join tbl_dept as dp
		on st.st_dpcode = dp.dp_code
	left join tbl_score as sc
		on st.st_num = sc.sc_stnum
	left join tbl_subject as sb
		on sc.sc_sbcode = sb.sb_code);
select * from view_학생정보
order by 학번;
create view view_성적일람표 as(
select sc.sc_stnum as 학번,
		st.st_name as 학생이름,
        dp.dp_code as  학과코드,
        dp.dp_name as 학과명,
        dp.dp_pro as 교수명,
        sc.sc_kor as 국어점수,
        sc.sc_eng as 영어점수,
        sc.sc_math as 수학점수,
        sc.sc_music as 음악점수,
        sc.sc_art as 미술점수,
		sc.sc_sw as 소프트웨어공학점수,
        sc.sc_db as 데이터베이스점수,
        (sc_kor + sc_eng + sc_math + sc_music + sc_art + sc_sw + sc_db) as 총점,       
        ((sc_kor + sc_eng + sc_math + sc_music + sc_art + sc_sw + sc_db)/7) as 평균
from tbl_score as sc
	left join tbl_student as st
		on sc.sc_stnum = st.st_num
	left join tbl_dept as dp
		on st.st_dpcode = dp.dp_code);

select * from view_성적일람표
order by 총점;





