use score;
drop table tbl_student;
create table tbl_student(
st_num	char(8)	primary key,
st_name	varchar(20)	NOT NULL	,
st_dept	varchar(20)	NOT NULL	,
st_grade	int	NOT NULL	,
st_tel	varchar(15)	NOT NULL,	
st_addr	varchar(125)		

);

insert tbl_student (st_num, st_name, st_dept, st_grade, st_tel, st_addr)
values ('20210001','손흥민', '체육학과', '3', '010-1234-1234' ,'광주');

drop table tbl_score;
create table tbl_score(
sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(8)	NOT NULL	,
sc_subject	varchar(20)	NOT NULL,	
sc_score	int	NOT NULL
);


insert tbl_score (sc_stnum, sc_subject, sc_score)
values ('20210001', '체육', '100');

insert tbl_score (sc_stnum, sc_subject, sc_score)
values ('20210001', '국어', '90');

insert tbl_score (sc_stnum, sc_subject, sc_score)
values ('20210001', '수학', '70');


alter table tbl_score
add CONSTRAINT fk_student
FOREIGN key(sc_stnum)
REFERENCES tbl_student(st_num);
drop view view_list;
create view view_list as (
select st.st_num st_num ,
		st.st_name st_name,
        st.st_dept st_dept,
        st.st_grade st_grade,
        count(*) subs,
        sum(sc_score) sum,
        round(avg(sc_score)) avg
from tbl_student as st
	left join tbl_score as sc
		on st.st_num = sc.sc_stnum
        group by st_num);

select * from view_list
where st_num = '20210001';

