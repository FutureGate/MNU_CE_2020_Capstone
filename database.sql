drop database if exists `demand_prediction`;
create database if not exists `demand_prediction`;
use `demand_prediction`;

-- ----------------------------------------------
-- 판매점 테이블
-- ----------------------------------------------

create table SHOP_TABLE (
	`shop_id`					integer auto_increment not null,
	`shop_name`					varchar(30),
    `contact`					varchar(40),
    `email`						varchar(40),
    primary key(shop_id)
) default character set utf8mb4 collate utf8mb4_bin;



-- ----------------------------------------------
-- 유저 테이블
-- ----------------------------------------------

create table USER_TABLE (
    `user_id`					varchar(10) unique not null,
	`user_name`					varchar(20) not null,
    `password`					varchar(20) not null,
    `shop_id`					integer not null,
    `registered_date`			date not null,
    `user_level`				integer not null,
    primary key(user_id),
    foreign key (shop_id) references SHOP_TABLE (shop_id)
) default character set utf8mb4 collate utf8mb4_bin;



-- ----------------------------------------------
-- 판매 이력 테이블
-- ----------------------------------------------

create table SALE_TABLE (
	`sale_id`					integer auto_increment not null,
	`sale_date`					date not null,
	`shop_id`					integer not null,
    `item_id`					integer not null,
    `sale_count`				integer not null,
    primary key(sale_id)
) default character set utf8mb4 collate utf8mb4_bin;





-- ----------------------------------------------
-- 상품 테이블
-- ----------------------------------------------

create table ITEM_TABLE (
	`item_id`					integer auto_increment not null,
	`item_name`					varchar(20) not null,
	`shop_id`					integer not null,
    primary key(item_id),
    foreign key (shop_id) references SHOP_TABLE (shop_id) 
) default character set utf8mb4 collate utf8mb4_bin;




-- ----------------------------------------------
-- 테스트 테이블
-- ----------------------------------------------

create table TEST (
	test integer
) default character set utf8mb4 collate utf8mb4_bin;