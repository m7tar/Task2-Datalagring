/* number of lessons each month */
--grouping all lesson types
CREATE VIEW all_lessons AS
SELECT 'group lesson' AS type, group_lesson.lesson_id, timeslot.start_time FROM group_lesson JOIN timeslot ON group_lesson.lesson_id = timeslot.lesson_id
UNION ALL
SELECT 'ensembles' AS type, ensembles.lesson_id, timeslot.start_time FROM ensembles JOIN timeslot ON ensembles.lesson_id = timeslot.lesson_id
UNION ALL
SELECT 'individual' AS type, include.id, timeslot.start_time FROM include JOIN timeslot ON timeslot.lesson_id = include.id;

-- filtering per year
CREATE VIEW lessons_in_2022 AS
SELECT TO_CHAR(start_time, 'Month') AS month, type, COUNT(*) AS number_of_lessons
FROM all_lessons WHERE EXTRACT(year FROM start_time) = 2022
GROUP BY month, type, EXTRACT(month FROM start_time)
ORDER BY EXTRACT(month FROM start_time);

*********************************************

/* show siblings of students*/
-- join tables student and sibling and count the rows where a student has a sibiling, the view created will be used in next query
CREATE VIEW siblings_per_student AS 
SELECT student.id,
COUNT(CASE WHEN sibling.sibling_student_id IS NOT NULL THEN 'has_sibling' END ) AS number_of_siblings
FROM student
LEFT JOIN sibling ON student.id = sibling.sibling_student_id
GROUP BY student.id
ORDER BY student.id;

-- shows the number of sibilings and how many students has that amount
SELECT number_of_siblings, count(*) AS number_of_students
       FROM siblings_per_student 
       GROUP BY number_of_siblings
       ORDER BY number_of_siblings;

*********************************************

/* show instructors lessons under a specific month with a specific amount of lessons */

CREATE VIEW instructor_lessons_per_month AS
SELECT 
lesson.instructor_id ,
    COUNT(*) AS amount_of_lesson 
    FROM lesson FULL JOIN timeslot ON lesson.id = timeslot.lesson_id
    WHERE EXTRACT (month FROM timeslot.start_time) = 7
    GROUP BY lesson.instructor_id
    HAVING COUNT(*) > 1 
    ;
	
**************************************************
/* number of ensembles showing next week with amount of seats */

CREATE MATERIALIZED VIEW lesson_next_week AS
    SELECT to_char(start_time, 'Day') as weekday, genre, start_time,
    
    CASE
        WHEN CAST(student_amount AS int) = CAST(max_amount_of_students AS int) THEN 'full'
        WHEN CAST(student_amount AS int) = CAST(max_amount_of_students AS int) - 1 THEN '1 seats left'
        WHEN CAST(student_amount AS int) = CAST(max_amount_of_students AS int) - 2 THEN '2 seats left'
        ELSE 'More than 2 seats left'
    END as seats_left
    FROM lesson INNER JOIN ensembles ON lesson.id = ensembles.lesson_id INNER JOIN timeslot ON lesson.id = timeslot.lesson_id
    WHERE date_trunc('week', start_time) = date_trunc('week', now()) + interval '1 week' ORDER BY genre, weekday;

