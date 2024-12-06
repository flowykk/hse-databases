## 1. Написать функцию вычисления площади прямоугольника функция получает два параметра - длину и ширину прямоугольника

```sql
CREATE FUNCTION CalculateRectangleArea (@length DECIMAL(12,2), @width DECIMAL(12,2))
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN @length * @width
END

SELECT dbo.CalculateRectangleArea(10.5, 5.3) AS RectangleArea;
```

![Screenshot 2024-12-06 at 09 24 00](https://github.com/user-attachments/assets/87b9cfd5-a511-4883-8227-a14821fc5d95)

## 2. Написать функцию вычисления объема параллелепипеда в функцию передается длина , ширина, высота. Функция вычисляет объем

```sql
CREATE FUNCTION CalculateCuboidVolume (@length DECIMAL(12,2), @width DECIMAL(12,2), @height DECIMAL(12,2))
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN @length * @width * @height
END

SELECT dbo.CalculateCuboidVolume(10.5, 5.3, 3.2) AS CuboidVolume;
```

![Screenshot 2024-12-06 at 09 24 43](https://github.com/user-attachments/assets/1a29fe96-809e-4f37-8574-4284c1c60f26)

## 3. Написать функцию вычисления среднего значения от суммы последовательных чисел от 1 до n. Функция принимает значение n decimal(12,2) и возвращает среднее значение суммы чисел.

```sql
CREATE FUNCTION dbo.CalculateAverageSum(
@N DECIMAL(12, 2)
)
RETURNS DECIMAL(12, 2)
AS
BEGIN
RETURN (@N * (@N + 1) / 2) / @N;
END;
```

![Screenshot 2024-12-06 at 09 26 14](https://github.com/user-attachments/assets/6d12c9f4-237c-45d8-ba9f-13f3d7852b99)

## 4. Написать функцию вычисления сложного процента. В функцию передается сумма value типа DECIMAL(12.2), значение процента pers в виде числа с плавающей точкой, например 0.20 и количества лет для вычисления.

```sql
CREATE FUNCTION CalculateCompoundInterest (@value DECIMAL(12,2), @pers FLOAT, @years INT)
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN @value * POWER(1 + @pers, @years)
END

SELECT dbo.CalculateCompoundInterest(1000, 0.05, 3) AS CompoundInterest;
```

![Screenshot 2024-12-06 at 09 26 59](https://github.com/user-attachments/assets/31f6d171-c28e-4b6f-859c-102fd0b05460)

## 5 Решить задачу 4. при условии, что на второй год проценты возрастают на пятую часть об своего предыдущего значения.

```sql
CREATE FUNCTION CalculateCompoundInterestWithIncrease (@value DECIMAL(12,2), @pers FLOAT, @years INT)
RETURNS DECIMAL(12,2)
AS
BEGIN
    DECLARE @result DECIMAL(12,2)
    DECLARE @i INT
    SET @result = @value
    SET @i = 1
    
    WHILE @i <= @years
    BEGIN
        SET @result = @result * (1 + @pers)
        
        IF @i = 2
        BEGIN
            SET @pers = @pers + (@pers * 0.2)
        END
        
        SET @i = @i + 1
    END
    
    RETURN @result
END

SELECT dbo.CalculateCompoundInterestWithIncrease(1000, 0.05, 3) AS CompoundInterest;
```

![Screenshot 2024-12-06 at 09 41 02](https://github.com/user-attachments/assets/4c68cbed-f540-4767-8c25-c4672bb6a5f3)

## 6. Написать функцию, вычисляющую степень числа. В функцию передается число value типа DECIMAL(12,3) и показатель степени n типа INT. Функция возвращает число типа DECIMAL(12,3)

```sql
CREATE FUNCTION CalculatePower (@value DECIMAL(12,3), @n INT)
RETURNS DECIMAL(12,3)
AS
BEGIN
    RETURN POWER(@value, @n)
END

SELECT dbo.CalculatePower(2.5, 3) AS PowerResult;
```

![Screenshot 2024-12-06 at 09 27 47](https://github.com/user-attachments/assets/37747c32-9288-4c1e-b1cd-15bed1376a96)

## 7. Написать хранимую процедуру получения среднего значения для четных чисел  целого числа n. Среднее значение вычисляется как сумма последовательных четных чисел от 1 до n поделенная на количество цифр, составляющих эту сумму. Алгоритм реализовать при помощи создания временной таблицы и вычисления среднего значения ее поля.

```sql
CREATE PROCEDURE CalculateEvenAverage (@n INT)
AS
BEGIN
    CREATE TABLE #EvenNumbers (Number INT)
    
    DECLARE @i INT = 2
    WHILE @i <= @n
    BEGIN
        INSERT INTO #EvenNumbers (Number) VALUES (@i)
        SET @i = @i + 2
    END

    SELECT AVG(Number) AS Average FROM #EvenNumbers

    DROP TABLE #EvenNumbers
END

EXEC dbo.CalculateEvenAverage 10;
```

![Screenshot 2024-12-06 at 09 28 23](https://github.com/user-attachments/assets/b60056c0-fc37-41db-953e-3b4e2304d66e)

## 8. Написать хранимую процедуру, которая получает на вход фамилию сотрудника и вычисляет среднее значение произведения qty*unitprice*(1-discount) для таблицы sales.orderdetails базы данных tsql2012

```sql
CREATE PROCEDURE CalculateAvgProductValue (@lastName VARCHAR(50))
AS
BEGIN
    SELECT AVG(qty * unitprice * (1 - discount)) AS AverageValue
    FROM sales.orderdetails od
    JOIN sales.orders o ON od.orderid = o.orderid
    JOIN hr.employees e ON e.empid = o.empid
    WHERE e.lastname = @lastName;
END


EXEC dbo.CalculateAvgProductValue 'Smith';
```

![Screenshot 2024-12-06 at 09 38 39](https://github.com/user-attachments/assets/749a5b4b-c061-4bff-b1c3-f8ba8a03010e)

## 9. Написать триггер типа AFTER для таблицы из трех полей AfterT

```sql
CREATE TABLE AfterT (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Value DECIMAL(12,2)
);

CREATE TRIGGER AfterInsertTrigger
ON AfterT
AFTER INSERT
AS
BEGIN
    PRINT 'Данные были вставлены:'
    SELECT * FROM INSERTED;
END;

CREATE TRIGGER AfterUpdateTrigger
ON AfterT
AFTER UPDATE
AS
BEGIN
    PRINT 'Данные были обновлены:'
    SELECT * FROM INSERTED;
END;

CREATE TRIGGER AfterDeleteTrigger
ON AfterT
AFTER DELETE
AS
BEGIN
    PRINT 'Данные были удалены:'
    SELECT * FROM DELETED;
END;
```

### Для проверки триггера dbo.AfterInsertTrigger

```sql
INSERT INTO AfterT (ID, Name, Value) VALUES (1, 'Product1', 100.50);
```

![Screenshot 2024-12-06 at 09 42 08](https://github.com/user-attachments/assets/00f4ffcb-c49b-4eac-bdaf-11615ed5cbca)

### Для проверки триггера dbo.AfterUpdateTrigger

```sql
UPDATE AfterT SET Value = 150.75 WHERE ID = 1;
```

![Screenshot 2024-12-06 at 09 42 37](https://github.com/user-attachments/assets/a10848d0-0485-4d93-bd9f-9557038c3e84)

### Для проверки триггера dbo.AfterDeleteTrigger

```sql
DELETE FROM AfterT WHERE ID = 1;
```

![Screenshot 2024-12-06 at 09 42 44](https://github.com/user-attachments/assets/b1a50156-8de5-4c72-816d-34ec168f7a69)

## 10. Написать хранимую процедуру, которая выводит записи из таблицы sales.orderdetails для диапазона полных стоимостей(qty*unitprice*(1-discount)) от @v1 lj @v2 

```sql
CREATE PROCEDURE GetOrderDetailsByPriceRange (@v1 DECIMAL(12,2), @v2 DECIMAL(12,2))
AS
BEGIN
    SELECT *
    FROM tsql2012.sales.orderdetails
    WHERE qty * unitprice * (1 - discount) BETWEEN @v1 AND @v2
END

EXEC dbo.GetOrderDetailsByPriceRange 100, 500;
```

![Screenshot 2024-12-06 at 09 39 44](https://github.com/user-attachments/assets/24be9fd8-7b3f-4716-885f-dfe59771f8e4)

## 11. Написать хранимую процедуру постраничного вывода записей из таблицы tsql2012.sales.OrderDetails. В функцию передается начальное смещение для строки и количество выводимых на страницу записей

```sql
CREATE PROCEDURE GetOrderDetailsWithPaging (@offset INT, @limit INT)
AS
BEGIN
    SELECT *
    FROM tsql2012.sales.orderdetails od
    ORDER BY od.orderid
    OFFSET @offset ROWS FETCH NEXT @limit ROWS ONLY
END

EXEC dbo.GetOrderDetailsWithPaging 0, 10;
```

![Screenshot 2024-12-06 at 09 40 26](https://github.com/user-attachments/assets/bc1861c3-9afc-49cb-9419-77290e249d6a)
