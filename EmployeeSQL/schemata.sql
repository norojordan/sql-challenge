-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/

-- Setting up the schema

CREATE TABLE "departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(255)   NOT NULL,
    "birth_date" VARCHAR(255)   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(255)   NOT NULL,
    "hire_date" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(255)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--Data Analysis

--1. List the following details for each employee: employee number, last name, first name, sex and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries Using(emp_no);

-- Other method - without JOIN
--select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
--from employees e, salaries s
--where e.emp_no = s.emp_no;


--2. List the first name, last name and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';


--3. List the manager of each department with department number, department name, manager's employee's number
-- last name and first name.

SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN employees USING(emp_no)
INNER Join departments USING(dept_no);

--4. List the department of each employee with employee number, last name, first name and department name.
Select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
From employees
INNER JOIN dept_emp USING(emp_no)
INNER JOIN departments USING(dept_no);


--5. List first name, last name and sex for employees whose first name is "Hercules" and last name begins with "B".
Select first_name, last_name, sex
From employees
WHERE first_name = 'Hercules' and last_name like 'B%';


--6. List all employees in the Sales department, including their employee number, last name, first name and department name.
Select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
From employees
INNER JOIN dept_emp USING(emp_no)
INNER JOIN departments USING(dept_no)
where dept_name = 'Sales';

--select de.emp_no, e.last_name, e.first_name, d.dept_name
--from dept_emp de, departments d, employees e
--where de.emp_no = e.emp_no
--and de.dept_no = d.dept_no
--and d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments including their employee number, last name, first name and deparment name.

Select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
From employees
INNER JOIN dept_emp USING(emp_no)
INNER JOIN departments USING(dept_no)
where (dept_name = 'Sales' or dept_name = 'Development');


--8. In descending order, list the frequency count of employee last names and how many employees share each last name. 
select last_name, count(last_name) as fcount
from employees 
group by last_name
order by fcount desc;




