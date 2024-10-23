## 1. Проверить запросом к таблицам groups и students нет ли в таблице groups групп, в которых не занимается ни один студент.

```sql
SELECT g.GroupName FROM groups g
LEFT JOIN students s
ON g.gr_id = s.gr_id
WHERE s.st_id IS NULL;
```

![Screenshot 2024-10-23 at 13 01 19](https://github.com/user-attachments/assets/dfb58930-58a1-44dd-b489-1a079638aba5)

## 2. Объединить запросом две таблицы и вывести авторов и названия книг

```sql
SELECT a.au_lastname, b.b_name
FROM Authors a
JOIN books b
ON a.au_id = b.au_id;
```

![Screenshot 2024-10-23 at 13 03 46](https://github.com/user-attachments/assets/2f3f7fd6-2d0e-4804-b243-d1921c2cde0b)

## 3. Объединить при помощи JOIN таблицы [dbo].Classik и [dbo].Phrases и вывести все поля

```sql
SELECT *
FROM Classik c
JOIN Phrases p
ON c.classik_id = p.classik_id;
```

![Screenshot 2024-10-23 at 13 05 50](https://github.com/user-attachments/assets/9ba3379b-371a-4d94-9961-9abe65c98c73)

## 4. Вывести на экран при джойне двух таблиц Classik и Phrases крылатые выражения Горбачева

```sql
SELECT c.firstname, c.lastname, p.phrase
FROM Classik c
JOIN Phrases p
ON c.classik_id = p.classik_id
WHERE c.lastname = 'Gorbachev';
```

![Screenshot 2024-10-23 at 13 06 40](https://github.com/user-attachments/assets/d2a83ae0-dc16-4619-bcc6-63a3b79170a0)

## 5. Вывести на экран при соединении двух таблиц из задачи 2 выражения Горбачева и Зайцева

```sql
SELECT c.firstname, c.lastname, p.phrase
FROM Classik c
JOIN Phrases p
ON c.classik_id = p.classik_id
WHERE c.lastname IN ('Gorbachev', 'Zaytsev');
```

![Screenshot 2024-10-23 at 13 11 06](https://github.com/user-attachments/assets/4a064a2e-6d98-4b6b-b797-1802f7e2092d)

## 6. Объединить при помощи JOIN две таблицы cities и regions и вывести все значения на экран

```sql
SELECT c.city_name, r.region_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id;
```

![Screenshot 2024-10-23 at 13 15 21](https://github.com/user-attachments/assets/c332673e-8c6f-4dea-85ce-2507387c0e00)

## 7. Вывести на экран запрос предыдущей задачи  для города Тьматаракань

```sql
SELECT c.city_name, r.region_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id
WHERE c.city_name = 'Tma Tarakan';
```

![Screenshot 2024-10-23 at 13 16 07](https://github.com/user-attachments/assets/99a35355-f49a-49b9-867b-8fb0be4dbedc)

## 8. Объединить при помощи JOIN две таблицы regions и streets и вывести район и его улицу, для района в котором есть улица похожая на выражение "спартак чемпион"

```sql
SELECT r.region_name, ss.street_name
FROM regions r
JOIN streets ss 
ON r.region_id = ss.region_id
WHERE ss.street_name LIKE '%spartak chempion%';
```

![Screenshot 2024-10-23 at 13 17 18](https://github.com/user-attachments/assets/7c7c338f-6317-493b-becb-5e912b1037a2)

## 9. Вывести значение города , его района и улицу , для города района и улицы, где есть выражение в названии улицы похожее на "даешь ля"

```sql
SELECT c.city_name, r.region_name, ss.street_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id
JOIN streets ss
ON r.region_id = ss.region_id
WHERE ss.street_name LIKE '%daesh lya%';
```

![Screenshot 2024-10-23 at 13 18 43](https://github.com/user-attachments/assets/d59ffb40-cef4-45ca-b319-74b5e0eb7b78)

## 10. Вывести значение города , его района и улицу , для города района и улицы, где есть выражение в названии улицы похожее на "ЗАГС"

```sql
SELECT c.city_name, r.region_name, ss.street_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id
JOIN streets ss
ON r.region_id = ss.region_id
WHERE ss.street_name LIKE '%zags%';
```

![Screenshot 2024-10-23 at 13 19 36](https://github.com/user-attachments/assets/c6d0c144-d714-4c42-9311-554315d22fca)

## 11. Подсчитать сумму для поля qty таблицы Sales.OrderDetails базы данных TSQL2012

```sql
SELECT SUM(qty) AS TotalQuantity
FROM Sales.OrderDetails;
```

![Screenshot 2024-10-23 at 13 28 12](https://github.com/user-attachments/assets/a3e28d4b-c94f-4b6d-a1d2-942da1022fde)

## 12. Определить записи со стоимостью, подсчитанную в таблице sales.orderdetails больше чем 50.5

```sql

```

## 13. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для сотрудника по фамилии Peled (база tsql2012)

```sql

```

## 14. Найти максимальное значение выражения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)

```sql

```

## 15. Определить по таблицам sales.customers и sales.orders заказчиков, которые не сделали ни одного заказа(использовать LEFT JOIN)

```sql

```

## 16. Вывести информацию о сотрудниках и их заказах из таблиц hr.employees и sales.orders при помощи JOIN (вывести lastname, firstname, orderdate)

```sql

```

## 17. Вывести информацию о клиентах и их заказах из таблиц sales.customers и sales.orders при помощи JOIN (вывести contactname, orderdate)

```sql

```
