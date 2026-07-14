select * from parks_and_recreation.employee_salary
where first_name = "Leslie";


select * from parks_and_recreation.employee_salary
where salary <= 50000
;


select * from parks_and_recreation.employee_demographics
where gender != "Female"
;


select * from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'
;

-- AND OR NOT -- LOGICAL OPERATIORS

select * from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01' or not gender = "male"
;


select * from parks_and_recreation.employee_demographics
where (first_name = "Leslie" and age = 44) or age > 55;


-- LIKE statement
-- % and _
select * from parks_and_recreation.employee_demographics
where first_name like "%er%"; -- % means anything before or after


select * from parks_and_recreation.employee_demographics
where first_name like "a__"; -- _ means quantity of letter after a letter (or before) _ is 1 letter.


select * from parks_and_recreation.employee_demographics
where first_name like "a___%"; -- you can also combine. it means at least 4 letters. first one is "a". 3 letters is necessary and then it can be anything after it


select * from parks_and_recreation.employee_demographics
where birth_date like '1989%'




