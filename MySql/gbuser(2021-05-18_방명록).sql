-- GuestBook으로 접속한 화면
use guestbook;
show databases;
drop table tbl_guest_book;
create table tbl_guest_book(
	gb_seq	BIGINT	auto_increment	primary key,
	gb_date	varchar(10)	not null,
	gb_time	varchar(10)	not null,
	gb_writer	varchar(30)	not null,	
	gb_email	varchar(30)	not null,	
	gb_password	varchar(125)	not null,
	gb_content	varchar(2000)	not null	
);

insert into tbl_guest_book(gb_date,gb_time,gb_writer,gb_email,gb_password,gb_content)
values ('2021-05-18','10:30:00','key','kkh_8080@naver.com','12345',',내일은 휴일');
insert into tbl_guest_book(gb_date,gb_time,gb_writer,gb_email,gb_password,gb_content)
values ('2021-05-18','10:35:00','key','kkh_8080@naver.com','12345',',내일은 수요일');
select * from tbl_guest_book;
-- DELETE, UPDATE를 수행할 때는 2개의 이상의 레코드에 영향이 미치는 명령은
-- 매우 신중하게 실해앻야 한다
-- 가장 좋은 방법은 변경, 삭제하고자 하는 데이터가
-- 여러개 있더라도 가급적 PK를 기준으로
-- 1개씩 처리하는 것이 좋다
update tbl_guest_book
set gb_content = '내일은 수요일'
where gb_seq = 2;

select 30 * 40 ;
-- MySQL 고유함수로 문자열을 연결할 때
select concat('대한','민국','만세');
select * from tbl_guest_book
where gb_content like '%내일%';
-- Oracle의 DECODE()와 유사한 형태의 조건연산
-- gb_seq의 값이
select if(mod(gb_seq , 2) = 0, '짝수', '홀수')
from tbl_guest_book;

select * from tbl_guest_book
order by gb_date desc, gb_time desc;

select * from tbl_guest_book
where gb_content
like '%국가%'
order by gb_date, gb_time;
create view view_방명록 as(
select gb_seq  '일련번호',
		gb_date  '등록일자',
        gb_time  '등록시간',
        gb_writer  '등록자이름',
        gb_email  '등록Email',
        gb_password  '비밀번호',
        gb_content  '내용'
from tbl_guest_book);
















