--task1  (lesson2)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/
SELECT dep 'Department', emp 'Employee', sal 'Salary' FROM
    (SELECT d.name dep, e.name emp, e.salary sal,
    dense_rank() over (partition by d.id order by e.salary desc) as r
    FROM Employee e
    INNER JOIN Department d
    ON e.departmentId = d.id) a
WHERE a.r <= 3


--task2  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/17
SELECT 
    member_name, 
    status, 
    SUM(amount*unit_price) AS costs
FROM FamilyMembers AS fm
JOIN Payments AS p
    ON fm.member_id = p.family_member
WHERE YEAR(date) = 2005
GROUP BY member_name, status


--task3  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/13
SELECT name
FROM Passenger
GROUP BY name
HAVING COUNT(name) > 1 


--task4  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/38
SELECT COUNT(first_name) AS count
FROM Student
WHERE first_name='Anna' 


--task5  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/35
SELECT COUNT(classroom) AS count 
FROM Schedule
WHERE 
    YEAR(date) = 2019
    AND MONTH(date) = 9
    AND DAY(date) = 2 
    
    
--task6  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/38
-- было в task4
SELECT COUNT(first_name) AS count
FROM Student
WHERE first_name='Anna'


--task7  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/32
SELECT FLOOR(AVG(YEAR(CURRENT_DATE) - YEAR(birthday))) AS age 
FROM FamilyMembers


--task8  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/27
SELECT good_type_name, SUM(amount*unit_price) AS costs
FROM GoodTypes
JOIN Goods ON good_type_id = type
JOIN Payments ON good_id = good
WHERE YEAR(date) = 2005
GROUP BY good_type_name


--task9  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/37
SELECT MIN(TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE)) AS year
FROM Student


--task10  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/44
SELECT MAX(TIMESTAMPDIFF(YEAR, birthday, CURRENT_DATE)) AS max_year
FROM Student AS s
JOIN Student_in_class AS sic ON s.id = sic.student
JOIN Class AS c ON sic.class = c.id
WHERE c.name LIKE '10%'


--task11 (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/20
SELECT status, member_name, amount*unit_price AS costs FROM Payments p
JOIN Goods AS g ON p.good = g.good_id
JOIN GoodTypes AS gt ON g.type = gt.good_type_id
JOIN FamilyMembers AS fm ON p.family_member = fm.member_id
WHERE gt.good_type_name = 'entertainment'


--task12  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/55
DELETE FROM Company
WHERE Company.id IN (
    SELECT company FROM Trip 
    GROUP BY company
    HAVING count(id) = (
        SELECT min(count) 
        FROM (
            SELECT count(id) AS count
            FROM Trip
            GROUP BY company
        ) AS min_count
    )
)


--task13  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/45
SELECT classroom
FROM Schedule 
GROUP BY classroom
HAVING count(*) = (
    SELECT count(*)
    FROM Schedule
    GROUP BY classroom
    ORDER BY count(*) DESC 
    LIMIT 1
)


--task14  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/43
SELECT t.last_name FROM Teacher AS t
JOIN Schedule AS sch ON t.id = sch.teacher
JOIN Subject AS s ON sch.subject = s.id
WHERE s.name = 'Physical Culture'
ORDER BY t.last_name


--task15  (lesson2)
-- https://sql-academy.org/ru/trainer/tasks/63
SELECT CONCAT(
    last_name, '.',
    left(first_name,1), '.',
    left(middle_name,1), '.') AS name
FROM Student
ORDER BY name ASC
