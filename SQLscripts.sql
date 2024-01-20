USE new_schema_1
CREATE TABLE employee (
    id INT NOT NULL,
    name VARCHAR(45) NULL,
    age VARCHAR(45) NULL,
    city VARCHAR(45) NULL,
    salary VARCHAR(45) NULL,
    PRIMARY KEY (id)
);

INSERT INTO employee (id, name, age, city, salary)
VALUES (1, 'John Doe', '42', 'California', '20000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (2, 'Bhiku Mahatre', '35', 'Mumbai', '100000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (3, 'Sardar Khan', '39', 'Wasseypur', '900000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (4, 'Ganesh Gaitonde', '37', 'Mumbai', '480000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (5, 'Patrick Bateman', '27', 'New York', '3000000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (6, 'Vito Corleone', '62', 'Sicily', '9000000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (7, 'Tony Montana', '52', 'Miami', '10000000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (8, 'Travis Bickle', '26', 'New York', '900000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (9, 'Alex', '22', 'London', '1000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (10, 'Norman Bates', '28', 'Oregon', '3000000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (11, 'Sauron', '527', 'Mordor', '100000000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (12, 'Aegon Targaryen', '121', 'Dragonstone', '999000000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (13, 'Tom Riddle', '18', 'Hogwarts', '5000');
INSERT INTO employee (id, name, age, city, salary)
VALUES (14, 'Eobard Thawne', '56', 'Central City', '55000000');

-- addition
SELECT id, name, salary, salary +1 as new_salary FROM employee

-- similarly we can do sub, mul and div

-- conditional operation
-- emp with salary less than 40000

SELECT * FROM employee
WHERE salary < 40000; -- it shows john doe, alex and tom riddle

-- similarly greater than

SELECT * FROM employee
WHERE salary > 40000;

-- query works ok
-- logical operators(and, or, not, between

-- and

SELECT * FROM employee
WHERE city = 'New York' AND salary > 20000

-- between

SELECT * FROM employee
WHERE salary BETWEEN 25000 AND 500000

-- truncate table is used to delete whole data inside table without deleting its structure
-- delete from tableName where <condition> will delete a row
-- alter statement will add columns

ALTER TABLE employee 
ADD (dob DATE);

-- select statement 

select distinct city from employee -- this will select all the cityies we have in employee table 
select count(*) from employee; -- this counts the number of rows in table

-- checking the datatype of each column

-- lets change the datatype of salary to int for further studies:
alter table employee
modify column salary int;

-- order by increasing or decreasing

select * from employee 
order by salary desc -- highest salary on top 

-- random statement
select * from employee order by rand();

-- in statement is used for applying multiple ORs in where

select * from employee where city in ('New York','Mumbai');

-- using update to change sardar khan's income
update employee set salary = 900002 
where id = 3;

-- order by multiple

select * from employee order by name asc, salary desc

-- to learn SQL joins, lets make three tables first.for
-- 1. employee2
CREATE TABLE employee2 (
	empid INT PRIMARY KEY, 
    empname VARCHAR (50),
    age INT,
    designation VARCHAR (50),
    city VARCHAR (50),
    salary INT,
    DOJ DATE,
    deptID INT);
    
INSERT INTO employee2 VALUES(1011, 'Abhigyan', 34, 'HR Manager', 'Hyderabad', 30000, '2023-03-12', 11);
INSERT INTO employee2 VALUES(1012, 'Ajay', 27, 'HR Manager', 'Ranchi', 25000, '2024-01-12', 11);
INSERT INTO employee2 VALUES(1013, 'Shantanu', 43, 'HR Manager', 'New Delhi', 25000, '2017-04-12', 11);
INSERT INTO employee2 VALUES(1014, 'Rounak Vats', 23, 'SDE', 'Hyderabad', 30000, '2023-08-10', 12);
INSERT INTO employee2 VALUES(1015, 'Yuvraj Kunwar', 52, 'Assistant Manager', 'Mumbai', 40000, '2012-02-01', 13);
INSERT INTO employee2 VALUES(1016, 'Ajinkya', 35, 'Assistant Manager', 'Deoghar', 15000, '2023-02-19', 13);
INSERT INTO employee2 VALUES(1017, 'Phalguni Pathak', 29, 'System Engineer', 'Hyderabad', 45000, '2023-09-15', 12);
INSERT INTO employee2 VALUES(1018, 'Sanjana', 22, 'Account Executive', 'Mumbai', 15000, '2023-03-12', 14);
INSERT INTO employee2 VALUES(1019, 'Abhinav Deepak', 32, 'Account Manager', 'Patna', 40000, '2015-11-25', 14);
INSERT INTO employee2 VALUES(1020, 'Abhigyan', 31, 'Chartered Accountant', 'Pune', 67000, '2021-04-22', 14);
INSERT INTO employee2 VALUES(1021, 'Akash Dip', 21, 'SDE', 'Deoghar', 45000, '2023-03-12', 12);
UPDATE employee2
SET designation = 'Sales Manager'
WHERE empid = 1016;
UPDATE employee2
SET designation = 'Sales Manager'
WHERE empid = 1015;
INSERT INTO employee2 VALUES(1022, 'Pankaj Tripathi', 42, 'Market Ambassdor', 'Mumbai', 80000, '2022-11-12', 13);
INSERT INTO employee2 VALUES(1023, 'Niraj Verma', 24, 'Market Consultant', 'Mumbai', 28000, '2023-10-10', 13);
INSERT INTO employee2 VALUES(1024, 'Sambhav Sinha', 24, 'Data Engineer', 'Ranchi', 40000, '2021-03-28', 15);
INSERT INTO employee2 VALUES(1025, 'Shashwat Shekhar', 23, 'Data Analyst', 'Patna', 35000, '2020-09-26', 15);
INSERT INTO employee2 VALUES(1026, 'Anshul Kumar', 29, 'Data Scientist', 'Banglore', 67000, '2019-12-01', 15);

SELECT * FROM employee2

-- Now lets make department table
CREATE TABLE department(
	deptID INT,
    deptName VARCHAR(50));
    
INSERT INTO department VALUES(11, 'HR'), (12, 'IT'), (13, 'Sales and Marketing'), (14, 'Finance'), (15, 'DBMS');
SELECT * FROM department

-- Now lets make the project assignment table
CREATE TABLE projects(
	projectID INT PRIMARY KEY,
    empid INT,
    projectName VARCHAR(50),
    projectManager VARCHAR(50));
    
INSERT INTO projects 
VALUES
	(110, 1014, 'ERP System', 'Mainak Mukhopadhyay'),
    (210, 1013, 'Employee Assistance Program', 'Anil Sharma'),
    (310, 1017, 'Cyber Security', 'Kamta Nath Mishra'),
    (410, 1021, 'Network Solutions', 'Pateto Nath'),
    (510, 1026, 'Data Warehousing', 'Prabhas Ranjan'),
    (610, 1023, 'Outreach Program', 'Saunak Paul'),
    (710, 1015, 'Salesman Program', 'Chinmay Chakroborty')

SELECT * FROM projects

-- Q1. retrieve the employee details and the department they are working on

SELECT employee2.*, department.deptName
FROM employee2
INNER JOIN department ON employee2.deptID = department.deptID;

-- Q2. retrieve the necessary employee details, project they are working on and their project manager

SELECT employee2.empid, employee2.empname, employee2.age, employee2.designation, projects.projectName, projects.projectManager
FROM employee2
INNER JOIN projects ON employee2.empid = projects.empid;

-- Q3. repeat the same question joining the table FULLY

SELECT employee2.empid, employee2.empname, projects.projectName, projects.projectManager
FROM employee2
LEFT OUTER JOIN projects ON employee2.empid = projects.empid
UNION
SELECT employee2.empid, employee2.empname, projects.projectName, projects.projectManager
FROM employee2
RIGHT OUTER JOIN projects ON employee2.empid = projects.empid;

-- scaler function

-- using ucase()
select name, ucase(name) as upperCaseName from athlete_events1; -- we see all the names turn to uppercase

-- using lcase() to lower case the noc column
select NOC, lcase(NOC) as lowerNOC from athlete_events1;

-- using mid()
select Team, mid(Team,1,3) as teamAbv from athlete_events1; -- shows team abreveated as first 3 characters
