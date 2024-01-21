USE testSchema;
-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) 
-- of all the departments.
select d.department_name, l.location_id, l.street_address, l.city, l.state_province, l.country_id
from departments d
inner join locations l on 
	d.location_id = l.location_id;

-- 2. Write a query to find the name (first_name, last name), department ID and name of all the employees.
select e.first_name, e.last_name, d.department_id, d.department_name
from employeesNew e
inner join departments d 
	on e.department_id = d.department_id;

-- 3. Write a query to find the name (first_name, last_name), job, department ID and name of the employees 
-- who works in London.
select e.first_name, e.last_name, d.department_id, d.department_name
from employeesNew e
join departments d 
on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where l.city = 'London';

-- 4. Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name).
select e.employee_id 'empID', e.last_name 'empName',
	m.employee_id 'managerID', m.last_name 'managerName'
from employeesNew e
join employeesNew m on e.manager_id = m.employee_id;

-- 5. Write a query to find the name (first_name, last_name) and hire date of the employees 
-- who was hired after 'Allan'.
select first_name, last_name, hire_date
from employeesNew
where date(hire_date) > (
	select hire_date from employeesNew
	where first_name = 'Allan');
    
-- 6. Write a query to get the department name and number of employees in the department.
select d.department_name 'deptName', count(distinct e.employee_id) 'numEmployees'
from employeesNew e
join departments d
on e.department_id = d.department_id
group by department_name;

-- before qn 7 first make jobs table
create table jobs (
	job_id int primary key,
    job_title varchar(45),
    min_salary int,
    max_salary int);
    
alter table jobs
modify column job_id varchar(50);
    insert into jobs values ('AD_PRES', 'President', 20000, 40000),
    ('AD_VP', 'Administration Vice President', 15000, 30000),
    ('AD_ASST', 'Administration Assistant', 3000, 6000),
    ('FI_MGR', 'Finance Manager', 8200, 16000),
    ('FI_ACCOUNT', 'Accountant', 4200, 9000),
    ('AC_MGR', 'Accounting Manager', 8200, 16000),
    ('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
    ('SA_MAN', 'Sales Manager', 10000, 20000),
    ('SA_REP', 'Sales Representative', 6000, 12000),
    ('PU_MAN', 'Purchasing Manager', 8000, 15000),
    ('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
    ('ST_MAN', 'Stock Manager', 5500, 8500),
    ('ST_CLERK', 'Stock Clerk', 2000, 5000),
    ('SH_CLERK', 'Shipping Clerk', 2500, 5500),
    ('IT_PROG', 'Programmer', 4000, 10000),
    ('MK_MAN', 'Marketing Manager', 9000, 15000),
    ('MK_REP', 'Marketing Representative', 4000, 9000),
    ('HR_REP', 'Human Resources Representative', 4000, 9000),
    ('PR_REP', 'Public Relations Representative', 4500, 10500);
    
-- 7. Write a query to find the employee ID, job title, number of days between ending date and starting date for 
-- all jobs in department 90.
select employee_id, job_title, end_date - start_date
from jobHistory
natural join jobs
where department_id = 90;

-- 8. Write a query to display the department ID and name and first name of manager.
select d.department_id 'deptID', d.department_name 'deptName', e.first_name 'name'
from departments d
join employeesNew e on d.manager_id = e.employee_id;

-- 9. Write a query to display the department name, manager name, and city.
select d.department_name 'deptName', e.first_name 'managerName', l.city 'city'
from employeesNew e
join departments d on e.employee_id = d.manager_id
join locations l on d.location_id = l.location_id;

-- 10. Write a query to display the job title and average salary of employees.
select jb.job_title 'jobTitle', avg(e.salary) 'avgSalary'
from jobs jb
join employeesNew e
on jb.job_id = e.job_id
group by jb.job_title;

-- 11. Write a query to display job title, employee name, and the difference between 
-- salary of the employee and minimum salary for the job.
select jb.job_title 'jobTitle', e.first_name 'empName', e.salary-jb.min_salary 'difference'
from employeesNew e
join jobs jb 
on jb.job_id = e.job_id;

-- 12. Write a query to display the job history that were done by any employee who is currently 
-- drawing more than 10000 of salary.
select jh.* from jobHistory jh
join employeesNew e
on jh.employee_id = e.employee_id
where e.salary > 10000;

-- 13. Write a query to display department name, name (first_name, last_name), hire date, salary 
-- of the manager for all managers whose experience is more than 15 years.
select first_name, last_name, hire_date, salary, 
(DATEDIFF(now(), hire_date))/365 Experience 
from departments d 
join employeesNew e
on d.manager_id = e.employee_id
where (DATEDIFF(now(), hire_date))/365 > 15;

JOIN employeesNew e 
ON d.manager_id = e.employee_id
WHERE (DATEDIFF(now(), hire_date))/365>15;
