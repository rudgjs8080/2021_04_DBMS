-- 2021-05-07 농협마트 2
/*
iolist 테이블과 product 테이블간에 상품으로 JOIN을 하여
NULL 값이 없는것이 확인되었다

1. iolist 테이블에 상품코드 칼럼을 추가하고
2. product 테이블에서 상품코드를 가져와 iolist 테이블에 저장
3. iolist 테이블과 product 테이블간에
    상품코드를 기준으로 JOIN을 할 수 있도록
    테이블 변경을 시작한다
*/

-- tbl_iolist 에 상품코드를 저장할 칼럼을 추가
Alter table tbl_iolist
add io_pcode char(6);

desc tbl_iolist;

-- 생성된 io_pcode 칼럼에 io_pname칼럼의 상품이름에 해당하는
-- 코드 데이터를 tbl_product에서 가져와서
-- 저장을 해야한다

-- 테이블의 데이터를 변경하기 위한 DML
-- tbl_iolist 전체를 반복하면서
--      io_pcode 칼럼에 값을 갱신하라
-- 이때 tbl_iolist의 상품으로 tbl_product 데이터를 조회하여
--      일치하는 데이터가 있으면 
--      그중에 상품코드 칼럼의 값을 가져와서
--      io_pcode 칼럼에 저장하라

update tbl_iolist IO
set io_pcode = (
    select p_code from tbl_product P
    where IO.io_pname = P.p_name
);

/*
iolist 전체 데이터를 보여달라
iolist 데이터의 상품이름을 product 테이블에서 조회하여
일치하는 상품이 있으면 리스트를 보일때 같이 보여달라
라는 Sub Query
*/

select IO.io_pname,
(
    select P.p_name from tbl_product P
    where IO.io_pname = P.p_name
) as 상품이름,
(
    select P.p_code from tbl_product P
    where IO.io_pname = P.p_name
) as 상품코드
from tbl_iolist IO;

-- tbl_iolist의 상품코드 칼럼에 저장된 값과
-- tbl_product의 상품코드를 JOIN하여 데이터 조회
select IO.io_pcode, IO.io_pname, P.p_name, P.p_iprice, P.p_oprice
from tbl_iolist IO
    Left join tbl_product P
        on IO.io_pcode = P.p_code;
        
/*
매일매출 데이터에서 거래처 정보를 추출하고
거래처 정보 데이터를 생성한 후
거래처 코드를 만들고
tbl_dept Table을 작성한 다음 데이터 import

iolist에 io_dcode 칼럼을 추가하고
데이터를 UPDATE 수행
*/

-- 1. iolist로 부터 거래처명, 대표자명 칼럼을 기준으로
-- 중복되지 않은 데이터를 조회
-- 거래처명, 대표자명 순으로 정렬
-- projection : 기준이 되는 칼럼을 SELECT 표현
--      필요한 칼럼만 나타나며 전체 데이터가 출력
-- 중복되지 않게(같은 데이터는 1번만 출력)
--      칼럼을 Group by 묶기
select io_dname, io_dceo
from tbl_iolist
group by io_dname, io_dceo
order by io_dname, io_dceo;

create table tbl_dept(
    d_code	char(5)		primary key,
    d_name	nvarchar2(50)	not null,	
    d_ceo	nvarchar2(20)	not null,	
    d_tel	varchar2(20)		,
    d_addr	nvarchar2(125)		,
    d_product	nvarchar2(20)	
);

-- import 된 거래처정보와 매입매출정보를 JOIN하여
-- NULL 값이 있는지 확인

-- tbl_iolist에 io_dcode 칼럼추가, char(5)

-- 거래처정보 테이블에서 거래처 코드를 조회하여
-- tbl_iolist의 io_dcode 칼럼에 update

select IO.io_dname, D.d_name
from tbl_iolist IO
    left join tbl_dept D
        on IO.io_dname = D.d_name
where D.d_name is null;

alter table tbl_iolist
add io_dcode char(5);

update tbl_iolist IO
set io_dcode = (
    select d_code from tbl_dept D
    where IO.io_dname = D.d_name and io_dceo = d_ceo);

select io_date, io_time, io_pcode, p_name, io_dcode, d_name, d_ceo,
        decode(io_inout,'1','매입','2','매출') as 구분,
        io_qty, io_price
    from tbl_iolist
        left JOIN tbl_product
            on p_code = io_pcode
        left JOIN tbl_dept
            on d_code = io_dcode;

commit















