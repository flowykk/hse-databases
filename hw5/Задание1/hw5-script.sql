--1. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]
-- показать  все записи, где поле region равно NULL

SELECT * 
FROM [Production].[Suppliers]
WHERE region IS NULL;

--2. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]
-- показать все записи где поле region не равно NULL

SELECT * 
FROM [Production].[Suppliers]
WHERE region IS NOT NULL;

--3. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
--  состоящие из четырех букв (Указание - любая буква это подчеркивание)

SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE '____';  -- Подчеркивание = любой букве

--4. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
--  начинающиеся с Ca(Ка).

SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE N'Ка%';  -- Символ "%" означает любое количество символов после "Ca"
-- Префикс N перед строковыми литералами, чтобы указывать, что строка является юникодом

--5. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
--  заканчивающиеся на ed(ед).

SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE N'%ед'; 

--6. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
--  содержащие ele(еле).

SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE N'%еле%';

--7. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012,
--  которые не начинаются с букв ABCDE(АБВГД).

SELECT LastName
FROM [HR].[Employees]
WHERE LastName NOT LIKE N'[А-Д]%';  -- Оператор "[A-Д]" исключает фамилии, начинающиеся с этих букв

--8.0 Выбрать из таблицы Task значения price так, чтобы они не повторялись

SELECT DISTINCT price
FROM Task;

--8.1 Получить сумму значений в таблице task для поля price

SELECT SUM(price)
FROM Task;

--8.2 Получить среднее значение в таблице task для поля price

SELECT AVG(price)
FROM Task;

--8.3 Выбрать все значения из таблицы task и отсортировать их по полю price в порядке убывания

SELECT *
FROM Task
ORDER BY price DESC;

-- (база данных tsql2012)
--9 Подсчитать максимальное значение в таблице Sales.OrderDetails
 -- для выражения qty * unitprice *(1-discount) для orderid = 10250

SELECT MAX(qty * unitprice * (1 - discount)) AS MaxValue
FROM Sales.OrderDetails
WHERE orderid = 10250;

-- 10. Для базы данных tsql2012 в таблице sales.orderdetails 
-- посчитать сумму значений qty для orderid = 10248

SELECT SUM(qty) AS Sum
FROM Sales.OrderDetails
WHERE orderid = 10248;

-- 11. Для таблицы hr.employees определить всех работников, которые родились
-- в 1970 и 1973 годах

SELECT empid, lastname, firstname, birthDate
FROM [HR].[Employees]
WHERE YEAR(BirthDate) IN (1970, 1973);
