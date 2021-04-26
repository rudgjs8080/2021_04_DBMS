-- 2021-04-26
-- 학생정보 테이블 생성
-- 학번 : 고정문자열 5 , 기본키 설정
-- 이름 : 한글가변문자열 20, NULL 값 올수 없음
--
CREATE TABLE tbl_score(
    sc_num char(5) primary key,
    sc_kor NUMBER not null,
    sc_eng NUMBER not null,
    sc_math NUMBER not null
);

DROP table tbl_score;
drop table tbl_student;

create table tbl_student(       
    st_num	CHAR(5)	Primary Key,
    st_name	nVARCHAR2(20)NOT NULL,	
    st_dept	nVARCHAR2(10),
    st_grade VARCHAR(5),
    st_tel	VARCHAR(20),
    st_addr	nVARCHAR2(125)		
);
drop view veiw_1반학생;
drop view veiw_영어점수;
drop view view_1반학생;
drop view view_score;
-- 임포트한 데이터 확인
select * from tbl_student;

-- 임포트한 데이터의 개수(데이터 레코드 수) 확인
-- count() : SQL의 통계함수, 개수를 계산
select count(*) from tbl_student;

select * from tbl_score;
select count(*) from tbl_score;

-- 임포트된 성적데이터의 전체 과목 총점 계산
-- 통계함수 sum() : 숫자칼럼의 총점
-- 전체 레코드의 데이터를 합산
select sum(sc_kor) as 국어총점,
        sum(sc_eng) as 영어총점,
        sum(sc_math) as 수학총점
from tbl_score;

select sc_num as 학번,
    (sc_kor + sc_eng + sc_math) as 총점
from tbl_score;

-- 전체 과목의 평균점수
-- 통계함수 AVG()를 사용하여 과목평균 계산
-- ALIAS 설정을 할 때 AS 키워드를 생략가능
select AVG(sc_kor) 국어, avg(sc_eng) 영어, avg(sc_math)수학
from tbl_score;

-- 전체학생 성적중에 국어 최고점, 국어 최저점
select Max(sc_kor) 국어최고, MIN(sc_kor) 국어최저
from tbl_score;

-- 통계함수
-- count(), sum(), avg(), min(), max()
-- 통계함수를 사용할 때 통계에 포함하지 않는 칼럼을
-- 보고자 할 때는 GROUP BY를 사용하여 묶어줘야 한다
-- 학번으로 묶어서, 동일한 학번의 국어점수의 합계 할 때
select sc_num, sum(sc_kor)
from tbl_score
group by sc_num;

select * from tbl_student
where st_num = 'S0005';

-- 성적데이터를 보면서
-- 각 학생의 이름 등을 같이 보고싶다
-- 2개의 테이블을 JOIN을 하여 함께 보자 
-- tbl_score를 나열하고 tbl_score의 sc_num의 값과 같은 데이터를
-- tbl_student에서 찾아서 함께 나열하라
select * from tbl_score, tbl_student
where sc_num = st_num;

select sc_num,st_name,st_dept,sc_kor,sc_eng,sc_math
from tbl_score, tbl_student
where sc_num = st_num;

-- 2개 이상의 테이블을 JOIN 할 때
-- 각각 테이블의 칼럼(속성)이름이 같은 경우
-- 문제가 발생할 수 있다

select 
    tbl_score.sc_num,
    tbl_student.st_name,
    tbl_student.st_dept,
    tbl_score.sc_kor,
    tbl_score.sc_eng,
    tbl_score.sc_math
from tbl_score, tbl_student
where sc_num = st_num;

-- 테이블이름을 부착하기 번거로우면
-- 테이블에 Alias를 추가한 후
-- 각 칼럼 이름에 Alias를 사용할 수 있다

select 
    SC.sc_num,
    ST.st_name,
    ST.st_dept,
    SC.sc_kor,
    SC.sc_eng,
    SC.sc_math
from tbl_score SC, tbl_student ST
where sc_num = st_num;

-- 테스트를 위하여 학생 데이터 일부를 삭제
delete from tbl_student
where st_num >= 'S0080';

-- 학생데이터에서 일부를 삭제 한 후
-- JOIN을 실행하였더니
-- 성적데이터가 79개 밖에 조회되지 않는다
-- 성적데이터는 모두 100개가 있지만
-- 학생데이터는 79개만 남아 있기 때문에
-- JOIN한 결과가 학생데이터와 같은 수인 79개만 조회된다
-- EQ JOIN(참조 무결성이 보장되는 경우 사용하는 일반적인 JOIN)
select 
    SC.sc_num,
    ST.st_name,
    ST.st_dept,
    SC.sc_kor,
    SC.sc_eng,
    SC.sc_math
from tbl_score SC, tbl_student ST
where sc_num = st_num;

-- 학생데이터는 1 ~ 79까지 있고
-- 성적데이터는 1 ~ 100까지 있다
-- 성적데이터의 80~ 100까지는
-- 실제 존재하는 학생인지 증명할 방법이 없다
-- 성적데이터는 무결성이 깨진 상태가 된다
-- 학생테이블과 성적테이블간의 연관(관계) 참조가
-- 무너진 상태가 된다
-- => 참조 무결성이 깨졌다(오류)
-- 참조 무결성에 문제가 생긴경우
-- JOIN을 했을 때 인출되는 데이터의 신뢰성을 보증할 수 없다
select * from tbl_score;
select * from tbl_student;

-- 참조 무결성 여부와 관계없이
-- 모든 데이터를 JOIN하여 보고 싶을 때
-- LEFT JOIN( LEFT OUT JOIN)
-- tbl_score 테이블의 데이터는 모두 보여주고
-- 학생 테이블에서 학번이 일치하는 학생이 있으면
-- 같이 보여달라
-- 보통 table의 참조무결성 보증을 설정하는 경우가 있는데
-- 참조관계에 없는 다수의 테이블을 JOIN 하여 보고 싶을 때는
-- LEFT JOIN을 사용한다
-- 참조 무결성 보증이 된 경우도 LEFT JOIN 을 수행하면
-- 모든 데이터의 참조 무결성이 잘되고 있는지 확인 할 수 있다
-- 
select 
    SC.sc_num,
    ST.st_name,
    ST.st_dept,
    SC.sc_kor,
    SC.sc_eng,
    SC.sc_math
from tbl_score SC
    LEFT JOIN tbl_student ST
            ON sc_num = st_num;

select count(*) from tbl_score, tbl_student; -- 7900 값 도출
-- EQ JOIN을 실행할 때 조건을 부여하지 않으면
-- 테이블 * 테이블만큼의 데이터가 출력된다
-- 이렇게 인출된 데이터를 '카티션곱' 이라고 한다

-- 학생데이터에 없는 학생의 성적이 추가되어 있는지 여부를
-- 알아보고 싶을 때
-- 참조 무결성에 오류가 있는지 알고 싶을 때
select count(*)
from tbl_score
    left join tbl_student
            on sc_num = st_num;

--학생데이터를 모두 나열하고
-- 학생데이터와 일치하는 성적데이터만 보여라
-- 학생데이터와 성적데이터간의 참조 무결성을 보여라
-- 학생 데이터와 성적데이터간의 참조 무결성이 오류가 있기 때문
-- 실제 학생데이터에 존재하는 성적정보만 보고 싶을 때
select count(*)
from tbl_student
    left join tbl_score
        on st_num = sc_num;

select sc_num As 학번
from tbl_score;
drop view view_성적정보;
--  ROUND (값, 자릿수) : 자릿수 이하에서 반올림
-- ROUND(값, 0 ) : 소수점이하 반올림하고 정수형으로
CREATE VIEW view_성적정보
as
(
    select SC.sc_num as 학번,
            ST.st_name as 이름,
            ST.st_dept as 학과,
            ST.st_grade as 학년,
            ST.st_tel as 전화번호,
            SC.sc_kor as 국어점수,
            SC.sc_eng as 영어점수,
            SC.sc_math as 수학점수,
            ROUND((SC.sc_kor + SC.sc_eng + SC.sc_math)/3,2) as 평균,
            SC.sc_kor + SC.sc_eng + SC.sc_math as 총점
    from tbl_score SC
        LEFT JOIN tbl_student ST
        on sc_num = st_num
);

select * from VIEW_성적정보;

select * from view_성적정보
order by 학번;

select * from view_성적정보
order by 학과,평균 DESC;








