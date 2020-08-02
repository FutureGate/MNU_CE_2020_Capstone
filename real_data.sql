insert into ITEM_TABLE values(0, "건청무화과", 1);  -- 실제 아이템
insert into ITEM_TABLE values(0, "청무화과잼", 1);  -- 실제 아이템
insert into ITEM_TABLE values(0, "청무화과즙", 1);  -- 실제 아이템

-- ----------------------------------------------
-- 드림테크 회사에서의 건청무화과 통계 데이터 생성
-- ----------------------------------------------
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-01-01 00:00:00', 1, 4, 8, 0.25);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-02-01 00:00:00', 1, 4, 2, 0.10);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-03-01 00:00:00', 1, 4, 2, 0.06);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-04-01 00:00:00', 1, 4, 321, 10.7);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-05-01 00:00:00', 1, 4, 641, 20.6);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-06-01 00:00:00', 1, 4, 200, 6.67);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-07-01 00:00:00', 1, 4, 17, 0.54);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-08-01 00:00:00', 1, 4, 57, 1.83);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-09-01 00:00:00', 1, 4, 428, 14.2);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-10-01 00:00:00', 1, 4, 994, 33.1);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-11-01 00:00:00', 1, 4, 2258, 75.2);
insert into `STAT_TABLE` values (0, '2019-12-31', '2018-12-01 00:00:00', 1, 4, 657, 21.2);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-01-01 00:00:00', 1, 4, 372, 12);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-02-01 00:00:00', 1, 4, 422, 14.55);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-03-01 00:00:00', 1, 4, 114, 3.68);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-04-01 00:00:00', 1, 4, 52, 1.73);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-05-01 00:00:00', 1, 4, 862, 27.8);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-06-01 00:00:00', 1, 4, 604, 20.13);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-07-01 00:00:00', 1, 4, 52, 1.68);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-08-01 00:00:00', 1, 4, 174, 5.61);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-09-01 00:00:00', 1, 4, 1305, 43.5);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-10-01 00:00:00', 1, 4, 3027, 97.6);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-11-01 00:00:00', 1, 4, 3844, 128.1);
insert into `STAT_TABLE` values (0, '2019-12-31', '2019-12-01 00:00:00', 1, 4, 1153, 37.1);


-- ----------------------------------------------
-- 드림테크 회사에서의 건청무화과 예측 데이터 생성
-- ----------------------------------------------
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-01-01 00:00:00', '겨울', 1, 4, 537.52);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-02-01 00:00:00', '겨울', 1, 4, 752.57);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-03-01 00:00:00', '봄', 1, 4, 115.39);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-04-01 00:00:00', '봄', 1, 4, 32.15);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-05-01 00:00:00', '봄', 1, 4, 913.66);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-06-01 00:00:00', '여름', 1, 4, 825.81);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-07-01 00:00:00', '여름', 1, 4, 77.19);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-08-01 00:00:00', '여름', 1, 4, 278.35);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-09-01 00:00:00', '가을', 1, 4, 1968.17);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-10-01 00:00:00', '가을', 1, 4, 4228.74);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-11-01 00:00:00', '가을', 1, 4, 4861.14);
insert into `MONTHLY_FORECAST_TABLE` values (0, '2019-12-31', '2020-12-01 00:00:00', '겨울', 1, 4, 1765.41);