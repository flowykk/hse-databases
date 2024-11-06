## 1. Вывести информацию из двух таблиц(firmid , firmname, сумму величины value для каждой фирмы) Firmvalues и Firms при помощи при помощи JOIN и группировки

```sql
SELECT  f.FirmId, f.FirmName, SUM(v.[Value]) AS TotalValue
FROM dbo.Firms f
JOIN dbo.FirmValues v ON f.FirmId = v.FirmId
GROUP BY f.FirmId, f.FirmName
ORDER BY f.FirmId;
```

![Screenshot 2024-11-06 at 21 39 41](https://github.com/user-attachments/assets/df6b7fa5-3a25-491c-803e-ad52e9c646b5)

## 2. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы sales.orderdetails для каждого работника. Вывести фамилию, имя и сумму. (Не забывать что работники находятcя в таблице hr.employees и их данные связаны с таблицей sales.orderdetails через таблицу sales.orders)
   
```sql
SELECT e.lastname, e.firstname, SUM(od.qty * od.unitprice * (1 - od.discount)) AS total
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN hr.employees e ON o.empid = e.empid
GROUP BY e.empid, e.lastname, e.firstname
ORDER BY e.lastname, e.firstname;
```

![Screenshot 2024-11-06 at 21 41 17](https://github.com/user-attachments/assets/b02533c2-4b9c-42a4-9520-207dc2562067)

## 3. Упражнение аналогичное предыдущему, только уже данные вычисляются не для сотрудника а для клиента. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы sales.orderdetails для каждого клиента. Вывести contactname и сумму. (Не забывать что клиенты находятcя в таблице sales.customers и их данные связаны с таблицей sales.orderdetails через таблицу sales.orders)

```sql
SELECT c.contactname, SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalAmount
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN sales.customers c ON o.custid = c.custid
GROUP BY c.custid, c.contactname
ORDER BY c.contactname;
```

![Screenshot 2024-11-06 at 21 42 12](https://github.com/user-attachments/assets/e2c50e45-fa3a-4872-9eb0-054a87a19c70)

## 4. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы sales.orderdetails для каждого заказа. Вывести еще номер заказа и дату заказа 

```sql
SELECT o.orderid, o.orderdate, SUM(od.qty * od.unitprice * (1 - od.discount)) AS total
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY o.orderid;
```

![Screenshot 2024-11-06 at 21 42 56](https://github.com/user-attachments/assets/e24dde2c-438b-4b0a-aa9b-b711b0dc3bf1)

## 5. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы sales.orderdetails для каждого года, месяца и дня заказа. выводить в запросе qty*unitprice*(1-discount), год, месяц и день

```sql
SELECT YEAR(o.orderdate) AS OrderYear, MONTH(o.orderdate) AS OrderMonth, DAY(o.orderdate) AS OrderDay, SUM(od.qty * od.unitprice * (1 - od.discount)) AS total
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
GROUP BY YEAR(o.orderdate), MONTH(o.orderdate), DAY(o.orderdate)
ORDER BY OrderYear, OrderMonth, OrderDay;
```

![Screenshot 2024-11-06 at 21 43 50](https://github.com/user-attachments/assets/69735e76-0b11-4b5e-95ae-2c632beb8a6a)

## 6. Сколько студентов учится в каждой группе? Вывести id группы, наименование группы и количество студентов в группе

```sql
SELECT g.gr_id, g.GroupName, COUNT(s.st_id) AS count
FROM dbo.Groups g
JOIN dbo.Students s ON g.gr_id = s.gr_id
GROUP BY g.gr_id, g.GroupName
ORDER BY g.gr_id;
```

![Screenshot 2024-11-06 at 21 46 23](https://github.com/user-attachments/assets/6e2af3c5-6750-48f3-a700-5e555c47dd2e)


     



