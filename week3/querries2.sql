-- find course oddered in fall 2009 but not in spring 2010
SELECT DISTINCT(course_id) FROM section
WHERE semester = 'Fall' AND year = 2009 AND
course_id NOT IN (
    SELECT course_id FROM section
    WHERE semester = 'Spring' AND year = 2010
);

-- find the total num of distinct students wh9o have taken course sections taught by the instructor with ID 10101
SELECT COUNT(DISTINCT(ID)) FROM takes 
WHERE (course_id, sec_id, semester, year) IN (
    SELECT course_id, sec_id, semester, year FROM teaches
    WHERE teaches.ID = 10101
);

-- find names of instructor with salary greater than that of some instructor in the biology dept 
SELECT DISTINCT(T.name) FROM instructor AS T, instructor AS S FULL 
WHERE T.salary > S.salary AND S.department_name = 'Biology'; 

SELECT name FROM instructor
WHERE salary > SOME(
    SELECT salary FROM instructor 
    WHERE department_name = 'Biology'
);

-- find the name of all instructor whose salary is greater than the salary of all instructor in the biology dept  
SELECT name FROM instructor
WHERE salary > ALL(
    SELECT salary FROM instructor
    WHERE dept_name = 'Biology'
);

-- find all courses taught in both the fall 2009 and in spring 2010
SELECT course_id FROM section AS S
WHERE semester = 'Fall' AND year = 2009 AND
EXISTS (
    SELECT * FROM section AS T 
    WHERE semester = 'Spring' AND year = 2010 AND S.course_id = T.course_id
);

-- find all student who have taken all curses offered in the biology dept 
SELECT DISTINCT(S.ID), S.name FROM student AS S 
WHERE NOT EXISTS (
    SELECT course_id FROM course 
    WHERE dept_name = 'Biology' EXCEPT (
        SELECT T.course_id FROM takes AS T 
        WHERE S.ID = T.ID
    )
);

-- find all course that were offered at most once in 2009
SELECT T.course_id FROM course AS T 
WHERE UNIQUE (
    SELECT R.course_id FROM section AS R 
    WHERE T.course_id = R.course_id AND R.year = 2009
);

-- find all instructors salaries of those dept where the avg salary is > 42000 
SELECT dept_name, avg_salary FROM (
    SELECT dept_name, AVG(salary) AS avg_salary FROM instructor 
    GROUP BY dept_name
) AS T 
WHERE avg_salary > 42000;

-- find all dept with the max budget 
WITH max_budget(value) AS (
    SELECT MAX(budget) AS value FROM department
)
SELECT D.name FROM department AS D, max_budget AS M
WHERE D.budget = M.value;

-- list of all dept along with the num of instructors in each dept 
SELECT dept_name, (
    SELECT COUNT(*) FROM instructor I
    WHERE D.dept_name = I.dept_name
) AS num_instructor FROM department D;

-- modifying database

-- ######### delete #########


-- delete tuples in the instructor for those instructors associated with a dept in Watson building 
DELETE FROM instructor 
WHERE dept_name IN (
    SELECT dept_name FROM department
    WHERE building = 'Watson'
);

-- now there is an issue, as you delete entries from the instructor table the avg also changes 
-- so it can't be done like this 
DELETE FROM instructor 
WHERE salarY < (
    SELECT AVG(salary) FROM instructor 
);

-- so we have to calculate the avg first and then store it somewhere 
-- and then use that value to delete entries from instructors


-- ######### insert #########

-- this syntax is more explainatory
INSERT INTO course (course_id, title, dept_name, credit) VALUES (
    'CS-437', 'DBMS', 'Comp sc', NULL
);

-- add all instructors to the student table with tot_creds set to 0
INSERT INTO student 
SELECT ID, name, dept_name, 0 FROM instructor;



-- ######### update #########

-- 3% raise to salary of instructors with a salary > 100k and 5% raise for salary < 100k
UPDATE instructor 
    SET salary = salary * 1.03
    WHERE salary > 100000;

UPDATE instructor 
    SE salary = salary * 1.05
    WHERE salary <= 100000;

-- now it might happen that the updated values from the 1st update get into the 2nd update 
-- so here its better to use case statement 
UPDATE instructor
    SET salary = 
    CASE 
        WHEN salary <= 100000 THEN salary*1.05
        ELSE salary * 1.03
    END;

-- update with scalar subquerries 
-- recompute and update tot_credit value for all student 
UPDATE student S 
    SET tot_cred = (
        SELECT CASE 
            WHEN SUM(credit) IS NOT NULL THEN SUM(credit)
            ELSE 0
        END 
        FROM takes, course 
        WHERE takes.course_id = course.course_id 
        AND S.ID = takes.ID 
    );

