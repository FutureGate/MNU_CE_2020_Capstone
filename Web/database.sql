drop database if exists `demand_prediction`;
create database if not exists `demand_prediction`;
use `demand_prediction`;

-- ----------------------------------------------
-- 유저 테이블
-- ----------------------------------------------

create table USER_TABLE (
    `user_id`					varchar(10) unique not null,
	`company_name`				varchar(20) not null,
    `password`					varchar(20) not null,
    `email`						varchar(30),
    `contact`					varchar(20) not null,
    `about`						varchar(200),
    `registered_date`			date not null,
    `user_level`				integer not null,
    primary key(user_id)
) default character set utf8mb4 collate utf8mb4_bin;



-- ----------------------------------------------
-- 판매 이력 테이블
-- ----------------------------------------------

create table SALES_TABLE (
	`user_id`					varchar(10) unique not null,
	`sale_date`					date not null,
    `prod_code`					varchar(10) not null,
    `prod_name`					varchar(20) not null,
    `sale_count`				integer not null,
    primary key(user_id, sale_date, prod_code),
    foreign key (user_id) references USER_TABLE (user_id)
) default character set utf8mb4 collate utf8mb4_bin;



-- ----------------------------------------------
-- 테스트 테이블
-- ----------------------------------------------

create table TEST (
	test integer
) default character set utf8mb4 collate utf8mb4_bin;

insert into TEST values(122);
insert into TEST values(123);
insert into TEST values(142);