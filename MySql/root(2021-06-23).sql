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
create table tbl_score(
sc_seq	bigint	auto_increment	primary key,
sc_stnum	char(8)	NOT NULL	,
sc_sbcode	char(4)	NOT NULL,	
sc_score	int	NOT NULL	
);
-- drop table tbl_score;
insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values ('20210001' , 'S001', '90');

insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values ('20210001' , 'S002', '60');

insert into tbl_score(sc_stnum, sc_sbcode, sc_score)
values ('20210001' , 'S003', '91');

create table tbl_subject(
sb_code	char(4)		primary key,
sb_name	varchar(20)	NOT NULL	,
sb_prof	varchar(20)		
);

insert into tbl_subject(sb_code, sb_name, sb_prof)
values ('S001','국어','기다은');

commit;