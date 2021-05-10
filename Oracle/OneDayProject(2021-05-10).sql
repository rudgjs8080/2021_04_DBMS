-- 2021-05-10 Onedayproject
drop table tbl_myfoods;
drop view view_일일섭취량;
create table tbl_foods(
    f_code char(7)	primary key,
    f_name nvarchar2(100) not null,	
    f_year char(4)	not null,
    f_ccode char(6)	not null,
    f_icode	char(4)	not null,
    f_one number,
    f_total	number,
    f_energy number,	
    f_protein number,	
    f_fat number,
    f_carbon number	,	
    f_sugar	number		
);

create table tbl_company(
    c_code char(6) primary key,
    c_name nvarchar2(100) not null	
);

create table tbl_items(
    i_code char(4)	primary key,
    i_name nvarchar2(100) not null
);

create table tbl_myfoods(
    mf_seq	number	primary key,
    mf_date	varchar2(10)	not null,
    mf_fcode	char(7)	not null,
    mf_value	number	not null
);

create SEQUENCE seq_score
start with 1
INCREMENT by 1;

alter table tbl_foods
add CONSTRAINT fk_company
FOREIGN key(f_ccode)
REFERENCES tbl_company(c_code);

alter table tbl_foods
add CONSTRAINT fk_items
FOREIGN key(f_icode)
REFERENCES tbl_items(i_code);

alter table tbl_myfoods
add CONSTRAINT fk_foods
FOREIGN key(mf_fcode)
REFERENCES tbl_foods(f_code);

create view view_식품정보 as
(
select F.f_code as 식품코드,
    F.f_name as 식품명,
    F.f_year as 출시연도,
    C.c_name as 제조사명,
    I.i_name as 분류명,
    F.f_one as 제공량,
    F.f_total as 총내용량,
    F.f_energy as 에너지,
    F.f_protein as 단백질,
    F.f_fat as 지방,
    F.f_carbon as 탄수화물,
    F.f_sugar as 총당류
from tbl_foods F
    left join tbl_company C
        on F.f_ccode = C.c_code
    left join tbl_items I
        on F.f_icode = I.i_code);

select * from view_식품정보
order by 식품코드;

create view view_일일섭취량 as (
select MF.mf_date as 날짜,
        F.f_name as 식품명,
        F.f_one as 제공량,
        F.f_total as 총내용량,
        F.f_energy as 에너지,
        F.f_protein as 단백질,
        F.f_fat as 지방,
        F.f_carbon as 탄수화물,
        F.f_sugar as 총당류
from tbl_myfoods MF
    left join tbl_foods F
        on mf.mf_fcode = F.f_code);

select * from view_일일섭취량;

select * from tbl_myfoods;

select * from view_식품정보
where 식품명 = '가나슈케이크';

select * from tbl_myfoods;





