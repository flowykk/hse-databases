## 1. Удалить все записи из таблицы [dbo].Students

```sql
DELETE FROM [dbo].[Students];
```

## 2. Удалить одну запись из таблицы [dbo].Students , где st_id = 2

```sql
DELETE FROM [dbo].[Students]
WHERE st_id = 2;
```

## 3. Удалить две записи из таблицы [dbo].Students где  st_id = 2 и st_id = 3

```sql
DELETE FROM [dbo].[Students]
WHERE st_id IN (2, 3);
```

## 4. Обновить одно поле в таблице [dbo].Students вместо Ленский написать Онегин

```sql
UPDATE [dbo].[Students]
SET LastName = 'Онегин'
WHERE LastName = 'Ленский';
```

## 5. Обновить два поля в таблице [dbo].Students вместо Владимир Ленский написать Евгений Онегин

```sql
UPDATE [dbo].[Students]
SET FirstName = 'Евгений', LastName = 'Онегин'
WHERE LastName = 'Ленский' AND FirstName = 'Владимир';
```

## 6. Выбрать из таблицы [dbo].Students запись, где фамилия Раскольников.

```sql
SELECT * 
FROM [dbo].[Students]
WHERE LastName = 'Раскольников';
```

## 7. Напишите скрипт создания таблицы test с тремя переменными типа int, char(20), varchar(50). Наименования переменных могут быть любыми.

```sql
CREATE TABLE [dbo].[test] 
(
  column1 INT,
  column2 CHAR(20),
  column3 VARCHAR(50)
);
```

## 8. Заполните таблицу test данными, хотя бы три записи.

```sql
INSERT INTO [dbo].[test] (column1, column2, column3)
VALUES (1, 'Sample1', 'Test data 1'),
       (2, 'Sample2', 'Test data 2'),
       (3, 'Sample3', 'Test data 3');
```

## 9. Выберите инструкцией SELECT все поля(колонки) из таблицы test

```sql
SELECT *
FROM [dbo].[test] 
```

![Screenshot 2024-10-10 at 01 05 16](https://github.com/user-attachments/assets/53ade5c2-4aa6-4d11-be0b-d235bea729f7)

## 10. Для чего используется инструкция USE?

```sql
-- USE используется для указания, какую БД использовать для выполнения последующих запросов
```

## 11. Выбрать из таблицы Employees базы данных TSQL2012 все поля для сотрудника с фамилией Buck(Бак) и именем Sven(Свен).

```sql
SELECT * 
FROM [HR].[Employees]
WHERE LastName = N'Бак' AND FirstName = N'Свен';
```

![Screenshot 2024-10-10 at 01 08 00](https://github.com/user-attachments/assets/0137a57d-c89d-4425-9f4b-915122703e79)

## 12. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников у которых empid больше или равен 3 и меньше или равен 7.

```sql
SELECT * 
FROM [HR].[Employees]
WHERE empid >= 3 AND empid <= 7;
```

![Screenshot 2024-10-10 at 01 08 37](https://github.com/user-attachments/assets/c9360a46-037b-4358-bd79-53c5ac9e4506)

## 13. Выбрать из таблицы hr.employees сотрудников, у которых empid <= 3 и empid >= 6

```sql
-- Результат запрсоа будет пустым, так как такое условие не имеет смысла
```

## 14. Выбрать из таблицы Employees базы данных TSQL2012 всех сотрудников у которых empid больше или равен 3 и меньше или равен 7 но не равен 5.

```sql
SELECT * 
FROM [HR].[Employees]
WHERE empid >= 3 AND empid <= 7 AND empid <> 5;
```

![Screenshot 2024-10-10 at 01 09 29](https://github.com/user-attachments/assets/e64044bc-f0a3-4e39-b3b4-befe68de8987)
