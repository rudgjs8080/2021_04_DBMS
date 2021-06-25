-- DataBase Schema
-- 물리적 저장공간
-- Oracle : TableSpace + User 생성하여
-- 	연동을 하면 User를 통해서 모든 물리적 DB에
-- 	접근이 된다
-- MySQL : DataBase가 Schema가 되고 
-- 	모든 데이터의 저장공간이 된다
--	User는 단지 DB SW에 접속하는
--	사용자 개념이고 구체적으로
-- 	DB Schema와 연결이 되지 않는다
create database GuestBook;
-- gbUser 사용자를 등록하고
-- 접근권한을 localhost로 제한하겠다
create User gbuser@localhost;
-- 원격 또는 다른 서버, Client에서 접속가능하도록
create user gbuser@'%';

-- MySQL DataBase는 MySQL에서
-- 매우 중요한 정보가 저장되는 곳;
-- DB 정보확인 위하여 DB 사전에 접근
Use MySQL; 
show tables;
desc user;
-- 사용자 정보가 등록된 Table select
select host, user from user;
-- 등록된 사용자의 권한 확인
show grants for 'gbuser'; 
-- gbuser에게 모든 권한을 부여하라
-- localhost에서만 접근가능
grant all privileges on *.* to
'gbuser';
-- 192.168.0.*
-- 현재 공유기에 공통으로 연결된
-- PC에서 MySQL Server에 접근하라
create user gbuser;
-- 현재 공유기에 공통으로 연결된
-- PC에서 접근할 때 모든 권한을 부여하겠다
grant all privileges on *.* to
'gbuser'@'192.168.0.%';
-- 5.7 버전에서 user 비번 변경하기
update user 
set password = password('12345')
where user='gbuser';
-- MySQL 8.x 에서 비번변경하기
alter user 'gbuser'
identified with mysql_native_password
by '12345';
flush privileges;






