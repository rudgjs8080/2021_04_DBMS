-- 2021-04-30 
drop table tbl_books;
create table tbl_books(
    bk_isbn	char(13) primary key,
    bk_title nvarchar2(125)	not null,	
    bk_ccode char(5) not null,
    bk_acode char(5) not null,
    bk_date	char(10),
    bk_price number	,
    bk_pages number		
);

create table tbl_company(
    cp_code	char(5)	primary key,
    cp_title nvarchar2(125)	not null,
    cp_ceo nvarchar2(20),
    cp_tel varchar2(20),
    cp_addr	nvarchar2(125),
    cp_genre nvarchar2(125)		
);

create table tbl_author(
    au_code	char(5)  primary key,
    au_name	nvarchar2(50) not null,	
    au_tel	varchar2(20),
    au_addr	nvarchar2(125),
    au_genre nvarchar2(30)		
);

-- 3의 table을 JOIN
drop view view_도서정보;
create view view_도서정보 as
(
select b.bk_isbn as ISBN,
        b.bk_title as 도서명,
        c.cp_title as 출판사명,
        c.cp_ceo as 출판사대표,
        A.au_name as 저자명,
        a.au_tel as 저자연락처,
        b.bk_date as 출판일,
        b.bk_price as 가격,
        b.bk_pages as 페이지
from tbl_books B
    left join tbl_company C
        on B.bk_ccode = c.cp_code
    left join tbl_author A
        on B.bk_acode = a.au_code
);
-- 단독 테이블로 생성된 VIEW는 INSERT, UPDATE, DELETE를 실행할 수 있다
-- Table JOIN한 결과로 생성된 VIEW는 읽기전용

select * from view_도서정보;

delete from tbl_books;
commit;











