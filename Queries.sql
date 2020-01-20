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

SELECT * from retirement_info ;

-- Recreate retirement_info table

DROP TABLE  retirement_info;


-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

--  Practice Inner Join

-- Joining departments and dept_manager tables
--  Gets all entries in dept_no and dept_manager 
--  where dept_no matches in both tables 
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


--  Left join practice with some aliasing practice

SELECT ri.emp_no, ri.first_name, ri.last_name, de.to_date
FROM retirement_info as ri
LEFT JOIN department_employees de ON ri.emp_no = de.emp_no;


--  Aliasing more practice

-- Joining departments and dept_manager tables
SELECT de.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as de
INNER JOIN dept_manager as dm
ON de.dept_no = dm.dept_no;

-- review
SELECT * FROM retirement_info
limit 10;

---  Current Employees
---
--- Use more filtering to restrict the retiring employees


SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN department_employees as de ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');




---  Practice Counting, Joining and Order by

-- Very nicely written group by code. Thanks UCB. 
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no  -- variables, first one is the countby, second is the groupby
FROM current_emp as ce  --  from with alias
LEFT JOIN department_employees as de  -- left jion with alias
ON ce.emp_no = de.emp_no  -- join condtion
GROUP BY de.dept_no  -- group by
ORDER BY de.dept_no;

--- Skill Drill
--- Save the last query as a new table "retiring_employees"
--- First save as table then save as CSV

SELECT COUNT(ce.emp_no), de.dept_no   -- countby and group by variables
INTO  retiring_employees  -- name of new table
FROM current_emp as ce  --  from table with alias
LEFT JOIN department_employees as de  -- left join  to with alias
ON ce.emp_no = de.emp_no  -- join condtion
GROUP BY de.dept_no  -- group by
ORDER BY de.dept_no;  -- order by

---
--- Check it fool     
---

SELECT * FROM retiring_employees



--- Skill Drill Plus
--- Add Dept_Name to report table

SELECT COUNT(ce.emp_no), de.dept_no, dp.dept_name   -- countby and group by variables
--INTO  retiring_employees  -- name of new table
FROM current_emp as ce  --  from table with alias
LEFT JOIN department_employees as de  -- left join  to with alias
ON ce.emp_no = de.emp_no  -- join condtion
LEFT JOIN departments as  dp 
ON de.dept_no = dp.dept_no
GROUP BY de.dept_no, dp.dept_name  -- group by
ORDER BY de.dept_no;  -- order by

---
--- Disco !!!
--- 



--- 
---  7.3.5 Additional Lists
---

---
--- 1 Employee Information: A list of employees containing
--- 	their unique employee number, their last name, first name, gender, to_date, and salary
---     filter by retiring employees

SELECT em.emp_no, em.last_name, em.first_name, em.gender, sa.salary, de.to_date 
-- SELECT COUNT (*)  ---41,380  --45, 784 when joined with de - seems wrong - why take data from dept emp if emp is really what we want???
INTO emp_info   
FROM employees AS em
INNER JOIN salaries sa 
ON em.emp_no = sa.emp_no
INNER JOIN department_employees de 
ON em.emp_no = de.emp_no
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (em.hire_date BETWEEN '1985-01-01' AND '1988-12-31');


---
--- 2 Manager Information: A list of employees containing Managers retiring info
---   A list of managers for each department, including 
---   the department number, name, and the manager’s employee number, last name, first name, 
---   and the starting and ending employment dates

SELECT  COUNT (*) --- only  5??

SELECT  
		dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);


---
--- Department Retirees: An updated current_emp list that includes everything it currently has, 
--- but also the employee’s departments
--- 

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
-- INTO dept_info
FROM current_emp as ce
INNER JOIN department_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
ORDER BY 2,3;


---
---
-- What’s going on with the salaries?
-- Why are there only five active managers for nine departments?
-- Why are some employees appearing twice?
---
---

---
--- Skill Drill
-- Create a query that will return only the information relevant to the Sales team. The requested list includes:
-- Employee numbers
-- Employee first name
-- Employee last name
-- Employee department name
-- 

SELECT ce.emp_no,  -- current employee table
ce.first_name,
ce.last_name,
d.dept_name	  -- department table.
INTO sales_emp
FROM current_emp as ce
INNER JOIN department_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name ='Sales'
ORDER BY 3,2;

--
-- Skill Drill
-- Create another query that will return the following information for the Sales and Development teams:
-- Employee numbers
-- Employee first name
-- Employee last name
-- Employee department name
--

SELECT ce.emp_no,  -- current employee table
ce.first_name,
ce.last_name,
d.dept_name	  -- department table.
INTO sales_dev_emp
FROM current_emp as ce
INNER JOIN department_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development') --- use In with WHERE
ORDER BY 3,2;

--
--
-- select * from sales_dev_emp
--
--



