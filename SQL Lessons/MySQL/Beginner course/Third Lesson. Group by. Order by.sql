-- group by

select gender, avg(age), max(age), min(age), count(age)
from parks_and_recreation.employee_demographics
group by gender
;


select occupation, salary
from parks_and_recreation.employee_salary
group by occupation, salary
;


-- order by
select *
from parks_and_recreation.employee_demographics
order by gender asc, age desc -- asc smallest to biggest;  desc - biggest to smallect
;



select *
from parks_and_recreation.employee_demographics
order by 5 asc, 4 desc -- numbers mean the number of the column (5 - gender, 4 - age) NOT RECOMMENDED
;



