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