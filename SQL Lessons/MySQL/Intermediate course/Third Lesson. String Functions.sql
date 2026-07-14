-- String Functions

select length('skyfall');

select first_name, length(first_name) as length
from employee_demographics
order by length 
;


select upper('sky'); -- makes capital
select lower('SKY'); -- makes small

select trim('             sky         '); -- remove spaces

select ltrim('             sky         '); -- remove spaces from left
select rtrim('             sky         '); -- remove spaces from right


select first_name, left(first_name, 4), -- limit 4 letters
right(first_name, 4),  -- limit 4 letters from the end
substring(first_name, 3, 2), -- Идти на третью букву и взять 2 буквы (включая третью)
birth_date,
substr(birth_date, 6,2) as birth_month
from employee_demographics
;



select first_name, replace(first_name, 'A', 'z') -- replace big A to small z
from employee_demographics
;

select locate('x','Alexander') -- return the position of letter 'x'
;

select first_name, locate('An', first_name)
from employee_demographics
;

select first_name, last_name, birth_date,
concat(first_name,' ',last_name, ' ' ,birth_date) as full_name -- combine in one column
from employee_demographics;


select first_name, last_name, birth_date, concat(first_name,' ',last_name, ' ' ,substr(birth_date, 6, 2)) as full_name
from employee_demographics;

select * from employee_demographics





