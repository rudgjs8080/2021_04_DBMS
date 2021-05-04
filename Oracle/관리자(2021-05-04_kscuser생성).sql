-- 2021-05-04 kschoolDB 생성

create tablespace KschoolDB
datafile 'C:/oraclexe/data/kschool.dbf'
size 1m AUTOEXTEND on next 1k;

create USER kscuser IDENTIFIED by kscuser
default tablespace kschooldb;

grant dba to kscuser;







