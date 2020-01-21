--- 
--- Pewlett Hackard Employee DB SQL Challenge
---


--  Part 1.  Generate Tables

--  1 Number of [titles] Retiring

SELECT COUNT (*) -- 54,722  This is what we want. RIGHT JOIN ti on ce. Then left join salaries on current employees.
FROM titles ti
RIGHT JOIN current_emp AS ce ON ti.emp_no = ce.emp_no
LEFT JOIN salaries AS sa ON ce.emp_no=sa.emp_no;


SELECT ce.emp_no,
		ce.first_name,
		ce.last_name,
		ti.title,
		ti.from_date,
		sa.salary
--INTO titles_retiring
FROM titles AS ti
RIGHT JOIN current_emp AS ce ON ti.emp_no = ce.emp_no
LEFT JOIN salaries AS sa on ce.emp_no=sa.emp_no
LIMIT 20;

---
--- Part 1. 2 Only the Most Recent Titles
---
SELECT COUNT(*) FROM titles_retiring;
SELECT * FROM titles_retiring
ORDER BY emp_no, from_date DESC;

---
---  Remove Duplicates
---  this is actually a method to find duplicates which I thought is what they were asking for
---  but they are actually asking for latest title.
---  this did find one duplicate. will run again after latest title cleanup
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

SELECT * FROM titles_retiring;

SELECT * FROM titles_retiring
ORDER by 1,5 DESC;

---
---  Part 1. 2  Use Partitioning Method to retain only latest title for employees
---  			Generates table: recent_titles_retiring
---

---DROP TABLE recent_titles_retiring;

SELECT emp_no, first_name, last_name, title, from_date, salary 
INTO recent_titles_retiring
FROM (SELECT emp_no, first_name, last_name, title, from_date, salary, ROW_NUMBER() OVER 
		(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   			FROM titles_retiring
  	 ) tmp WHERE rn = 1;

SELECT COUNT(*) FROM recent_titles_retiring; -- still 33,118 looking good.
SELECT * FROM recent_titles_retiring
ORDER BY 1
LIMIT 20;

--- This is the syntax found in https://blog.theodo.com/2018/01/search-destroy-duplicate-rows-postgresql
SELECT id, firstname, lastname, startdate, position
FROM
  (SELECT id, firstname, lastname, startdate, position,
     ROW_NUMBER() OVER 
(PARTITION BY (firstname, lastname) ORDER BY startdate DESC) rn
   FROM people
  ) tmp WHERE rn = 1;


---
---  Part 1. 3 Who's Ready for a Mentor?
---














