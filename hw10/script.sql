-- 1. Ранжировать учеников по баллам всех экзаменов испльзуя функцию DENDE_RANK()
SELECT ID, [name], class, points, subjects,
       DENSE_RANK() OVER (ORDER BY points DESC) AS rank
FROM exam;

-- 2. Ранжировать учеников по баллам всех экзаменов испльзуя функцию RANK()
SELECT ID, [name], class, points, subjects,
       RANK() OVER (ORDER BY points DESC) AS rank
FROM exam;

-- 3. Если хотим ранжировать всех учеников по классам
SELECT ID, [name], class, points, subjects,
       RANK() OVER (PARTITION BY class ORDER BY points DESC) AS rank
FROM exam;

-- 4. Решить предыдущую задачу если мы хотим сделать сортировку,
-- разбив по предметам(subjects) и в каждом предмете расположить
-- учеников по возрастанию результатов
SELECT ID, [name], class, points, subjects,
       RANK() OVER (PARTITION BY subjects ORDER BY points ASC) AS rank
FROM exam;

-- 5. Разбить учащихся на 3 группы в зависимости от набранных
-- баллов (функция NTILE)
SELECT ID, [name], class, points, subjects,
       NTILE(3) OVER (ORDER BY points DESC) AS group_num
FROM exam;

-- 6. Разбить учащихся на две группы для каждого из предметов(subjects),
-- группы в порядке возрастания баллов
SELECT ID, [name], class, points, subjects,
       NTILE(2) OVER (PARTITION BY subjects ORDER BY points ASC) AS group_num
FROM exam;

-- 7. Найти в каждом классе(class) одного лучшего по баллам ученика 
-- выыессти для них class, points,subjects, id, name
WITH RankedStudents AS (
    SELECT class, points, subjects, ID, [name], ROW_NUMBER() OVER (PARTITION BY class ORDER BY points DESC) AS rank
    FROM exam
)
SELECT class, points, subjects, ID, [name]
FROM RankedStudents
WHERE rank = 1;

-- 8. Решить задачу предыдущую задачу но уже найти лучших 
-- не по классу , а по предмету(subjects)
WITH RankedStudents AS (
    SELECT subjects, points, class, ID, [name], ROW_NUMBER() OVER (PARTITION BY subjects ORDER BY points DESC) AS rank
    FROM exam
)
SELECT subjects, points, class, ID, [name]
FROM RankedStudents
WHERE rank = 1;

-- 9. Показать результаты предыдущего и следующего
-- ученика при сортировке по баллам(функции LAG() и LEAD())
SELECT ID, [name], class, points, subjects,
       LAG(points) OVER (ORDER BY points DESC) AS previous_points,
       LEAD(points) OVER (ORDER BY points DESC) AS next_points
FROM exam;

-- 10. Найти насколько при отсортированных данных следующие
-- результаты отличаются от предыдущих по баллам в процентах ,
-- использовать функцию LAG()
SELECT ID, [name], class, points, subjects, LAG(points) OVER (ORDER BY points DESC) AS previous_points,
    CASE 
        WHEN LAG(points) OVER (ORDER BY points DESC) IS NOT NULL THEN 
            ((points - LAG(points) OVER (ORDER BY points DESC)) * 1.0 / LAG(points) OVER (ORDER BY points DESC)) * 100
        ELSE NULL
    END AS percentage_difference
FROM exam;

-- 11. Найти насколько при отсортированных данных следующие
-- результаты отличаются от предыдущих по баллам в процентах ,
-- использовать функцию LEAD()
SELECT ID, [name], class, points, subjects, LEAD(points) OVER (ORDER BY points DESC) AS next_points,
    CASE 
        WHEN LEAD(points) OVER (ORDER BY points DESC) IS NOT NULL THEN 
            ((LEAD(points) OVER (ORDER BY points DESC) - points) * 1.0 / points) * 100
        ELSE NULL
    END AS percentage_difference
FROM exam;

-- 12. Определить баллы для каждого ученика и данные лучшего и самого отстающего
-- по сравнению с рассматриваемым учеником для каждого предмета(Функции FIRST_VALUE и LAST_VALUE)
SELECT ID, [name], class, points, subjects,
       FIRST_VALUE(points) OVER (PARTITION BY subjects ORDER BY points DESC) AS best_points,
       LAST_VALUE(points) OVER (PARTITION BY subjects ORDER BY points DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS worst_points
FROM exam;

-- 13.Решить предыдущую задачу без оконных функций.
-- Определить баллы для каждого ученика и данные лучшего и самого отстающего
-- по сравнению с рассматриваемым учеником для каждого предмета без
-- оконных функций традиционным методом
SELECT e1.ID, e1.[name], e1.class, e1.points, e1.subjects,
       (SELECT MAX(points) FROM exam e2 WHERE e2.subjects = e1.subjects) AS best_points,
       (SELECT MIN(points) FROM exam e2 WHERE e2.subjects = e1.subjects) AS worst_points
FROM exam e1;

-- 14. Определить баллы для каждого ученика и разницу между лучшим и самым отстающим
-- по сравнению с рассматриваемым учеником для каждого класса
SELECT class, ID, [name], points,
       (SELECT MAX(points) FROM exam e2 WHERE e2.class = e1.class) - 
       (SELECT MIN(points) FROM exam e2 WHERE e2.class = e1.class) AS points_diff
FROM exam e1;

-- 15. Определить разницу в процентах для каждого ученика между его результатом и 
-- и лучшим результатом по его предмету
SELECT ID, [name], class, points, subjects, MAX(points) OVER (PARTITION BY subjects) AS max_points_by_subject,
    CASE 
        WHEN MAX(points) OVER (PARTITION BY subjects) IS NOT NULL THEN 
            ((points - MAX(points) OVER (PARTITION BY subjects)) * 1.0 / MAX(points) OVER (PARTITION BY subjects)) * 100
        ELSE NULL
    END AS percentage_difference_from_best
FROM exam;

-- 16. Определить по каждому предмету сумму баллов и долю каждого ученика по отношению
-- к данной сумме по каждому предмету
SELECT ID, [name], class, points, subjects, SUM(points) OVER (PARTITION BY subjects) AS total_points_by_subject,
    (100 * points * 1.0 / SUM(points) OVER (PARTITION BY subjects)) AS share_of_total_points
FROM exam;

-- 17. Определить по каждому классу сумму баллов и долю каждого ученика по отношению
-- к данной сумме по каждому классу
SELECT ID, [name], class, points, subjects, SUM(points) OVER (PARTITION BY class) AS total_points_by_class,
    (100 * points * 1.0 / SUM(points) OVER (PARTITION BY class)) AS share_of_total_points
FROM exam;

-- 18. Определить сколько учеников сдавало экзамен по каждому предмету,
-- средний балл по каждому предмету
-- отношение баллов каждого ученика к среднему баллу по каждому предмету
SELECT 
    subjects, 
    COUNT(ID) AS number_of_students, 
    AVG(points) AS average_points_by_subject,
    points * 1.0 / AVG(points) OVER (PARTITION BY subjects) AS share_of_average_points
FROM exam
GROUP BY subjects, points;

-- 19. БЕЗ ОКОННЫХ ФУНКЦИЙ. Определить сколько учеников сдавало экзамен по каждому предмету,
-- средний балл по каждому предмету
-- отношение баллов каждого ученика к среднему баллу по каждому предмету
SELECT e.subjects, stats.number_of_students, stats.average_points AS average_points_by_subject,
    e.points * 1.0 / stats.average_points AS share_of_average_points
FROM exam e
JOIN (
    SELECT subjects,COUNT(ID) AS number_of_students,AVG(points) AS average_points
    FROM exam
    GROUP BY subjects
) stats ON e.subjects = stats.subjects;

-- 20. Определить доход и расход с нарастающим итогом
SELECT [Date], inmoney, outmoney,
       SUM(inmoney) OVER (ORDER BY [Date]) AS cumulative_inmoney,
       SUM(outmoney) OVER (ORDER BY [Date]) AS cumulative_outmoney
FROM [dbo].[money];

-- 21. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом
SELECT [Date], inmoney, outmoney,
       SUM(inmoney) OVER (ORDER BY [Date]) - SUM(outmoney) OVER (ORDER BY [Date]) AS income_vs_expense
FROM [dbo].[money];

-- 22. Определить разницу дохода с нарастающим итогом и расхода с нарастающим итогом
-- для каждого года
SELECT YEAR([Date]) AS year, 
       SUM(inmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) AS cumulative_inmoney,
       SUM(outmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) AS cumulative_outmoney,
       SUM(inmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) - 
       SUM(outmoney) OVER (PARTITION BY YEAR([Date]) ORDER BY [Date]) AS income_vs_expense
FROM [dbo].[money];

-- 23. Определить среднее значение за каждые три года дохода и расхода
SELECT YEAR([Date]) / 3 AS period, 
       AVG(inmoney) AS avg_inmoney, 
       AVG(outmoney) AS avg_outmoney
FROM [dbo].[money]
GROUP BY YEAR([Date]) / 3;
