-- 여기는 SCUSER로 접속
drop table tbl_student;

CREATE TABLE tbl_student(
    sc_num CHAR(5),
    sc_name nvarchar2(20),
    sc_dept nvarchar2(10),
    sc_grade varchar2(5),
    sc_tel varchar2(20),
    sc_addr nvarchar2(125)
);

-- 생성한 table에 데이터 추가
-- DML(데이터 조작어) 명령을 사용하여 데이터 추가(create)
-- create : 테이블에 존재하지 않는 데이터를 새로 추가한다 라는 개념

INSERT INTO tbl_student(sc_num, sc_name, sc_dept, sc_grade)
values('00001','홍길동','경제학과','3');

-- 데이터를 추가한 후에는 잘 추가되었는지 확인
-- tbl_student table에 저장되어있는 모든 데이터를 무조건 보여달라
SELECT * FROM tbl_student;
INSERT INTO tbl_student (sc_num, sc_dept, sc_grade)
values('00001','컴퓨터공학','2');
SELECT * FROM tbl_student;

-- 위에서 생성한 tbl_student 테이블에는
-- 데이터를 추가하려고 할 때
-- 이름 데이터가 없어도 추가가 된다
-- 같은 학번의 데이터가 이미 추가되어 있어도 또 다시 추가가 된다
-- 이런식으로 데이터가 계속 추가된다면 전체 데이터의 신뢰성에 문제가 된다
-- DBMS 에서는 table(Entity)를 설계할 때 이러한 오류를 방지하기 위하여
-- table을 생성할 때 "제약조건"을 설정하여 데이터가 INSERT 되지 못하도록
-- 하는 기능이 있다
-- 작성된 table을 삭제하고 다시 제약조건을 설정하여 생성하자
-- 1. 학생의 이름은 데이터가 반드시 있어야만 한다
--      sc_name(학생 이름) 칼럼은 NOT NULL
-- 2. 학번은 절대 중복되면 안된다
--      tbl_student의 학번은 유일해야 한다

CREATE TABLE tbl_student(
    sc_num CHAR(5) UNIQUE NOT NULL,
    sc_name nvarchar2(20) NOT NULL,
    sc_dept nvarchar2(10),
    sc_grade varchar2(5),
    sc_tel varchar2(20),
    sc_addr nvarchar2(125)
);
-- 학생이름이 없으므로 INSERT 불가
INSERT INTO tbl_student(sc_num, sc_dept)
values('00001','컴퓨터공학');
-- 학생이름 데이터 추가
INSERT INTO tbl_student(sc_num, sc_name, sc_dept)
values('00001','기성용','컴퓨터공학');
-- 만약 학번을 위와 같은 학번으로 입력하게 되면 UNIQUE관련 오류가 발생한다
--      UNIQUE는 매우 신중하게 설정해야한다
INSERT INTO tbl_student(sc_num, sc_name, sc_dept)
values('00002','박지성','전기공학');
SELECT * FROM TBL_STUDENT;

-- 기본키 칼럼(Primary Key)
-- 데이터를 조회(SELECT)할 때 st_num 칼럼을 기준으로 조회하면
-- 반드시 원하는 데이터 1개만 보여지는 조건을 만족하게 하는 칼럼
-- 제약조건이 반드시 UNIQUE 하면서 NOT NULL 이어야 한다
-- 기본키는 제약조건에 UNIQUE와 NOT NULL을 같이 설정해야 하는데
-- DBMS는 기본키 제약조건을 설정하는 키워드가 별도로 있다

-- Primary Key = UNIQUE + NOT NULL + 기타 조건
-- 가장 우선순위가 높은 제약조건

CREATE TABLE tbl_student(
    sc_num CHAR(5) Primary key,
    sc_name nvarchar2(20) NOT NULL,
    sc_dept nvarchar2(10),
    sc_grade varchar2(5),
    sc_tel varchar2(20),
    sc_addr nvarchar2(125)
);
INSERT INTO tbl_student(sc_num, sc_name, sc_dept)
values('00001','손흥민','경영학과');
INSERT INTO tbl_student(sc_num, sc_name, sc_dept)
values('00002','박지성','전기공학');
INSERT INTO tbl_student(sc_num, sc_name, sc_dept)
values('00003','차범근','간호학과');
-- DESC = DESCRIBE : 현재 테이블의 구조를 보여달라는 명령문
DESC tbl_student;
SELECT 
* 
FROM tbl_student;

select 
* 
from tbl_student
where sc_num = '00001';

SELECT
    *
FROM tbl_student;




