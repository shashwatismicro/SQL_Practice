-- Chapter 1

-- 1. Write a query to display the name (first_name, last_name) and salary for all employees whose salary 
-- is not in the range $10,000 through $15,000.
select first_name, last_name, salary
from employeesNew
where not SALARY between 10000 and 15000;

-- 2. Write a query to display the name (first_name, last_name) and department ID of all employees in 
-- departments 30 or 100 in ascending order.
select first_name, last_name, department_id
from employeesNew
where DEPARTMENT_ID = 30 or DEPARTMENT_ID = 100
order by DEPARTMENT_ID;

-- 3. Write a query to display the name (first_name, last_name) and salary for all employees whose salary 
-- is not in the range $10,000 through $15,000 and are in department 30 or 100.
select first_name, last_name, salary
from employeesNew
where (DEPARTMENT_ID = 30 or DEPARTMENT_ID = 100)
	and (salary not between 10000 and 15000);

-- 4. Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987.
select first_name, last_name, hire_date
from employeesNew
where year(hire_date) = '1987%';

-- 5. Write a query to display the first_name of all employees who have both "b" and "c" in their first name.
select first_name
from employeesNew
where FIRST_NAME like '%b%' and FIRST_NAME like '%c%';

-- 6. Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a 
-- Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000.
select last_name, job_id, salary
from employeesNew
where JOB_ID = 'IT_PROG' OR 'SH_CLERK'
	and SALARY not in (4500, 10000, 15000);

-- 7. Write a query to display the last name of employees whose names have exactly 6 characters.
select last_name
from employeesNew
where LAST_NAME like '______';

-- 8. Write a query to display the last name of employees having 'e' as the third character.
select last_name
from employeesNew
where last_name like '__e%';

-- 9. Write a query to display the jobs/designations available in the employees table.
select job_id as jobsAvailable from employeesNew;

-- 10. Write a query to display the name (first_name, last_name), salary and PF (15% of salary) of all employees.
select first_name, last_name, salary, salary*0.15 as PF
from employeesNew;

-- 11. Write a query to select all record from employees where last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'.
select * from employeesNew
where LAST_NAME in ('Blake', 'Scott', 'King', 'Ford');

-- Chapter 2

-- 1. Write a query to list the number of jobs available in the employees table.
select count(distinct job_id) as numOfJobs
from employeesNew;

-- 2. Write a query to get the total salaries payable to employees.
select sum(salary) from employeesNew;

-- 3. Write a query to get the minimum salary from employees table.
select min(salary) from employeesNew;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.
select max(salary) from employeesNew
where JOB_ID = 'IT_PROG';

-- 5. Write a query to get the average salary and number of employees working the department 90.
select avg(salary) as avgSalary, count(distinct employee_id) as numOfEmployees
from employeesNew
where DEPARTMENT_ID = 90;

-- 6. Write a query to get the highest, lowest, sum, and average salary of all employees.
select max(salary) as highest,
	min(salary) as lowest,
    sum(salary) as sum,
    avg(salary) as averageSalary
from employeesNew;

-- 7. Write a query to get the number of employees with the same job.
select job_id, count(*)
from employeesNew
group by JOB_ID;

-- 8. Write a query to get the difference between the highest and lowest salaries.
select max(salary)-min(salary) as difference
from employeesNew;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
select MANAGER_ID, min(salary)
from employeesNew
group by MANAGER_ID;

-- 10. Write a query to get the department ID and the total salary payable in each department.
select department_id, sum(salary) as totalSal
from employeesNew
group by DEPARTMENT_ID;

-- 11. Write a query to get the average salary for each job ID excluding programmer.
select job_id, avg(salary) as avgSalary
from employeesNew
where not JOB_ID = 'IT_PROG'
group by JOB_ID;

-- 12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), 
-- for department ID 90 only.
select
	job_id,
    sum(salary) as totalSal,
    max(salary) as maximum,
    min(salary) as minimum,
    avg(salary) as avgSalary
from employeesNew
where DEPARTMENT_ID = 90
group by JOB_ID;

-- 13. Write a query to get the job ID and maximum salary of the employees where maximum salary 
-- is greater than or equal to $4000.
select job_id, max(SALARY)
from employeesNew
where salary >= 4000
group by JOB_ID;

-- 14. Write a query to get the average salary for all departments employing more than 10 employees.
select DEPARTMENT_ID, avg(salary) as avgSalary, count(*)
from employeesNew
group by DEPARTMENT_ID
having count(distinct EMPLOYEE_ID) > 10;
