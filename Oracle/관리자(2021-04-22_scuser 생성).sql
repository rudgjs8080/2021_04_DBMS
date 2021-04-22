----------------------------------삭제
DROP TABLESPACE SCHOOLDB -- 반드시
INCLUDING CONTENTS AND DATAFILES -- 옵션
CASCADE CONSTRAINTS; -- 옵션

---------------------------------- 생성
CREATE TABLESPACE schoolDB
DATAFILE 'C:/oraclexe/data/school.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER scuser IDENTIFIED BY scuser
DEFAULT TABLESPACE schooldb;

grant DBA to scuser;