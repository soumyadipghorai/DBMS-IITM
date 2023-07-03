-- classroom with capacity < 100
SELECT DISTINCT(building) FROM classroom 
WHERE capacity < 100; 

-- by default 
SELECT ALL(building) FROM classroom
WHERE capacity < 100; 

-- list of student of department which have a budget < 0.1million 
SELECT S.name AS studentName, D.budget AS deptBudget FROM student AS S, department AS D 
WHERE S.dept_name = D.dept_name AND D.budget < 100000;

-- find the names of all instructor whose dept is finance or whose dept is in watson or taylor building 
SELECT name FROM instructor I, department D 
WHERE D.dept_name = I.dept_name 
AND I.dept_name = 'Finance' OR building IN ('Watson', 'Taylor');

-- find the titles of all courses wjose course_id has three alphabets indicating the dept 
SELECT title FROM course 
WHERE course_id LIKE "___-%";

-- obtain list of all students in alphabetic order of dept and within each dept in desc order of total credit 
SELECT name, dept_name, tot_cred FROM student 
ORDER BY dept_name ASC, tot_cred DESC;

-- Find course provided in fall and spring 
SELECT course_id FROM teaches
WHERE semester = 'Fall' AND yer = 2018 
UNION
SELECT course_id FROM teaches 
WHERE semester = 'Spring' AND year = 2018; 


-- instructor from comp sc and finance dept where salary < 80k
SELECT name FROM instructor
WHERE dept_name IN ('Comp sc', 'Finance')
INTERSECT 
SELECT name FROM instructor 
WHERE salary < 80000; 

-- instructor from comp sc and finance dept where salary < 90k and > 70k 
SELECT name FROM instructor
WHERE dept_name IN ('Comp sc', 'Finance')
EXCEPT  
SELECT name FROM instructor 
WHERE salary < 90000 AND salary > 70000; 

-- builsing with avg capacity > 25 
SELECT building, AVG(capacity) FROM classroom
GROUP BY building
HAVING AVG(capacity) > 25;

-- similarly you can use max, min, count, sum
