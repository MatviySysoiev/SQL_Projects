-- Stored Procedures

create procedure large_salaries()
select *
from employee_salary
where salary >= 50000
;

call large_salaries()


use 'parks_and_recreation'
drop procedure if exists large_salaries2
delimiter $$
create procedure large_salaries2()
begin
	select *
	from employee_salary
	where salary >= 50000;
	select *
	from employee_salary
	where salary <= 50000;
end $$
delimiter ;

call large_salaries2();


delimiter $$
create procedure large_salaries4(emp_id int) -- getting id
begin
	select *
	from employee_salary
    where employee_id = emp_id
    ;
end $$
delimiter ;



call large_salaries4(1) -- 1 means employee_id






