-- 2021-05-07 농협마트
drop table tbl_iolist;

create table tbl_iolist(
    io_seq	number primary key,
    io_date	varchar2(10) not null,	
    io_time	nvarchar2(50) not null,	
    io_pname nvarchar2(50) not null,	
    io_dname nvarchar2(50) not null,	
    io_dceo	nvarchar2(20) not null,
    io_inout varchar2(1) not null,
    io_qty number not null,
    io_price number	not null
);

select count(*) from tbl_iolist;

select io_inout, count(*)
from tbl_iolist
group by io_inout;

-- io_inout 칼럼의 데이터가 1이면 매입을 표시
-- 아니면 매출을 표시하라
-- if io_inout == 1 then '매입'
-- else '매출'

select
    decode(io_inout,'1','매입','매출') as 구분,
    count(*)
from tbl_iolist
group by decode(io_inout,'1','매입','매출');

select
    decode(io_inout,'1','매입','2','매출') as 구분,
    count(*)
from tbl_iolist
group by decode(io_inout,'1','매입','2','매출');

/*
매입매출 데이터를 DB로 import 한 후
테이블에서 상품정보, 거래처정보를 분리하여
제3정규화를 수행하기

현재 매입매출 테이블에 상품이름과 거래처명(대표포함)이 저장되어 있다
현재 테이블에서 만약 상품이름이나 거래처명이 변경되어야 하는 일이 발생한다면
다수의 데이터(레코드)에 변경(UPDATE)가 되는 상황이 만들어진다
다수의 데이터를 변경하는 명령은
데이터 무결성을 해치는 원인중의 하나이다

상품테이블을 별도로 분리하고
상품코드, 상품명 형식으로 저장한 후
매입매출 테이블에는 상품명 대신 상품코드를 포함하고
이후 JOIN을 통해 데이터를 조회하는 것이 좋다

*/

-- 1. 매입매출 테이블에서 상품정보를 중복없이 추출하기

select io_pname
from tbl_iolist
group by io_pname
order by io_pname;

-- 2. 매입매출 테이블에서 상품정보와 매입단가 매출단가도 같이 추출하기 
--      매입단가 매출단가도 같이 추출하기
--      전체 데이터에서 상품별로 가장 높은 가격을 가져와서
--      매입매출 단가로 사용하자

select io_pname, 
    max(decode(io_inout,'1',io_price,0)) as 매입단가,
    max(decode(io_inout,'2',io_price,0)) as 매출단가
from tbl_iolist
group by io_pname
order by io_pname;

/*
상품 리스트를 추출했는데 매입단가가 0, 또는 매출단가가 0인 경우
매입단가와 매출단가를 계산

매입단가가 0 인 경우
매출단가에서 마진(20%)을 빼고, 다시 부가세(10%)를 뺀 가격
매입단가 = (매출단가 / 1.2) / 1.1

매출단가는 매입단가에 20% 마진 추가, 부가세 10% 추가
매출단가 = (매입단가 * 1.2) 1*1

10원단위 절사
매출단위 = int(매출단가 / 10) * 10

*/

create table tbl_product(
    p_code	char(6)		primary key,
    p_name	nvarchar2(50)	not null,	
    p_iprice	number	not null,
    p_oprice	number	not null,
    p_vat	varchar2(1)	default 'Y'	
);

-- 매입매출 데이터에서 상품정보를 생성했다
-- 생성된 상품정보가 맞게 되었는지 검증하기
-- 두 테이블을 JOIN하여 혹시 NULL 값이 있는지 확인하기
select IO.io_pname, P.p_name
from tbl_iolist IO
    left join tbl_product P
        on IO.io_pname = P.p_name;

-- 리스트가 너무 많아서 null을 찾기가 어려울때
-- JOIN된 상품정보의 상품이름이 NULL인 데이터만 조회하기
-- 이 조회에서 데이터가 한건도 나타나지 않아야 한다
select IO.io_pname, P.p_name
from tbl_iolist IO
    left join tbl_product P
        on IO.io_pname = P.p_name
where P.p_name is null;














