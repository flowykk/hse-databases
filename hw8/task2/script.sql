-- 1. Вывести информацию из двух таблиц(firmid , firmname,
-- сумму величины value для каждой фирмы)
-- Firmvalues и Firms при помощи при помощи JOIN и группировки

SELECT  f.FirmId, f.FirmName, SUM(v.[Value]) AS TotalValue
FROM dbo.Firms f
JOIN dbo.FirmValues v ON f.FirmId = v.FirmId
GROUP BY f.FirmId, f.FirmName
ORDER BY f.FirmId;

-- 2. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
-- sales.orderdetails для каждого работника. Вывести фамилию , имя
-- и сумму. (Не забывать что работники находятcя в таблице hr.employees
-- и их данные связаны с таблицей sales.orderdetails через таблицу
-- sales.orders)

SELECT e.lastname, e.firstname, SUM(od.qty * od.unitprice * (1 - od.discount)) AS total
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN hr.employees e ON o.empid = e.empid
GROUP BY e.empid, e.lastname, e.firstname
ORDER BY e.lastname, e.firstname;

-- 3. Упражнение аналогичное предыдущему, только уже данные
-- вычисляются не для сотрудника а для клиента
-- Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
-- sales.orderdetails для каждого клиента. Вывести contactname
-- и сумму. (Не забывать что клиенты находятcя в таблице sales.customers
-- и их данные связаны с таблицей sales.orderdetails через таблицу
-- sales.orders)

SELECT c.contactname, SUM(od.qty * od.unitprice * (1 - od.discount)) AS TotalAmount
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
JOIN sales.customers c ON o.custid = c.custid
GROUP BY c.custid, c.contactname
ORDER BY c.contactname;

-- 4. Вывести сумму произведения qty*unitprice*(1-discount) из таблицы
-- sales.orderdetails для каждого заказа. Вывести еще номер заказа
-- и дату заказа 

SELECT o.orderid, o.orderdate, SUM(od.qty * od.unitprice * (1 - od.discount)) AS total
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY o.orderid;

-- 5. Вывести сумму произведения qty*unitprice*(1-discount)
-- из таблицы sales.orderdetails для каждого года, месяца и дня заказа.
-- выводить в запросе qty*unitprice*(1-discount), год, месяц и день

SELECT YEAR(o.orderdate) AS OrderYear, MONTH(o.orderdate) AS OrderMonth, DAY(o.orderdate) AS OrderDay, SUM(od.qty * od.unitprice * (1 - od.discount)) AS total
FROM sales.orderdetails od
JOIN sales.orders o ON od.orderid = o.orderid
GROUP BY YEAR(o.orderdate), MONTH(o.orderdate), DAY(o.orderdate)
ORDER BY OrderYear, OrderMonth, OrderDay;

-- 6. Сколько студетов учится в каждой группе?
-- Вывести id группы, наименование группы и количество студентов
-- в группе

SELECT g.gr_id, g.GroupName, COUNT(s.st_id) AS count
FROM dbo.Groups g
JOIN dbo.Students s ON g.gr_id = s.gr_id
GROUP BY g.gr_id, g.GroupName
ORDER BY g.gr_id;
