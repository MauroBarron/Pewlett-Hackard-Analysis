--- 
--- Pewlett Hackard Employee DB SQL Challenge
---

---
---  Part 1.  Generate Tables for "Number of [titles] Retiring." Include only most recent titles.
---

--- Check the Logic
SELECT COUNT (*) -- 489,903  This is what we want. RIGHT JOIN ti on em. Then left join salaries on employees.
FROM titles ti
RIGHT JOIN employees AS em ON ti.emp_no = em.emp_no  -- join employees to all titles.
LEFT JOIN salaries AS sa on em.emp_no=sa.emp_no  -- join employee salaries
JOIN department_employees as de ON em.emp_no = de.emp_no  -- Join dept to get current employee status

--- Now Get the data

-- DROP TABLE titles_retiring

SELECT em.emp_no,
		em.first_name,
		em.last_name,
		em.hire_date,
		em.birth_date,
		ti.title,
		ti.from_date,
		ti.to_date,
		sa.salary
INTO titles_retiring
FROM titles AS ti
RIGHT JOIN employees AS em ON ti.emp_no = em.emp_no  -- join employees to all titles.
LEFT JOIN salaries AS sa on em.emp_no=sa.emp_no  -- join employee salaries  
JOIN department_employees as de ON em.emp_no = de.emp_no  -- Join dept to get current employee status 
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')  --  User defined retirement age range
AND de.to_date = ('9999-01-01')  -- defines current employee 
;

---		data counts
---  	Joins produced 489,903 rows. 
---  	Birth range filter reduces to 147,942
---     Current Employee filter [to_date]  reduces to 112,049
---		SELECT * FROM titles_retiring LIMIT 10 -- sanity check
---		SELECT COUNT(*) FROM titles_retiring 
SELECT * FROM titles_retiring LIMIT 10 -- sanity check



---
---  Part 1.  Only the Most Recent Titles
---
---
---  Remove Duplicates: this is actually a method to find duplicates which is what I thought the Challenge was
---  asking for on first read. They are actually asking for latest title.
---
---  Did find one duplicate. Cleaned with 
---  
SELECT
  emp_no,
  title,
  count(*)
FROM titles_retiring
GROUP BY
  emp_no,
  title
HAVING count(*) > 1;

---
--- Retain Only the Most Recent Titles. Use partitioning to eliminate older titles for employees.
---

---DROP TABLE recent_titles_retiring;

SELECT emp_no, first_name, last_name, hire_date, birth_date, title, from_date, to_date, salary 
INTO recent_titles_retiring
FROM (SELECT emp_no, first_name, last_name, hire_date, birth_date, title, from_date, to_date, salary, ROW_NUMBER() OVER 
		(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   			FROM titles_retiring
  	 ) tmp WHERE rn = 1;


---  NOTE: The partitioning was dones using syntax found in https://blog.theodo.com/2018/01/search-destroy-duplicate-rows-postgresql

--- Sanity Checks
SELECT COUNT(*) FROM recent_titles_retiring; 72,458 -- looking good.
---
SELECT * FROM recent_titles_retiring
ORDER BY 1;
---

---
--- Duplicate Check After Partition
---
SELECT
  emp_no,
  title,
  count(*)
FROM recent_titles_retiring
GROUP BY
  emp_no,
  title
HAVING count(*) > 1;

---
--- found no duplicates
---


---
---  Part 1. 2  By Job Titles:  Count of current, eligible for retirement employees.
---  Question is "How many current employees of each title are presently eligible for retirement?"
---

---
---This next code chunk technically does as instructed but output is nonsensical to making a business decision
---Instructions introduced unncessary confusion by 
---
---
SELECT  from_date, title,  COUNT(title) 
FROM recent_titles_retiring
GROUP BY  from_date, title
ORDER BY 1 DESC, 2;

---
--- This next code chunk represents what I think they really are asking for. 
---
--- "How many current employees of each title are presently eligible for retirement?
---
---  Don't understand what is meant by "In descending order (by date)....
--- 

SELECT title, COUNT(title) 
FROM recent_titles_retiring rtr
GROUP BY rtr.title
ORDER BY 2 DESC;


--
---
---  Part 1. 3 Who's Ready for a Mentor?
---
---   Create a new table that contains the following information:
---		Employee number 
---		First and last name 
---		Title
---		from_date 
---     to_date
---	Note: The hire date needs to be between January 1, 1965 and December 31, 1965.
---	Also, make sure only current employees are included in this list.  
---		
---	Export the data as a CSV.

--- 

select * from recent_titles_retiring
ORDER BY 5

-- DROP TABLE mentors

SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date,
	hire_date,
	birth_date
INTO mentors
FROM recent_titles_retiring 
WHERE (hire_date BETWEEN '1985-01-01' AND '1985-12-31') -- Our user defined mentor age range
-- sanity check
SELECT COUNT(*) FROM mentors --- 8555
SELECT * FROM mentors LIMIT 25


---
---
--- Part 2.  Summary of the data
---
---

--
-- Number of individuals retiring
--

-- Total number of current employees  -- 240124
SELECT COUNT(*)
FROM employees AS em
JOIN department_employees as de ON em.emp_no = de.emp_no  -- Join dept to get current employee status 
WHERE de.to_date = ('9999-01-01')  -- 240124

-- Total number of retirement eligible employees
SELECT COUNT(*)FROM recent_titles_retiring -- 72458

-- Calculate percentage
SELECT CAST(72458 AS float) / CAST(240124 AS float)

-- Calculate numbers hired in past five year?

SELECT * FROM Employees ORDER BY hire_date DESC;

SELECT COUNT(*) FROM Employees
WHERE hire_date  BETWEEN '2000-01-01' AND '2000-12-31'; -- 13 -- not a full year - exclude

SELECT COUNT(*) FROM Employees
WHERE hire_date  BETWEEN '1999-01-01' AND '1999-12-31'; -- 1514

SELECT COUNT(*) FROM Employees
WHERE hire_date  BETWEEN '1998-01-01' AND '1998-12-31'; -- 4155

SELECT COUNT(*) FROM Employees
WHERE hire_date  BETWEEN '1997-01-01' AND '1997-12-31'; -- 6669

SELECT COUNT(*) FROM Employees
WHERE hire_date  BETWEEN '1996-01-01' AND '1996-12-31'; -- 9574

SELECT ((1514 + 4155 + 6669 + 9574)/4)


--- How about by dept?

SELECT title, COUNT(title) 
FROM recent_titles_retiring rtr
GROUP BY rtr.title
ORDER BY 2 DESC;

-- Mentors by dept

SELECT title, COUNT(title) 
FROM mentors m
GROUP BY m.title
ORDER BY 2 DESC;

