-- Limit and Aliasing

select *
from parks_and_recreation.employee_demographics
order by age desc
limit 3 -- columns limit
;

select *
from parks_and_recreation.employee_demographics
order by age desc
limit 2, 1 -- take the second columns + 1 next 
;

-- Aliasing
select gender, avg(age) as avg_age -- rename the column
from parks_and_recreation.employee_demographics
group by gender
having avg_age > 40
;
