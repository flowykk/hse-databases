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

```

## 7. Вывести на экран запрос предыдущей задачи  для города Тьматаракань

```sql

```

## 8. Объединить при помощи JOIN две таблицы regions и streets и вывести район и его улицу, для района в котором есть улица похожая на выражение "спартак чемпион"

```sql

```

## 9. Вывести значение города , его района и улицу , для города района и улицы, где есть выражение в названии улицы похожее на "даешь ля"

```sql

```

## 10. Вывести значение города , его района и улицу , для города района и улицы, где есть выражение в названии улицы похожее на "ЗАГС"

```sql

```

## 11. Подсчитать сумму для поля qty таблицы Sales.OrderDetails базы данных TSQL2012

```sql

```

## 12. Определить записи со стоимостью , подсчитанную в таблице sales.orderdetails больше чем 50.5

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
