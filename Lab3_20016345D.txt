--Question (1)
--(a)
select name, course_id
from student natural join takes;

-- or 
select name, couse_id
from student, takes
where student.id = takes.id;

--(b)
/*
Not the same. 
Natural join will join tables based on all the same columns they contain
The result of (instructor natural join teaches) will contain two same columns with table course, which are dept_name and course_id, 
so when executing the second natural join in (instructor natural join teaches natural join course), not only course_id will be considered, but also dept_name.

Thus, the result of the first clause will be different with the other two. It will generate the same result with 

select count(*)
from instructor, teaches, course
where instructor.id = teaches.id and
	teaches.course_id = course.course_id and 
	instructor.dept_name = course.dept_name;

*/
--(c)
select name, course.course_id, title, grade
from student natural join takes, course
where takes.course_id = course.course_id and
student.id = '1000';

--Question 2
--(a)
select course_id, title
from course
where course_id in ( select course_id
	from takes
	where id = '10269');
	
--(b)
select prereq_id
from prereq
where course_id in (select course_id from takes where id = '10269');

--(c)
--Answers are not limited to the following methods.
--Method 1
select title 
from course
where course_id in (select prereq_id
				from prereq
				where course_id in (select course_id from takes where id = '10269'))

--Method 2
select title 
from course, prereq
where course.course_id = prereq.prereq_id and prereq.course_id in (select course_id from takes where id = '10269');


--Method 3

select title
from (select *
from prereq
where course_id in (select course_id from takes where id = '10269')) as T, course
where T.prereq_id = course.course_id

--Quesion 3
--(a)
select dept_name, sum_cred
from(select dept_name, sum(credits) as sum_cred
from course
group by dept_name) as T
where T.sum_cred > 20;

--(b)
select dept_name, building, budget, sum_cred
from department natural join (select dept_name, sum(credits) as sum_cred
	from course
	group by dept_name) as T
where T.sum_cred > 20 and department.budget> 500000;

--Question 4
--(a)
select course_id, count(id) 
from takes 
group by course_id;

--(b)

select teaches.id, count(*)
from teaches, takes
where (teaches.course_id = takes.course_id and teaches.sec_id = takes.sec_id and teaches.semester = takes.semester and teaches.year = takes.year)
group by teaches.id



