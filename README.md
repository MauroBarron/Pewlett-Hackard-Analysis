# Pewlett-Hackard-Analysis
## **Exploring databases with SQL using PostreSQL**

### Contents: 

1. Project Description.
2. Project Results Summary.
3. Entity Relationship Diagram
4. List of attachments.

### 1 -Project Description.  

Starting with a set of csv files of employee data from PH Human Resources, the overall objectives are to build an Entity Relationship Diagram, create a SQL database, import the csv files, and write queries that create necessary new tables, analyze the data and ultimately paint a picture of the impact of impending retiring employees on the company's human resource needs, and identify a set of  potential mentors. 

### 2 -Project Results Summary.  

###### Overall Summary

Pewlett Hackard currently has 240,124 employees of which 72,458 are eligible for retirement as defined by having a birth date between 1952 and 1955 inclusive.

This represents a whopping 30% of the current PH workforce. Clearly this is a potentially huge problem for PH.

##### Hiring

Over the past four  years where full data was available, 1999-99, the number of new hires has been decreasing. 

1. 1999 - 1,514 new hires
2. 1998 - 4,155 new hires
3. 1997 -  6,669 new hires
4. 1996 -  9,574 new hires

So if the all the 72K eligible employees retire in the next four years at an average rate of 13,000 per year, this clearly means HP needs to ramp up resources in their Recruiting and HR departments and find prepare to onboard at least 50% more folks per year than they have for their largest recent hiring year of 1996. 

###### Exodus by Department

Looking at the exodus by department, we can see that most retiring people are either Senior Engineeers or Senior Staff. 

![Retirees by Job Title](/Images/Retirees_by_Job_Title.png)

###### Mentors to the Rescue

Fortunately some folks have been identified as potential mentors that can help coach younger employees into developing their skills to take some of the senior positions.  The total number of mentors 8,555, represents about 12% of the retiring employees, so depending on their availability to actually server as mentors, this will alleviate the employee shortfall to a small degree

![MentorsbyJobTitle](/Images/Mentors_by_Job_Title.png)

###### Recommendations

Clearly PH has to develop a thorough plan to handle this potentially disastrous shortfall of senior engineers and senior staff. Internal mentoring will definitely help, but overall a massive recruiting effort will need to take place.

Additional analysis should be done by department. For each department we should identify the number of retiring folks and the number of available mentors, as the percentage difference is likely to vary by department. In short, more analysis by department may lead to discover that different staffing strategies will be needed by different departments.

### 3 -Entity Relationship Diagram  

The ERD below shows the provided and derived tables of the database.  Unfortunately QuickDBD limits the free diagram to ten named tables, so the table shown below named "Table 11," is the Mentor list. Other temporary derived tables were also not included in this ERD due to 10 table limit, but Mentor is too important to the business questions to drop from the ERD.

![ERD](/Images/PH_Retiring_Employees_ERD.png)


### 4 -List of Attachments

###### Queries

1. The schema.sql shows the code used to import the table
2. The Queries.sql contains the code used to build some of the intermediate tables used in this analysis. 
3. The Challenge.SQL  contains the queries to build the three tables specific to the challenge.  This sql also contains various ad hoc summary queries used to flush the report summary.

###### Files. Six new tables created and exported as CSV

1. retirement_info.csv - practice table. Initial list of retiring employees. Defined by a birth date range, and by a hire_date range
2. current_emp.csv - practice table: retirement_info table filtered by retirement date designation of "9999-01-01"
3. retiring_employees_csv - practice table.  a report table. list departments and count of employees by department eligible for retirement.
4. sales_dev.emp.csv  - practice table: Retiring employees for Saves and Development departments
5. emp_info.csv  - Current employees.  Defined by a birth date range, hire date range and current employee status.
6. manager_info.csv - Current managers by department
7. dept_info.csv  - Current employees appended with department info. 
8. titles_retiring.csv - list of  employees  eligible for retirement with all job titles they had at PH.
9. recent_titles_retiring.csv - A clean version of titles_retiring containing only the latest (recent) job title.
10. mentors.csv. - A list of employees that match criterion to be mentors.
