use testSchema;
-- Q. 1. Write a SQL statement to change the email column of employees table with 'not available' for all employees.

update employeesNew
set email = 'not available'
limit 10; -- used limit because of safeMode

select * from employeesNew;

-- reloading table to not be fooled again
drop table employeesNew;

select * from employeesNew;

-- 1. Write a query to display the names (first_name, last_name) using alias name "First Name", "Last Name"
select first_name as 'First Name', last_name as 'Last Name' from employeesNew;

-- 2. Write a query to get unique department ID from employee table.
select distinct department_id from employeesNew;

-- 3. Write a query to get all employee details from the employee table order by first name, descending.
select * from employeesNew 
order by first_name desc;

-- 4. Write a query to get the names (first_name, last_name), salary, PF of all the employees 
-- (PF is calculated as 15% of salary).
select first_name, last_name, salary, salary*0.15 as PF
from employeesNew;

-- 5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary.
select employee_id, first_name, last_name, salary
from employeesNew order by salary;

-- 6. Write a query to get the total salaries payable to employees.
select sum(salary) as totalPayableSalary from employeesNew;

-- 7. Write a query to get the maximum and minimum salary from employees table.
select max(salary) as maxSalary, min(salary) as minSalary
from employeesNew;

-- 8. Write a query to get the average salary and number of employees in the employees table.
select count(distinct employee_id) as numberOfEmployees,
avg(salary) as avgSalary from employeesNew;

-- 9. Write a query to get the number of employees working with the company.
select count(distinct employee_id) as numberOfEmployees from employeesNew;

-- 10. Write a query to get the number of jobs available in the employees table.
select count(distinct job_id) as jobAvailable from employeesNew;

-- 11. Write a query get all first name from employees table in upper case.
select ucase(first_name) as firstName from employeesNew;

-- 12. Write a query to get the first 3 characters of first name from employees table.
select mid(first_name, 1,3) as abvName from employeesNew;

-- 13. Write a query to calculate 171*214+625.
select 171*214+625;

-- 14. Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) of all the employees
-- from employees table.
select concat(first_name, ' ', last_name) as fullName from employeesNew;

-- 15. Write a query to get first name from employees table after removing white spaces from both side.
select trim(first_name) as trimmedName, first_name as untrimmedName from employeesNew;

-- 16. Write a query to get the length of the employee names (first_name, last_name) from employees table.
select first_name, last_name, 
length(first_name) + length(last_name) as length
from employeesNew;

-- 17. Write a query to check if the first_name fields of the employees table contains numbers.
select first_name from employeesNew
where first_name regexp '[0-9]';

-- 18. Write a query to select first 10 records from a table.
select * from employeesNew limit 10;

-- 19. Write a query to get monthly salary (round 2 decimal places) of each and every employee
-- Note : Assume the salary field provides the 'annual salary' information.
select employee_id, first_name, last_name, round(salary/12, 2) as monthlySalary
from employeesNew;