show databases;

use mysql;

show tables;

create database student;

create user student@loacalhost;
create user student@'%';
select host, user from user;

show grants for 'student';

grant all privileges on *.* to 'student';

