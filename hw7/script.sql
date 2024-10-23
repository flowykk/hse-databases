-- 1. Проверить запросом к таблицам groups и students нет ли в таблице groups групп, в которых не занимается ни один студент.

SELECT g.GroupName FROM groups g
LEFT JOIN students s
ON g.gr_id = s.gr_id
WHERE s.st_id IS NULL

-- 2. Объединить запросом две таблицы и вывести авторов и названия книг

SELECT a.au_lastname, b.b_name
FROM Authors a
JOIN books b
ON a.au_id = b.au_id

-- 3. Объединить при помощи JOIN таблицы [dbo].Classik и [dbo].Phrases и вывести все поля

SELECT *
FROM Classik c
JOIN Phrases p
ON c.classik_id = p.classik_id

-- 4. Вывести на экран при джойне двух таблиц Classik и Phrases крылатые выражения Горбачева

SELECT c.firstname, c.lastname, p.phrase
FROM Classik c
JOIN Phrases p
ON c.classik_id = p.classik_id
WHERE c.lastname = 'Gorbachev'

-- 5. Вывести на экран при соединении двух таблиц из задачи 2 выражения Горбачева и Зайцева

SELECT c.firstname, c.lastname, p.phrase
FROM Classik c
JOIN Phrases p
ON c.classik_id = p.classik_id
WHERE c.lastname IN ('Gorbachev', 'Zaytsev')

-- 6. Объединить при помощи JOIN две таблицы cities и regions и вывести все значения на экран

SELECT c.city_name, r.region_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id

-- 7. Вывести на экран запрос предыдущей задачи  для города Тьматаракань

SELECT c.city_name, r.region_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id
WHERE c.city_name = 'Tma Tarakan'

-- 8. Объединить при помощи JOIN две таблицы regions и streets и вывести район и его улицу, для района в котором есть улица похожая на выражение "спартак чемпион"

SELECT r.region_name, ss.street_name
FROM regions r
JOIN streets ss 
ON r.region_id = ss.region_id
WHERE ss.street_name LIKE '%spartak chempion%'

-- 9. Вывести значение города , его района и улицу , для города района и улицы, где есть выражение в названии улицы похожее на "даешь ля"

SELECT c.city_name, r.region_name, ss.street_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id
JOIN streets ss
ON r.region_id = ss.region_id
WHERE ss.street_name LIKE '%daesh lya%'

-- 10. Вывести значение города , его района и улицу , для города района и улицы, где есть выражение в названии улицы похожее на "ЗАГС"

SELECT c.city_name, r.region_name, ss.street_name
FROM cities c
JOIN regions r
ON c.city_id = r.city_id
JOIN streets ss
ON r.region_id = ss.region_id
WHERE ss.street_name LIKE '%zags%'

-- 11. Подсчитать сумму для поля qty таблицы Sales.OrderDetails базы данных TSQL2012

SELECT SUM(qty) AS TotalQuantity
FROM Sales.OrderDetails

-- 12. Определить записи со стоимостью , подсчитанную в таблице sales.orderdetails больше чем 50.5

SELECT * FROM Sales.OrderDetails
WHERE (unitprice * qty * (1 - discount)) > 50.5

-- 13. Подсчитать среднее выражение для произведения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для сотрудника по фамилии Peled (база tsql2012)
-- Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails HR.Employees

SELECT AVG(qty * unitprice * (1 - discount)) AS AverageSales
FROM Sales.OrderDetails od
JOIN Sales.Orders o ON od.orderid = o.orderid
JOIN HR.Employees e ON o.empid = e.empid
WHERE e.LastName = N'Пелед'

-- 14. Найти максимальное значение выражения qty * unitprice *(1-discount) в таблице Sales.OrderDetails для клиента у которого contactname = "Ray, Mike"(база tsql2012)
-- Указание: Сделать JOIN таблицы Sales.Orders Sales.OrderDetails Sales.Customers

SELECT MAX(qty * unitprice * (1 - discount)) AS MaxSales
FROM Sales.OrderDetails od
JOIN Sales.Orders o ON od.OrderID = o.OrderID
JOIN Sales.Customers c ON o.custid = c.custid
WHERE c.ContactName = 'Ray, Mike'

-- 15. Определить по таблицам sales.customers и sales.orders заказчиков, которые не сделали ни одного заказа(использовать LEFT JOIN)

SELECT c.custid, c.contactname, o.orderid
FROM Sales.Customers c
LEFT JOIN Sales.Orders o ON c.custid = o.custid
WHERE o.OrderID IS NULL

-- 16. Вывести информацию о сотрудниках и их заказах из таблиц hr.employees и sales.orders при помощи JOIN (вывести lastname, firstname, orderdate)

SELECT e.lastname, e.firstname, o.orderdate
FROM HR.Employees e
JOIN Sales.Orders o ON e.empid = o.empid

-- 17. Вывести информацию о клиентах и их заказах из таблиц sales.customers и sales.orders при помощи JOIN (вывести contactname, orderdate)

SELECT c.contactname, o.orderdate
FROM Sales.Customers c
JOIN Sales.Orders o ON c.custid = o.custid
