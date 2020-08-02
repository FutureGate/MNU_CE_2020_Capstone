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
-- 판매 이력 테이블
-- ----------------------------------------------

create table SALE_TABLE (
	`sale_id`					integer auto_increment not null,
	`sale_date`					date not null,
	`shop_id`					integer not null,
    `item_id`					integer not null,
    `sale_count`				integer not null,
    primary key(sale_id),
    foreign key (shop_id) references SHOP_TABLE (shop_id),
    foreign key (item_id) references ITEM_TABLE (item_id)
) default character set utf8mb4 collate utf8mb4_bin;


-- ----------------------------------------------
-- 요청 테이블
-- ----------------------------------------------

create table REQUEST_TABLE (
	`request_id`					integer auto_increment not null,
    `shop_id`						integer not null,
    `item_id`						integer not null,
    `request_date`					date not null,
    `state`							varchar(20),
    `trained`						integer not null,
    primary key(request_id),
    foreign key (shop_id) references SHOP_TABLE (shop_id),
    foreign key (item_id) references ITEM_TABLE (item_id)
) default character set utf8mb4 collate utf8mb4_bin;



-- ----------------------------------------------
-- 예측치 테이블
-- ----------------------------------------------

create table FORECAST_TABLE (
    `forecast_id`				integer auto_increment not null,
    `base_date`					date not null,
    `sale_date`					date not null,
	`shop_id`					integer not null,
    `item_id`					integer not null,
    `sale_count`				float(5, 2) not null,
    primary key(forecast_id),
    foreign key (shop_id) references SHOP_TABLE (shop_id),
    foreign key (item_id) references ITEM_TABLE (item_id)
) default character set utf8mb4 collate utf8mb4_bin;



-- ----------------------------------------------
-- 월간 예측치 테이블
-- ----------------------------------------------

create table MONTHLY_FORECAST_TABLE (
    `forecast_id`				integer auto_increment not null,
    `base_date`					date not null,
    `sale_date`					date not null,
    `season`					varchar(5),
	`shop_id`					integer not null,
    `item_id`					integer not null,
    `sale_count`				float(5, 2) not null,
    primary key(forecast_id),
    foreign key (shop_id) references SHOP_TABLE (shop_id),
    foreign key (item_id) references ITEM_TABLE (item_id)
) default character set utf8mb4 collate utf8mb4_bin;



-- ----------------------------------------------
-- 통계 테이블
-- ----------------------------------------------

create table STAT_TABLE (
	`stat_id`					integer auto_increment not null,
    `base_date`					date not null,
    `stat_date`					date not null,
    `shop_id`					integer not null,
    `item_id`					integer not null,
	`sum`						integer not null,
    `avg`						float(5, 2) not null,
    primary key(stat_id),
    foreign key (shop_id) references SHOP_TABLE (shop_id),
    foreign key (item_id) references ITEM_TABLE (item_id)
) default character set utf8mb4 collate utf8mb4_bin;

-- ----------------------------------------------
-- 테스트 테이블
-- ----------------------------------------------

create table TEST (
	test integer
) default character set utf8mb4 collate utf8mb4_bin;
