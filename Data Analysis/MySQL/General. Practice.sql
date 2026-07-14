select first_name, last_name, age
from employee_demographics
where age > 40;

select first_name, last_name, occupation
from employee_salary
where lower(occupation) like '%director%';

select *
from suppliers
order by country, supplier_name;

select s.first_name, s.last_name, d.gender, s.salary
from employee_salary s
inner join employee_demographics d
	on s.employee_id = d.employee_id;
    
    
with CTE_Table as (
	select occupation, avg(salary) as avg_salary
    from employee_salary
    group by occupation
)
select *
from CTE_Table
where avg_salary > 50000;

select s.first_name, s.last_name, s.salary, coalesce(pd.department_name, 'No data') as department_name
from employee_salary s
left join parks_departments pd
	on s.dept_id = pd.department_id;
    
select concat(e.first_name, ' ', e.last_name) as employee,
e.salary, pd.department_name,
avg(e.salary) over(partition by e.dept_id) as avg_salary
from employee_salary e
left join parks_departments pd
	on e.dept_id = pd.department_id;
    
select concat(e.first_name, ' ', e.last_name) as employee,
e.salary, coalesce(pd.department_name, 'No DATA') as department_name,
case
	when e.dept_id is null then null
    else dense_rank() over(partition by e.dept_id order by e.salary desc)
end  as ranking
from employee_salary e
left join parks_departments pd
	on e.dept_id = pd.department_id;
    
with cte_table as (
	select concat(e.first_name, ' ', e.last_name) as employee,
    e.salary, avg(e.salary) over() as avg_salary
    from employee_salary e
)
select *
from cte_table
where salary > avg_salary


    
    








