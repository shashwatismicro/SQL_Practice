-- Common Table Expressions
/* 
Syntax:

WITH table_alias (column_names) AS (
			query
            )
SELECT *
FROM table_name tb, table_alias ta
WHERE condition;

*/
-- Solving basic questions
use testSchema2;

-- Fetch data of those employees who's salary are more than the avg salary of all the employees.
with avg_salary (avg_sal) as (
		select avg(salary)
        from employeeData)
select *
from employeeData ed, avg_salary av
where ed.salary > av.avg_sal;


-- Find stores who's sales were better than avg sales of all the stores
-- find the total sum per store, find its avg, compare
with total_sales (store_id, total_sales_perStore) as (
		select s.storeID, sum(price) as sum_price
		from sales s
		group by s.storeID),
	avg_sales (avg_sales_perStore) as (
		select avg(ts.total_sales_perStore) as avg_price
        from total_sales ts)
select *
from total_sales ts
join avg_sales av
on ts.total_sales_perStore > av.avg_sales_perStore;

/* RECURSIVE QUERY : Recursive queries, also known as hierarchical or recursive common table expressions, 
re a feature in SQL that allows you to perform operations on hierarchical data or relationships 
within a table. These queries are particularly useful when dealing with data that has a recursive 
structure, such as organizational hierarchies, family trees, or network graphs.

SYNTAX :

WITH [RECURSIVE] CTE_name AS (
			SELECT query (nonRecursiveQuery_or_baseQuery)
				UNION [ALL]
			SELECT query (recursiveQuery using CTE_name [with a termination condition])
            )
SELECT * FROM CTE_name;
*/

-- Display numbers from 1 to 10 without using any in-built function
with recursive numbers as (
		select 1 as num
        union
        select num + 1
        from numbers
        where num < 10)
select *
from numbers;

-- Find the hierarchy of employees under a given manager 'Neena'. show emp_id, emp_name, manager_name, level
with recursive emp_hierarchy as (
		select employee_id, first_name, manager_id, job_id, 1 as tier
        from employeeData
        where first_name = 'Neena'
        union
        select ed.employee_id, ed.first_name, ed.manager_id, ed.job_id, tier + 1 as tier
        from emp_hierarchy eh
        join employeeData ed
        on eh.employee_id = ed.manager_id
        )
select eh2.EMPLOYEE_ID, eh2.FIRST_NAME, ed2.FIRST_NAME as manager_name, eh2.tier as level
from emp_hierarchy eh2
join employeeData ed2
on eh2.manager_id = ed2.EMPLOYEE_ID;


-- Find hierarchy of managers over a given employeee, 'Ismael'
with recursive emp_hierarchy as (
		select employee_id, first_name, manager_id, job_id, 1 as tier
        from employeeData
        where first_name = 'Ismael'
        union
        select ed.employee_id, ed.first_name, ed.manager_id, ed.job_id, tier + 1 as tier
        from emp_hierarchy eh
        join employeeData ed
        on eh.MANAGER_ID = ed.EMPLOYEE_ID
        )
select eh2.EMPLOYEE_ID, eh2.FIRST_NAME, ed2.FIRST_NAME as manager_name, eh2.tier as level
from emp_hierarchy eh2
join employeeData ed2
on eh2.manager_id = ed2.EMPLOYEE_ID
order by eh2.tier;

/* 
Use a recursive query to display the hierarchical structure of all the employees. Include columns for 
employee ID, first name, last name, and manager ID.
*/

with recursive hierarchy_table as (
		select employee_id, first_name, last_name, manager_id
        from employeeData
        where manager_id = 0
        union all
        select e.employee_id, e.first_name, e.last_name, e.manager_id
        from employeeData e
        join hierarchy_table h
        on e.manager_id = h.employee_id)
select * from hierarchy_table;

/* 
Create a query to count the number of subordinates for each manager. Include columns for 
manager ID, manager name, and the count of subordinates.
*/

with recursive subordinate_table as(
		select employee_id, first_name, last_name, manager_id
        from employeeData
        where manager_id = 0
        union all
        select e.employee_id, e.first_name, e.last_name, e.manager_id
        from subordinate_table st
        join employeeData e
        on e.manager_id = st.employee_id)
select
  m.employee_id as manager_id,
  m.first_name as manager_name,
  COUNT(e.employee_id) as subordinate_count
from subordinate_table e
join employeeData m on e.manager_id = m.employee_id
group by m.employee_id, manager_name
order by manager_id;
