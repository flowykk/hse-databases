## 1. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]. Показать  все записи, где поле region равно NULL

## 2. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers]. Показать все записи где поле region не равно NULL

## 3. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, состоящие из четырех букв (Указание - любая буква это подчеркивание)

## 4. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, начинающиеся с Ca(Ка).

## 5. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, заканчивающиеся на ed(ед).

## 6. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, содержащие ele(еле).

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

## 8.0 Выбрать из таблицы Task значения price так, чтобы они не повторялись

## 8.1 Получить сумму значений в таблице task для поля price

## 8.2 Получить среднее значение в таблице task для поля price

## 8.3 Выбрать все значения из таблицы task и отсортировать их по полю price в порядке убывания

## 9 Подсчитать максимальное значение в таблице Sales.OrderDetails для выражения qty * unitprice *(1-discount) для orderid = 10250

## 10. Для базы данных tsql2012 в таблице sales.orderdetails. Посчитать сумму значений qty для orderid = 10248

## 11. Для таблицы hr.employees определить всех работников, которые родились в 1970 и 1973 годах
