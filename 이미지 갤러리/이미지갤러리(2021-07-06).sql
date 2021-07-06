use mylibs;

create table tbl_gallery(
g_seq	BIGINT	auto_increment	primary key,
g_writer	VARCHAR(20)	not null	,
g_date	VARCHAR(10)	not null	,
g_time	VARCHAR(10)	not null	,
g_subject	VARCHAR(50)	not null,	
g_content	VARCHAR(1000)	not null	,
g_image	VARCHAR(125)	not null	
);
drop table tbl_gallery;
select * from tbl_gallery;

insert into tbl_gallery
(g_writer, g_date, g_time, g_subject, g_content)
values('key','2021-07-06','15:18:00','test','test 2');

-- 현재 연결된 session에서 INSERT가 수행되고
-- 그 과정에서 auto_increment 칼럼이 변화가 있으면
-- 그 값을 알려주는 함수
select last_insert_id();

create table tbl_files(
file_seq	BIGINT	auto_increment	primary key,
file_gseq	BIGINT	not null	,
file_original	VARCHAR(125)	not null	,
file_upname	VARCHAR(125)	not null	
);
drop table tbl_files;
show tables;

