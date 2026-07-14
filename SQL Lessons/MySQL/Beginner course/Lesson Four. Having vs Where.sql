-- Having vs Where

select gender, avg(age) -- we'll got an error, because avg(age) cause only after group by func
from parks_and_recreation.employee_demographics
where avg(age) > 40
group by gender
;


select gender, avg(age) -- we'll got an error, because avg(age) cause only after group by func
from parks_and_recreation.employee_demographics
group by gender
having avg(age) > 40 -- comes after group by. was created for this situations
;

select occupation, avg(salary)
from parks_and_recreation.employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary) > 75000
;



