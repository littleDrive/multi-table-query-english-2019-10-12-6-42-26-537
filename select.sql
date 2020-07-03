# 1.Query the existence of 1 course
SELECT * FROM course WHERE id = 1;

# 2.Query the presence of both 1 and 2 courses
SELECT * FROM course WHERE id = 1 or id = 2;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
SELECT s.id, s.name, AVG(sc.score) as avg_score FROM
	student_course sc LEFT JOIN student s on sc.studentId = s.id
	GROUP BY sc.studentId
	HAVING AVG(sc.score) >= 60;

# 4.Query the SQL statement of student information that does not have grades in the student_course table
SELECT id,name,age,sex
    FROM student s LEFT JOIN student_course sc on s.id = sc.studentId
    WHERE score IS NULL

# 5.Query all SQL with grades
SELECT s.id AS id, s.`name` AS name,
	COUNT(sc.courseId) AS course_num, SUM(sc.score) AS allscore
	FROM student s , student_course sc
		WHERE s.id = sc.studentId
		GROUP BY s.id, s.`name`;

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
SELECT * FROM student WHERE id in (
	SELECT sc1.studentId FROM
		(SELECT * FROM student_course WHERE courseId = '1') as sc1,
		(SELECT * FROM student_course WHERE courseId = '2') as sc2
		WHERE sc1.studentId = sc2.studentId
);

# 7.Retrieve 1 student score with less than 60 scores in descending order
select s.* , sc.score score from student s, student_course sc
	where s.id = sc.studentId and sc.score < 60  and sc.courseId = '1'
	order by sc.score desc

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
SELECT courseId, AVG(score) score FROM student_course
 GROUP BY courseId
 ORDER BY score DESC, courseId ASC;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select s.name name , sc.score score
	from student s, student_course sc, course c
	where sc.studentId = s.id and sc.courseId = c.id
		and c.`name` = 'Math' and sc.score < 60