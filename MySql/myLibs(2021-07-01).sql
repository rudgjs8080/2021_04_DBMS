create database myLibs;
use myLibs;

create table tbl_books(
title	varchar(255)		,
link	varchar(255)		,
image	varchar(255)		,
author	varchar(255)		,
price	int		,
discount	int	,	
publisher	varchar(255)		,
isbn	char(13)		primary key,
description		varchar(2000)		,
pubdate	varchar(25)		
);

select * from tbl_books;