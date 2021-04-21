-------------------------------- 생성
CREATE TABLESPACE iolistDB
DATAFILE 'C:/oraclexe/data/iolist.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER iouser IDENTIFIED BY iouser
DEFAULT TABLESPACE iolistDB;

GRANT DBA TO iouser; 

GRANT CREATE SESSION TO iouser; 

GRANT INSERT ON iolistDB TO iouser;

---------------------------------- 삭제
-- 반드시 옵션을 같이 작성하자

DROP USER iouser CASCADE;

DROP TABLESPACE iolistDB -- 반드시
INCLUDING CONTENTS AND DATAFILES -- 옵션
CASCADE CONSTRAINTS; -- 옵션