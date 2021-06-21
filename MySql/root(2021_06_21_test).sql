create database score;

create USER gbuser@localhost;
use mysql;
show tables;
desc user;
select host, user
from user;
show grants for gbuser@localhost;

grant all privileges on *.* to gbuser@localhost;
create user
gbuser@'192.168.0.%';
alter user
'gbuser'@'localhost'
identified with
mysql_native_password
by '12345';
flush privileges;

select * from user
where user ='gbuser';