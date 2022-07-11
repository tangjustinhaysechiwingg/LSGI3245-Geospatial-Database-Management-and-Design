1a
select name
from instructor
where dept_name = 'Biology';

1b
select *
from course
where dept_name = 'Comp. Sci.'and credits =3 ;

2a
select name
from student
order by tot_cred asc;

2b
select name
from instructor
order by dept_name asc, salary desc;

3a
select *
from student
where id like '13%' and name like 'D%';

3b
select name, id
from student
where id like '_____';

3c
select name
from student
where name like 'A%a%' or name like '%a%a%';

4a
select avg (tot_cred)
from student
where dept_name= 'English';

4b
select dept_name, sum (credits) as tot_cred
from course
group by dept_name;

5a
select course_id
from takes
where id = '43616' and year = '2008' and semester ='Spring';

5b
select course_id
from takes
where id = '435' or id ='858';

5c
select course_id from teaches where semester ='Fall' and year = '2005' 
except 
select course_id from teaches where id = '22591';

5d 
select course_id from teaches where semester ='Fall' and year = '2005' 
except 
select course_id from teaches where id = '22591' or id ='28097';

6a
select name, course_id
from student, takes
where student.id = takes.id;

6b
select distinct name, course.course_id, title
from student, takes, course
where student.id=takes.id and course.course_id=takes.course_id;
