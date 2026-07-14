-- case statements

select first_name,
last_name,
age,
case
	when age<= 30 then 'Young'
    when age between 31 and 50 then 'old'
	else 'rip'
end as age_bracket
from employee_demographics;


-- Pay Increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus


select sal.first_name, sal.last_name, sal.salary, 
case
	when salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
    else salary
end as New_Salary, deps.department_name,
case
	when deps.department_name = 'Finance' then
    salary * .10
    else "Zero"
end as Bonus
from employee_salary as sal
inner join parks_departments as deps
	on deps.department_id = sal.dept_id
;

select * from parks_departments;
select * from employee_salary

