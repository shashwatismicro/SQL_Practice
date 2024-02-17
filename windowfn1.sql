use testSchema2;
-- Learning and Practicing Window Functions

/*
Window functions are a category of SQL functions that perform a calculation across a specified range of rows 
related to the current row. Unlike aggregate functions (e.g., SUM, AVG, COUNT), which collapse multiple rows 
into a single result, window functions maintain the individual rows in the result set while performing 
calculations on them.

SYNTAX:

SELECT
  column1,
  column2,
  window_function(column3) OVER (
    [PARTITION BY partition_column1, ... ]
    [ORDER BY order_column1 [ASC|DESC], ... ]
    [ROWS | RANGE frame_specification]
  ) AS result_column
FROM
  your_table;

*/

select e.*, 
max(salary) over() as max_sal
from employeeData e;
-- the above query fetches all the data from employeeData table and adds another column of max salary

select e.*, 
max(salary) over(partition by d.department_name) as max_sal, d.department_name
from employeeData e
join departmentData d
on e.department_id = d.department_id;
-- in the above query, we have used partition by statement to group max_sal by the department_name in 
-- departmentData table. So we can see max_sal each department wise

-- row_number(), rank(), dense_rank(), lead() and lag()

select e.*,
row_number() over (partition by e.job_id) as rowNum
from employeeData e;
-- the above query returns all employee details with rowNum as the num of nth employee in that 'job_id'

-- fetch the details of the first two employees from each department
-- hint: lowest employee_id has joined earliest
select *
from (
		select e.*,
		row_number() over(partition by d.department_name order by e.employee_id) as row_num,
		d.department_name
		from employeeData e
		join departmentData d
		on e.department_id = d.department_id) tablex
where tablex.row_num < 3;


-- fetch the top 3 employees in each department earning max salary
select *
from (
		select e.*,
		rank() over(partition by d.department_name order by e.salary desc) as rnk,
		d.department_name
		from employeeData e
		join departmentData d
		on e.department_id = d.department_id) tablex
where tablex.rnk < 4;

/*
Difference between rank, dense_rank and row_number

RANK, DENSE_RANK, and ROW_NUMBER are window functions in SQL used to assign a unique rank to each 
row within a result set based on a specified column or columns. While they share similarities, 
there are key differences:

Ranking Behavior:

RANK: Assigns a unique rank to each distinct row within the result set. Ties receive the same rank, 
and the next rank is skipped.
DENSE_RANK: Similar to RANK but without skipping ranks for ties. Ties receive the same rank, and the next 
rank is not skipped.
ROW_NUMBER: Assigns a unique integer to each row. Ties receive different row numbers, 
and there is no skipping.


Handling Ties:

RANK: Ties receive the same rank, and the subsequent rank is skipped. 
For example, if two rows tie for the first rank, the next rank is 3.
DENSE_RANK: Ties receive the same rank, and the next rank is not skipped. 
If two rows tie for the first rank, the next rank is 2.
ROW_NUMBER: Ties receive distinct row numbers. 
Each row, even if it ties with another, gets a unique number.
*/

SELECT
e.first_name,
e.salary, e.job_id,
RANK() OVER (partition by job_id order by salary desc) AS rank_column,
DENSE_RANK() OVER (partition by job_id order by salary desc) AS dense_rank_column,
ROW_NUMBER() OVER (partition by job_id order by salary desc) AS row_number_column
FROM
employeeData e;

-- Lead() and Lag
/*
LEAD() and LAG() are window functions in SQL that allow you to access subsequent and preceding rows in 
the result set, respectively. These functions are useful for comparing a current row with its 
next or previous row. 
*/

-- write a query to display if the salary of the current employee is greater, less than or equal to the previous emp.
select e.first_name, e.salary,
lag(salary) over() as previous_emp_sal,
case 
	when e.salary > lag(salary) over() then 'Higher than previous'
    when e.salary < lag(salary) over() then 'Lower than previous'
    when e.salary = lag(salary) over() then 'Same as previous'
    end sal_comparison
from employeeData e;
