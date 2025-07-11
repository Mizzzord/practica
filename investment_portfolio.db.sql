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
