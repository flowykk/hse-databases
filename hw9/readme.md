## 1. Определить количество клиентов с которыми оформлял заказ каждый сотрудник. Использовать таблицы sales.orders и hr.Employees .Вывести фамилию , имя сотрудника и количество клиентов. Решить задачу тремя способами при помощи изолированного подзапроса, при помощи коррелированного подзапроса, при помощи JOIN и группировки

## 1.1. Изолированный подзапрос

```sql
SELECT e.LastName, e.FirstName, (SELECT COUNT(DISTINCT custid) 
     FROM sales.Orders) AS ClientCount
FROM hr.Employees e;
```

![Screenshot 2024-11-10 at 17 46 22](https://github.com/user-attachments/assets/cbc875aa-d349-4c99-9d1c-827ac28dd786)

## 1.2. Коррелированный подзапрос

```sql
SELECT e.LastName, e.FirstName, (SELECT COUNT(DISTINCT o.custid) 
     FROM sales.Orders o
     WHERE o.EmpID = e.EmpID) AS ClientCount
FROM hr.Employees e;
```
![Screenshot 2024-11-10 at 17 49 24](https://github.com/user-attachments/assets/bc8b5272-4a58-4f08-87f1-341ca0aeff8e)

## 1.3. JOIN и группировка

```sql
SELECT e.LastName, e.FirstName, COUNT(DISTINCT o.custid) AS ClientCount
FROM hr.Employees e
JOIN sales.Orders o ON e.EmpID = o.EmpID
GROUP BY e.LastName, e.FirstName;
```

![Screenshot 2024-11-10 at 17 47 57](https://github.com/user-attachments/assets/e0f7b643-c50d-4985-9bc0-246a835a23c9)

## 2. Та же самая задача, но не повторять в учете одного и того же клиента

## 2.1. Изолированный подзапрос

```sql
SELECT e.lastname, e.firstname, (SELECT COUNT(DISTINCT o.custid)
     FROM Sales.Orders AS o
     WHERE o.empid = e.empid) AS count
FROM HR.Employees AS e;
```

![Screenshot 2024-11-14 at 20 10 31](https://github.com/user-attachments/assets/877dc613-15de-4df2-bfe3-5feb9fdd39cc)

## 2.2. Коррелированного подзапроса

```sql
SELECT e.lastname, e.firstname, COUNT(DISTINCT o.custid) AS count
FROM HR.Employees AS e
LEFT JOIN Sales.Orders AS o ON e.empid = o.empid
GROUP BY e.empid, e.lastname, e.firstname;
```

![Screenshot 2024-11-14 at 20 10 45](https://github.com/user-attachments/assets/5606f466-a725-4236-a30a-04f0fefbd882)

## 2.3. JOIN и группировка

```sql
SELECT e.lastname, e.firstname, COUNT(DISTINCT o.custid) AS count
FROM HR.Employees AS e
JOIN Sales.Orders AS o ON e.empid = o.empid
GROUP BY e.empid, e.lastname, e.firstname;
```

![Screenshot 2024-11-14 at 20 10 54](https://github.com/user-attachments/assets/3701cbf0-45b3-47da-8d58-01b7695f0f2d)

## 3. Определить количество клиентов для каждого сотрудника для каждого года работы. Вывести фамилию , имя сотрудника и количество клиентов

```sql
SELECT e.LastName, e.FirstName, YEAR(o.OrderDate) AS OrderYear, COUNT(o.custid) AS ClientCount
FROM hr.Employees e
JOIN sales.Orders o ON e.EmpID = o.EmpID
GROUP BY e.LastName, e.FirstName, YEAR(o.OrderDate);
```

![Screenshot 2024-11-10 at 17 58 06](https://github.com/user-attachments/assets/eafd31fb-3e89-4965-8b77-d8d6b2697e64)


## 4. Та же самая задача, но не повторять в учете одного и того же клиента

```sql
SELECT e.LastName, e.FirstName, YEAR(o.OrderDate) AS OrderYear, COUNT(DISTINCT o.custid) AS ClientCount
FROM hr.Employees e
JOIN sales.Orders o ON e.EmpID = o.EmpID
GROUP BY e.LastName, e.FirstName, YEAR(o.OrderDate);
```

![Screenshot 2024-11-10 at 17 58 12](https://github.com/user-attachments/assets/25be42c9-9690-4a47-8b7c-83741597bb01)

## 5. Решить задачу на отсутствие определенных чисел в таблице

### Нахождение отсутствующих чисел между 2 и 4 в `MyNumbers`

```sql
CREATE TABLE MyNumbers (
    num INT
);

INSERT INTO MyNumbers (num) VALUES (1), (2), (4), (5);

WITH AllNumbers AS (
    SELECT 2 AS num UNION ALL
    SELECT 3 UNION ALL
    SELECT 4
)

SELECT num
FROM AllNumbers
WHERE num NOT IN (SELECT num FROM MyNumbers);
```

![Screenshot 2024-11-10 at 17 59 53](https://github.com/user-attachments/assets/be92297a-6127-40a0-b36d-55873b18ffc4)

## 6. Определить сумму qty из таблицы sales.OrderDetails и фамилии работников из таблицы hr.employees , у которых есть в фамилии буква 'и' при помощи трех известных методов
   
## 6.1 Коррелированный подзапрос

```sql
SELECT 
    e.LastName,
    (SELECT SUM(od.qty)
     FROM sales.OrderDetails od
     JOIN sales.Orders o ON od.OrderID = o.OrderID
     WHERE o.EmpID = e.EmpID) AS qty
FROM hr.Employees e
WHERE e.LastName LIKE N'%и%';
```

![Screenshot 2024-11-10 at 19 33 41](https://github.com/user-attachments/assets/fed3c44d-d3c5-4fad-b0a3-d8fece087e65)

## 6.2 JOIN и группировка

```sql
SELECT 
    e.LastName,
    SUM(od.Qty) AS qty
FROM hr.Employees e
JOIN sales.Orders o ON e.EmpID = o.EmpID
JOIN sales.OrderDetails od ON o.OrderID = od.OrderID
WHERE e.LastName LIKE N'%и%'
GROUP BY e.LastName;
```

![Screenshot 2024-11-10 at 19 34 01](https://github.com/user-attachments/assets/04e76691-c500-4961-944d-3b36db231681)
