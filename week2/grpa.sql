-- Write an SQL statement to find the team_id of the players who were born before the year '2003'.
SELECT team_id FROM players 
WHERE dob < '2003-01-01' ;

-- Write an SQL statement to find the match numbers and fourth referees ID of the matches where assistant referee 1(assistant_referee_1) is 'R0002'.
SELECT match_num, fourth_referee FROM match_referees
WHERE assistant_referee_1 = 'R0002';

-- Write an SQL statement to find the names of players of the team: 'All Stars'.
SELECT P.name FROM players P 
JOIN teams T 
ON T.team_id = P.team_id 
WHERE T.name = 'All Stars';

-- Write an SQL statement to find the roll number and mobile number (roll_no, mobile_no) of students who belong to the department with department code as 'CS' and who were born after '2001-06-15'.
SELECT roll_no, mobile_no FROM students 
WHERE department_code = 'CS' AND dob > '2001-06-15';

-- Write an SQL statement to find faculty ID of the faculty who belongs to the department:'Mechanical Engineering' and joined on '2016-04-08'.
SELECT F.id FROM faculty F
JOIN departments D 
ON D.department_code = F.department_code 
WHERE department_name = 'Mechanical Engineering' AND F.doj = '2016-04-08';