## 1. Для каждого сотрудника получить количество сделанных заказов на каждую дату. Ожидается , что сотрудники делают по одному заказу на каждую дату, но могут быть исключения. Вывести empid сотрудника , дату orderdate и количество заказов на данную дату. Использовать таблицу sales.orders. 

```sql
SELECT empid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY empid, orderdate
ORDER BY empid, orderdate;
```

![Screenshot 2024-11-06 at 19 30 36](https://github.com/user-attachments/assets/13c2086a-4b0c-47f8-b7a5-673f66e3355d)

## 2. Определить сотрудников, которые на одну дату оформили два или более заказов. Вывести empid сотрудников и соответствующие даты.

```sql
SELECT empid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY empid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY empid, orderdate;
```

![Screenshot 2024-11-06 at 19 32 11](https://github.com/user-attachments/assets/e4a669ad-5587-4821-94d3-f84a34883bba)

## 3. Для каждого сотрудника получить количество сделанных заказов на каждую дату. Ожидается, что сотрудники делают по одному заказу на каждую дату, но могут быть исключения. Вывести empid сотрудника, lastname сотрудника, дату orderdate и количество заказов на данную дату. Использовать таблицу hr.employees и sales.orders. 

```sql
SELECT o.empid, e.lastname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN hr.employees e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
ORDER BY o.empid, o.orderdate;
```

![Screenshot 2024-11-06 at 19 33 32](https://github.com/user-attachments/assets/fdcfd503-6d30-4794-a431-9640a5a7fe09)

## 4. Определить сотрудников, которые на одну дату оформили два или более заказов. Вывести empid сотрудников, lastname и соответствующие даты.

```sql
SELECT o.empid, e.lastname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN hr.employees e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.empid, o.orderdate;
```

![Screenshot 2024-11-06 at 19 34 02](https://github.com/user-attachments/assets/0e98fead-2cf2-4a58-9318-7f0a3eea58e6)

## 5. Решить задачи 1-4 при условии, что вместо сотрудника мы имеем дело с заказчиком(клиентом таблица sales.cusomers) 

### 5.1

```sql
SELECT custid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY custid, orderdate
ORDER BY custid, orderdate;
```

![Screenshot 2024-11-06 at 19 36 27](https://github.com/user-attachments/assets/beacac1f-64c4-4544-ac94-66d1a4e7c7bf)

### 5.2

```sql
SELECT custid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY custid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY custid, orderdate;
```

![Screenshot 2024-11-06 at 19 36 51](https://github.com/user-attachments/assets/65e5ca55-7b2b-4064-b37a-c7f2a937fb6d)

### 5.3

```sql
SELECT o.custid, c.companyname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN sales.customers c ON o.custid = c.custid
GROUP BY o.custid, c.companyname, o.orderdate
ORDER BY o.custid, o.orderdate;
```

![Screenshot 2024-11-06 at 19 37 12](https://github.com/user-attachments/assets/42362254-9038-460b-978d-6b089a2ba8b3)

### 5.4

```sql
SELECT o.custid, c.companyname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN sales.customers c ON o.custid = c.custid
GROUP BY o.custid, c.companyname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.custid, o.orderdate;
```

![Screenshot 2024-11-06 at 19 37 22](https://github.com/user-attachments/assets/5f1fc601-ff36-4bd8-98b3-8aac35380096)

## 6. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для сотрудника по фамилии Peled (Пелед) (база tsql2012)
Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails HR.Employees

```sql
SELECT AVG(od.qty * od.unitprice * (1 - od.discount)) AS avg
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN hr.employees e ON o.empid = e.empid
WHERE e.lastname = 'Peled';
```

![Screenshot 2024-11-06 at 19 39 07](https://github.com/user-attachments/assets/bdeeede7-865b-42ab-96a2-962cdf06f56e)

## 7. Найти максимальное значение выражения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)
Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails Sales.Customers

```sql
SELECT MAX(od.qty * od.unitprice * (1 - od.discount)) AS max
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN sales.customers c ON o.custid = c.custid
WHERE c.contactname = 'Ray, Mike';
```

![Screenshot 2024-11-06 at 19 39 32](https://github.com/user-attachments/assets/655b5e3b-9829-48a1-a0b9-91d532a0ad8c)

## 8. Определить по таблице sales.orders количество заказов, сделанных за каждый год при помощи данной группировки

```sql
SELECT YEAR(o.orderdate) year, COUNT(o.orderid) count
FROM sales.orders o
GROUP BY YEAR(o.orderdate)
ORDER BY YEAR(o.orderdate);
```

![Screenshot 2024-11-06 at 19 41 19](https://github.com/user-attachments/assets/9eec12d4-a150-4989-a6d4-bb52d98b44a5)

## 9. Определить по таблице sales.orders количество заказов, сделанных за каждый день 2008 года при помощи группировки

```sql
SELECT o.orderdate, COUNT(o.orderid) count
FROM sales.orders o
WHERE YEAR(o.orderdate) = 2008
GROUP BY o.orderdate
ORDER BY o.orderdate;
```

![Screenshot 2024-11-06 at 19 41 57](https://github.com/user-attachments/assets/96c213c5-076e-48a0-8f8b-6ee97b24bcda)

## 10. Определить количество клиентов для empid каждого сотрудника из таблицы sales.orders

```sql
SELECT empid, COUNT(DISTINCT custid) AS customer_count
FROM sales.orders
GROUP BY empid;
```

![Screenshot 2024-11-06 at 19 42 29](https://github.com/user-attachments/assets/7af6eb3a-c922-4879-8ff2-87f4b9bad901)

## 11. Определить количество клиентов для каждого сотрудника для каждого года работы

```sql
SELECT empid, YEAR(orderdate) AS order_year, COUNT(DISTINCT customerid) AS customer_count
FROM sales.orders
GROUP BY empid, YEAR(orderdate)
ORDER BY empid, order_year;
```

![Screenshot 2024-11-06 at 19 42 58](https://github.com/user-attachments/assets/420e68c2-ab65-474f-8699-095c299b9b5f)
