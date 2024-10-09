## 1. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers] показать  все записи, где поле region равно NULL

```sql
SELECT * 
FROM [Production].[Suppliers]
WHERE region IS NULL;
```

<img width="1561" alt="Screenshot 2024-10-09 at 16 05 25" src="https://github.com/user-attachments/assets/095963ba-d116-450b-b0cd-f7e140900335">

## 2. Из базы данных TSQL 2012 из таблицы [Production].[Suppliers] показать все записи где поле region не равно NULL

```sql
SELECT * 
FROM [Production].[Suppliers]
WHERE region IS NOT NULL;
```

<img width="1629" alt="Screenshot 2024-10-09 at 16 06 33" src="https://github.com/user-attachments/assets/4ab7413f-cd38-4d1f-bafe-e36769b56886">

## 3. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, состоящие из четырех букв (Указание - любая буква это подчеркивание)

```sql
SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE '____';  -- Подчеркивание = любой букве
```

<img width="151" alt="Screenshot 2024-10-09 at 16 08 05" src="https://github.com/user-attachments/assets/5d62cf6b-314b-409f-81a9-c0759ac71605">

## 4. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, начинающиеся с Ca(Ка).

```sql
SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE N'Ка%'; -- Префикс N перед строковыми литералами, чтобы указывать, что строка является юникодом
```

<img width="157" alt="Screenshot 2024-10-09 at 16 21 02" src="https://github.com/user-attachments/assets/15b03fec-1b43-48ac-b50b-ebbc221ebb68">

## 5. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, заканчивающиеся на ed(ед).

```sql
SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE N'%ед'; -- Префикс N перед строковыми литералами, чтобы указывать, что строка является юникодом
```

<img width="149" alt="Screenshot 2024-10-09 at 16 22 02" src="https://github.com/user-attachments/assets/a05fede5-c38f-425a-8f76-3e768eb4ecb2">

## 6. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, содержащие ele(еле).

```sql
SELECT LastName
FROM [HR].[Employees]
WHERE LastName LIKE N'%еле%'; -- Префикс N перед строковыми литералами, чтобы указывать, что строка является юникодом
```

<img width="149" alt="Screenshot 2024-10-09 at 16 22 23" src="https://github.com/user-attachments/assets/937c79b9-f251-4181-98e3-2707104a4ee7">

## 7. Найти все фамилии в таблице [HR].Employees базы данных TSQL 2012, которые не начинаются с букв ABCDE(АБВГД).

```sql
SELECT LastName
FROM [HR].[Employees]
WHERE LastName NOT LIKE N'[А-Д]%';  -- Оператор "[A-E]" исключает фамилии, начинающиеся с этих букв
```

<img width="152" alt="Screenshot 2024-10-09 at 16 23 38" src="https://github.com/user-attachments/assets/fb962ad6-e222-4b74-a6af-698985c14b3b">

## 8.0 Выбрать из таблицы Task значения price так, чтобы они не повторялись

```sql
```

## 8.1 Получить сумму значений в таблице task для поля price

```sql
```

## 8.2 Получить среднее значение в таблице task для поля price

```sql
```

## 8.3 Выбрать все значения из таблицы task и отсортировать их по полю price в порядке убывания

```sql
```

## 9 Подсчитать максимальное значение в таблице Sales.OrderDetails для выражения qty * unitprice *(1-discount) для orderid = 10250

```sql
```

## 10. Для базы данных tsql2012 в таблице sales.orderdetails. Посчитать сумму значений qty для orderid = 10248

```sql
```

## 11. Для таблицы hr.employees определить всех работников, которые родились в 1970 и 1973 годах

```sql
```
