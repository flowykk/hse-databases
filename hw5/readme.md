## 1. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers] показать  все записи, где поле region равно NULL

```sql
SELECT * 
FROM [Production].[Suppliers]
WHERE region IS NULL;
```

<img width="1561" alt="Screenshot 2024-10-09 at 16 05 25" src="https://github.com/user-attachments/assets/095963ba-d116-450b-b0cd-f7e140900335">

## 2. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers] показать все записи где поле region не равно NULL

```sql
SELECT * 
FROM [Production].[Suppliers]
WHERE region IS NOT NULL;
```

<img width="1629" alt="Screenshot 2024-10-09 at 16 06 33" src="https://github.com/user-attachments/assets/4ab7413f-cd38-4d1f-bafe-e36769b56886">

## 3. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, состоящие из четырех букв (Указание - любая буква это подчеркивание)

```sql
```

## 4. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, начинающиеся с Ca(Ка).

```sql
```

## 5. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, заканчивающиеся на ed(ед).

```sql
```

## 6. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, содержащие ele(еле).

```sql
```

## 7. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, которые не начинаются с букв ABCDE(АБВГД).

```sql
CREATE TABLE Task
(
  orderid int,
  price decimal(7,2) 
)

INSERT INTO Task  (orderid, price) VALUES (1,1.5) 
INSERT INTO Task  (orderid, price) VALUES (2,2.5) 
INSERT INTO Task  (orderid, price) VALUES (3,20.5) 
INSERT INTO Task  (orderid, price) VALUES (4,2.5)
INSERT INTO Task (orderid) VALUES (5)
```

```sql
```

## 8.0 Выбрать из таблицы Task значения price так, чтобы они не повторялись

```sql
```

## 8.1 Получить сумму значений в таблице task для поля price

```sql
```

## 8.2 Получить среднее значение в таблице task для поля price

```sql
```

## 8.3 Выбрать все значения из таблицы task и отсортировать их по полю price в порядке убывания

```sql
```

## 9 Подсчитать максимальное значение в таблице Sales.OrderDetails для выражения qty * unitprice *(1-discount) для orderid = 10250

```sql
```

## 10. Для базы данных tsql2012 в таблице sales.orderdetails. Посчитать сумму значений qty для orderid = 10248

```sql
```

## 11. Для таблицы hr.employees определить всех работников, которые родились в 1970 и 1973 годах

```sql
```
