use student;
show databases;

create table tbl_student(
	st_num	char(5)		primary key,
	st_name	varchar(10)	not null	,
	st_tel	varchar(20)	not null	,
	st_addr	varchar(125)		,
	st_grade	int not null,	
	st_dpcode	char(4)	not null	
);