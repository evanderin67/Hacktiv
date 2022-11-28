--Create and add data to Teacher Table
CREATE TABLE teachers (
    id SERIAL NOT NULL PRIMARY KEY ,
    first_name varchar(25) NOT NULL,
    last_name varchar(50),
    school varchar(50) NOT NULL,
    hire_date date,
    salary numeric
    );
	
INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
    VALUES ('Samuel', 'Abbers', 'Standford University', '2006-01-30', 32000),
           ('Jessica', 'Abbers', 'Standford University', '2005-01-30', 33000),
           ('Tom', 'Massi', 'Harvard University', '1999-09-09', 39500),
           ('Esteban', 'Brown', 'MIT', '2007-01-30', 36000),
           ('Carlos', 'Alonso', 'Standford University', '2001-01-30', 44000);

--Create and add data to Course Table   
CREATE TABLE courses (
    id serial NOT NULL PRIMARY KEY,
    name varchar(20),
    teachers_id INT,
    total_students INT
    );
	
INSERT INTO courses (name, teachers_id, total_students)
    VALUES  ('Calculus', 2, 20),
            ('Physics', 2, 10),
            ('Calculus', 1, 30),
            ('Computer Science', 1, 20),
            ('Politic', 13, 15),
            ('Algebra', 2, 10),
            ('Algebra', 13, 30),
            ('Computer Science', 10, 35),
            ('Life Science', 11, 20),
            ('Chemistry', 9, 22),
            ('Chemistry', 8, 16),
            ('Calculus', 5, 19),
            ('Politic', 4, 17),
            ('Biology', 6, 22),
            ('Physics', 3, 29),
            ('Biology', 8, 28),
            ('Calculus', 12, 34),
            ('Physics', 13, 34),
            ('Biology', 14, 25),
            ('Calculus', 15, 20);
--C.1 Group By
	-- Case 1 : Who is the teacher with the highest salary for each university ?
	-- Cara 1 (Tanpa Group By)
	Select id,first_name,last_name,school,salary
	from teachers a	
	where salary = (select max(salary) from teachers b where a.school = b.school);
	-- Cara 2 (Dengan Group By)
	with max_teachers as(
	Select school,max(salary) as max
	from teachers
	group by 1)
	select a.id, a.first_name, a.last_name, a.school , a.salary
	from teachers a
	right join max_teachers
	on a.school = max_teachers.school
	where a.salary = max_teachers.max;
	
	-- Case 2 : Who is the teacher with the highest salary from Standford University ?
	-- Cara 1 (Tanpa Group by)
	Select id,first_name,last_name,school,salary
	from teachers a	
	where salary = (select max(salary) from teachers b where a.school = b.school)
	and school = 'Standford University';
	
	-- Cara 2 (Dengan Group By)
	Select id,first_name,last_name, school,max(salary)
	from teachers
	where school ='Standford University'
	group by 1,2,3,4
	order by 5 DESC
	Limit 1;
	
	
	
--C.1 Join
	--Case 1 : Display all courses with teacher's identity
	Select a.id, a.name , a.teachers_id, b.first_name, b.last_name
	from courses a
	left join teachers b
	on a.teachers_id = b.id;
	
	--Case 2 : Display how many courses per universities
	select a.school, count(b.id) as jumlah_course
	from teachers a
	left join courses b
	on a.id = b.teachers_id
	group by 1;
	
	--Case 3 : Display how many total_students per teachers
	select a.id, a.first_name, a.last_name, sum(b.total_students) as total_students
	from teachers a
	left join courses b
	on a.id = b.teachers_id
	group by 1,2,3;
	
	--Case 4 : Display how many courses per teachers
	select a.id, a.first_name, a.last_name, count(b.id) as total_courses
	from teachers a
	left join courses b
	on a.id = b.teachers_id
	group by 1,2,3;
	

		  