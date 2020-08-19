-- Create tables and import CSVs
DROP TABLE departments;
CREATE TABLE departments (dept_no VARCHAR NOT NULL, dept_name VARCHAR);
ALTER TABLE departments ADD COLUMN ID SERIAL PRIMARY KEY;
SELECT * FROM departments;

DROP TABLE dept_emp;
CREATE TABLE dept_emp (emp_no VARCHAR, dept_no VARCHAR);
ALTER TABLE dept_emp ADD COLUMN ID SERIAL PRIMARY KEY;
SELECT * FROM dept_emp;

DROP TABLE dept_manager;
CREATE TABLE dept_manager (dept_no VARCHAR, emp_no VARCHAR);
ALTER TABLE dept_manager ADD COLUMN ID SERIAL PRIMARY KEY;
SELECT * FROM dept_manager;

DROP TABLE employees;
CREATE TABLE employees (emp_no VARCHAR, emp_title VARCHAR,
						birth_date VARCHAR, first_name VARCHAR, last_name VARCHAR, sex VARCHAR, hire_date DATE NOT NULL);
ALTER TABLE employees ADD COLUMN ID SERIAL PRIMARY KEY;
SELECT * FROM employees;

DROP TABLE salaries;
CREATE TABLE salaries (emp_no VARCHAR, salary INT);
ALTER TABLE salaries ADD COLUMN ID SERIAL PRIMARY KEY;
SELECT * FROM salaries;

DROP TABLE titles;
CREATE TABLE titles (title_id VARCHAR, title VARCHAR);
ALTER TABLE titles ADD COLUMN ID SERIAL PRIMARY KEY;
SELECT * FROM titles;

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, 
employees.last_name, employees.first_name
FROM departments
RIGHT JOIN dept_manager
ON (departments.dept_no = dept_manager.dept_no)
INNER JOIN employees
ON (dept_manager.emp_no = employees.emp_no);

-- List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN departments
ON (dept_emp.dept_no = departments.dept_no);

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.emp_no, employees.last_name, employees.first_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN departments
ON (dept_emp.dept_no = departments.dept_no)
WHERE departments.dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN departments
ON (dept_emp.dept_no = departments.dept_no)
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT employees.last_name, COUNT(employees.emp_no)
FROM employees 
GROUP BY employees.last_name 
ORDER BY COUNT(employees.emp_no) DESC;








