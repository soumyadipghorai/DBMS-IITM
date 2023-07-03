-- Write an SQL statement to find the match number of the match held on '2020-05-15' and the name of the fourth referee who refereed that match.
WITH matchNumAndRef(match_num, name) AS (
    SELECT MR.match_num, R.name 
    FROM match_referees MR
    JOIN referees R 
    ON R.referee_id = MR.fourth_referee
)
SELECT MNR.match_num, MNR.name 
FROM matchNumAndRef MNR
JOIN matches M 
ON M.match_num = MNR.match_num 
WHERE M.match_date = '2020-05-15';

-- Write an SQL statement to find the name of the oldest player in the team named 'All Stars'.
SELECT P.name FROM players P 
JOIN teams T 
ON T.team_id = P.team_id 
WHERE T.name = 'All Stars'
ORDER BY P.dob LIMIT 1; 

-- Write an SQL statement to find the name of the player who belongs from the team name 'Amigos'. 
SELECT P.name FROM players P 
JOIN teams T 
ON T.team_id = P.team_id 
WHERE T.name = 'Amigos';

-- Write an SQL statement to find department_code and member_type of the students who have issued (borrowed) books on '2021-08-02'.
WITH studentMember(department_code, member_type, member_no) AS (
    SELECT S.department_code, M.member_type, M.member_no
    FROM students S 
    JOIN members M
    ON M.roll_no = S.roll_no 
)
SELECT SM.department_code, SM.member_type FROM studentMember SM
JOIN book_issue BI 
ON SM.member_no = BI.member_no
WHERE BI.doi = '2021-08-02';

--  Write an SQL statement to find the book titles and the number of copies of the books which has the word 'Advanced' in their title.
SELECT BCA.title, COUNT(BCO.ISBN_no) FROM book_catalogue BCA
JOIN book_copies BCO 
ON BCO.ISBN_no = BCA.ISBN_no
WHERE BCA.title LIKE '%Advanced%'
GROUP BY BCA.title;