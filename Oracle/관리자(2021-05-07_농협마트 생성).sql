-- 2021-05-07 농협마트
create tablespace nonghyupDB
datafile 'c:/oraclexe/data/nonghyup.dbf'
size 1m autoextend on next 1k;

create user nhuser identified by nhuser
default tablespace nonghyupDB;

grant dba to nhuser;


