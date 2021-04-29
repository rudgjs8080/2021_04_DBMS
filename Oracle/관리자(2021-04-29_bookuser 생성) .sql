-- 2021-04-29

create tablespace rentbookdb
datafile 'C:/oraclexe/data/rentbook.dbf'
size 1m AUTOEXTEND on next 1k;

create User bookuser IDENTIFIED by bookuser
DEFAULT tablespace RentBookdb;

grant dba to bookuser;



