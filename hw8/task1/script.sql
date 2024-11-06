-- 1. Для каждого сотрудника получить количество сделанных заказов на
--    каждую дату. Ожидается , что сотрудники делают по одному
--    заказу на каждую дату, но могут быть исключения
--    Вывести empid сотрудника , дату orderdate и количество заказов
--    на данную дату. Использовать таблицу sales.orders. 
 
SELECT empid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY empid, orderdate
ORDER BY empid, orderdate;

-- 2. Определить сотрудников, которые на одну дату оформили
--    два или более заказов. Вывести empid сотрудников 
--    и соответствующие даты

SELECT empid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY empid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY empid, orderdate;

-- 3. Для каждого сотрудника получить количество сделанных заказов на
--    каждую дату. Ожидается , что сотрудники делают по одному
--    заказу на каждую дату, но могут быть исключения
--    Вывести empid сотрудника , lastname сотрудника , дату orderdate и количество заказов
--    на данную дату. Использовать таблицу hr.employees и sales.orders. 

SELECT o.empid, e.lastname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN hr.employees e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
ORDER BY o.empid, o.orderdate;

-- 4. Определить сотрудников, которые на одну дату оформили
--    два или более заказов. Вывести empid сотрудников, lastname 
--    и соответствующие даты

SELECT o.empid, e.lastname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN hr.employees e ON o.empid = e.empid
GROUP BY o.empid, e.lastname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.empid, o.orderdate;

-- 5. Решить задачи 1-4 при условии, что вместо сотрудника 
--    мы имеем дело с заказчиком(клиентом таблица sales.cusomers) 

-- 5.1

SELECT custid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY custid, orderdate
ORDER BY custid, orderdate;

-- 5.2

SELECT custid, orderdate, COUNT(orderid) AS order_count
FROM sales.orders
GROUP BY custid, orderdate
HAVING COUNT(orderid) >= 2
ORDER BY custid, orderdate;

-- 5.3

SELECT o.custid, c.companyname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN sales.customers c ON o.custid = c.custid
GROUP BY o.custid, c.companyname, o.orderdate
ORDER BY o.custid, o.orderdate;

-- 5.4

SELECT o.custid, c.companyname, o.orderdate, COUNT(o.orderid) AS order_count
FROM sales.orders o
JOIN sales.customers c ON o.custid = c.custid
GROUP BY o.custid, c.companyname, o.orderdate
HAVING COUNT(o.orderid) >= 2
ORDER BY o.custid, o.orderdate;

-- 6. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в 
--    таблице Sales.OrderDetails для сотрудника по фамилии Peled (Пелед) (база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails HR.Employees

SELECT AVG(od.qty * od.unitprice * (1 - od.discount)) AS avg
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN hr.employees e ON o.empid = e.empid
WHERE e.lastname = 'Peled';

-- 7. Найти максимальное значение выражения qty * unitprice *(1-discount)
--    в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)
--    Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails Sales.Customers

SELECT MAX(od.qty * od.unitprice * (1 - od.discount)) AS max
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN sales.customers c ON o.custid = c.custid
WHERE c.contactname = 'Ray, Mike';

-- 8. Определить по таблице sales.orders количество заказов ,
--    сделанных за каждый год при помощи группировки
-- SELECT YEAR(o.orderdate), COUNT(o.orderid) FROM sales.Orders o
-- GROUP BY YEAR(o.orderdate)
-- ORDER BY YEAR(o.orderdate)

SELECT YEAR(o.orderdate) year, COUNT(o.orderid) count
FROM sales.orders o
GROUP BY YEAR(o.orderdate)
ORDER BY YEAR(o.orderdate);

-- 9. Определить по таблице sales.orders количество заказов ,
--    сделанных за каждый день 2008 года при помощи группировки
   
SELECT o.orderdate, COUNT(o.orderid) count
FROM sales.orders o
WHERE YEAR(o.orderdate) = 2008
GROUP BY o.orderdate
ORDER BY o.orderdate;

-- 10. Определить количество клиентов для empid каждого сотрудника
-- из таблицы sales.orders

SELECT empid, COUNT(DISTINCT custid) AS customer_count
FROM sales.orders
GROUP BY empid;

-- 11. Определить количество клиентов для каждого сотрудника
-- для каждого года работы

SELECT empid, YEAR(orderdate) AS order_year, COUNT(DISTINCT customerid) AS customer_count
FROM sales.orders
GROUP BY empid, YEAR(orderdate)
ORDER BY empid, order_year;
