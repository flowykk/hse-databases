
## 1. Сделать копии таблиц Production.Categories и Production.Products из базы данных tsql2012 в dbo.Categories и dbo.Products тремя способами

a) При помощи инструкции SELECT INTO с подзапросом
b) При помощи инструкции SELECT INTO без подзапроса (просто из таблицы)
c) При помощи INSERT INTO в итоговую таблицу

### a)

```sql
SELECT * INTO dbo.Categories
FROM ( SELECT * FROM Production.Categories) AS Subquery;

SELECT * INTO dbo.Products
FROM (SELECT * FROM Production.Products) AS Subquery;
```

### b) 

```sql
SELECT * INTO dbo.Categories
FROM Production.Categories;

SELECT * INTO dbo.Products
FROM Production.Products;
```

### c) 

```sql
CREATE TABLE dbo.Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(255),
    Description NVARCHAR(MAX)
);

CREATE TABLE dbo.Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    QuantityPerUnit NVARCHAR(255),
    UnitPrice DECIMAL(10, 2),
    UnitsInStock SMALLINT,
    UnitsOnOrder SMALLINT,
    ReorderLevel SMALLINT,
    Discontinued BIT
);

INSERT INTO dbo.Categories
SELECT * FROM Production.Categories;

INSERT INTO dbo.Products
SELECT * FROM Production.Products;
```

## 2. Обновить цену unitprice в таблице orderdetails для работника по фамилии Пелед, Увеличить ее на 20% при помощи соединения(JOIN) с таблицами employees и orders

```sql
UPDATE od
SET od.UnitPrice = od.UnitPrice * 1.2
FROM Sales.OrderDetails od
INNER JOIN sales.Orders o ON od.OrderID = o.OrderID
INNER JOIN hr.Employees e ON o.empid = e.empid
WHERE e.LastName = 'Peled';
```

![Screenshot 2024-12-11 at 14 40 54](https://github.com/user-attachments/assets/79b284de-f25b-4eae-91cc-b3c90f2bfd81)

## 3. Обновить цену unitprice в таблице orderdetails для работника по фамилии Пелед, Увеличить ее на 20% при помощи коррелированного подзапроса  с участием таблицм employees и orders

```sql
UPDATE sales.OrderDetails
SET UnitPrice = UnitPrice * 1.2
WHERE OrderID IN (
    SELECT o.OrderID
    FROM sales.Orders o
    WHERE o.empid IN (
        SELECT e.empid
        FROM hr.Employees e
        WHERE e.LastName = 'Peled'
    )
);
```

![Screenshot 2024-12-11 at 14 40 33](https://github.com/user-attachments/assets/36574b32-8110-4208-b68c-655b18b04565)

## 4. Удалить записи в таблице orderdetails для работника по фамилии Пелед при помощи соединения(JOIN) с таблицами employees и orders

```sql
DELETE od
FROM sales.OrderDetails od
INNER JOIN sales.Orders o ON od.OrderID = o.OrderID
INNER JOIN hr.Employees e ON o.empid = e.empid
WHERE e.LastName = 'Peled';
```

![Screenshot 2024-12-11 at 14 41 18](https://github.com/user-attachments/assets/cccf4209-df4d-4e48-bf57-05552450fac2)

## 5. Удалить записи в таблице orderdetails для работника по фамилии Пелед при помощи коррелированного подзапроса и таблиц  employees и orders

```sql
DELETE FROM sales.OrderDetails
WHERE OrderID IN (
    SELECT o.OrderID
    FROM sales.Orders o
    WHERE o.empid IN (
        SELECT e.empid
        FROM hr.Employees e
        WHERE e.LastName = 'Peled'
    )
);
```

![Screenshot 2024-12-11 at 14 42 15](https://github.com/user-attachments/assets/7443968c-9d45-4eec-9659-01772efb33f4)

## 6. Создать таблицу test. Занести в нее несколько записей, некоторые долны быть одинаковыми кроме первичных ключей. Удалить повторяющиеся записи.

```sql
CREATE TABLE test (
    id INT PRIMARY KEY,
    lastname NVARCHAR(30),
    firstname NVARCHAR(30)
);

INSERT INTO test (id, lastname, firstname)
VALUES
    (1, 'Bayden', 'Djo'),
    (2, 'Rejgan', 'Ronald'),
    (3, 'Linkoln', 'Avraam'),
    (4, 'Brezhnev', 'Leonid'),
    (5, 'Stalin', 'Iosif'),
    (6, 'Bayden', 'Djo'),
    (7, 'Rejgan', 'Ronald');

DELETE FROM test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM test
    GROUP BY lastname, firstname
);
```

![Screenshot 2024-12-11 at 14 44 59](https://github.com/user-attachments/assets/ce40abb2-819d-4349-a223-6e48adc83c73)

## 7. Сделать таблицу testex одинаковой с таблицей test при помощи инструкции MERGE

```sql
CREATE TABLE testex (
    id INT PRIMARY KEY,
    lastname NVARCHAR(30),
    firstname NVARCHAR(30)
);

MERGE INTO testex AS Target
USING test AS Source
ON Target.id = Source.id
WHEN MATCHED THEN
    UPDATE SET lastname = Source.lastname, firstname = Source.firstname
WHEN NOT MATCHED THEN
    INSERT (id, lastname, firstname)
    VALUES (Source.id, Source.lastname, Source.firstname);
```

![Screenshot 2024-12-11 at 14 46 52](https://github.com/user-attachments/assets/34467b50-7bf5-4cf7-b06b-8ebddda4e0b9)

## 8. Объединить таблицы Categories и Products при помощи JOIN по полю categoryid. Создать по данному запросу представление View с именем v1 и вывести все поля представления на экран

```sql
CREATE VIEW v1 AS
SELECT c.categoryid AS categoryid_c,
       p.categoryid AS categoryid_p,
       p.productid,                 
       p.productname
FROM Production.Categories c
JOIN Production.Products p ON c.categoryid = p.categoryid;
```

![Screenshot 2024-12-11 at 14 49 24](https://github.com/user-attachments/assets/e8ddcc07-23ec-4a78-8bac-d58d75f64368)

## 9. Определить для каждого работника суммарную стоимость заказа unitprice*qty*(1-discount) за каждый год для таблиц orderdetails, orders, employees. Вывести значения lastname, firstname, год заказа, суммарная стоимость. Решить при помощи подзапроса с последующим соединением этого подзапроса с таблицей employees и созданием из данного подзапроса представления(view).

```sql
CREATE VIEW OrderSummary AS
SELECT 
    e.LastName,
    e.FirstName,
    YEAR(o.OrderDate) AS OrderYear,
    SUM(od.UnitPrice * od.qty * (1 - od.Discount)) AS TotalCost
FROM hr.Employees e
JOIN sales.Orders o ON e.empid = o.empid
JOIN sales.OrderDetails od ON o.OrderID = od.OrderID
GROUP BY e.LastName, e.FirstName, YEAR(o.OrderDate);
```

![Screenshot 2024-12-11 at 14 50 18](https://github.com/user-attachments/assets/32898e99-3dba-4107-86ea-4a65594286c7)
