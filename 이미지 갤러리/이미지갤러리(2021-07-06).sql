use mylibs;

create table tbl_gallery(
g_seq	BIGINT	auto_increment	primary key,
g_writer	VARCHAR(20)	not null	,
g_date	VARCHAR(10)	not null	,
g_time	VARCHAR(10)	not null	,
g_subject	VARCHAR(50)	not null,	
g_content	VARCHAR(1000)	not null	,
g_image	VARCHAR(125)		
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
drop table tbl_member;
show tables;
select*from tbl_gallery;
select * from tbl_files;
select * from tbl_member;
-- EQ JOIN
-- 카티션 곱
-- 두개의 table을 JOIN하여
-- table1 개수 * table 2 개수 만큼  list 출력
select * from tbl_gallery G, tbl_files F
	where G.g_seq = F.file_gseq
    and G.g_seq = 1;

/*
view_gallery의 SQL 코드
EQ JOIN을 만들어서 보여지는 코드
tbl_gallery에는 데이터가 있는데
tbl_file에 
*/

create view view_gallery as(
select G.g_seq as g_seq,
		G.g_writer as g_writer,
        G.g_date as g_date,
        G.g_time as g_time,
        G.g_subject as g_subject,
        G.g_content as g_content,
        G.g_image as g_image,
		F.file_seq as f_seq,
        F.file_original as f_original,
        F.file_upname as f_upname
from tbl_gallery G, tbl_files F
	where G.g_seq = F.file_gseq);
    drop view Gallery;
    desc view_gallery;
    
    
/*
1:N 관계의 table일 경우
보통은 FK로 설정하여 데이터를 유지한다

1:0..N : child table에 연관된 데이터가
		하나도 없는 경우가 있다
        
1:1..N : child table에 연관된 데이터가
		최소 한 개는 있는 경우

1:1..N 인 경우는 EQ JOIN을 수행해도
		실제로 Parent tableㅔ 있는 데이터는 무조건 출력이 된다
1:0..N 인 경우 child table에 데이터가 하나도 없는 경우
		EQ JOIN을 수행하면
        출력되는 데이터가 한개도 없는 상황이 발생한다
        
JOIN을 수행할 때는 FK가 설정되는 경우가 있거나 말거나
	JOIN은 LEFT(OUTTER) JOIN을 수행하는 것이 좋다
*/
select G.g_seq as g_seq,
		G.g_writer as g_writer,
        G.g_date as g_date,
        G.g_time as g_time,
        G.g_subject as g_subject,
        G.g_content as g_content,
        G.g_image as g_image,
		F.file_seq as f_seq,
        F.file_original as f_original,
        F.file_upname as f_upname
from tbl_gallery G 
	left join tbl_files F
	on G.g_seq = F.file_gseq;
    
    
    
    
    
    select * from view_gallery;
desc tbl_gallery;
-- insert 수령할 때
-- auto_increment로 설정된 칼컬럼에
-- 0 또는 null, ''등을 설정하면
-- auto_increment가 작동된다
insert into tbl_gallery
(g_seq, g_writer, g_date, g_time, g_subject, g_content)
value(0, 'key','2021','00:00','title','content');

select max(g_seq) from tbl_gallery;
update tbl_gallery set g_image = null
where g_seq = 7;

select * from tbl_gallery;
