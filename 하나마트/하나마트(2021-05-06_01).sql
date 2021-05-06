-- 2021-05-06 iouser 접속

create table tbl_iolist(
    io_seq	number	primary key,
    io_date	varchar2(10) not null,	
    io_pname nvarchar2(50) not null,	
    io_dname nvarchar2(50) not null,	
    io_dceo	nvarchar2(20) not null,
    io_inout nvarchar2(5) not null,	
    io_qty number not null,
    io_price number	not null,	
    io_total number		
);

select count(*) from tbl_iolist
where io_inout = '매출';

select io_inout, count(*)
from tbl_iolist
group by io_inout;
-- 매입과 매출금액 총합

select io_inout, sum(io_total)
from tbl_iolist
group by io_inout;

select io_inout,
    sum(decode(io_inout,'매입',io_total)) as 매입합계,
    sum(decode(io_inout,'매출',io_total)) as 매출합계
from tbl_iolist
group by io_inout;

select 
    sum(decode(io_inout,'매입',io_total)) as 매입합계,
    sum(decode(io_inout,'매출',io_total)) as 매출합계
from tbl_iolist;

-- 일년동안 매입과 매출금액을 계산하고
-- 단순 이익금 계산해보기 
select 
    sum(decode(io_inout,'매입',io_total)) as 매입합계,
    sum(decode(io_inout,'매출',io_total)) as 매출합계,
    sum(decode(io_inout,'매출',io_total)) - sum(decode(io_inout,'매입',io_total))
    as 순이익금
from tbl_iolist;

-- 매입매출관련하여
-- 소매점에서 상품을 매입하여 소비자한테 판매할 때
-- 매입할 때 매입부가세 발생
-- 판매할 때 매출부가세 발생
-- 매출부가세 - 매입부가세를 계산하여 일년에 2 ~ 4 회에
-- 부가가치세를 납부한다

--농사를 지어서 쌀 20KG를 생산하여 판매를 하면
-- 5만원 정도의 금액의 판매가 된다
-- 쌀을 공장에서 가공하여 생산품(공산품)으로 만들게 되면
-- 실제 20KG의 쌀을 직접 판매하는 것보다 더 큰 이익을 가질 수 있다
-- 이때 실제 쌀보다 더 많은 이익이 발생하게 되므로 
-- 가치가 부가 되었다 라고 표현한다
-- 가치가 부가되는 만큼 세금을 납부하도록 한다
-- 부가가치세(Value Add Tax)
-- 매입을 할때는 매입금액의 10% 만큼을 세금을 포함하여 매입을 하고
-- 매출을 할때는 매출금액의 10% 만큼 세금을 포함하여 판매한다

-- 매입매출 데이터에서 보면
-- 매입금액은 부가세 10%를 제외한 금액으로 입력하고
-- 매출금액은 부가세 10%가 포함된 금액으로 입력한다
-- 샘플데이터의 매입금액은 VAT 제외 금액이고
--      매출금액은 VAT 포함된 금액이다
-- 매입과 매출 데이터로 지난 1년간 납부한 VAT 금액을 계산해보자
-- 매입금액 : 22737397
-- 매출금액 : 41683800
-- VAT = (매출금액에 포함된 VAT) - (매입금액 * 0.1)
-- 매출금액의 VAT 제외된 합계 = 매출금액 /1.1
-- 매출 부가세 : VAT 제외된 매출금액 * 0.1
select 
    sum(decode(io_inout, '매입' ,round(io_total * 0.1))) as 매입부가세,
    sum(decode(io_inout,'매출',round((io_total / 1.1 ) * 0.1))) as 매출부가세,
    sum(decode(io_inout,'매출',round((io_total / 1.1 ) * 0.1))) - 
    sum(decode(io_inout, '매입' ,round(io_total * 0.1))) as 납부세액
from tbl_iolist;

-- 거래처별로 매입과 매출 합계
-- DECODE(칼럼명, 조건값, true일때, false일때)
-- 실제 저장된 데이터를 PIVOT으로 보여주기
select io_dname, 
    sum(decode(io_inout,'매입',io_total,0)) as 매입합계,
    sum(decode(io_inout,'매출',io_total,0))as 매출합계
from tbl_iolist
group by io_dname;

-- 상품별로 매입과 매출 합계
select io_pname,
    sum(decode(io_inout,'매입',io_total,0)) as 매입합계,
    sum(decode(io_inout,'매출',io_total,0))as 매출합계
from tbl_iolist
group by io_pname;

-- 2020-01-01 부터 2020-06-30 기간동안 
-- 거래된 리스트를 거래처별로  조회

select io_dname,
    sum(decode(io_inout,'매입',io_total,0)) as 매입합계,
    sum(decode(io_inout,'매출',io_total,0)) as 매출합계
from tbl_iolist
where io_date between '01/01/2020' and '06/30/2020'
group by io_dname
order by io_dname;
-- 날짜값은 입력할 필요가 없다 날짜값을 입력하면 거래처가 중복되게 나온다

-- 전체 데이터에서 상품리스트만 중복없이 조회
-- 상품리스트와 매입, 매출단가를 조회하기
-- 같은 상품이라도 거래 시기에 따라 매입과 매출금액이 
-- 달라질 수 있기 때문에 
-- 데이터중에서 제일 높은 단가를 가져오기
select io_pname as 상품명,
    max(decode(io_inout,'매입',io_price,0)) as 매입단가,
    max(decode(io_inout,'매출',io_price,0)) as 매출단가
from tbl_iolist
group by io_pname
order by io_pname;

-- 전체데이터에서 거래처 리스트만 중복없이 조회
select io_dname as 거래처명, io_dceo
from tbl_iolist
group by io_dname, io_dceo
order by io_dname;

/*
매입매출 데이터로부터 상품정보 테이블 데이터를 생성하기
1. 매입매출 데이터에서 상품명으로 그룹을 하고
2. 매입, 매출 구분에 따라 각각 매입단가, 매출단가를 가져오기
3. 매입과 매출에 0 인 값이 있다
4. 매입단가가 0인 데이터는 매출데이터에서 임의로 생성하기
    매출단가의  80%를 매입단가로 하고, 부가세를 제외한 금액으로 계산
    E2 항목의 값에 0.8을 곱하여 80% 가격이 되고
    다시 그 금액을 1.1 로 나누면 부가세를 제외한 가격이 된다
    
5. 매출단가가 0인 데이터는 매입데이터에서 임의로 생성하기
매입단가의 20%를 추가하고 부가세 10%를 추가

*/

-- 상품정보 테이블
-- default 속성
-- insert 수행할 때 값이 지정되지 않으면 자도응로 추가될 데이터
-- 자동으로 not null로 설정된다
create table tbl_product(
    p_code char(5)	primary key,
    p_name nvarchar2(50) not null,	
    p_iprice number	not null,
    p_oprice number	not null,
    p_vat varchar2(1)	default 'y'	
);
select * from tbl_dept;

create table tbl_dept(
    dp_code	char(5)		primary key,
    dp_name	nvarchar2(50) not null,
    dp_ceo	nvarchar2(50) not null,
    dp_tel	varchar2(20),
    dp_addr	nvarchar2(125)
);
/*
매입매출 데이터로부터
상품정보, 거래처정보 데이터를 생성하고
테이블을 생성하여 데이터를 import 했다

매입매출데이터와, 상품정보, 거래처정보를
JOIN하기 위해서는 매입매출데이터에 상품코드, 거래처코드가 있어야 한다
그러나 현재 데이터는 코드 칼럼이 잆이 이름 칼럼만 있는 상태이다

매입매출 데이터에 상품코드, 거래처코드 칼럼을 추가하고
세 table을 JOIN할 수 있도록 변경하기
*/















