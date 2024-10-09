
USE TSQL2012
--SELECT с различной логикой запроса

## Выбрать из таблицы hr.employees информацию о сотруднике с empid = 4

```sql
SELECT * 
FROM [HR].[Employees]
WHERE empid = 4;

SELECT *
FROM [HR].[Employees]
WHERE empid = (SELECT 4); -- Использован подзапрос SELECT
```

![Screenshot 2024-10-10 at 00 29 15](https://github.com/user-attachments/assets/e1c58bbe-24b6-4488-bcd7-36d65f03ad60)

## Выбрать из таблицы hr.employees информацию о сотруднике с empid = 3 и о сотруднике с empid = 8

```sql
SELECT * 
FROM [HR].[Employees]
WHERE empid IN (3, 8);

SELECT * 
FROM [HR].[Employees]
WHERE empid = 3 OR empid = 8;
```

![Screenshot 2024-10-10 at 00 28 48](https://github.com/user-attachments/assets/2e63e073-5d88-470c-92b7-dd054b8200a2)

## Выбрать из таблицы hr.employees информацию о сотрудниках, у которых  empid >= 2 и empid <= 6

```sql
SELECT * 
FROM [HR].[Employees]
WHERE empid BETWEEN 2 AND 6;

SELECT * 
FROM [HR].[Employees]
WHERE empid >= 2 AND empid <= 6;
```

![Screenshot 2024-10-10 at 00 30 10](https://github.com/user-attachments/assets/863ceed7-85af-453a-b977-a3603dd14157)

## Выбрать из таблицы hr.employees информацию о сотрудниках, у которых  empid <= 3 и empid >= 6

```sql
SELECT * 
FROM [HR].[Employees]
WHERE empid <= 3 AND empid >= 6;
```

![Screenshot 2024-10-10 at 00 31 17](https://github.com/user-attachments/assets/e33b53f6-1ab8-40c6-847f-ebf48726a08e)

## Выбрать из таблицы hr.employees информацию о сотрудниках, у которых  empid >= 3 и empid <= 7 и empid <> 4

```sql
SELECT * 
FROM [HR].[Employees]
WHERE empid >= 3 AND empid <= 7 AND empid <> 4;

SELECT * 
FROM [HR].[Employees]
WHERE empid BETWEEN 3 AND 7 AND empid <> 4;
```

![Screenshot 2024-10-10 at 00 32 04](https://github.com/user-attachments/assets/9031cbd2-8d88-46e6-ad63-aab3415b70bc)

## Выбрать из таблицы hr.employees информацию о сотрудниках, у которых  empid >= 3 и empid <= 7 и empid <> 4 и empid = 9

```sql
-- Такой запрос не вернет данных, так как является бессмысленным
```

## Выбрать из таблицы hr.employees информацию о сотрудниках, которые родились в 1971 году

```sql
SELECT * 
FROM [HR].[Employees]
WHERE YEAR(BirthDate) = 1971;

SELECT * 
FROM [HR].[Employees]
WHERE BirthDate BETWEEN '1971-01-01' AND '1971-12-31';
```

![Screenshot 2024-10-10 at 00 35 23](https://github.com/user-attachments/assets/bb5c33c2-966d-4839-ac16-80b50b6a6bdb)

## Выбрать из таблицы hr.employees информацию о сотрудниках, которые родились в январе

```sql
SELECT * 
FROM [HR].[Employees]
WHERE MONTH(BirthDate) = 1;
```

![Screenshot 2024-10-10 at 00 35 57](https://github.com/user-attachments/assets/22edc0a7-d992-4606-ba39-321d87692c5d)
