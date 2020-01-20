--- 
--- Pewlett Hackard Employee DB SQL Queries
---

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
--SELECT count(first_name)  --41,380
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Practice Selct Into
SELECT first_name, last_name
INTO  retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- check result

SELECT * from retirement_info




















