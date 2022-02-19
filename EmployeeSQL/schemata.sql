-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Setting up the schema

Drop Table if exists Departments;
Drop Table if exists dept_emp;
Drop Table if exists dept_manager;
Drop Table if exists employees;
Drop Table if exists Salaries;
Drop Table if exists Titles;

CREATE TABLE "Departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
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

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR(255)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


--Data Analysis

--1. List the following details for each employee: employee number, last name, first name, sex and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, Salaries.salary
FROM employees
INNER JOIN Salaries Using(emp_no);
---employees.emp_no=Salaries.emp_no;

--2. List the first name, last name and hire date for employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';

--where hire_date between '1/1/1986' and '12/31/1986' didn't work

--3. List the manager of each department with department number, department name, manager's employee's number
-- last name and first name.
SELECT dept_manager.dept_no, departments.dept_no, dept_manager.emp_no, employess.last_name, employees.first_name
FROM dept_manager
INNER JOIN employees USING(emp_no)
INNER Join Departments USING(dept_no);

--4. List the department of each employee with employee number, last name, first name and department name.
Select employees.emp_no, employees.last_name, employees.first_name, Departments.dept_name
From employees
INNER JOIN dept_emp USING(emp_no)
INNER JOIN Departments USING(dept_no);


--5. List first name, last name and sex for employees whose first name is "Hercules" and last name begins with "B".
Select first_name, last_name, sex
From employees
WHERE first_name = 'Hercules' and last_name like 'B%';


--6. List all employees in the Sales department, including their employee number, last name, first name and department name.

--7. List all employees in the Sales and Development departments including their employee number, last name, first name and deparment name.

--8. In descending order, list the frequency count of employee last names and how many employes share each last name. 



