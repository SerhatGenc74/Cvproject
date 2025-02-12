create database CVWebSiteDB
go 
use CVWebSiteDB
go
create table AdminUsers(
id int identity(1,1)not null,
userId nchar(5) primary key not null,
nickName varchar(25) unique not null,
email varchar(100) unique not null,
Role varchar(15),
password varBinary(max) not null,
)
create table Contents(
id int identity(1,1) not null,
contentId nchar(10) primary key not null,
type nchar(20) not null,
tags varchar(max),
visibleContent varchar(Max), 
content varchar(Max),
subContent varchar(Max),
deleteId bit not null, 
)
create table Projects(
id int identity(1,1) not null,
projectId nchar(4) primary key not null, 
title varchar(100),
description varchar(250),
coverImgUrl varchar(50),
tags varchar(max),
deleteId bit not null
)
Create Table ProjectDetails(
id int identity(1,1) not null,
projectId nchar(4) foreign key references Projects(projectId) not null,
type nchar(20) not null,
visibleContent varchar(max),
content varchar(max),
subContent varchar(max),
deleteId bit not null
)
Create Table Portfolio(
id int identity(1,1) not null,
tag varchar(20) unique,
title varchar(50),
coverImgUrl varchar(50),
deleteId bit not null
)