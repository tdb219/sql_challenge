-- Begin Data Engineering Section

-- create tables and corresponding keys


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

-- select * from "departments"

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL
);

-- select * from "dept_emp"

CREATE TABLE "dept_manager" (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL
);

-- select * from "dept_manager"


CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(30)   NOT NULL,
    "birth_date" varchar(30)   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(30)   NOT NULL,
    "hire_date" varchar(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

-- select * from "employees"

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

-- select * from "salaries"


CREATE TABLE "titles" (
    "title_id" varchar(30)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

-- select * from "titles"


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


-- End table generation


-- Begin Data Analysis section

-- List the following details of each employee: employee number, last name, first name, sex, and salary.
select "employees".emp_no, "employees".last_name, "employees".first_name, "employees".sex, "salaries".salary
from "employees"
left join "salaries"
on "employees".emp_no = "salaries".emp_no


-- List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date from employees
where hire_date like '%1986'


-- List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select "dept_manager".dept_no, "departments".dept_name, "dept_manager".emp_no, "employees".last_name, "employees".first_name
from "dept_manager"
left join "employees"
on "dept_manager".emp_no = "employees".emp_no
left join "dept_emp"
on "dept_manager".emp_no = "dept_emp".emp_no
left join "departments"
on "dept_emp".dept_no = "departments".dept_no


-- List the department of each employee with the following information: employee number, last name, first name, and department name.
select "employees".emp_no, "employees".last_name, "employees".first_name, "departments".dept_name
from "employees"
left join "dept_emp"
on "employees".emp_no = "dept_emp".emp_no
left join "departments"
on "dept_emp".dept_no = "departments".dept_no


-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select * from "employees"
where first_name = 'Hercules' and last_name like 'B%'


-- List all employees in the Sales department, including their employee number, last name, first name, and department name.
select "employees".emp_no, "employees".last_name, "employees".first_name, "departments".dept_name
from "employees"
left join "dept_emp"
on "employees".emp_no = "dept_emp".emp_no
left join "departments" 
on "dept_emp".dept_no = "departments".dept_no
where dept_name = 'Sales'


-- List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select "employees".emp_no, "employees".last_name, "employees".first_name, "departments".dept_name
from "employees"
left join "dept_emp"
on "employees".emp_no = "dept_emp".emp_no
left join "departments" 
on "dept_emp".dept_no = "departments".dept_no
where dept_name = 'Sales' or dept_name = 'Development'

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
select last_name, count(last_name) as "last_name_count" from "employees"
group by last_name
order by "last_name_count" desc