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

## 4. Определить сотрудников, которые на одну дату оформилидва или более заказов. Вывести empid сотрудников, lastname и соответствующие даты.

```sql
![Uploading Screenshot 2024-11-06 at 19.33.11.png…]()
```

## 5. Решить задачи 1-4 при условии, что вместо сотрудника мы имеем дело с заказчиком(клиентом таблица sales.cusomers) 

```sql

```

## 6. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для сотрудника по фамилии Peled (Пелед) (база tsql2012)
Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails HR.Employees

```sql

```

## 7. Найти максимальное значение выражения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)
Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails Sales.Customers

```sql

```

## 8. Определить по таблице sales.orders количество заказов, сделанных за каждый год при помощи группировки
    SELECT YEAR(o.orderdate), COUNT(o.orderid) FROM sales.Orders o
	GROUP BY YEAR(o.orderdate)
	ORDER BY YEAR(o.orderdate)

```sql

```

## 9. Определить по таблице sales.orders количество заказов, сделанных за каждый день 2008 года при помощи группировки

```sql

```

## 10. Определить количество клиентов для empid каждого сотрудника из таблицы sales.orders
Та же самая задача, но не повторять в учете одного и того же клиента

```sql

```

## 11. Определить количество клиентов для каждого сотрудника для каждого года работы
Та же самая задача, но не повторять в учете одного и того же клиента

```sql

```
