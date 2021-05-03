-- 2021-05-03
drop table tbl_buyer;

create table tbl_buyer(
    bu_code	char(5)	primary key,
    bu_name	nvarchar2(50) not null,	
    bu_birth number	not null,
    bu_tel	varchar2(20),
    bu_addr	nvarchar2(125)		
);

create table tbl_rent(
    br_seq	number primary key,
    br_sdate varchar2(10) not null,
    br_isbn	char(13) not null,
    br_bcode char(5) not null,
    br_edate varchar2(10),
    br_price number		
);

select * from tbl_buyer
order by bu_birth;

-- tbl_rent 와 tbl_books, tbl_buyer table을
-- 참조무결성 설정
-- 대상 table은 다중관계의 table
-- tbl_buyer 데이터 1개(1명의)고객이
-- 다수의 tbl_rent에 포함이 된다
-- tbl_buyer 1: tbl_rent N = 1:다의 관계이다
-- N의 table에서 FK 설정을 하고 1의 table과 관계를 맺는다
-- fk 삭제
alter table tbl_rent
drop constraint fk_books;

alter table tbl_rent
add CONSTRAINT fk_books
FOREIGN key(br_isbn)
references tbl_books(bk_isbn);

alter table tbl_rent
add constraint fk_buyer
foreign key(br_bcode)
REFERENCES tbl_buyer(bu_code);

desc tbl_rent;
/*
이름       널?       유형           
-------- -------- ------------ 
BR_SEQ   NOT NULL NUMBER       
BR_SDATE NOT NULL VARCHAR2(10) 
BR_ISBN  NOT NULL CHAR(13)     
BR_BCODE NOT NULL CHAR(5)      
BR_EDATE          VARCHAR2(10) 
BR_PRICE          NUMBER       

tbl_rent table에는 필수 사용하는 데이터 칼럼을 
PK로 설정하는데 어려움이 있다
다른 table의 칼럼을 참조를 하고는 있지만
모든 칼럼이 중복값을 가질 수 있는 관계로
단일 칼럼으로 PK를 설정할 수 없다

PK를 설정하고, 더불어 주문관련 리스트를 보는데 사용할
br_seq 칼럼을 만들고 이 칼럼으로 PK를 설정했다

rent 테이블에 데이터를 INSERT하려고 할때
항상 유일한 값으로 PK를 설정해야 하는 어려움이 있다
보통 이러한 칼럼은 일련번호 순으로 만드는데
오라클을 이외의 다른 DBMS에는 일련번호를 자동으로
만들어주는  table속성이 있다
오라클(11 이하)에서는 그러한 속성이 없다
mySQL의 경우 칼럼 속성에 AUTO_INCREMENT로 설정을 하면
그 칼럼을 INSERT할 때 별도 값을 지정하지 않아도
항상 유일한 일련번호로 자동 생성이 된다

오라클에서는 일련번호를 생성하기 위한 별도의 객체가 존재한다
*/
-- 오라클에서 일련번호를 생성하는 SEQUENCE 객체
-- DDL 명령을 사용하여 SEQ 객체 생성
-- 이름을 명명할 때 SEQ_로 시작하고
-- 뒤에 적용할 대상 table명을 붙여 생성한다

create sequence seq_rent
start with 1 -- 시작값
increment by 1; -- 자동증가값

select seq_rent.nextval from dual;

insert into tbl_rent(br_seq, br_sdate, br_isbn, br_bcode)
values (seq_rent.nextval,'2021-05-03', '9791188850426','B0001');

select *from tbl_rent;
delete tbl_rent;
-- 이미 만들어져있는 SEQ 삭제
Drop sequence seq_rent;

-- 기존에 사용하던 SEQ를 삭제하고 다시 생성할 경우
-- 반드시 적용되는 Table의 칼럼 값을 확인해야 한다
-- seq 칼럼의 최대값을 확인하고 
select max(br_seq) from tbl_rent;

-- SEQ의 start 값을 적용하는 테이블의 SEQ 최대값보다 크게 설정해야한다
create sequence seq_rent
start with 11
increment by 1;

-- tbl_rent는 회원이 도서를 대여한 리스트가 있다
-- 여기에는 도서코드, 회원코드만 있기 때문에 
-- 구체적인 정보를 알수없다
-- table JOIN을 통해서 구체적인 정보를 확인하자
-- EQ JOIN
select * 
from tbl_rent BR, tbl_books BO, tbl_buyer BU
    where BR.br_isbn = BO.bk_isbn and BR.br_bcode = BU.bu_code;

-- INNER JOIN
-- FK 관계가 설정된 TABLE 간에 사용하는 JOIN
-- FK 관계가 설정되지 않은 TABLE 간에서는 조회되는 데이터가
-- 실제와 다를 수 있다
select 
    BR.br_sdate as 대여일,
    BR.br_bcode as 회원코드,
    BU.bu_name as 회원명,
    BR.br_isbn as ISBN,
    BK.bk_title as 도서명,
    BR.br_edate as 반납일,
    BR.br_price as 대여금
from tbl_rent BR
    join tbl_books BK
        on BR.br_isbn = BK.bk_isbn
    join tbl_buyer BU
        on BR.br_bcode = BU.bu_code;

-- LEFT(OUTER) JOIN
-- 테이블간에 FK가 설정되지 않고
-- 참조하는 테이블의 데이터가 마련되지 않은 경우
-- FROM 절에 표현된 Table 데이터 위주로 조회하고자 할 때
-- FK 설정되지 않아도 데이터 조회는 모두 할 수 있다
-- 단 JOIN된 테이블의 데이터가 없으면 NULL로 표현된다
drop view view_도서대여정보;
create view view_도서대여정보 as
(
select 
    BR.br_seq as 주문번호,
    BR.br_sdate as 대여일,
    BR.br_bcode as 회원코드,
    BU.bu_name as 회원명,
    BU.bu_tel as 회원연락처,
    BR.br_isbn as ISBN,
    BK.bk_title as 도서명,
    BR.br_edate as 반납일,
    BR.br_price as 대여금
from tbl_rent BR
    left join tbl_books BK
        on BR.br_isbn = BK.bk_isbn
    left join tbl_buyer BU
        on BR.br_bcode = BU.bu_code);

select * from view_도서대여정보;

select * from view_도서대여정보
where 회원명 = '명윤일';

select * from view_도서대여정보
where 대여일 < '2021-05-30';

select * from view_도서대여정보
where 대여일 < '2021-05-25' and 반납일 is null;

-- 중복된 데이터가 있으면 그룹으로 묶어서
-- 단순하게 보여달라 
select 대여일, 회원코드, 회원명, BU.bu_tel
from view_도서대여정보 BR
    left join tbl_buyer BU
        on BR.회원코드 = BU.bu_code
where 대여일 < '2021-05-25' and 반납일 is null
group by 대여일, 회원코드, 회원명, BU.bu_tel;

/*
위으 코드는 전체 데이터중에서 대여일과 반납일에 조건을 부여한후
데이터를 간추리고, 간추려진 데이터를 GROUP으로 묶어보여주기

아래 코드는 전체 데이터를 GROUP으로 묶고
묶인 데이터를 조건에 맞는 항목만 보여주기

이 두코드는 결과는 같지만
실행하는 성능은 매우 많은 차이가 난다
데이터가 많을수록 성능차이는 더욱 명확하게 난다
*/

select 대여일, 회원코드, 회원명, BU.bu_tel
from view_도서대여정보 BR
    left join tbl_buyer BU
        on BR.회원코드 = BU.bu_code
group by 대여일, 회원코드, 회원명, BU.bu_tel, 반납일
having 대여일 < '2021-05-25' and 반납일 is null;

/* 예시)
학생이름   과목     점수
--------------------------
홍길동     국어      50
홍길동     영어      80
홍길동     수학      70
이몽룡     국어      56
이몽룡     영어      85
이몽룡     수학      73
--------------------------
홍길동 학생의 4과목 총점을 계산하기 위한 코드

select 학생이름, sum(점수)
from tbl_score
group by 학생이름
having sum(점수) > 180;

tbl_score에서 영어, 수학 2과목의 점수만 총점을 계산하고 싶다

select 학생이름, sum(점수)
from tbl_score
where 과목 = '과학' or 과목 = '수학'
group by 학생이름;

*/
-- 직업별로 급여의 합계 계산하기
select 직업, sum(급여)
from tbl_급여
group by 직업;

-- 직업별로 급여 합계를 게산할때
-- 직업이 영업직인 사람을 제외하고 싶다
select 직업, sum(급여)
from tbl_급여
where 직업!= '영업직'
group by 직업;

select 직업, sum(급여)
from tbl_급여
group by 직업
having 직업!= '영업직';

-- 급여테이블에서 영업직을 제외한 직업의 급여 총합계를 계산하고
-- 총합계가 1000000 이상인 데이터만 보여라
select 직업, sum(급여)
from tbl_급여
where 직업!= '영업직'
group by 직업
having sum(급여) > 1000000;

-- 급여테이블에서 영업직을 제외하고
-- 실급여가 1000000을 초과하는 데이터만 합산하여 보여라
select 직업, sum(급여)
from tbl_급여
where 직업!= '영업직' and 급여 > 1000000
group by 직업;

-- 대여일이 2021-05-13 이전이고 아직 미납된 데이터
select * from view_도서대여정보
where 대여일 <= '2021-05-13' and 반납일 is null;

select 대여일, 회원코드, 회원명, 회원연락처, 도서명
from view_도서대여정보
where 대여일 <'2021-05-13' and 반납일 is null
group by 대여일, 회원코드, 회원명, 회원연락처, 도서명;

insert into tbl_rent(br_seq, br_sdate, br_bcode, br_isbn)
values (seq_rent.nextval,'2021-04-01','B0012','9791162540572');

select * from tbl_rent;

insert into tbl_rent(br_seq, br_sdate, br_bcode, br_isbn)
values (seq_rent.nextval,'2021-04-01','B0010','9791162540572');













