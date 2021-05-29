use accountbook;
show databases;
alter table tbl_accountbook modify a_seq bigint auto_increment primary key;
create table tbl_accountbook(
	a_seq	Bigint	auto_increment primary key	,
	a_date	varchar(10)	not null	,
	a_time	varchar(10)	not null	,
	a_exp	bigint		,
	a_eatexp	bigint	,	
	a_transexp	bigint	,	
	a_etc	bigint		);
    
alter table tbl_accountbook add a_fasion bigint;


    

