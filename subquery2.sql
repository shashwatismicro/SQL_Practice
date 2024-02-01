-- Subquery questions practice
use testSchema2;

/* 1. Write a query to find the name (first_name, last_name) and the salary of the employees who have a 
higher salary than the employee whose last_name='Bull'.*/
select first_name, last_name, salary 
from employeeData
where salary > (select salary
			from employeeData
            where last_name = 'Bull');


/*2. Write a query to find the name (first_name, last_name) of all employees who works in the IT department.*/
select first_name, last_name
from employeeData
where DEPARTMENT_ID = (
		select DEPARTMENT_ID
        from departmentData
        where DEPARTMENT_NAME = 'IT');


/*3. Write a query to find the name (first_name, last_name) of the employees who have a manager 
and worked in a USA based department.*/
select first_name, last_name
from employeeData
where MANAGER_ID is not null
and DEPARTMENT_ID in (
		select DEPARTMENT_ID
        from departmentData
        where LOCATION_ID in (
				select LOCATION_ID
                from locationData
                where country_id = 'US')
		);


/*4. Write a query to find the name (first_name, last_name) of the employees who are managers. */
select first_name, last_name
from employeeData
where employee_id in (
			select distinct manager_id
            from employeeData);


/*5. Write a query to find the name (first_name, last_name), and salary of the employees 
whose salary is greater than the average salary.*/
select first_name, last_name, salary
from employeeData
where salary > (
		select avg(salary)
        from employeeData);


/*6. Write a query to find the name (first_name, last_name), and salary of the employees 
whose salary is equal to the minimum salary for their job grade. */
select first_name, last_name, salary
from employeeData
where SALARY in (
		select min_salary
        from jobData);


/*7. Write a query to find the name (first_name, last_name), and salary of the employees who earns more 
than the average salary and works in any of the IT departments.*/
select first_name, last_name, salary
from employeeData
where salary > (
		select avg(salary)
        from employeeData)
and DEPARTMENT_ID in (
		select DEPARTMENT_ID
        from departmentData
        where DEPARTMENT_NAME like 'IT%');


/*8. Write a query to find the name (first_name, last_name), and salary of the employees who 
earns more than the earning of Mr. Bell.*/
select first_name, last_name, salary
from employeeData
where salary > (
		select salary
        from employeeData
        where FIRST_NAME like '%Bell%'
			or LAST_NAME like '%Bell%');


/*9. Write a query to find the name (first_name, last_name), and salary of the employees who 
earn the same salary as the minimum salary for all departments.*/
select first_name, last_name, salary
from employeeData
where salary in (
			select min(salary)
            from employeeData
            group by DEPARTMENT_ID);


/*10. Write a query to find the name (first_name, last_name), and salary of the employees whose salary 
is greater than the average salary of all departments.*/
select first_name, last_name, salary
from employeeData
where salary > all(
		select avg(salary)
        from employeeData
        group by DEPARTMENT_ID);
        
-- or another way to solve using nested subquery:

select first_name, last_name, salary
from employeeData
where salary > (
		select max(avg_salary)
        from (
				select avg(salary) as avg_salary
				from employeeData
				group by DEPARTMENT_ID) max_avg_salary
			);


/*11. Write a query to find the name (first_name, last_name) and salary of the employees who 
earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). 
Sort the results of the salary of the lowest to highest.*/
select first_name, last_name, salary
from employeeData
where SALARY > all (
		select salary
        from employeeData
        where job_id = 'SH_CLERK')
order by salary;


/*12. Write a query to find the name (first_name, last_name) of the employees who are not supervisors.*/
select first_name, last_name
from employeeData
where EMPLOYEE_ID not in (
		select MANAGER_ID
        from departmentData);


/*13. Write a query to display the employee ID, first name, last name, and department names of all employees.*/
select employee_id, first_name, last_name, (
		select DEPARTMENT_NAME
        from departmentData d
        where d.DEPARTMENT_ID = e.DEPARTMENT_ID)
        as dept_name
from employeeData e;

/* Above question was a good example of correlated query. We do not use it often because of its 
inefficiency. This question could be solved more efficiently using JOINS */



/*14. Write a query to display the employee ID, first name, last name, salary of all employees whose salary 
is above average for their departments.*/
--
select employee_id, first_name, last_name, salary
from employeeData ed
where salary > (
		select avg(SALARY)
        from employeeData ed2
        where ed2.DEPARTMENT_ID = ed.DEPARTMENT_ID);


/*15. Write a query to fetch even numbered records from employees table.*/
select * from employeeData
where EMPLOYEE_ID%2 = 0;


/*16. Write a query to find the 5th maximum salary in the employees table.*/
select distinct salary as fifthMax_salary
from employeeData
order by salary desc
limit 4, 1;


/*17. Write a query to find the 4th minimum salary in the employees table.*/
select distinct salary as fourth_minSal
from employeeData
order by salary
limit 3,1;


/*18. Write a query to select last 10 records from a table.*/
select *
from (
		select *
        from employeeData
        order by EMPLOYEE_ID desc
        limit 10) tableAlias
order by EMPLOYEE_ID asc;


/*19. Write a query to list the department ID and name of all the departments where no employee is working.*/
select department_id, department_name
from departmentData
where DEPARTMENT_ID not in (
		select distinct DEPARTMENT_ID
        from employeeData);


/*20. Write a query to get 3 maximum salaries.*/
select distinct salary
from employeeData
order by SALARY desc
limit 3;


/*21. Write a query to get 3 minimum salaries.*/
select distinct salary
from employeeData
order by SALARY
limit 3;


/*22. Write a query to get nth max salaries of employees.*/
select * 
from employeeData
where salary = (
		select distinct salary
		from employeeData
		order by SALARY desc
		limit 5, 1); -- taking n = 6, n-1 = 5
