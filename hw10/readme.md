## 1. Ранжировать учеников по баллам всех экзаменов испльзуя функцию DENDE_RANK()

```sql
SELECT ID, [name], class, points, subjects,
       DENSE_RANK() OVER (ORDER BY points DESC) AS rank
FROM exam;
```

![image](https://github.com/user-attachments/assets/03bb7b41-edda-4765-9de8-89bcaf8e1959)

## 2. Ранжировать учеников по баллам всех экзаменов испльзуя функцию RANK()

```sql
SELECT ID, [name], class, points, subjects,
       RANK() OVER (ORDER BY points DESC) AS rank
FROM exam;
```

![Screenshot 2024-11-21 at 11 23 15](https://github.com/user-attachments/assets/a26039e5-6c3c-45bf-bbf2-c9068dc1ddae)

## 3. Если хотим ранжировать всех учеников по классам

```sql
SELECT ID, [name], class, points, subjects,
       RANK() OVER (PARTITION BY class ORDER BY points DESC) AS rank
FROM exam;
```

![Screenshot 2024-11-21 at 11 23 55](https://github.com/user-attachments/assets/317c7df4-859f-4fcf-851b-512a01f2cde1)

## 4. Решить предыдущую задачу если мы хотим сделать сортировку, разбив по предметам(subjects) и в каждом предмете расположить учеников по возрастанию результатов

```sql
SELECT ID, [name], class, points, subjects,
       RANK() OVER (PARTITION BY subjects ORDER BY points ASC) AS rank
FROM exam;
```

![Screenshot 2024-11-21 at 11 24 27](https://github.com/user-attachments/assets/7b648925-9172-44a5-9da3-153df4101d99)

## 5. Разбить учащихся на 3 группы в зависимости от набранных баллов (функция NTILE)

```sql
SELECT ID, [name], class, points, subjects,
       NTILE(3) OVER (ORDER BY points DESC) AS group_num
FROM exam;
```

![Screenshot 2024-11-21 at 11 24 56](https://github.com/user-attachments/assets/fb359a02-c9f1-44d7-bc44-cd588486ea25)

## 6. Разбить учащихся на две группы для каждого из предметов(subjects), группы в порядке возрастания баллов

```sql
SELECT ID, [name], class, points, subjects,
       NTILE(2) OVER (PARTITION BY subjects ORDER BY points ASC) AS group_num
FROM exam;
```

![Screenshot 2024-11-21 at 11 25 35](https://github.com/user-attachments/assets/053c61cf-869b-4e95-a6db-f6318d9f1561)

## 7. Найти в каждом классе(class) одного лучшего по баллам ученика выыессти для них class, points,subjects, id, name

```sql
WITH RankedStudents AS (
    SELECT class, points, subjects, ID, [name], ROW_NUMBER() OVER (PARTITION BY class ORDER BY points DESC) AS rank
    FROM exam
)
SELECT class, points, subjects, ID, [name]
FROM RankedStudents
WHERE rank = 1;
```

![Screenshot 2024-11-21 at 11 32 43](https://github.com/user-attachments/assets/417a2a66-c114-4f5d-a375-5fe476727393)

## 8. Решить задачу предыдущую задачу но уже найти лучших не по классу , а по предмету(subjects)

```sql
WITH RankedStudents AS (
    SELECT subjects, points, class, ID, [name], ROW_NUMBER() OVER (PARTITION BY subjects ORDER BY points DESC) AS rank
    FROM exam
)
SELECT subjects, points, class, ID, [name]
FROM RankedStudents
WHERE rank = 1;
```

![Screenshot 2024-11-21 at 11 34 01](https://github.com/user-attachments/assets/8768824a-d0f5-45cc-98b5-d3e7116d95fc)

## 9. Показать результаты предыдущего и следующего ученика при сортировке по баллам(функции LAG() и LEAD())

```sql
SELECT ID, [name], class, points, subjects,
       LAG(points) OVER (ORDER BY points DESC) AS previous_points,
       LEAD(points) OVER (ORDER BY points DESC) AS next_points
FROM exam;
```

![Screenshot 2024-11-21 at 11 34 25](https://github.com/user-attachments/assets/1acda0d6-7d66-47ff-b8dd-037284b624cd)

## 10. Найти насколько при отсортированных данных следующие результаты отличаются от предыдущих по баллам в процентах, использовать функцию LAG()

```sql
SELECT ID, [name], class, points, subjects, LAG(points) OVER (ORDER BY points DESC) AS previous_points,
    CASE 
        WHEN LAG(points) OVER (ORDER BY points DESC) IS NOT NULL THEN 
            ((points - LAG(points) OVER (ORDER BY points DESC)) * 1.0 / LAG(points) OVER (ORDER BY points DESC)) * 100
        ELSE NULL
    END AS percentage_difference
FROM exam;
```

![Screenshot 2024-11-21 at 11 38 10](https://github.com/user-attachments/assets/e6a0dba8-d252-4e71-9d70-814893e383f5)

## 11. Найти насколько при отсортированных данных следующие результаты отличаются от предыдущих по баллам в процентах, использовать функцию LEAD()

```sql
SELECT ID, [name], class, points, subjects, LEAD(points) OVER (ORDER BY points DESC) AS next_points,
    CASE 
        WHEN LEAD(points) OVER (ORDER BY points DESC) IS NOT NULL THEN 
            ((LEAD(points) OVER (ORDER BY points DESC) - points) * 1.0 / points) * 100
        ELSE NULL
    END AS percentage_difference
FROM exam;
```

![Screenshot 2024-11-21 at 11 39 47](https://github.com/user-attachments/assets/31b8152b-09c8-46ac-b135-ce88e21ed328)

## 12. Определить баллы для каждого ученика и данные лучшего и самого отстающего по сравнению с рассматриваемым учеником для каждого предмета(Функции FIRST_VALUE и LAST_VALUE)

```sql
SELECT ID, [name], class, points, subjects,
       FIRST_VALUE(points) OVER (PARTITION BY subjects ORDER BY points DESC) AS best_points,
       LAST_VALUE(points) OVER (PARTITION BY subjects ORDER BY points DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS worst_points
FROM exam;
```

![Screenshot 2024-11-21 at 11 40 58](https://github.com/user-attachments/assets/11a2d699-0470-447f-853b-b733ed17e3d3)

## 13.Решить предыдущую задачу без оконных функций. Определить баллы для каждого ученика и данные лучшего и самого отстающего по сравнению с рассматриваемым учеником для каждого предмета без оконных функций традиционным методом

```sql
SELECT e1.ID, e1.[name], e1.class, e1.points, e1.subjects,
       (SELECT MAX(points) FROM exam e2 WHERE e2.subjects = e1.subjects) AS best_points,
       (SELECT MIN(points) FROM exam e2 WHERE e2.subjects = e1.subjects) AS worst_points
FROM exam e1;
```

![Screenshot 2024-11-21 at 11 41 19](https://github.com/user-attachments/assets/51068e1c-04d7-48e6-a4de-debf438569f3)

## 14. Определить баллы для каждого ученика и разницу между лучшим и самым отстающим по сравнению с рассматриваемым учеником для каждого класса

```sql
SELECT class, ID, [name], points,
       (SELECT MAX(points) FROM exam e2 WHERE e2.class = e1.class) - 
       (SELECT MIN(points) FROM exam e2 WHERE e2.class = e1.class) AS points_diff
FROM exam e1;
```

![Screenshot 2024-11-21 at 11 41 47](https://github.com/user-attachments/assets/792606ef-74d5-4466-99fe-429059c0dbf0)

## 15. Определить разницу в процентах для каждого ученика между его результатом и лучшим результатом по его предмету

```sql
SELECT ID, [name], class, points, subjects, MAX(points) OVER (PARTITION BY subjects) AS max_points_by_subject,
    CASE 
        WHEN MAX(points) OVER (PARTITION BY subjects) IS NOT NULL THEN 
            ((points - MAX(points) OVER (PARTITION BY subjects)) * 1.0 / MAX(points) OVER (PARTITION BY subjects)) * 100
        ELSE NULL
    END AS percentage_difference_from_best
FROM exam;
```

![Screenshot 2024-11-21 at 11 43 17](https://github.com/user-attachments/assets/555ec497-8b75-46c8-b0a5-0499a34794af)

## 16. Определить по каждому предмету сумму баллов и долю каждого ученика по отношению к данной сумме по каждому предмету

```sql
SELECT ID, [name], class, points, subjects, SUM(points) OVER (PARTITION BY subjects) AS total_points_by_subject,
    (100 * points * 1.0 / SUM(points) OVER (PARTITION BY subjects)) AS share_of_total_points
FROM exam;
```

![Screenshot 2024-11-21 at 11 44 18](https://github.com/user-attachments/assets/0473e7f0-6ff3-45d0-97ee-69efe7d733a0)

## 17. Определить по каждому классу сумму баллов и долю каждого ученика по отношению к данной сумме по каждому классу

```sql
SELECT ID, [name], class, points, subjects, SUM(points) OVER (PARTITION BY class) AS total_points_by_class,
    (100 * points * 1.0 / SUM(points) OVER (PARTITION BY class)) AS share_of_total_points
FROM exam;
```

![Screenshot 2024-11-21 at 11 44 53](https://github.com/user-attachments/assets/27f33a52-5c4a-4d0c-b9a4-ceeb79119a62)

## 18. Определить сколько учеников сдавало экзамен по каждому предмету, средний балл по каждому предмету отношение баллов каждого ученика к среднему баллу по каждому предмету

```sql
SELECT 
    subjects, 
    COUNT(ID) AS number_of_students, 
    AVG(points) AS average_points_by_subject,
    points * 1.0 / AVG(points) OVER (PARTITION BY subjects) AS share_of_average_points
FROM exam
GROUP BY subjects, points;
```

![Screenshot 2024-11-21 at 11 51 02](https://github.com/user-attachments/assets/1088352e-087a-4cbb-aa3e-7a2188ba7dc1)

## 19. БЕЗ ОКОННЫХ ФУНКЦИЙ. Определить сколько учеников сдавало экзамен по каждому предмету, средний балл по каждому предмету отношение баллов каждого ученика к среднему баллу по каждому предмету

```sql
SELECT e.subjects, stats.number_of_students, stats.average_points AS average_points_by_subject,
    e.points * 1.0 / stats.average_points AS share_of_average_points
FROM exam e
JOIN (
    SELECT subjects,COUNT(ID) AS number_of_students,AVG(points) AS average_points
    FROM exam
    GROUP BY subjects
) stats ON e.subjects = stats.subjects;
```

![Screenshot 2024-11-21 at 11 54 13](https://github.com/user-attachments/assets/8e0d084b-67a5-4660-8904-c1fcbcb2980e)

## 20. Определить доход и расход с нарастающим итогом

```sql
SELECT [Date], inmoney, outmoney,
       SUM(inmoney) OVER (ORDER BY [Date]) AS cumulative_inmoney,
       SUM(outmoney) OVER (ORDER BY [Date]) AS cumulative_outmoney
FROM [dbo].[money];
```

![Screenshot 2024-11-21 at 11 48 15](https://github.com/user-attachments/assets/6de76826-6d77-4241-a755-577e9a5416d6)

## 21. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом

```sql
SELECT [Date], inmoney, outmoney,
       SUM(inmoney) OVER (ORDER BY [Date]) - SUM(outmoney) OVER (ORDER BY [Date]) AS income_vs_expense
FROM [dbo].[money];
```

![Screenshot 2024-11-21 at 11 48 31](https://github.com/user-attachments/assets/b924f1c3-7968-46d0-92a6-e81236569fca)

## 22. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом для каждого года

```sql
SELECT YEAR([Date]) AS year, 
       SUM(inmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) AS cumulative_inmoney,
       SUM(outmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) AS cumulative_outmoney,
       SUM(inmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) - 
       SUM(outmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) AS income_vs_expense
FROM [dbo].[money];
```

![Screenshot 2024-11-21 at 11 48 50](https://github.com/user-attachments/assets/6824be75-dbf2-4a87-8ab2-067b3f122767)

## 23. Определить среднее значение за каждые три года дохода и расхода

```sql
SELECT YEAR([Date]) / 3 AS period, 
       AVG(inmoney) AS avg_inmoney, 
       AVG(outmoney) AS avg_outmoney
FROM [dbo].[money]
GROUP BY YEAR([Date]) / 3;
```

![Screenshot 2024-11-21 at 11 49 03](https://github.com/user-attachments/assets/7e8826de-83c0-4969-b293-f1f5e9c6e2b0)
