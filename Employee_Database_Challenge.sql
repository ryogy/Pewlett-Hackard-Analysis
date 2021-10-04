.sql

-- Create retirement titles column
SELECT e.emp_no,
e.first_name,
e.last_name,
titles.title,
titles.from_date,
titles.to_date
INTO retirement_titles
FROM employees as e
Inner Join titles
On (e.emp_no = titles.emp_no)
Where (birth_date Between '1952-01-01' And '1955-12-31')
Order By e.emp_no;

-- Create table for unique titles
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Create table to count retirement titles
Select Count(title), title 
Into retiring_titles
From unique_titles
Group By title
Order By count Desc;

-- Filtering Data to identify candidates for mentorship
Select Distinct On (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	titles.title
Into mentorship_eligibility
From employees as e
Inner Join dept_emp as de
On (e.emp_no = de.emp_no)
Inner Join titles
On (e.emp_no = titles.emp_no)
Where de.to_date = '9999-01-01'
And (e.birth_date Between '1965-01-01' And '1965-12-31')
Order By e.emp_no;

-- Counting number of eligible mentorship canidates (Not required as Deliverable)
Select Count(title), title 
Into mentorship_eligibility_count
From mentorship_eligibility
Group By title
Order By count Desc;