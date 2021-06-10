create table tbl_books(
    bk_isbn	char(13) primary key,
    bk_comp	char(5)	not null,
    bk_title	nvarchar2(125) not null,
    bk_author	char(5)	not null,                
    bk_date	varchar2(10),
    bk_pages	number,
    bk_price	number		
);

create table tbl_company(
    cp_code	char(5)		primary key,
    cp_name	nvarchar2(125)	not null,	
    cp_ceo	nvarchar2(30)	not null,	
    cp_tel	varchar2(20)	not null,	
    cp_addr	nvarchar2(125)	not null
    );
    
create table tbl_author(
    au_code	char(5)		primary key,
    au_name	nvarchar2(125)	not null,	
    au_tel	varchar2(20)		,
    au_addr	nvarchar2(125)		
);

-- import 된 데이터 확인

select count(*) from tbl_books;
select count(*) from tbl_company;
select count(*) from tbl_author;

-- tbl_books 테이블에서
-- 각 출판사별로 몇권의 도서를 출판했는지 조회

select bk_comp, count(*)
from tbl_books
group by bk_comp;

select count(*)bk_comp , bk_comp as 출판사코드
from tbl_books
group by bk_comp;

select count(*) 권수, cp_name
from tbl_books
    left join tbl_company
        on tbl_books.bk_comp = tbl_company.cp_code
        group by bk_comp, cp_name;

-- tbl_books 테이블에서
-- 도서 가격이 2만원 이상인 도서들의 리스트
-- 도서 가격이 2만원 이상인 도서들의 전체 합계 금액

select * from tbl_books
where bk_price >= 20000;

select count(*) as 권수,
        sum(bk_price) as 합계
from tbl_books
where bk_price >= 20000;

-- tbl_books, tbl_company, tbl_author 3개의 table을 JOIN하여
-- ISBN, 도서명, 출판사명, 출판사대표, 저자, 저자 연락처로
-- 출력되도록 SQL 작성

select b.bk_isbn as ISBN,
        b.bk_title as 도서명,
        c.cp_name as 출판사명,
        c.cp_ceo as 출판사대표,
        a.au_name as 저자명,
        a.au_tel as 저자연락처
from tbl_books B
    left join tbl_company C
        on b.bk_comp = c.cp_code
    left join tbl_author A
        on A.au_code = b.bk_author
order by b.bk_price, b.bk_pages;

-- tbl_books, tbl_company, tbl_author 3개의 table을 JOIN하여
-- ISBN, 도서명, 출판사명, 출판사대표, 저자, 저자 연락처, 출판일로
-- 출판일이 2018년
-- 출력되도록 SQL 작성

select b.bk_isbn as ISBN,
        b.bk_title as 도서명,
        c.cp_name as 출판사명,
        c.cp_ceo as 출판사대표,
        a.au_name as 저자명,
        a.au_tel as 저자연락처,
        b.bk_date as 출판일
from tbl_books B
    left join tbl_company C
        on b.bk_comp = c.cp_code
    left join tbl_author A
        on A.au_code = b.bk_author
where b.bk_date like '%2018%'
order by b.bk_date ;

select * from (
select b.bk_isbn as ISBN,
        b.bk_title as 도서명,
        c.cp_name as 출판사명,
        c.cp_ceo as 출판사대표,
        a.au_name as 저자명,
        a.au_tel as 저자연락처,
        b.bk_date as 출판일
from tbl_books B
    left join tbl_company C
        on b.bk_comp = c.cp_code
    left join tbl_author A
        on A.au_code = b.bk_author
where b.bk_date like '%2018%'
order by b.bk_date );

-- tbl_books와 tbl_company, tbl_books와 tbl_author의
-- fk 설정
-- bk_comp와 cp_code, bk_author와 au_code

alter table tbl_books add CONSTRAINT fk_comp FOREIGN key (bk_comp)
references tbl_company (cp_code);

alter table tbl_books add CONSTRAINT fk_author foreign key (bk_author)
references tbl_author (au_code);

/*
 PK : 개체 무결성을 보장하기 위한 조건
 내가 어떤 데이터를 수정, 삭제 할 때
 수정하거나 삭제해서는 안되는 데이터는 유지하면서
 반드시 수정하거나 삭제하는 데이터는 수정, 삭제가 된다
 수정이상, 삭제이상을 방지하는 방법
 중복된 데이터는 절대 추가될 수 없다 : 삽입 이상을 방지하는 방법
 
 FK : 두개이상의 table을 연결하는 view(조회)를 할 때
 어떤 데이터가 NULL값으로 보이는 것을 방지하기 위한 조치
 
 child(tbl_books):bk_comp           Parent(tbl_company): cp_code
    있을수 있고 추가 가능       <<      있는 코드
    있어서는 안되고 추가 불가능 <<      없는 코드
    있는 코드                   >>      코드 삭제 불가능
    있는 코드                   >>      반드시 있어야 한다
*/

-- update와 delete는 pk 를 사용해야 한다
update tbl_author set au_tel = '010-9898-6428'
where au_code = 'A0006';









