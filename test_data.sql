-- ----------------------------------------------
-- 판매점 데이터 생성
-- ----------------------------------------------
insert into SHOP_TABLE values(0, "드림테크", "010-2222-2222", "test@test.com");
insert into SHOP_TABLE values(0, "ㅇㅇ회사", "010-2222-3333", "test@t22t.com");


-- ----------------------------------------------
-- 유저 생성
-- ----------------------------------------------
insert into USER_TABLE values("admin", "관리자", "1234", 1, "2020-02-22", 0);
insert into USER_TABLE values("user", "일반사용자", "1234", 2, "2020-02-22", 1);


-- ----------------------------------------------
-- 상품 정보 생성
-- ----------------------------------------------
insert into ITEM_TABLE values(0, "딸기 잼", 1);  -- 1번 아이템
insert into ITEM_TABLE values(0, "포도 잼", 1);  -- 2번 아이템
insert into ITEM_TABLE values(0, "사과 잼", 1);  -- 3번 아이템


-- ----------------------------------------------
-- 드림테크 회사에서의 딸기잼 판매 데이터 생성
-- ----------------------------------------------
insert into SALE_TABLE values(0, "2020-01-01", 1, 1, 20); -- 1번 판매 이력
insert into SALE_TABLE values(0, "2020-01-02", 1, 1, 19); -- 1번 판매 이력



-- ----------------------------------------------
-- 드림테크 회사에서의 사과잼 예측 데이터 생성
-- ----------------------------------------------
/*
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-01 00:00:00', 1, 3, 10);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-02 00:00:00', 1, 3, 9);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-03 00:00:00', 1, 3, 13);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-04 00:00:00', 1, 3, 8);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-05 00:00:00', 1, 3, 6);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-05 00:00:00', 1, 3, 7);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-05 00:00:00', 1, 3, 10);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-05 00:00:00', 1, 3, 15);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-05 00:00:00', 1, 3, 10);
insert into `FORECAST_TABLE` values (0, '2020-12-31', '2021-01-05 00:00:00', 1, 3, 4);


-- ----------------------------------------------
-- 드림테크 회사에서의 사과잼 통계 데이터 생성
-- ----------------------------------------------

insert into `STAT_TABLE` values (0, '2020-12-31', '2020-01-01', 1, 3, 200, 12.2);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-02-01', 1, 3, 400, 13.2);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-03-01', 1, 3, 560, 9.5);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-04-01', 1, 3, 599, 15.1);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-05-01', 1, 3, 325, 18.9);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-06-01', 1, 3, 429, 21.4);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-07-01', 1, 3, 600, 23.7);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-08-01', 1, 3, 719, 21.6);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-09-01', 1, 3, 502, 14.54);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-10-01', 1, 3, 312, 15.22);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-11-01', 1, 3, 213, 10.39);
insert into `STAT_TABLE` values (0, '2020-12-31', '2020-12-01', 1, 3, 451, 8.11);
*/

-- ----------------------------------------------
-- 드림테크 회사에서의 사과잼 데이터 생성
-- ----------------------------------------------

insert into `SALE_TABLE` values (0,'2020-01-01 00:00:00',1,3,12);
insert into `SALE_TABLE` values (0,'2020-01-02 00:00:00',1,3,16);
insert into `SALE_TABLE` values (0,'2020-01-03 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-01-04 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-01-05 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-01-06 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-01-07 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-01-08 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-01-09 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-01-10 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-01-11 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-01-12 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-01-13 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-01-15 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-01-16 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-01-17 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-01-18 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-01-19 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-01-20 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-01-21 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-01-22 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-01-23 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-01-24 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-01-25 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-01-26 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-01-27 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-01-28 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-01-29 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-01-30 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-01-31 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-02-01 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-02-02 00:00:00',1,3,12);
insert into `SALE_TABLE` values (0,'2020-02-03 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-02-04 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-02-05 00:00:00',1,3,19);
insert into `SALE_TABLE` values (0,'2020-02-06 00:00:00',1,3,15);
insert into `SALE_TABLE` values (0,'2020-02-07 00:00:00',1,3,15);
insert into `SALE_TABLE` values (0,'2020-02-08 00:00:00',1,3,17);
insert into `SALE_TABLE` values (0,'2020-02-09 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-02-10 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-02-11 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-02-12 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-02-13 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-02-14 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-02-15 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-02-16 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-02-17 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-02-18 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-02-19 00:00:00',1,3,12);
insert into `SALE_TABLE` values (0,'2020-02-20 00:00:00',1,3,14);
insert into `SALE_TABLE` values (0,'2020-02-21 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-02-22 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-02-23 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-02-24 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-02-25 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-02-26 00:00:00',1,3,19);
insert into `SALE_TABLE` values (0,'2020-02-27 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-02-28 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-02-29 00:00:00',1,3,20);
insert into `SALE_TABLE` values (0,'2020-03-01 00:00:00',1,3,36);
insert into `SALE_TABLE` values (0,'2020-03-02 00:00:00',1,3,12);
insert into `SALE_TABLE` values (0,'2020-03-03 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-03-04 00:00:00',1,3,21);
insert into `SALE_TABLE` values (0,'2020-03-05 00:00:00',1,3,14);
insert into `SALE_TABLE` values (0,'2020-03-06 00:00:00',1,3,16);
insert into `SALE_TABLE` values (0,'2020-03-07 00:00:00',1,3,16);
insert into `SALE_TABLE` values (0,'2020-03-08 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-03-09 00:00:00',1,3,21);
insert into `SALE_TABLE` values (0,'2020-03-10 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-03-11 00:00:00',1,3,23);
insert into `SALE_TABLE` values (0,'2020-03-12 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-03-13 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-03-14 00:00:00',1,3,16);
insert into `SALE_TABLE` values (0,'2020-03-15 00:00:00',1,3,17);
insert into `SALE_TABLE` values (0,'2020-03-16 00:00:00',1,3,28);
insert into `SALE_TABLE` values (0,'2020-03-17 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-03-18 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-03-19 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-03-20 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-03-21 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-03-22 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-03-23 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-03-24 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-03-25 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-03-26 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-03-27 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-03-28 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-03-29 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-03-30 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-03-31 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-04-01 00:00:00',1,3,18);
insert into `SALE_TABLE` values (0,'2020-04-02 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-04-03 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-04-04 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-04-05 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-04-06 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-04-08 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-04-09 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-04-10 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-04-11 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-04-12 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-04-13 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-04-14 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-04-15 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-04-16 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-04-17 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-04-18 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-04-20 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-04-21 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-04-22 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-04-23 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-04-24 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-04-25 00:00:00',1,3,13);
insert into `SALE_TABLE` values (0,'2020-04-26 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-04-27 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-04-28 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-04-29 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-04-30 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-05-06 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-05-07 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-05-08 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-05-09 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-05-10 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-05-11 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-05-12 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-05-13 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-05-14 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-05-15 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-05-16 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-05-17 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-05-18 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-05-19 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-05-20 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-05-21 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-05-22 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-05-23 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-05-24 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-05-25 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-05-26 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-05-27 00:00:00',1,3,15);
insert into `SALE_TABLE` values (0,'2020-05-28 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-05-29 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-05-30 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-05-31 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-06-01 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-06-02 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-06-03 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-06-04 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-06-05 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-06-06 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-06-07 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-06-08 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-06-09 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-06-10 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-06-11 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-06-12 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-06-13 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-06-14 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-06-15 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-06-16 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-06-17 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-06-18 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-06-19 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-06-20 00:00:00',1,3,2);


insert into `SALE_TABLE` values (0,'2020-06-21 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-06-22 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-06-23 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-06-24 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-06-25 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-06-26 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-06-27 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-06-28 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-06-29 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-06-30 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-07-01 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-07-02 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-07-03 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-07-04 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-07-05 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-07-06 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-07-07 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-07-08 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-07-09 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-07-10 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-07-11 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-07-12 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-07-13 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-07-14 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-07-15 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-07-16 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-07-17 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-07-19 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-07-20 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-07-21 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-07-22 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-07-23 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-07-24 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-07-25 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-07-26 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-07-27 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-07-28 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-07-29 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-07-30 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-07-31 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-08-01 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-08-02 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-08-03 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-08-04 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-08-05 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-08-06 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-08-07 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-08-08 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-08-09 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-08-10 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-08-11 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-08-12 00:00:00',1,3,13);
insert into `SALE_TABLE` values (0,'2020-08-13 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-08-14 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-08-15 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-08-16 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-08-17 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-08-18 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-08-19 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-08-20 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-08-21 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-10-27 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-10-28 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-10-29 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-10-30 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-10-31 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-11-01 00:00:00',1,3,12);
insert into `SALE_TABLE` values (0,'2020-11-02 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-11-03 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-11-04 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-11-05 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-11-06 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-11-07 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-11-08 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-11-09 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-11-10 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-11-15 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-11-16 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-11-17 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-11-18 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-11-19 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-11-20 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-11-21 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-11-22 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-11-23 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-11-24 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-11-25 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-11-26 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-11-28 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-11-29 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-11-30 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-12-01 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-12-02 00:00:00',1,3,9);
insert into `SALE_TABLE` values (0,'2020-12-03 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-12-04 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-12-05 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-12-07 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-12-08 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-12-09 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-12-10 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-12-11 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-12-13 00:00:00',1,3,3);
insert into `SALE_TABLE` values (0,'2020-12-16 00:00:00',1,3,6);
insert into `SALE_TABLE` values (0,'2020-12-17 00:00:00',1,3,10);
insert into `SALE_TABLE` values (0,'2020-12-18 00:00:00',1,3,11);
insert into `SALE_TABLE` values (0,'2020-12-19 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-12-20 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-12-21 00:00:00',1,3,5);
insert into `SALE_TABLE` values (0,'2020-12-22 00:00:00',1,3,2);
insert into `SALE_TABLE` values (0,'2020-12-23 00:00:00',1,3,7);
insert into `SALE_TABLE` values (0,'2020-12-24 00:00:00',1,3,4);
insert into `SALE_TABLE` values (0,'2020-12-26 00:00:00',1,3,13);
insert into `SALE_TABLE` values (0,'2020-12-27 00:00:00',1,3,8);
insert into `SALE_TABLE` values (0,'2020-12-28 00:00:00',1,3,1);
insert into `SALE_TABLE` values (0,'2020-12-29 00:00:00',1,3,16);
insert into `SALE_TABLE` values (0,'2020-12-30 00:00:00',1,3,12);
insert into `SALE_TABLE` values (0,'2020-12-31 00:00:00',1,3,7);
