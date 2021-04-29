-- 2021-04-29 bookuser
drop table tbl_books;
create table tbl_books(
    bk_isbn	char(13) primary key,
    bk_title nvarchar2(125)	not null,
    bk_ccode char(5) not null,
    bk_acode char(5) not null,
    bk_date	varchar2(10),
    bk_pages number,
    bk_price number		

);
delete tbl_books;
drop view view_도서정보;
insert all
into tbl_books (bk_isbn,bk_title,bk_ccode,bk_acode,bk_date,bk_price,bk_pages)
values ('1234567891234','마시멜로 이야기','12345','12345','2021-04-29',15000,245)
into tbl_books(bk_isbn,bk_title,bk_ccode,bk_acode,bk_date,bk_price,bk_pages)
values('1234567891235','국부론','12346','12445','2021-04-29',16000,352)
into tbl_books(bk_isbn,bk_title,bk_ccode,bk_acode,bk_date,bk_price,bk_pages)
values('1234567891236','심리학의 이해','12347','12512','2021-04-29',17000,123)
select * from dual;

select * from tbl_books;

create table tbl_company(
    cp_code	char(5) primary key,
    cp_title nvarchar2(125)	not null,
    cp_ceo nvarchar2(20),
    cp_tel varchar2(20),
    cp_addr	nvarchar2(125),
    cp_genre nvarchar2(125)		
)

insert all
into tbl_company(cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
values('12345','한국출판사','기성용','010-5234-8853','충북 충주시 모시래2길 15','추리소설')
into tbl_company(cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
values('12355','광주출판사','나상호','010-5534-8173','충북 충주시 모시래2길 29','시집')
into tbl_company(cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
values('12225','충주출판사','남하늘','010-5144-1233','충북 충주시 모시래2길 54','SF소설')

select * from dual;

insert into tbl_company(cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
values('12345','한국출판사','기성용','010-5234-8853','충북 충주시 모시래2길 15','추리소설');

insert into tbl_company(cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
values('12355','광주출판사','나상호','010-5534-8173','충북 충주시 모시래2길 29','시집');

insert into tbl_company(cp_code, cp_title, cp_ceo, cp_tel, cp_addr, cp_genre)
values('12225','충주출판사','남하늘','010-5144-1233','충북 충주시 모시래2길 54','SF소설');

select * from tbl_company;

create table tbl_author(
    au_code	char(5) primary key,
    au_name	nvarchar2(50) not null,	
    au_tel varchar2(20),		
    au_addr	nvarchar2(125),		
    au_genre nvarchar2(30)		
)

insert all
into tbl_author(au_code, au_name, au_tel, au_addr, au_genre)
values ('12345','메시','010-5219-9955','북구 운암동','추리소설')
select * from dual;

select * from tbl_books;

-- 3개의 테이블을 조인하여 view 만들기
create view view_도서정보 as
(
select B.bk_isbn as ISBN,
        B.bk_title as 도서명, 
        C.cp_title as 출판사명, 
        C.cp_ceo as 출판사대표, 
        A.au_name as 저자명, 
        A.au_tel as 저자연락처, 
        B.bk_date as 출판일, 
        B.bk_price as 가격
from tbl_books B
    left join tbl_company C
        on B.bk_ccode = C.cp_code
    left join tbl_author A
        on B.bk_acode = A.au_code);


/*
고정문자열 TYPE칼럼 주의사항 
CHAR() TYPE의 문자열 칼럼은 실제 저장되는 데이터 TYPE에 따라
주의를 해야 한다

만약 데이터가 숫자값으로만 되어있는 경우
00001,00002 와 같이 입력할 경우 0을 삭제해 버리는 경우가 있다

(엑셀에서 IMPORT하는) 실제 데이터가 날짜 타입일 경우
SQL의 날짜형 데이터로 변환한후 다시 문자열로 변환하여 저장한다

칼럼의 PK로 설정하지 않은 경우는 가급적 CHAR로 설정하지 말고
VARCHAR2로 설정하는 것이 좋다

고정문자열 칼럼으로 조회를 할 때 아래와 같은 조건을 부여하면
데이터가 조회되지 않는 현상이 발생할 수 있다
WHERE 코드 = '00001'


*/

select * from view_도서정보;

select * from view_도서정보
where isbn = '9791162540756';

-- 도서명이 엘리트 문자열로 시작되는 모든(List) 데이터
select * from view_도서정보
where 도서명 LIKE '엘리트%';

select * from view_도서정보
where 출판사명 like '%넥%';

select * from view_도서정보
where 출판일 like '%2018%';

-- substr() 함수를 사용한 문자열 가르기
-- substr(문자열데이터, 시작위치, 개수)
select substr(출판일,7,4)
from view_도서정보;

-- 출판일 칼럼의 데이터를 앞에서 4글자만 잘라서 보여라
select substr(출판일,7,4) as 출판년도 from view_도서정보;
-- 출판일 칼럼의 데이터를 오른쪽으로 부터 4글자만 잘라서 보여라
select substr(출판일,0,5) as 출판월일 from view_도서정보;



