-- Drop table if exists
DROP TABLE retirement_titles;

-- Create a new table
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS t
ON e.emp_no=t.emp_no
WHERE e.birth_date >= '19520101' AND e.birth_date <= '19551231'
ORDER BY e.emp_no;

-- Set primary & foreign keys
ALTER TABLE retirement_titles
ADD PRIMARY KEY (emp_no, from_date);
ALTER TABLE retirement_titles
ADD FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

-- Drop table if exists
DROP TABLE unique_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Set primary & foreign keys
ALTER TABLE unique_titles
ADD PRIMARY KEY (emp_no);
ALTER TABLE unique_titles
ADD FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

-- Drop table if exists
DROP TABLE retiring_titles;

-- Retrieve number of employees who are about to retire
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Set primary & foreign keys
ALTER TABLE retiring_titles
ADD PRIMARY KEY (title);
ALTER TABLE retiring_titles
ADD FOREIGN KEY (title)
REFERENCES retiring_titles(title);

-- Drop table if exists
DROP TABLE mentorship_eligibilty;

-- Create a Mentorship Eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibilty
FROM employees AS e
JOIN dept_employee AS de
ON e.emp_no=de.emp_no
JOIN titles AS t
ON e.emp_no=t.emp_no
WHERE de.to_date='99990101'
AND e.birth_date>='19650101'
AND e.birth_date<='19651231'
ORDER BY e.emp_no, t.from_date DESC;

-- Set primary & foreign keys
ALTER TABLE mentorship_eligibilty
ADD PRIMARY KEY (emp_no);
ALTER TABLE mentorship_eligibilty
ADD FOREIGN KEY (emp_no)
REFERENCES employees(emp_no);

