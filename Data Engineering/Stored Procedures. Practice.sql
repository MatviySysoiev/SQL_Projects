use parks_and_recreation;
drop procedure if exists get_salary_above;

delimiter $$
create procedure get_salary_above()
begin
	select *
	from employee_salary
	where salary > 50000;
end $$
delimiter ;

call get_salary_above();


use parks_and_recreation;
drop procedure if exists get_salary_above;

delimiter $$
create procedure get_salary_above_amount(in p_salary int)
begin
	select *
	from employee_salary
	where salary > p_salary;
end $$
delimiter ;

call get_salary_above_amount(60000);



use parks_and_recreation;
drop procedure if exists count_employees_in_department;
delimiter $$
create procedure count_employees_in_department(in p_dept_id INT, out p_total int)
begin
	select count(*) into p_total
    from employee_salary
    where dept_id = p_dept_id;
end $$
delimiter ;

CALL count_employees_in_department(1, @total);
SELECT @total;



use parks_and_recreation;
drop procedure if exists check_salary_level;
delimiter $$
create procedure check_salary_level(IN p_employee_id INT)
begin
	declare v_salary int;
    
	select salary
    into v_salary
    from employee_salary
    where employee_id = p_employee_id;
    
    if v_salary >= 70000 then
		select 'High salary' as salary_level;
	elseif v_salary >= 50000 then
		select 'Medium salary' as salary_level;
	else
		select 'Low salary' as salary_level;
	end if;
end $$
delimiter ;

call check_salary_level(4);



use parks_and_recreation;
drop procedure if exists increase_salary_by_department;
delimiter $$
create procedure increase_salary_by_department(IN p_dept_id INT, IN p_amount INT)
begin
	update employee_salary
    set salary = salary + p_amount
    where dept_id = p_dept_id;
    select *
    from employee_salary
    where dept_id = p_dept_id;
end $$
delimiter ;

CALL increase_salary_by_department(2, 3000);

























