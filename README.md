
# База данных инвестиционной платформы
## Назначение

Данная база данных хранит информацию о клиентах инвестиционной платформы, их счетах, портфелях, сделках, позициях и котировках ценных бумаг.  
Схема оптимизирована для аналитических запросов (reporting) и оперативной работы (OLTP) брокерского back‑office.

---

## Обзор сущностей и связей

| Сущность | Ключ | Основные связи |
|----------|------|----------------|
| **Clients** | `ClientID` | 1 ⇢ N **Accounts** |
| **Accounts** | `AccountID` | 1 ⇢ N **Portfolios** |
| **Portfolios** | `PortfolioID` | 1 ⇢ N **Holdings**, 1 ⇢ N **Transactions** |
| **Securities** | `SecurityID` | 1 ⇢ N **Holdings**, 1 ⇢ N **MarketData**, 1 ⇢ N **Transactions** |
| **Holdings** | `HoldingID` | N : 1 **Portfolios**, N : 1 **Securities** |
| **MarketData** | `PriceID` | N : 1 **Securities** |
| **Transactions** | `TransactionID` | N : 1 **Portfolios**, (опц.) N : 1 **Securities** |

---

## Описание таблиц

### 1. `Clients`

| Поле | Тип | Not Null | Уникальность / PK | По‑умолч. | Описание |
|------|-----|----------|-------------------|-----------|----------|
| `ClientID` | INTEGER | ✔︎ | **PK**, AUTOINCREMENT | — | Идентификатор клиента |
| `ClientType` | VARCHAR(20) | ✔︎ | — | — | Тип клиента (`Individual` / `LegalEntity`) |
| `FullName` | VARCHAR(255) | ✔︎ | — | — | ФИО / название компании |
| `TaxID` | VARCHAR(50) | ✔︎ | **UNIQUE** | — | ИНН / рег‑код |
| `ContactPerson` | VARCHAR(255) | — | — | — | Представитель (для юрлиц) |
| `Email` | VARCHAR(100) | — | **UNIQUE** | — | E‑mail |
| `PhoneNumber` | VARCHAR(20) | — | — | — | Телефон |
| `RegistrationDate` | DATE | ✔︎ | — | — | Дата регистрации |

---

### 2. `Accounts`

| Поле | Тип | Not Null | Уникальность / PK | По‑умолч. | Описание |
|------|-----|----------|-------------------|-----------|----------|
| `AccountID` | INTEGER | ✔︎ | **PK**, AUTOINCREMENT | — | Идентификатор счёта |
| `ClientID` | INT | ✔︎ | **FK → Clients.ClientID** | — | Владелец счёта |
| `AccountType` | VARCHAR(50) | — | — | — | Тип счёта (`Брокерский`, `ИИС`) |
| `Currency` | VARCHAR(3) | ✔︎ | — | `'RUB'` | Валюта счёта |
| `OpenDate` | DATE | ✔︎ | — | — | Дата открытия |
| `Status` | VARCHAR(20) | — | — | `'Active'` | Статус (`Active`, `Closed`) |

---

### 3. `Portfolios`

| Поле | Тип | Not Null | PK/Unique | По‑умолч. | Описание |
|------|-----|----------|-----------|-----------|----------|
| `PortfolioID` | INTEGER | ✔︎ | **PK**, AUTOINCREMENT | — | Идентификатор портфеля |
| `AccountID` | INT | ✔︎ | **FK → Accounts.AccountID** | — | Связанный счёт |
| `PortfolioName` | VARCHAR(100) | ✔︎ | — | — | Название |
| `RiskProfile` | VARCHAR(50) | — | — | — | Профиль риска |
| `StrategyDescription` | TEXT | — | — | — | Описание стратегии |
| `CreationDate` | DATE | ✔︎ | — | — | Дата создания |

---

### 4. `Securities`

| Поле | Тип | Not Null | PK/Unique | По‑умолч. | Описание |
|------|-----|----------|-----------|-----------|----------|
| `SecurityID` | INTEGER | ✔︎ | **PK**, AUTOINCREMENT | — | Идентификатор бумаги |
| `Ticker` | VARCHAR(20) | ✔︎ | **UNIQUE** | — | Биржевой тикер |
| `SecurityName` | VARCHAR(255) | ✔︎ | — | — | Полное название |
| `AssetClass` | VARCHAR(50) | ✔︎ | — | — | Класс актива (акция, ETF…) |
| `Industry` | VARCHAR(100) | — | — | — | Отрасль |
| `Currency` | VARCHAR(3) | ✔︎ | — | — | Валюта котировок |

---

### 5. `Holdings`

| Поле | Тип | Not Null | PK/Unique | По‑умолч. | Описание |
|------|-----|----------|-----------|-----------|----------|
| `HoldingID` | INTEGER | ✔︎ | **PK**, AUTOINCREMENT | — | Идентификатор позиции |
| `PortfolioID` | INT | ✔︎ | **FK → Portfolios.PortfolioID** | — | Портфель |
| `SecurityID` | INT | ✔︎ | **FK → Securities.SecurityID** | — | Бумага |
| `Quantity` | DECIMAL(18,4) | ✔︎ | — | — | Кол‑во бумаг |
| `AverageCost` | DECIMAL(18,4) | ✔︎ | — | — | Средняя цена покупки |
| (`PortfolioID`, `SecurityID`) | — | — | **UNIQUE** | — | Одна запись на бумагу в портфеле |

---

### 6. `MarketData`

| Поле | Тип | Not Null | PK/Unique | Описание |
|------|-----|----------|-----------|----------|
| `PriceID` | INTEGER | ✔︎ | **PK**, AUTOINCREMENT | Идентификатор ценовой записи |
| `SecurityID` | INT | ✔︎ | **FK → Securities.SecurityID** | Бумага |
| `PriceDate` | DATE | ✔︎ | — | Дата закрытия |
| `ClosePrice` | DECIMAL(18,4) | ✔︎ | — | Цена закрытия |
| (`SecurityID`, `PriceDate`) | — | — | **UNIQUE** | Уникальность котировки на дату |

---

### 7. `Transactions`

| Поле | Тип | Not Null | PK/Unique | Описание |
|------|-----|----------|-----------|----------|
| `TransactionID` | INTEGER | ✔︎ | **PK**, AUTOINCREMENT | Идентификатор сделки |
| `PortfolioID` | INT | ✔︎ | **FK → Portfolios.PortfolioID** | Портфель |
| `SecurityID` | INT | — | **FK → Securities.SecurityID** | Бумага (nullable для `Deposit`/`Withdraw`) |
| `TransactionType` | VARCHAR(20) | ✔︎ | — | Тип (`Buy`, `Sell`, `Deposit`, `Dividend` …) |
| `TransactionDate` | DATETIME | ✔︎ | — | Дата и время |
| `Quantity` | DECIMAL(18,4) | — | — | Кол‑во (nullable) |
| `Price` | DECIMAL(18,4) | — | — | Цена за единицу или сумма |
| `Commission` | DECIMAL(10,2) | — | — | Комиссия брокера |

---

## Индексация и производительность

* Первичные ключи создают кластерные индексы во всех таблицах.  
* Уникальные ограничения (`UNIQUE`) автоматически формируют некластерные индексы, ускоряя поиск по тикеру, ИНН и др.  
* Для аналитики по датам котировок рекомендуется добавить составной индекс _(SecurityID, PriceDate DESC)_.

---

## Примеры запросов

```sql
-- 1. Текущая стоимость портфеля
SELECT p.PortfolioName,
       SUM(h.Quantity * md.ClosePrice) AS MarketValue
FROM Holdings h
JOIN Portfolios p   ON p.PortfolioID = h.PortfolioID
JOIN (
    SELECT SecurityID, MAX(PriceDate) AS LastDate
    FROM MarketData
    GROUP BY SecurityID
) t ON t.SecurityID = h.SecurityID
JOIN MarketData md ON md.SecurityID = t.SecurityID AND md.PriceDate = t.LastDate
GROUP BY p.PortfolioID;

-- 2. История сделок клиента
SELECT c.FullName,
       t.TransactionDate,
       t.TransactionType,
       s.Ticker,
       t.Quantity,
       t.Price,
       t.Commission
FROM Transactions t
JOIN Portfolios p ON p.PortfolioID = t.PortfolioID
JOIN Accounts a   ON a.AccountID   = p.AccountID
JOIN Clients c    ON c.ClientID    = a.ClientID
LEFT JOIN Securities s ON s.SecurityID = t.SecurityID
WHERE c.ClientID = :ClientID
ORDER BY t.TransactionDate DESC;
```

---

## Загрузка и использование

1. Создайте новую SQLite‑БД:

   ```bash
   sqlite3 investment_platform.sqlite < schema_and_data.sql
   ```

2. Подключитесь к базе через DBeaver / DataGrip или любую библиотеку (`sqlite3`, SQLAlchemy).

3. При работе с внешними API для обновления котировок используйте таблицу **MarketData**.

