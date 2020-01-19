-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

--DROP TABLE employees;  --had to recreate it. made a mistake.

CREATE TABLE employees (
	emp_no int NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date VARCHAR NOT NULL,
	PRIMARY KEY (emp_no)
	--UNIQUE (dept_name)
	);
	
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

	
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

--DROP TABLE titles;  --had to recreate it. made a mistake.

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

-- DROP TABLE department_employees;  --had to recreate it. made a mistake.

CREATE TABLE department_employees (
	emp_no INT NOT NULL, 
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, dept_no)
);


SELECT * FROM departments; 
SELECT * FROM employees;
SELECT * FROM dept_manager; 
SELECT * FROM salaries;
SELECT * FROM titles;
SELECT * FROM department_employees;

-- Now some data analysis

--  employee data born between 1952-01-01 and 1955-12-31
SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
limit 10;


SELECT count(*)  --90,398
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Skill Drill
-- Create three more queries to search for employees who were born in 1953, 1954, and 1955.

-- 1952 ount
SELECT count(*) -- 21,209
FROM employees
WHERE birth_date BETWEEN '1952-1-01' AND '1952-12-31';

-- 1953
SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- 1953 count
SELECT count(*) -- 22,857
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- 1954
SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- 1954 count
SELECT count(*) -- 23,228
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- 1955 count
SELECT count(*) -- 22,007
FROM employees
WHERE birth_date BETWEEN '1955-01' AND '195512-31';


--- 
--- Retirement Eligibility -- 41,380
---

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT count(*)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
