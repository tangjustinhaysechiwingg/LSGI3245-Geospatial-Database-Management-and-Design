LSGI3245 Midterm Test 
20016345D Tang Justin Hayse Chi Wing G.

Part A

A1
select name, dept_name
from instructor 
where salary >=60000 and salary <90000
order by salary asc; 

A2
select time_slot_id,avg(end_min)
from time_slot
where day ='F'
group by time_slot_id;

A3(a)
select course_id,building,semester
from section
where building ilike '%a%';

A3(b)
select course_id,building,semester
from section
where building ilike '%a%a%' and building not ilike '%a%a%a%';

A4
select name,dept_name,tot_cred
from (select avg(tot_cred) as avg_cred from student) as T,student
where tot_cred>T.avg_cred;

A5
select name
from instructor 
where dept_name = 'Psychology' or dept_name = 'Languages';

A6
(select course_id
from section
where building = 'Saucon')
except
(select course_id
from section
where semester = 'Fall' and year = '2004');

A7
select count(id)
from instructor 
where dept_name='Cybernetics' and salary >30000;

A8
select name
from instructor
where salary >some (select salary
				   from instructor
				   where dept_name='Accounting');




Part B

B1(a)
select distinct takes.id , teaches.id
from takes, teaches
where takes.course_id = teaches.course_id and takes.sec_id = teaches.sec_id and takes.semester = teaches.semester and takes.year =teaches.year;

B1(b)
select count(*)
from (select instructor.name
from  advisor, teaches natural join instructor , takes
where takes.course_id = teaches.course_id and takes.sec_id = teaches.sec_id and takes.semester = teaches.semester and takes.year =teaches.year and advisor.s_id = takes.id and advisor.i_id = teaches.id
group by instructor.name) as T;

B2(a)
select prereq.prereq_id, title, course.dept_name
from prereq, course
where
prereq.course_id = '747'
and prereq.prereq_id = course.course_id;

B2(b)
select * 
from
(select id,course_id as prereq_id,semester,year from takes where course_id in
(select prereq_id 
from prereq)) as T,takes where takes.id = T.id;
