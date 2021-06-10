-- 관리자 화면

/*
오라클에서는 관리자 (sys, system, sysdba) 계정이 존재하고
관리자 계정으로 접속을 하면
오라클 시스템 자체를 컨트롤 할 수 있는 권한이 있다
sysdba 권한이다 라고 한다

보안사고 : 허가받지 않은 사용자가 네트워크를 통해서 불법적으로
시스템에 침투하여 데이터, 시스템을 파괴하는 행위
관리자(sysdba) 권한의 노출로 인하여 관리자 권한 탈취

데이터 무결성 파괴 : 허가된 사용자가 권한이 잘못 부여되거나,
과도하게 권한을 부여하여 명령을 잘못사용하여 데이터에 문제를
일으키는 것

관리자 권한에서는 최소한으로 테이블 스페이스와 사용자를 생성하여
사용자에게 권한을 부여하는 정도만 사용하도록 권장한다
*/


create tablespace testDB
datafile 'C:/oraclexe/data/testDB.dbf'
size 1m AUTOEXTEND on next 1k;

drop user tester;

create user tester IDENTIFIED by tester
default tablespace testDB;

/*
최초로 사용자계정을 생성한 후에는
아직 아무런 권한이 없기 때문에
DB에 접속하는 것 조차 할 수 없다
실습을 쉽게 하기 위하여 생성한 사용자 계정에 DBA 권한을 부여한다

DBA 권한 : 시스템관련 DB에 접근은 할 수 없으나
            기타 table을 만드는 일부터 대부분의 
            DBMS 관련 명령을 사용하여
            DB를 핸들링 할 수 있는 권한
*/


grant dba to tester;



