use testSchema2;
-- In this script we will study Subquerries and its types
-- 1. Scalar subquery: When subquery returns only one row.

-- Q. Find the employees who's salary is more than the avg. salary earned by all the employees.
select * from employee
where salary > (
		select avg(salary) 
		from employee);

-- another way to solve the same problem with JOINS
select e.*
from employee e
join (select avg(salary) sal from employee) avg_sal
on e.salary > avg_sal.sal;

-- 2. Multiple row Subquery : Subquery that returns multiple rows
							-- They are of two types -
							-- i) Multiple row multiple column
							-- ii) Multiple row single column

-- i) 
-- Q) Find employees who earn highest salary in each department
select * from employee
where (deptName, salary) in (
	select deptName, max(salary)
	from employee
	group by deptName);

-- ii)
-- Q) Find deparments who do not have any employees
select * 
from department
where not deptName in(
	select deptName 
    from employee);
    
-- 3) Co-related Subquery : It is a subquery which depends directly upon the outer subquery

-- Q) Find the employees in each department who earn more than the avg Salary in that department. 
select *
from employee e
where  salary > 
		(select avg(salary) as avg_sal
        from employee e2
        where e2.deptName = e.deptName
		);
-- Above  we can see that the subquery cannot be executed without existence of the outer query, because
-- the subquery has a column e.deptName which is referenced directly to the employee table in outer query

-- Now let's try to solve a previous question using co-related query

-- Q) Find deparments who do not have any employees
select *
from department d
where not exists(
		select 1
        from employee e
        where e.deptName = d.deptName);

-- Nested subquery : It is a subquery within a subquery. Let's explore with an example
-- Q) Find stores who's sales were better than avg. sales accross all the stores
select *
from (
		select storeName, sum(price) total_sales
        from sales
        group by storeName) sales
join (
		select avg(total_sales) as sales
        from(
				select storeName, sum(price) as total_sales
                from sales
                group by storeName) alias ) avg_sales
on sales.total_sales > avg_sales.sales;

-- we see the queries are used redundantly so there is a better way to solve this problem
-- Let's use CTE to solve the above problem

with sales as(
		select storeName, sum(price) as total_sales
		from sales
		group by storeName)
select *
from sales
join (select avg(total_sales) as sales
	  from sales alias) avg_sales
 on sales.total_sales > avg_sales.sales;     
 