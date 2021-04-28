-- 2021-04-28
drop table tbl_booksTable;
create table tbl_booksTable(
    bt_isbn	char(13) primary key,
    bt_pub	nvarchar2(20)	not null	,
    bt_title	nvarchar2(100)	not null,	
    bt_writer	nvarchar2(50)	not null,	
    bt_trans	nvarchar2(20)		,
    bt_day	varchar2(10)		,
    bt_page	number		,
bt_price	number		

);
delete tbl_bookstable;
insert all
into tbl_booksTable(bt_isbn,bt_pub,bt_title,bt_writer,bt_trans,bt_day,bt_page,bt_price) values ('4599853126584' , '비즈니스북스', '데스 바이 아마존', '시로타 마코토', '신희연', '2019-04-15',275,15000)
into tbl_booksTable(bt_isbn,bt_pub,bt_title,bt_writer,bt_trans,bt_day,bt_page,bt_price) values ('4599853126585','북라이프','4주만에 완성하는 레깅스핏 스트레칭','다쿠로','장현정','2018-04-15',245,16000)
into tbl_booksTable(bt_isbn,bt_pub,bt_title,bt_writer,bt_trans,bt_day,bt_page,bt_price) values ('4599853126586','북라이프','왕이 된 남자2','김선덕','' ,'2019-05-15',154,25000)
into tbl_booksTable(bt_isbn,bt_pub,bt_title,bt_writer,bt_trans,bt_day,bt_page,bt_price) values ('4599853126587', '북라이프', '왕이 된 남자1', '김선덕', '', '2018-12-13', 153, 32000)
into tbl_booksTable(bt_isbn,bt_pub,bt_title,bt_writer,bt_trans,bt_day,bt_page,bt_price) values ('4599853126588','비즈니스북스','새벽에 읽는 유대인 인생특강','장대운','','2018-12-05',123,14000)
select * from dual;

select count(*) from tbl_bookstable;
select * from tbl_bookstable;

--ALTER TABLE : TABLE을 변경하는 명령
-- 만들어진 table의 이름을 변경하기
Alter table tbl_bookstable rename to tbl_books_v2;

-- 이미 데이터가 담긴 테이블을 복제
-- 테이블 구조와 데이터를 복제하여 백업을 하는 용도
-- 일부 제약조건이 함께 복제되지 않는다

create table tbl_books as select * from tbl_books_v2;

-- TABLE을 복제한 후 오라클에서는
-- 반드시 PK를 다시 설정해 주어야 한다
-- Table을 생성하고 데이터가 있는 상태에서
-- PK를 변경, 추가 하는 경우에는 
-- PK로 설정하려고 하는 칼럼의 데이터가
-- PK조건(유일성, Not null)을 만족하지 않는 데이터가 있으면
-- 명령이 실패한다
-- 대량의 데이터가 저장된 table을 alter(변경)할 경우는
-- 매우 신중하게 실행을 해야한다
-- 또한 미리 데이터 검증을 통하여 제약조건에 위배되는 
-- 데이터가 있는지 확인을 해야 한다

alter table tbl_books -- tbl_books table을 변경
add CONSTRAINT PK_ISBN -- 제약조건을 추가하는데 이름을 PK_ISBN
primary key(bk_isbn); -- bk_isbn 칼럼을 PK로 설정하겠다

-- 생성된 PK를 제거하는 명령
alter table tbl_books drop primary key cascade;

/*
도서정보를 저장하기 위하여 tbl_books 테이블을 생성하고
도서정보를 import 했다
도서정보는 어플로 만들기 전에 사용하던 데이터인 관계로 
데이터베이스의 규칙에 다소 어긋난 데이터가 있다

저자 항목(칼럼)을 보면 저자가 2명 이상인 데이터가 있고
또한 역자로 2명 이상인 경우가 있다

데이터를 저장할 칼럼을 크게 설정하여 입력(import)하는데는
문제가 없는데 저자나 역자를 기준으로 데이터를
여러가지 조건을 부여하여 조회를 하려고 하면
문제가 발생할 수 있다
특히 저자이름으로 Groupping하여 데이터를 조회해 보려고 하면
상당히 어려움을 겪을 수 있다

*/

desc tbl_books_v2;

-- 특정 칼럼의 이름을 변경
alter table tbl_books_v2 
rename column bk_writer2 to bt_writer2; 

-- bt_wirter2라는 칼럼을 생성
-- 한글가변문자열2로 선언하고 not null로 설정하라
-- alter table을 이용하여 칼럼을 추가하는 경우에는
-- 사전에 제약조건 설정이 매우 까다롭다
-- 제약조건을 설정하려면
-- 1. 칼럼을 아무런 제약조건 없이 추가한 후
-- 2. 제약 조건에 맞는 데이터를 입력한 후
-- 3. 제약조건을 설정한다 
alter table tbl_books_v2
add bk_writer2 nvarchar2(50);

/*
데이터 베이스의 제1정규화
한 칼럼에 저장되는 데이터는 원자성을 가져야 한다
한 칼럼에 2개 이상의 데이터가 구분자로 나뉘어 저장되는 것을 막는 조치
이미 2개 이상의 데이터가 저장된 경우 분리하여 원자성을 갖도록 하는 것
*/

/*
도서정보 데이터의 제1정규화를 수행하고 보니
저자 데이터를 저장할 칼럼이이후에 또 변경해야 하는 상황이
발생할 수 있는 이슈가 발견되었다

제2정규화를 통하여 테이블 설계를 다시 해야 하겠다
1. 정규화를 수행할 칼럼이 무엇인가 파악(인식한다)
    저자 데이터를 저장할 칼럼
    복수의 데이터가 필요한 경우
2. 도서정보와 관련된 저자데이터를 저장할 Table을 새로 생성한다
    tbl_writer table을 생성할 예정
    
    "도서의 ISBN"과 "저자 리스트"를 포함하는 형태의 데이터를 만든다
    -------------------
    ISBN    저자
    -------------------
    1       홍길동
    1       이몽룡
    2       성춘향
    3       임꺽정   
*/

-- 도서의 저자 리스트를 저장할 table 생성
create table tbl_books_writer(
    bw_seq	number primary key,
    bw_isbn	char(13) not null,
    bw_writer nvarchar2(50) not null	
);
drop table tbl_book_writer;
-- tbl_books_v2 테이블의 데이터를 삭제하고
-- 제1정규화가 완료된 데이터로 다시 import
delete from tbl_books_v2;
commit;
select * from tbl_books_v2;

-- 제1정규화가 완료된 도서정보로부터 저자리스트를 생성

select '(' || bt_isbn, bt_writer1 from tbl_books_v2
group by '(' || bt_isbn, bt_writer1
union all
select '(' ||bt_isbn, bt_writer2 from tbl_books_v2
where bt_writer2 is not null
group by '(' ||bt_isbn, bt_writer2;
-- '(' -> 문자를 강제로 넣어서 엑셀에 넣을 때 문자열로 넣기위한 과정

-- union all : 두개이상의 출력된 리스트를 합하여 1개의 리스트로 보여라
-- 각각의 조회 결과에서 나타나는 칼럼이 일치해야 한다

-- 도서정보와 저자리스트를 JOIN하여 데이터 조회
-- 저자가 1명인 경우는 한개의 도서만 출력이 되고
-- 도서가 2명 이상인 경우는 같은 ISBN, 같은 도서명, 다른 저자 형식으로 
-- 저자 수 만큼 데이터가 출력될 것이다
select bt_isbn, bt_title, bw_writer
from tbl_books_v2
    left join tbl_books_writer
        on bt_isbn = bw_isbn
order by bt_isbn;
-- 제 2 정규화가 완료된 상태에서 
-- 도서정보를 입력하면서 저자정보를 추가하려면 
-- 저자정보에는 ISBN 저자명을 포함한 데이터를 추가해 주면 된다

select bw_writer, bt_isbn, bt_title
from tbl_books_v2
    left join tbl_books_writer
        on bt_isbn = bw_isbn
order by bw_writer;

-- 정보처리기사
-- 제 1 정규화 : 원자성
-- 제 2 정규화 : 완전함수 종속성
-- 제 3 정규화 : 이행적함수 종속성

-- tbl_books_writer 에 데이터를 추가하려고 할 때
-- isbn이 도서에 저자를 추가하고 싶을 때
-- 테이블에 bw_seq 칼럼에는 이미 등록된 값이 아닌
-- 새로운 숫자를 사용하여 데이터를 추가해야 한다
-- 데이터를 추가할 때 마다 새로운 값이 무엇인지 알아야 하는
-- 매우 불편한 상황이 만들어지고 말았다 
insert into tbl_books_writer(bw_seq,bw_isbn,bw_writer)
values (35,'9791162540558','홍길동');












