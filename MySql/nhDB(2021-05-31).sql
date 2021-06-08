use nhdb;
desc tbl_iolist;
select * from tbl_iolist;
drop table tbl_iolist;
create table tbl_iolist(
	io_seq	bigint	auto_increment	primary key,
	io_date	varchar(10)	not null	,
    io_time varchar(10)	not null	,
	io_pname	varchar(50)	not null,	
	io_dname	varchar(50)	not null,	
	io_dceo	varchar(20)	not null	,
	io_inout	varchar(5)	not null,	
	io_qty	int	not null	,
	io_price	int	not null,	
	io_total	int		
);

-- 매입과 매출의 합계
-- io_inout 칼럼 1이면 매입, 2이면 매출
-- 수량*단가를 곱하여 합계 계산
select (io_qty * io_price) 합계
from tbl_iolist;

-- 통계함수와 group by 함수를 사용하여alter
-- 매입총액과 매출총액 추출
select io_inout, sum(io_qty * io_price) 합계
from tbl_iolist
group by io_inout;

select case when io_inout='1' then '매입'
			when io_inout = '2' then '매출'
		end 구분,
        sum(io_qty * io_price) as 합계
from tbl_iolist
group by io_inout;

-- if(조건, true, false) : MySQL 전용 함수 
select if(io_inout = '1', '매입','매출') 구분,
	sum(io_qty * io_price) 합계
    from tbl_iolist
    group by io_inout;

select sum(if(io_inout = '1', io_qty * io_price,0)) 매입,
		sum(if(io_inout = '2', io_qty * io_price,0)) 매출
        from tbl_iolist;
        
select 	io_date 일자,
		sum(if(io_inout = '1', io_qty * io_price,0)) 매입,
		sum(if(io_inout = '2', io_qty * io_price,0)) 매출
        from tbl_iolist
        group by io_date
        order by io_date;

-- 각 거래처별로 매입 매출 합계
select io_dname 거래처,
		sum(if(io_inout = '1' , io_qty * io_price, 0)) 매입,
		sum(if(io_inout = '2' , io_qty * io_price, 0))  매출
from tbl_iolist
group by io_dname
order by 매출 desc;

-- 2020년 4월의 매입매출 리스트 조회
-- 2020년 4월의 거리처별로 매입매출 합계

select * from tbl_iolist
where io_date between '2020-04-01' and '2020-04-30'
order by io_date;

select * from tbl_iolist
where left(io_date, 7) = '2020-04';

select 	io_dname,
		sum(if(io_inout = '1' , io_qty * io_price, 0)) 매입,
		sum(if(io_inout = '2' , io_qty * io_price, 0)) 매출
from tbl_iolist
where io_date like '%2020-04%'
group by io_dname
order by io_date;




create table tbl_product(
	p_code	char(6)		primary key,
	p_name	varchar(50)	not null	,
	p_iprice	int	not null	,
	p_oprice	int	not null	,
	p_vat	varchar(1)	default 'Y'	
);

create table tbl_dept(
	d_code	char(5)		primary key,
	d_name	varchar(50)	not null	,
	d_ceo	varchar(50)	not null	,
	d_tel	varchar(20)		,
	d_addr	varchar(125)	,	
	d_product	varchar(20)	);
	

