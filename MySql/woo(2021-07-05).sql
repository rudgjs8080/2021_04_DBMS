create database woo;
drop table tbl_user;
use woo;
create table tbl_user(
us_name varchar(100) ,
us_id varchar(100) primary key,
us_pw varchar(100),
us_city varchar(100),
us_dist varchar(100));

select * from tbl_user;

CREATE DATABASE woo;


CREATE TABLE tbl_addr(
		ar_code	CHAR(10)		PRIMARY KEY,
		ar_si	VARCHAR(10)	,
		ar_gu	VARCHAR(10)	,	
		ar_dong	VARCHAR(10)	,	
		ar_x	VARCHAR(5)	,	
		ar_y	VARCHAR(5)	,	
		ar_addr	VARCHAR(100)
);

select * from tbl_addr;

select * from tbl_addr
WHERE ar_addr LIKE CONCAT ('%' , '광주광역시서구양', '%');

/*
String dong = "중흥동";
VO vo = null;
while(true) {
   vo = findByDong(dong);
   if(vo != null ) break;
   dong = dong.substring(0, dong.length - 1)
   if(dong.legnth < 1) break; 	
}




|


*/
select * from tbl_addr WHERE ar_dong LIKE CONCAT ('중흥동', '%');
select * from tbl_addr WHERE ar_dong LIKE CONCAT ('중흥', '%');



