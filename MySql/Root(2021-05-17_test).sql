-- 현재 존재하는 DataBase를 보여달라
show databases;
-- 지금부터 MYSQL DataBase를 사용하겠다
-- 사용자와 연관이 없이 기본적으로 사용할 
-- DataBase를 지정하여 사용할 준비
use MYSQL;
-- 현재 접속한 DataBase(mysql)에 있는
-- 모든 table을 보여달라
show tables;
-- myDB 라는 DataBase 저장소 생성
create database myDB;
-- 생성된 저장소 확인
Show databases;
-- MySQL 에서는 사용할 DB를 open하기
-- USE 명령을 사용항 DB open
USE myDB;
-- 현재 DB(myDB)에 있는 모든 table을 보여달라
show tables;

-- MySQL에서는 일련번호와 관련된 칼럼에alter
-- AUTO_INCREMENT 옵션을 설정하면 
-- INSERT 할때 값을 지정하지 않아도alter
-- 자동으로 ID, SEQ 값을 생성하여
-- 칼럼에 추가해 준다
create table tbl_test(
	id bigint primary key auto_increment,
    name varchar(50) not null,
    tel varchar(20),
    addr varchar(125)
);

desc tbl_test;

insert into tbl_test(name, tel, addr)
values ('홍길동','010-1234-1234','서울시');

select * from tbl_books;
-- MySQL은 Linux 철학을 유지하고 있기 때문에
-- 명령이 정상으로 수행되면
-- 아무런 메시지도 보이지 않는다
create table tbl_books(
	bt_isbn	char(13) primary key,
	bt_pub varchar(20) not null,
	bt_title varchar(100) not null,
	bt_writer1	varchar(50)	not null,
	bt_writer2	varchar(50)	not null,
	bt_day varchar(10),
	bt_page	INT,
	bt_price INT		
);
show tables;
desc tbl_books;
select * from tbl_books;
drop table tbl_books;

-- 도서 가격이 25000원 이상인 데이터
select *
from tbl_books
where bt_price >= 20000;

-- 도서 가격이 10000원 이상 20000원 이하
select *
from tbl_books
where bt_price between 10000 and 20000;

-- 도서명에 '왕' 문자열이 있는 도서
select *
from tbl_books
where bt_title like '%왕%';

-- Java 등 코딩에서 중간 문자열 검색
-- MySQL : concat('%', '왕', '%')
select *
from tbl_books
where bt_title
like concat('%','왕','%');

select left(bt_day,4)
from tbl_books;

select *
from tbl_books
where left(bt_day,4) = '2018';

select *
from tbl_books
order by bt_day;

select *
from tbl_books
order by bt_title desc;
-- 처음 3개의 데이터만 추출
select *
from tbl_books
limit 3;
-- 4번째부터 (0부터 시작하여 3번) 2개	
-- 게시판 등 코딩에서 pagination을 표현할 때
-- 사용하는 방법
select *
from tbl_books
limit 3,2;

create database BookRent;
use BookRent;

create table tbl_books(
	bk_isbn	char(13)		primary key,
	bk_title	varchar(125)	not null,	
	bk_ccode	char(5)	not null	,
	bk_acode	char(5)	not null	,
	bk_date	char(10)		,
	bk_price	int		,
	bk_pages	int		
);

create table tbl_company(
	cp_code	char(5)		primary key,
	cp_title	varchar(125)	not null	,
	cp_ceo	varchar(20)		,
	cp_tel	varchar(20)		,
	cp_addr	varchar(125)	,	
	cp_genre	varchar(125)		
);

create table tbl_author(
	au_code	char(5)		primary key,
	au_name	varchar(50)	not null	,
	au_tel	varchar(20)		,
	au_addr	varchar(125)	,	
	au_genre	varchar(30)		
);

create table tbl_buyer(
	bu_code	char(5)		primary key,
	bu_name	varchar(50)	not null	,
	bu_birth	int	not null	,
	bu_tel	varchar(20)		,
	bu_addr	varchar(125)		
);

create table tbl_book_rent(
	br_seq	bigint primary key auto_increment,
	br_sdate varchar(10) not null,	
	br_isbn	char(13) not null,
	br_bcode char(5) not null,
	br_edate varchar(10),
	br_price int		
);

select * from tbl_book_rent;






