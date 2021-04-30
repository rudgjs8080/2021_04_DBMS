-- 2021-04-30 BookUser 삭제

drop USER bookuser cascade;

drop tablespace rentbookdb
including contents and datafiles
cascade constraints;

create USER bookuser IDENTIFIED by bookuser
default tablespace rentbookdb;

create tablespace rentbookdb
datafile 'c:/oraclexe/data/rentbook.dbf'
size 1m AUTOEXTEND on next 1k;

grant dba to bookuser;

