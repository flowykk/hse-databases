-- 1. Удалить все записи из таблицы [dbo].Students

DELETE FROM [dbo].[Students];

-- 2. Удалить одну запись из таблицы [dbo].Students , где st_id = 2

DELETE FROM [dbo].[Students]
WHERE st_id = 2;

-- 3. Удалить две записи из таблицы [dbo].Students где  st_id = 2 и st_id = 3

DELETE FROM [dbo].[Students]
WHERE st_id IN (2, 3);

-- 4. Обновить одно поле в таблице [dbo].Students вместо Ленский написать Онегин

UPDATE [dbo].[Students]
SET LastName = 'Онегин'
WHERE LastName = 'Ленский';

-- 5. Обновить два поля в таблице [dbo].Students вместо Владимир Ленский написать Евгений Онегин

UPDATE [dbo].[Students]
SET FirstName = 'Евгений', LastName = 'Онегин'
WHERE LastName = 'Ленский' AND FirstName = 'Владимир';

-- 6. Выбрать из таблицы [dbo].Students запись, где фамилия Раскольников.

SELECT * 
FROM [dbo].[Students]
WHERE LastName = 'Раскольников';

-- 7. Напишите скрипт создания таблицы test с тремя переменными типа int, char(20), varchar(50).Наименования переменных могут быть любыми.

CREATE TABLE [dbo].[test] 
(
  column1 INT,
  column2 CHAR(20),
  column3 VARCHAR(50)
);

-- 8. Заполните таблицу test данными, хотя бы три записи.

INSERT INTO [dbo].[test] (column1, column2, column3)
VALUES (1, 'Sample1', 'Test data 1'),
       (2, 'Sample2', 'Test data 2'),
       (3, 'Sample3', 'Test data 3');

-- 9. Выберите инструкцией SELECT все поля(колонки) из таблицы test

SELECT *
FROM [dbo].[test] 

-- 10. Для чего используется инструкция USE?

-- USE используется для указания, какую БД использовать для выполнения последующих запросов

-- 11. Выбрать из таблицы Employees базы данных TSQL2012 все поля для сотрудника с фамилией Buck(Бак) и именем Sven(Свен).

SELECT * 
FROM [HR].[Employees]
WHERE LastName = N'Бак' AND FirstName = N'Свен';

-- 12. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников у которых empid больше или равен 3 и меньше или равен 7.

SELECT * 
FROM [HR].[Employees]
WHERE empid >= 3 AND empid <= 7;

-- 13. Выбрать из таблицы hr.employees сотрудников, у которых empid <= 3 и empid >= 6

-- Результат запрсоа будет пустым, так как такое условие не имеет смысла

-- 14. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников у которых empid больше или равен 3 и меньше или равен 7 но не равен 5.

SELECT * 
FROM [HR].[Employees]
WHERE empid >= 3 AND empid <= 7 AND empid <> 5;
