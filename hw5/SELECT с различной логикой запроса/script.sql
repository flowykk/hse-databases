USE TSQL2012
--SELECT с различной логикой запроса

--Выбрать из таблицы hr.employees информацию о сотруднике с empid = 4

SELECT * 
FROM [HR].[Employees]
WHERE empid = 4;

SELECT *
FROM [HR].[Employees]
WHERE empid = (SELECT 4); -- Использован подзапрос SELECT

--Выбрать из таблицы hr.employees информацию о сотруднике с empid = 3 и о сотруднике с empid = 8

SELECT * 
FROM [HR].[Employees]
WHERE empid IN (3, 8);

SELECT * 
FROM [HR].[Employees]
WHERE empid = 3 OR empid = 8;

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid >= 2 и empid <= 6

SELECT * 
FROM [HR].[Employees]
WHERE empid BETWEEN 2 AND 6;

SELECT * 
FROM [HR].[Employees]
WHERE empid >= 2 AND empid <= 6;

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid <= 3 и empid >= 6

-- Но такой запрос не вернет данных, так как является бессмысленным
SELECT * 
FROM [HR].[Employees]
WHERE empid <= 3 AND empid >= 6;

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid >= 3 и empid <= 7 и empid <> 4

SELECT * 
FROM [HR].[Employees]
WHERE empid >= 3 AND empid <= 7 AND empid <> 4;

SELECT * 
FROM [HR].[Employees]
WHERE empid BETWEEN 3 AND 7 AND empid <> 4;

--Выбрать из таблицы hr.employees информацию о сотрудниках,
-- у которых  empid >= 3 и empid <= 7 и empid <> 4 и empid = 9

-- Такой запрос не вернет данных, так как является бессмысленным

--Выбрать из таблицы hr.employees информацию о сотрудниках,
--которые родились в 1971 году

SELECT * 
FROM [HR].[Employees]
WHERE YEAR(BirthDate) = 1971;

SELECT * 
FROM [HR].[Employees]
WHERE BirthDate BETWEEN '1971-01-01' AND '1971-12-31';

--Выбрать из таблицы hr.employees информацию о сотрудниках,
--которые родились в январе

SELECT * 
FROM [HR].[Employees]
WHERE MONTH(BirthDate) = 1;
