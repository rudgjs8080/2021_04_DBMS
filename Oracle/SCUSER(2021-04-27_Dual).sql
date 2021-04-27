-- 여기는 SCUSER 접속-- 여기는 SCUSER 접속

select 30 + 40 from dual;
select 40 - 30 from dual;
select 40 / 20 from dual;
select 30 * 40 from dual;

-- select 명령문을 사용하여
-- 간단한 연산을 수행할 수 있다
-- 표준 SQL에서는 select 연산식 형식으로 수행해 볼 수 있는데
-- oracle 에서는 from 절이 없는 select 는 허용하지 않는다
-- dual이라는 dummy table을 준비해놓고
-- SQL 연산을 수행할 때 사용하도록 만들어놨다 
select 30 + 40,
        40- 30,
        40/ 20,
        30 * 40 from dual;

select * from dual;

-- 정수부분만 출력, 소수점 첫째 자리에서 반올림
select Round(333.33) from dual;
select Round(333.33, 0) from dual;
select round(333.55) from dual;
select round(333.33) as 삼삼, round(333.44) as 사사, round(333.55) as 오오 from dual;
-- 소수 둘째자리에서 반올림하여 첫째 자리까지 표현 
select round(333.33,1) as 삼삼, round(333.44,1) as 사사, round(333.55,1) as 오오 from dual;

-- 일반저인 코딩과 달리 정수부분도 반올림 연산을 수행할 수 있다
select round(555,-1),
        round(555,-2),
        round(555,-3)
from dual;
-- 단순 문자열 출력
select '2021-04-27' as today from dual;
-- 문자열 연결할 때 + 를 사용하지 않고 ||를 사용한다
select '2021-04-27' || '11:20:00'as today from dual;

select to_date('2021-04-27' || '11:20:00', 'yyyy-mm-ddhh:mi:ss') from dual;
-- DBMS의 강제 형변환
-- 문자열형 숫자를 실제 숫자로 강제로 변환하여 사용하기
-- 강제 형변환은 다소 불편할 수 있지만 
-- 결과를 정확히 예측할 수 있기 때문에
-- 자동 형변환보다는 권하는 방식이다
-- 문자열형 숫자데이터를 실제 숫자형으로 변환하는것
select to_number('30') + to_number('40') from dual;

-- + 연산을 수행하면 문자열형 숫자데이터를 실제 숫자형으로
-- 변환하여 연산을 수행한다
-- 자동형변환은 예상하지 못하는 연산결과를 얻을 수 있다 

select '30' + '40' from dual;
-- 날짜와 시간데이터에 round를 입히기 
-- 보이는 것과 달리 실제 데이터는 
-- 2021-04-28:00:00:00 형식으로 round가 적용된다
select 
to_date ('2021-04-2811:27:00' , 'yyyy-mm-ddhh:mi;ss') from dual;
-- 무조건 소수점 이하 값을 절사(자름)
select trunc(333.55), trunc(333.99), trunc(333.33)
from dual;

select trunc(333.55,1), trunc(333.99,1), trunc(333.33,1)
from dual;
-- 나머지 연산
select mod(4,2), mod(5,3),mod(6,5)from dual;

select trunc(150/60) || '분' ||mod(150,60) || '초'
from dual;

select 
case when mod(11,2) = 1 then '홀수'
    else '짝수'
    end case
from dual;




