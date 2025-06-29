1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT *
FROM `students`
WHERE `date_of_birth` LIKE "1990%"

2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT *
FROM `courses`
WHERE `cfu` > 10

3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT *
FROM `students`
WHERE TIMESTAMPDIFF(YEAR, `date_of_birth`, '2025-06-23') > 30;

OPPURE

SELECT *
FROM `students`
WHERE TIMESTAMPDIFF(YEAR, `date_of_birth`, CURDATE()) > 30;


4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di
laurea (286)
SELECT *
FROM `courses`
WHERE `period` = "I semestre" 
AND `year` = 1

5. Selezionare tutti gli appelli d esame che avvengono nel pomeriggio (dopo le 14) del
20/06/2020 (21)
SELECT *
FROM `exams`
WHERE `date` = "2020-06-20"
AND TIME(`hour`) > "14:00:00"

6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT *
FROM `degrees`
where `level` = "magistrale"

7. Da quanti dipartimenti è composta luniversità? (12)
SELECT *
FROM `departments`

8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT *
FROM `teachers`
where `phone` IS NULL


-- Seconda parte

1. SELECT `enrolment_date`, COUNT(*)
FROM `students`
GROUP BY `enrolment_date`

2. SELECT `office_address`, COUNT(*)
FROM `teachers`
GROUP BY `office_address`

3. SELECT `exam_id`, AVG(`vote`)
FROM `exam_student`
GROUP BY `exam_id`

4. SELECT `department_id`, COUNT(*)
FROM `degrees`
GROUP BY `department_id`


-- Terza parte
1. SELECT *
FROM `students`
INNER JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

2. SELECT *
FROM `degrees`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `degrees`.`level` = 'magistrale'
AND `departments`.`name` = 'Dipartimento di Neuroscienze';

3. SELECT *
FROM `courses`
INNER JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `course_teacher`.`teacher_id` = 44;

4. SELECT 
    students.*,
    degrees.name AS degree_name,
    departments.name AS department_name
FROM students
INNER JOIN degrees ON students.degree_id = degrees.id
INNER JOIN departments ON degrees.department_id = departments.id
ORDER BY students.surname ASC, students.name ASC;

5. SELECT 
    degrees.name AS degree_name,
    courses.name AS course_name,
    teachers.name AS teacher_name,
    teachers.surname AS teacher_surname
FROM degrees
INNER JOIN courses ON courses.degree_id = degrees.id
INNER JOIN course_teacher ON course_teacher.course_id = courses.id
INNER JOIN teachers ON teachers.id = course_teacher.teacher_id
ORDER BY degree_name, course_name, teacher_surname;

6. SELECT DISTINCT teachers.*
FROM teachers
INNER JOIN course_teacher ON course_teacher.teacher_id = teachers.id
INNER JOIN courses ON courses.id = course_teacher.course_id
INNER JOIN degrees ON courses.degree_id = degrees.id
INNER JOIN departments ON degrees.department_id = departments.id
WHERE departments.name = 'Dipartimento di Matematica';