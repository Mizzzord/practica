BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Accounts" (
	"AccountID"	INTEGER,
	"ClientID"	INT NOT NULL,
	"AccountType"	VARCHAR(50),
	"Currency"	VARCHAR(3) NOT NULL DEFAULT 'RUB',
	"OpenDate"	DATE NOT NULL,
	"Status"	VARCHAR(20) DEFAULT 'Active',
	PRIMARY KEY("AccountID" AUTOINCREMENT),
	FOREIGN KEY("ClientID") REFERENCES "Clients"("ClientID")
);
CREATE TABLE IF NOT EXISTS "Clients" (
	"ClientID"	INTEGER,
	"ClientType"	VARCHAR(20) NOT NULL,
	"FullName"	VARCHAR(255) NOT NULL,
	"TaxID"	VARCHAR(50) NOT NULL UNIQUE,
	"ContactPerson"	VARCHAR(255),
	"Email"	VARCHAR(100) UNIQUE,
	"PhoneNumber"	VARCHAR(20),
	"RegistrationDate"	DATE NOT NULL,
	PRIMARY KEY("ClientID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Holdings" (
	"HoldingID"	INTEGER,
	"PortfolioID"	INT NOT NULL,
	"SecurityID"	INT NOT NULL,
	"Quantity"	DECIMAL(18, 4) NOT NULL,
	"AverageCost"	DECIMAL(18, 4) NOT NULL,
	PRIMARY KEY("HoldingID" AUTOINCREMENT),
	UNIQUE("PortfolioID","SecurityID"),
	FOREIGN KEY("PortfolioID") REFERENCES "Portfolios"("PortfolioID"),
	FOREIGN KEY("SecurityID") REFERENCES "Securities"("SecurityID")
);
CREATE TABLE IF NOT EXISTS "MarketData" (
	"PriceID"	INTEGER,
	"SecurityID"	INT NOT NULL,
	"PriceDate"	DATE NOT NULL,
	"ClosePrice"	DECIMAL(18, 4) NOT NULL,
	PRIMARY KEY("PriceID" AUTOINCREMENT),
	UNIQUE("SecurityID","PriceDate"),
	FOREIGN KEY("SecurityID") REFERENCES "Securities"("SecurityID")
);
CREATE TABLE IF NOT EXISTS "Portfolios" (
	"PortfolioID"	INTEGER,
	"AccountID"	INT NOT NULL,
	"PortfolioName"	VARCHAR(100) NOT NULL,
	"RiskProfile"	VARCHAR(50),
	"StrategyDescription"	TEXT,
	"CreationDate"	DATE NOT NULL,
	PRIMARY KEY("PortfolioID" AUTOINCREMENT),
	FOREIGN KEY("AccountID") REFERENCES "Accounts"("AccountID")
);
CREATE TABLE IF NOT EXISTS "Securities" (
	"SecurityID"	INTEGER,
	"Ticker"	VARCHAR(20) NOT NULL UNIQUE,
	"SecurityName"	VARCHAR(255) NOT NULL,
	"AssetClass"	VARCHAR(50) NOT NULL,
	"Industry"	VARCHAR(100),
	"Currency"	VARCHAR(3) NOT NULL,
	PRIMARY KEY("SecurityID" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Transactions" (
	"TransactionID"	INTEGER,
	"PortfolioID"	INT NOT NULL,
	"SecurityID"	INT,
	"TransactionType"	VARCHAR(20) NOT NULL,
	"TransactionDate"	DATETIME NOT NULL,
	"Quantity"	DECIMAL(18, 4),
	"Price"	DECIMAL(18, 4),
	"Commission"	DECIMAL(10, 2),
	PRIMARY KEY("TransactionID" AUTOINCREMENT),
	FOREIGN KEY("PortfolioID") REFERENCES "Portfolios"("PortfolioID"),
	FOREIGN KEY("SecurityID") REFERENCES "Securities"("SecurityID")
);
INSERT INTO "Accounts" VALUES (1,1,'Брокерский','RUB','2023-01-16','Active');
INSERT INTO "Accounts" VALUES (2,1,'ИИС','RUB','2023-01-20','Active');
INSERT INTO "Accounts" VALUES (3,2,'Брокерский','USD','2023-02-21','Active');
INSERT INTO "Accounts" VALUES (4,3,'Брокерский','RUB','2022-11-06','Active');
INSERT INTO "Accounts" VALUES (5,3,'Брокерский','USD','2022-12-01','Active');
INSERT INTO "Accounts" VALUES (6,4,'Брокерский','RUB','2022-12-13','Closed');
INSERT INTO "Accounts" VALUES (7,5,'Брокерский','EUR','2023-03-11','Active');
INSERT INTO "Accounts" VALUES (8,6,'ИИС','RUB','2023-04-02','Active');
INSERT INTO "Accounts" VALUES (9,7,'Брокерский','USD','2023-01-11','Active');
INSERT INTO "Accounts" VALUES (10,8,'Брокерский','RUB','2023-05-13','Active');
INSERT INTO "Accounts" VALUES (11,9,'Брокерский','USD','2023-02-16','Active');
INSERT INTO "Accounts" VALUES (12,10,'Брокерский','EUR','2023-06-19','Active');
INSERT INTO "Accounts" VALUES (13,11,'ИИС','RUB','2023-07-21','Active');
INSERT INTO "Accounts" VALUES (14,12,'Брокерский','USD','2023-03-23','Active');
INSERT INTO "Accounts" VALUES (15,13,'Брокерский','RUB','2023-08-24','Active');
INSERT INTO "Accounts" VALUES (16,14,'Брокерский','USD','2023-09-26','Active');
INSERT INTO "Accounts" VALUES (17,15,'Брокерский','EUR','2023-04-28','Active');
INSERT INTO "Accounts" VALUES (18,16,'ИИС','RUB','2023-10-30','Active');
INSERT INTO "Accounts" VALUES (19,17,'Брокерский','USD','2023-11-01','Active');
INSERT INTO "Accounts" VALUES (20,18,'Брокерский','RUB','2023-06-01','Active');
INSERT INTO "Accounts" VALUES (21,19,'Брокерский','USD','2024-01-03','Active');
INSERT INTO "Accounts" VALUES (22,20,'Брокерский','EUR','2024-02-05','Active');
INSERT INTO "Accounts" VALUES (23,21,'ИИС','RUB','2024-03-07','Active');
INSERT INTO "Accounts" VALUES (24,22,'Брокерский','USD','2024-04-09','Active');
INSERT INTO "Accounts" VALUES (25,23,'Брокерский','RUB','2024-05-11','Active');
INSERT INTO "Accounts" VALUES (26,24,'Брокерский','USD','2024-06-13','Active');
INSERT INTO "Accounts" VALUES (27,25,'Брокерский','EUR','2024-07-15','Active');
INSERT INTO "Accounts" VALUES (28,26,'ИИС','RUB','2024-08-17','Active');
INSERT INTO "Accounts" VALUES (29,27,'Брокерский','USD','2024-09-19','Active');
INSERT INTO "Accounts" VALUES (30,28,'Брокерский','RUB','2024-10-21','Active');
INSERT INTO "Accounts" VALUES (31,29,'Брокерский','USD','2024-11-23','Active');
INSERT INTO "Accounts" VALUES (32,30,'Брокерский','EUR','2024-12-25','Active');
INSERT INTO "Clients" VALUES (1,'Individual','Иванов Иван Иванович','770123456789',NULL,'ivanov@mail.ru','+79031234567','2023-01-15');
INSERT INTO "Clients" VALUES (2,'Individual','Петрова Мария Сергеевна','770987654321',NULL,'petrova@mail.ru','+79039876543','2023-02-20');
INSERT INTO "Clients" VALUES (3,'LegalEntity','ООО "ИнвестПлюс"','5401234567','Сидоров Петр Петрович','info@investplus.ru','+78314321123','2022-11-05');
INSERT INTO "Clients" VALUES (4,'LegalEntity','АО "Финансы и Ко"','5409876543','Кузнецов Артем Сергеевич','contact@finco.ru','+78314321124','2022-12-12');
INSERT INTO "Clients" VALUES (5,'Individual','Смирнов Алексей Олегович','770111122233',NULL,'smirnov@mail.ru','+79031112233','2023-03-10');
INSERT INTO "Clients" VALUES (6,'Individual','Кузнецова Ольга Дмитриевна','770222233344',NULL,'kuznetsova@mail.ru','+79032223344','2023-04-01');
INSERT INTO "Clients" VALUES (7,'LegalEntity','ООО "РосИнвест"','5402222333','Васильев Игорь Павлович','vasiliev@rosinvest.ru','+78314321125','2023-01-10');
INSERT INTO "Clients" VALUES (8,'Individual','Морозов Дмитрий Сергеевич','770333344455',NULL,'morozov@mail.ru','+79033334455','2023-05-12');
INSERT INTO "Clients" VALUES (9,'LegalEntity','ЗАО "ТехноФин"','5403333444','Громов Андрей Викторович','gromov@technofin.ru','+78314321126','2023-02-15');
INSERT INTO "Clients" VALUES (10,'Individual','Соколова Екатерина Павловна','770444455566',NULL,'sokolova@mail.ru','+79034445566','2023-06-18');
INSERT INTO "Clients" VALUES (11,'Individual','Воробьёв Павел Игоревич','770555566677',NULL,'vorobyev@mail.ru','+79035556677','2023-07-20');
INSERT INTO "Clients" VALUES (12,'LegalEntity','ООО "АльфаКапитал"','5404444555','Демидов Сергей Олегович','demidov@alfacap.ru','+78314321127','2023-03-22');
INSERT INTO "Clients" VALUES (13,'Individual','Егоров Николай Владимирович','770666677788',NULL,'egorov@mail.ru','+79036667788','2023-08-23');
INSERT INTO "Clients" VALUES (14,'Individual','Григорьева Анна Васильевна','770777788899',NULL,'grigorieva@mail.ru','+79037778899','2023-09-25');
INSERT INTO "Clients" VALUES (15,'LegalEntity','АО "ГлобалФинанс"','5405555666','Павлов Роман Сергеевич','pavlov@globalfin.ru','+78314321128','2023-04-27');
INSERT INTO "Clients" VALUES (16,'Individual','Денисов Артём Сергеевич','770888899900',NULL,'denisov@mail.ru','+79038889990','2023-10-29');
INSERT INTO "Clients" VALUES (17,'Individual','Зайцева Мария Алексеевна','770999900011',NULL,'zaitseva@mail.ru','+79039990001','2023-11-30');
INSERT INTO "Clients" VALUES (18,'LegalEntity','ООО "ИнвестГарант"','5406666777','Киселёв Илья Дмитриевич','kiselev@investgarant.ru','+78314321129','2023-05-31');
INSERT INTO "Clients" VALUES (19,'Individual','Исаев Сергей Павлович','771000011122',NULL,'isaev@mail.ru','+79031000112','2024-01-02');
INSERT INTO "Clients" VALUES (20,'Individual','Калинина Елена Сергеевна','771111122233',NULL,'kalinina@mail.ru','+79031111223','2024-02-04');
INSERT INTO "Clients" VALUES (21,'LegalEntity','ООО "ФинТраст"','5407777888','Белов Артем Евгеньевич','belov@fintrust.ru','+78314321130','2023-06-03');
INSERT INTO "Clients" VALUES (22,'Individual','Лебедев Максим Олегович','771222233344',NULL,'lebedev@mail.ru','+79031222334','2024-03-06');
INSERT INTO "Clients" VALUES (23,'Individual','Мельникова Светлана Игоревна','771333344455',NULL,'melnikova@mail.ru','+79031333445','2024-04-08');
INSERT INTO "Clients" VALUES (24,'LegalEntity','ЗАО "Ритм"','5408888999','Воронин Павел Аркадьевич','voronin@ritm.ru','+78314321131','2023-07-09');
INSERT INTO "Clients" VALUES (25,'Individual','Николаев Виктор Сергеевич','771444455566',NULL,'nikolaev@mail.ru','+79031444556','2024-05-10');
INSERT INTO "Clients" VALUES (26,'Individual','Орлова Татьяна Владимировна','771555566677',NULL,'orlova@mail.ru','+79031555667','2024-06-12');
INSERT INTO "Clients" VALUES (27,'LegalEntity','АО "КапиталПлюс"','5409999000','Савельев Дмитрий Павлович','saveliev@capitalplus.ru','+78314321132','2023-08-13');
INSERT INTO "Clients" VALUES (28,'Individual','Павлова Анна Геннадьевна','771666677788',NULL,'pavlova@mail.ru','+79031666778','2024-07-14');
INSERT INTO "Clients" VALUES (29,'Individual','Романов Евгений Алексеевич','771777788899',NULL,'romanov@mail.ru','+79031777889','2024-08-16');
INSERT INTO "Clients" VALUES (30,'LegalEntity','ООО "ФинЭксперт"','5410000111','Сергеев Николай Аркадьевич','sergeev@finexpert.ru','+78314321133','2023-09-17');
INSERT INTO "Holdings" VALUES (1,1,1,80,250.5);
INSERT INTO "Holdings" VALUES (2,1,2,50,170.2);
INSERT INTO "Holdings" VALUES (3,2,7,200,99.9);
INSERT INTO "Holdings" VALUES (4,3,3,10,155);
INSERT INTO "Holdings" VALUES (5,3,4,5,700);
INSERT INTO "Holdings" VALUES (6,4,6,100,50);
INSERT INTO "Holdings" VALUES (7,5,8,20,300);
INSERT INTO "Holdings" VALUES (8,6,9,15,145);
INSERT INTO "Holdings" VALUES (9,7,10,30,75);
INSERT INTO "Holdings" VALUES (10,8,11,40,2800);
INSERT INTO "Holdings" VALUES (11,9,12,25,3300);
INSERT INTO "Holdings" VALUES (12,10,13,12,500);
INSERT INTO "Holdings" VALUES (13,11,14,18,1500);
INSERT INTO "Holdings" VALUES (14,12,15,22,4000);
INSERT INTO "Holdings" VALUES (15,13,16,35,600);
INSERT INTO "Holdings" VALUES (16,14,17,28,21000);
INSERT INTO "Holdings" VALUES (17,15,18,17,23000);
INSERT INTO "Holdings" VALUES (18,16,19,9,12000);
INSERT INTO "Holdings" VALUES (19,17,20,14,500);
INSERT INTO "Holdings" VALUES (20,18,21,21,5000);
INSERT INTO "Holdings" VALUES (21,19,22,16,400);
INSERT INTO "Holdings" VALUES (22,20,23,13,170);
INSERT INTO "Holdings" VALUES (23,21,24,19,250);
INSERT INTO "Holdings" VALUES (24,22,25,15,700);
INSERT INTO "Holdings" VALUES (25,23,26,11,99.9);
INSERT INTO "Holdings" VALUES (26,24,27,24,101);
INSERT INTO "Holdings" VALUES (27,25,28,27,1200);
INSERT INTO "Holdings" VALUES (28,26,29,20,1500);
INSERT INTO "Holdings" VALUES (29,27,30,22,3500);
INSERT INTO "Holdings" VALUES (30,28,31,18,4800);
INSERT INTO "Holdings" VALUES (31,29,32,30,2000);
INSERT INTO "Holdings" VALUES (32,30,33,25,1100);
INSERT INTO "MarketData" VALUES (1,1,'2023-01-18',250.5);
INSERT INTO "MarketData" VALUES (2,1,'2023-06-10',260);
INSERT INTO "MarketData" VALUES (3,2,'2023-01-18',170.2);
INSERT INTO "MarketData" VALUES (4,3,'2023-02-23',155);
INSERT INTO "MarketData" VALUES (5,3,'2023-06-10',180);
INSERT INTO "MarketData" VALUES (6,4,'2023-02-23',700);
INSERT INTO "MarketData" VALUES (7,4,'2023-06-10',720);
INSERT INTO "MarketData" VALUES (8,5,'2023-03-01',0.035);
INSERT INTO "MarketData" VALUES (9,6,'2022-11-08',50);
INSERT INTO "MarketData" VALUES (10,7,'2023-01-22',99.9);
INSERT INTO "MarketData" VALUES (11,8,'2022-12-03',300);
INSERT INTO "MarketData" VALUES (12,9,'2023-03-13',145);
INSERT INTO "MarketData" VALUES (13,10,'2023-04-04',75);
INSERT INTO "MarketData" VALUES (14,11,'2023-05-15',2800);
INSERT INTO "MarketData" VALUES (15,12,'2023-02-18',3300);
INSERT INTO "MarketData" VALUES (16,13,'2023-06-21',500);
INSERT INTO "MarketData" VALUES (17,14,'2023-07-23',1500);
INSERT INTO "MarketData" VALUES (18,15,'2023-03-25',4000);
INSERT INTO "MarketData" VALUES (19,16,'2023-08-26',600);
INSERT INTO "MarketData" VALUES (20,17,'2023-09-28',21000);
INSERT INTO "MarketData" VALUES (21,18,'2023-04-30',23000);
INSERT INTO "MarketData" VALUES (22,19,'2023-11-01',12000);
INSERT INTO "MarketData" VALUES (23,20,'2023-06-03',500);
INSERT INTO "MarketData" VALUES (24,21,'2024-01-05',5000);
INSERT INTO "MarketData" VALUES (25,22,'2024-02-07',400);
INSERT INTO "MarketData" VALUES (26,23,'2024-03-09',170);
INSERT INTO "MarketData" VALUES (27,24,'2024-04-11',250);
INSERT INTO "MarketData" VALUES (28,25,'2024-05-13',700);
INSERT INTO "MarketData" VALUES (29,26,'2024-06-15',99.9);
INSERT INTO "MarketData" VALUES (30,27,'2024-07-17',101);
INSERT INTO "MarketData" VALUES (31,28,'2024-08-19',1200);
INSERT INTO "MarketData" VALUES (32,29,'2024-09-21',1500);
INSERT INTO "MarketData" VALUES (33,30,'2024-10-23',3500);
INSERT INTO "MarketData" VALUES (34,31,'2024-11-25',4800);
INSERT INTO "MarketData" VALUES (35,32,'2024-12-27',2000);
INSERT INTO "MarketData" VALUES (36,33,'2024-12-28',1100);
INSERT INTO "Portfolios" VALUES (1,1,'Основной портфель','Умеренный','Диверсифицированный портфель акций и облигаций','2023-01-17');
INSERT INTO "Portfolios" VALUES (2,2,'ИИС-стратегия','Консервативный','Фокус на облигациях и дивидендах','2023-01-21');
INSERT INTO "Portfolios" VALUES (3,3,'Глобальный рост','Агрессивный','Инвестиции в зарубежные акции роста','2023-02-22');
INSERT INTO "Portfolios" VALUES (4,4,'Корпоративный резерв','Консервативный','Краткосрочные облигации и депозиты','2022-11-07');
INSERT INTO "Portfolios" VALUES (5,5,'Долларовый портфель','Умеренный','Сбалансированный портфель в USD','2022-12-02');
INSERT INTO "Portfolios" VALUES (6,6,'Евро-стратегия','Умеренный','Портфель европейских акций и облигаций','2023-03-12');
INSERT INTO "Portfolios" VALUES (7,7,'Технологии','Агрессивный','Инвестиции в технологический сектор','2023-04-03');
INSERT INTO "Portfolios" VALUES (8,8,'Дивидендный','Консервативный','Портфель с упором на дивиденды','2023-05-14');
INSERT INTO "Portfolios" VALUES (9,9,'Сбалансированный','Умеренный','Акции и облигации 50/50','2023-02-17');
INSERT INTO "Portfolios" VALUES (10,10,'Риск-аппетит','Агрессивный','Максимальный рост','2023-06-20');
INSERT INTO "Portfolios" VALUES (11,11,'Стабильный доход','Консервативный','Облигации и депозиты','2023-07-22');
INSERT INTO "Portfolios" VALUES (12,12,'Международный','Умеренный','Глобальная диверсификация','2023-03-24');
INSERT INTO "Portfolios" VALUES (13,13,'Голубые фишки','Умеренный','Крупные компании','2023-08-25');
INSERT INTO "Portfolios" VALUES (14,14,'Энергетика','Агрессивный','Сектор энергетики','2023-09-27');
INSERT INTO "Portfolios" VALUES (15,15,'Консервативный','Консервативный','Минимальный риск','2023-04-29');
INSERT INTO "Portfolios" VALUES (16,16,'Долгосрочный','Умеренный','Портфель на 10 лет','2023-10-31');
INSERT INTO "Portfolios" VALUES (17,17,'Краткосрочный','Консервативный','Портфель на 1 год','2023-11-02');
INSERT INTO "Portfolios" VALUES (18,18,'Секторный','Агрессивный','Ставка на отрасль','2023-06-02');
INSERT INTO "Portfolios" VALUES (19,19,'Активный','Агрессивный','Частые сделки','2024-01-04');
INSERT INTO "Portfolios" VALUES (20,20,'Пассивный','Умеренный','ETF и индексные фонды','2024-02-06');
INSERT INTO "Portfolios" VALUES (21,21,'Детский','Консервативный','Портфель для ребёнка','2024-03-08');
INSERT INTO "Portfolios" VALUES (22,22,'Пенсионный','Консервативный','Пенсионные накопления','2024-04-10');
INSERT INTO "Portfolios" VALUES (23,23,'Валютный','Умеренный','Портфель в иностранной валюте','2024-05-12');
INSERT INTO "Portfolios" VALUES (24,24,'Рискованный','Агрессивный','Высокорисковые активы','2024-06-14');
INSERT INTO "Portfolios" VALUES (25,25,'Стабильный','Консервативный','Минимальная волатильность','2024-07-16');
INSERT INTO "Portfolios" VALUES (26,26,'Рост','Агрессивный','Ростовые акции','2024-08-18');
INSERT INTO "Portfolios" VALUES (27,27,'Диверсифицированный','Умеренный','Много разных классов активов','2024-09-20');
INSERT INTO "Portfolios" VALUES (28,28,'Инновации','Агрессивный','Новейшие технологии','2024-10-22');
INSERT INTO "Portfolios" VALUES (29,29,'Рынки развивающихся стран','Агрессивный','EM акции и облигации','2024-11-24');
INSERT INTO "Portfolios" VALUES (30,30,'Золото и сырьё','Умеренный','Портфель сырьевых активов','2024-12-26');
INSERT INTO "Securities" VALUES (1,'SBER','Сбербанк','Акция','Банки','RUB');
INSERT INTO "Securities" VALUES (2,'GAZP','Газпром','Акция','Энергетика','RUB');
INSERT INTO "Securities" VALUES (3,'AAPL','Apple Inc.','Акция','Технологии','USD');
INSERT INTO "Securities" VALUES (4,'TSLA','Tesla Inc.','Акция','Технологии','USD');
INSERT INTO "Securities" VALUES (5,'VTBR','ВТБ','Акция','Банки','RUB');
INSERT INTO "Securities" VALUES (6,'FXRU','FinEx Российские еврооблигации','ETF','Облигации','USD');
INSERT INTO "Securities" VALUES (7,'SU26238RMFS6','ОФЗ 26238','Облигация','Госдолг','RUB');
INSERT INTO "Securities" VALUES (8,'MSFT','Microsoft Corp.','Акция','Технологии','USD');
INSERT INTO "Securities" VALUES (9,'SIE.DE','Siemens AG','Акция','Промышленность','EUR');
INSERT INTO "Securities" VALUES (10,'BND','Vanguard Total Bond Market ETF','ETF','Облигации','USD');
INSERT INTO "Securities" VALUES (11,'GOOG','Alphabet Inc.','Акция','Технологии','USD');
INSERT INTO "Securities" VALUES (12,'AMZN','Amazon.com Inc.','Акция','Технологии','USD');
INSERT INTO "Securities" VALUES (13,'NFLX','Netflix Inc.','Акция','Медиа','USD');
INSERT INTO "Securities" VALUES (14,'BABA','Alibaba Group','Акция','Технологии','USD');
INSERT INTO "Securities" VALUES (15,'YNDX','Яндекс','Акция','Технологии','RUB');
INSERT INTO "Securities" VALUES (16,'ROSN','Роснефть','Акция','Энергетика','RUB');
INSERT INTO "Securities" VALUES (17,'LKOH','Лукойл','Акция','Энергетика','RUB');
INSERT INTO "Securities" VALUES (18,'GMKN','Норильский никель','Акция','Металлургия','RUB');
INSERT INTO "Securities" VALUES (19,'PLZL','Полюс','Акция','Золото','RUB');
INSERT INTO "Securities" VALUES (20,'TATN','Татнефть','Акция','Энергетика','RUB');
INSERT INTO "Securities" VALUES (21,'MGNT','Магнит','Акция','Ритейл','RUB');
INSERT INTO "Securities" VALUES (22,'SNGS','Сургутнефтегаз','Акция','Энергетика','RUB');
INSERT INTO "Securities" VALUES (23,'MOEX','Московская Биржа','Акция','Финансы','RUB');
INSERT INTO "Securities" VALUES (24,'FXIT','FinEx IT ETF','ETF','Технологии','USD');
INSERT INTO "Securities" VALUES (25,'FXRB','FinEx Российские облигации','ETF','Облигации','RUB');
INSERT INTO "Securities" VALUES (26,'SU26239RMFS4','ОФЗ 26239','Облигация','Госдолг','RUB');
INSERT INTO "Securities" VALUES (27,'SU26240RMFS2','ОФЗ 26240','Облигация','Госдолг','RUB');
INSERT INTO "Securities" VALUES (28,'SBERP','Сбербанк-преф','Акция','Банки','RUB');
INSERT INTO "Securities" VALUES (29,'FIVE','X5 Retail Group','Акция','Ритейл','RUB');
INSERT INTO "Securities" VALUES (30,'ENRU','РусГидро','Акция','Энергетика','RUB');
INSERT INTO "Securities" VALUES (31,'FXUS','FinEx US Equity','ETF','Технологии','USD');
INSERT INTO "Securities" VALUES (32,'FXGD','FinEx Gold','ETF','Золото','USD');
INSERT INTO "Securities" VALUES (33,'FXRL','FinEx Russia Large Cap','ETF','Финансы','RUB');
INSERT INTO "Securities" VALUES (34,'FXCN','FinEx China Equity','ETF','Технологии','USD');
INSERT INTO "Securities" VALUES (35,'FXDE','FinEx Germany Equity','ETF','Промышленность','EUR');
INSERT INTO "Securities" VALUES (36,'FXUK','FinEx UK Equity','ETF','Промышленность','GBP');
INSERT INTO "Securities" VALUES (37,'FXJP','FinEx Japan Equity','ETF','Технологии','JPY');
INSERT INTO "Securities" VALUES (38,'FXWO','FinEx World Equity','ETF','Технологии','USD');
INSERT INTO "Securities" VALUES (39,'FXRU2','FinEx Еврооблигации 2','ETF','Облигации','USD');
INSERT INTO "Securities" VALUES (40,'FXRB2','FinEx Облигации 2','ETF','Облигации','RUB');
INSERT INTO "Transactions" VALUES (1,1,1,'Buy','2023-01-18 10:00:00',100,250.5,15);
INSERT INTO "Transactions" VALUES (2,1,2,'Buy','2023-01-18 11:00:00',50,170.2,10);
INSERT INTO "Transactions" VALUES (3,1,1,'Dividend','2023-04-01 09:00:00',100,12,0);
INSERT INTO "Transactions" VALUES (4,2,7,'Buy','2023-01-22 15:00:00',200,99.9,18);
INSERT INTO "Transactions" VALUES (5,3,3,'Buy','2023-02-23 14:00:00',10,155,1.5);
INSERT INTO "Transactions" VALUES (6,3,4,'Buy','2023-02-23 15:30:00',5,700,2);
INSERT INTO "Transactions" VALUES (7,4,6,'Buy','2022-11-08 13:00:00',100,50,5);
INSERT INTO "Transactions" VALUES (8,5,8,'Buy','2022-12-03 12:00:00',20,300,2.5);
INSERT INTO "Transactions" VALUES (9,6,9,'Buy','2023-03-13 10:30:00',15,145,1);
INSERT INTO "Transactions" VALUES (10,1,1,'Sell','2023-06-10 16:00:00',20,260,3);
INSERT INTO "Transactions" VALUES (11,1,NULL,'Deposit','2023-01-17 09:00:00',NULL,100000,0);
INSERT INTO "Transactions" VALUES (12,2,NULL,'Deposit','2023-01-21 09:00:00',NULL,50000,0);
INSERT INTO "Transactions" VALUES (13,3,NULL,'Deposit','2023-02-22 09:00:00',NULL,20000,0);
INSERT INTO "Transactions" VALUES (14,7,10,'Buy','2023-04-04 12:00:00',30,75,2);
INSERT INTO "Transactions" VALUES (15,8,11,'Buy','2023-05-15 13:00:00',40,2800,5);
INSERT INTO "Transactions" VALUES (16,9,12,'Buy','2023-02-18 14:00:00',25,3300,6);
INSERT INTO "Transactions" VALUES (17,10,13,'Buy','2023-06-21 15:00:00',12,500,1.5);
INSERT INTO "Transactions" VALUES (18,11,14,'Buy','2023-07-23 16:00:00',18,1500,2.5);
INSERT INTO "Transactions" VALUES (19,12,15,'Buy','2023-03-25 17:00:00',22,4000,7);
INSERT INTO "Transactions" VALUES (20,13,16,'Buy','2023-08-26 18:00:00',35,600,2);
INSERT INTO "Transactions" VALUES (21,14,17,'Buy','2023-09-28 19:00:00',28,21000,8);
INSERT INTO "Transactions" VALUES (22,15,18,'Buy','2023-04-30 20:00:00',17,23000,7.5);
INSERT INTO "Transactions" VALUES (23,16,19,'Buy','2023-11-01 21:00:00',9,12000,3);
INSERT INTO "Transactions" VALUES (24,17,20,'Buy','2023-06-03 22:00:00',14,500,1);
INSERT INTO "Transactions" VALUES (25,18,21,'Buy','2024-01-05 23:00:00',21,5000,4);
INSERT INTO "Transactions" VALUES (26,19,22,'Buy','2024-02-07 09:00:00',16,400,1.5);
INSERT INTO "Transactions" VALUES (27,20,23,'Buy','2024-03-09 10:00:00',13,170,0.8);
INSERT INTO "Transactions" VALUES (28,21,24,'Buy','2024-04-11 11:00:00',19,250,1.2);
INSERT INTO "Transactions" VALUES (29,22,25,'Buy','2024-05-13 12:00:00',15,700,2.2);
INSERT INTO "Transactions" VALUES (30,23,26,'Buy','2024-06-15 13:00:00',11,99.9,0.9);
INSERT INTO "Transactions" VALUES (31,24,27,'Buy','2024-07-17 14:00:00',24,101,1.1);
INSERT INTO "Transactions" VALUES (32,25,28,'Buy','2024-08-19 15:00:00',27,1200,3.1);
INSERT INTO "Transactions" VALUES (33,26,29,'Buy','2024-09-21 16:00:00',20,1500,2.7);
INSERT INTO "Transactions" VALUES (34,27,30,'Buy','2024-10-23 17:00:00',22,3500,6.4);
INSERT INTO "Transactions" VALUES (35,28,31,'Buy','2024-11-25 18:00:00',18,4800,7.3);
INSERT INTO "Transactions" VALUES (36,29,32,'Buy','2024-12-27 19:00:00',30,2000,5.5);
INSERT INTO "Transactions" VALUES (37,30,33,'Buy','2024-12-28 20:00:00',25,1100,3.9);
COMMIT;
