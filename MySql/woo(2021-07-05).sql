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