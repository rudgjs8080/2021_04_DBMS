-- IOUSER 권한으로 접속
-- IOUSER DBA 권한을 갖고 있기 때문에
-- 일반적인 표준 DDL, DML, DCL 명령등을 사용할 수 있다
-- DDL(Data Definition Lang. 데이터 정의어)
--  객체 생성 CREATE : TABLE, INDEX, VIEW 생성
--  객체 삭제 DROP : TABLE, INDEX, VIEW 삭제
--  객체 변경, 수정 ALTER : TABLE, INDEX, VIEW
-- ORACLE 전용 DDL
--      객체 생성 CREATE SEQUENCE
-- 거래내역을 저장할 테이블
CREATE TABLE tbl_iolist (
    io_date VARCHAR2(10), 
    io_buyer nVARCHAR2(20), 
    io_pname nVARCHAR2(20),
    io_qty NUMBER,
    io_price NUMBER,
    io_total NUMBER
);

-- 생성된 table에 data 추가
INSERT INTO tbl_iolist(IO_DATE, io_buyer, io_qty, io_price)
values ('2021-01-01', '홍길동',10,1000);
-- 데이터 전체 조회
select io_date, io_buyer, io_qty, io_price
from tbl_iolist;

-- 위에서 생성한 tbl_iolist는 데이터를 추가하는데
-- 아무런 '제약조건'을 설정하지 않았다
-- 그랬더니 INSERT를 수행했을 때 실수로 상품명을 입력하지 않았는데도
-- 데이터가 INSERT 되어버렸다
-- 나중에 확인을 해보니 상품명이 없어서 데이터 활용가치가 
-- 매우 떨어지는 현상이 발생
-- 이런 상황을 INSERT(추가, 삽입) 이상현상이 발생했다 라고 한다
--      => 무결성이 훼손됐다
-- 기존의 Table을 제거하고 무결성을 유지하기 위한 제약조건을
-- 설정하여 table을 다시 만든다

-- 제약조건을 설정
DROP TABLE tbl_iolist;
CREATE TABLE tbl_iolist (
    io_date VARCHAR2(10), 
    io_buyer nVARCHAR2(20), 
    io_pname nVARCHAR2(20) NOT NULL,
    io_qty NUMBER,
    io_price NUMBER,
    io_total NUMBER
);
-- 데이터 INSERT(상품 데이터를 입력하지 않은 상태)
INSERT INTO tbl_iolist(IO_DATE, io_buyer, io_qty, io_price)
values ('2021-01-01', '홍길동',10,1000);
-- 명령수행에서 오류발생
-- io_pname 칼럼에 null을 insert 할 수 없다
-- io_pname 에 데이터가 setter 되지 않았다

INSERT INTO tbl_iolist(io_pname)
VALUES ('새우깡');
-- 조건없이 모든 데이터를 조회
SELECT * FROM tbl_iolist;
-- 원하는 칼럼을 배열하여 조건없이 모든 데이터를 조회하라
-- projection 지정
SELECT io_pname, io_buyer from tbl_iolist;
-- 필수 제약조건을 설정하자
CREATE TABLE tbl_iolist (
    io_date VARCHAR2(10) NOT NULL, 
    io_buyer nVARCHAR2(20)NOT NULL, 
    io_pname nVARCHAR2(20) NOT NULL,
    io_qty NUMBER NOT NULL,
    io_price NUMBER NOT NULL,
    io_total NUMBER
);

INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21','홍길동','새우깡',10,1000);
-- SELECT 명령문의 AS(ALIAS) 원래 table의 칼럼명을 변경하여 표현하고 싶을때
-- 1. tbl_iolist로부터 데이터를 가져오고
-- 2. project 로 설정된 칼럼들 데이터만 추출하여
-- 3. 리스트를 출력한다
SELECT io_date as 거래일자,
io_buyer as 고객명,
io_pname as 제품명,
io_qty as 수량,
io_price as 가격,
io_qty * io_price as 합계 
from tbl_iolist; -- iolistDB.iouser.tbl_iolist에서 데이터를 가져와라

INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21','임꺽정','진라면',18,2000);
INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21','성춘향','열라면',12,1500);
INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21','이몽룡','안성탕면',15,1400);
INSERT INTO tbl_iolist(io_date, io_buyer, io_pname, io_qty, io_price)
VALUES('2021-04-21','홍길동','매일우유',12,5000);

select * from tbl_iolist;

-- 1. tbl_iolist 로부터 데이터를 가져오기
-- 2. 가져온 데이터 중에서 io_buyer 칼럼에 저장된 값이 '홍길동'인 데이터만
-- 3. 추출해서 출력
select * from tbl_iolist
where io_buyer = '홍길동';

-- tbl_iolist에 저장되어 있는 데이터 리스트 중에서
-- io_buyer 칼럼의 값이 '홍길동' 인 데이터만 추출해서
-- io_buyer, io_pname 칼럼 보이고 나머지 칼럼은 숨김으로 하여 출력
select io_buyer as 고객명, io_pname as 제품명
from tbl_iolist
where io_buyer = '홍길동';












