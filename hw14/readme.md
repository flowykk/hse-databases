## Какие уровни изоляции гарантируют неповторяющееся чтение и непоявление фантомных записей для всех случаев жизни?

`SERIALIZABLE` — это **единственный уровень изоляции**, который гарантирует:  
    - Отсутствие **неповторяющегося чтения** (Non-Repeatable Reads).  
    - Отсутствие **фантомных записей** (Phantom Reads).  
    - Полную изоляцию всех транзакций, достигая эффекта последовательного выполнения транзакций.  

Существуют и другие уровни изоляции, такие как:
- `READ UNCOMMITTED` — чтение неподтвержденных данных;
- `READ COMMITTED` — чтение только подтвержденных данных;
- `REPEATABLE READ` — гарантирует, что при повторном чтении данных внутри транзакции они останутся неизменными. 

## Какой уровень изоляции гарантирует чтение всех неподтвержденных транзакциями вставок и обновлений?

**READ UNCOMMITTED** — самый низкий уровень изоляции.  
   - Транзакции могут **читать данные, которые еще не были подтверждены** другими транзакциями.  
   - Это приводит к **грязному чтению** (Dirty Reads).  

## Примеры с SQL-скриптами

### SERIALIZABLE и предотвращение фантомных записей

**Условие**: Две транзакции пытаются работать с данными. Транзакция 1 читает количество записей, а транзакция 2 пытается добавить новую запись. При уровне `SERIALIZABLE` фантомных записей не появится.

```sql
CREATE TABLE Products (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);

INSERT INTO Products (Id, Name) VALUES (1, 'Product A'), (2, 'Product B');
```

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;

SELECT COUNT(*) AS ProductCount FROM Products;

COMMIT TRANSACTION;
```

**Итог**: Получаем, что **Транзакция 2** не сможет добавить запись до тех пор, пока **Транзакция 1** не завершится.  

### READ UNCOMMITTED и грязное чтение

**Условие**: Транзакция 1 обновляет данные, но не подтверждает изменения. Транзакция 2 с уровнем `READ UNCOMMITTED` может прочитать эти неподтвержденные данные.

```sql
CREATE TABLE Orders (
    Id INT PRIMARY KEY,
    TotalAmount DECIMAL(10, 2)
);

INSERT INTO Orders (Id, TotalAmount) VALUES (1, 100.00);
```

```sql
BEGIN TRANSACTION;

UPDATE Orders
SET TotalAmount = 200.00
WHERE Id = 1;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT TotalAmount FROM Orders WHERE Id = 1;

ROLLBACK TRANSACTION;
```

**Итог**: Получаем, что **Транзакция 2** увидит `TotalAmount = 200.00`, несмотря на то, что изменения **не подтверждены** и позже будут откатаны.

### REPEATABLE READ и неповторяющееся чтение

**Условие**: Транзакция 1 дважды читает одни и те же данные. Транзакция 2 между этими чтениями обновляет данные. На уровне **REPEATABLE READ** изменение данных блокируется.

```sql
CREATE TABLE Inventory (
    Id INT PRIMARY KEY,
    Quantity INT
);

INSERT INTO Inventory (Id, Quantity) VALUES (1, 10);
```

#### Транзакция 1 с уровнем REPEATABLE READ
```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION;

SELECT Quantity FROM Inventory WHERE Id = 1;
SELECT Quantity FROM Inventory WHERE Id = 1;

COMMIT TRANSACTION;
```

**Итог**: Получаем, что обновление данных из **Транзакции 2** блокируется до завершения **Транзакции 1**.
