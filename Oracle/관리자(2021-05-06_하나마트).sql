-- 2021-05-06
-- 시스템에 작성된 tablespace를 확인하기
select * from dba_tablespaces;

drop user iouser cascade;

drop tablespace iolistdb
including contents and datafiles
cascade constraints;

create tablespace iolistdb
datafile 'c:/oraclexe/data/iolist.dbf'
size 1m autoextend on next 1k;

create user iouser identified by iouser
default tablespace iolistdb;

grant dba to iouser;

-- 오라클의 system 값
select * from dba_profiles;

-- 오라클에 새로 등록된 사용자의 password 만료일자
-- 기본값이 180으로 되어있어서
-- 새로운 사용자 등록 후 비번을 변경하지 않으면
-- 180일 후에는 접속이 불가능해진다
select * from dba_profiles
where resource_name = 'password_life_time';

alter profile default limit password_life_time unlimited;





