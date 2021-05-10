-- 2021-05-10 관리자 OneDayProject

create tablespace FoodDB
datafile 'C:/oraclexe/data/food.dbf'
size 1m AUTOEXTEND on next 1k;

create user food IDENTIFIED by food
default tablespace fooddb;

grant dba to food;