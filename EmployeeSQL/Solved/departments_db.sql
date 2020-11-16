create table departments (
	dept_no VARCHAR,
	dept_name VARCHAR,
	PRIMARY KEY dept_no
);

select * from departments
-------------------------------
create table dept_emp (
	emp_no INTEGER,
	dept_no VARCHAR
);
 
select * from dept_emp
-------------------------------
create table dept_manager (
	dept_no VARCHAR,
	emp_no INTEGER
);
 
select * from dept_manager
-------------------------------
create table employees (
	emp_no INTEGER,
	emp_title_id VARCHAR,
	birth_date VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	sex	VARCHAR,
	hire_date DATE
);
 
select * from employees
-------------------------------
create table salaries (
	emp_no INTEGER,	
	salary INTEGER
);
 
select * from salaries
-------------------------------
create table titles (
	title_id VARCHAR,	
	title VARCHAR
);

select * from titles
-----------------------------------------------------------------------------
--1)List the following details of each employee: employee number, last name, first name, sex, and salary.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
From salaries as s
inner join employees as e ON
e.emp_no = s.emp_no;

--2)List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date from employees
where hire_date between '1986-01-01' and '1986-12-31'
order by hire_date;

--3)List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
create view dept_manager_emp_no as (
	select d.dept_no, d.dept_name, dm.emp_no
	From dept_manager as dm
	inner join departments as d ON
	d.dept_no = dm.dept_no
	);
	
select * from dept_manager_emp_no --Next step is to join the view by employee name
	
	select dmen.dept_no, dmen.dept_name, dmen.emp_no, e.last_name, e.first_name
	from employees as e
	inner join dept_manager_emp_no as dmen ON
	e.emp_no = dmen.emp_no;

--4)List the department of each employee with the following information: employee number, last name, first name, and department name.
create view emp_by_dept as (
	select de.emp_no, d.dept_name
	from dept_emp as de
	inner join departments as d ON
	de.dept_no = d.dept_no
	);
	
select * from emp_by_dept--Next join view with names

select ed.emp_no, ed.dept_name, e.last_name, e.first_name
	from employees as e
	inner join emp_by_dept as ed ON
	ed.emp_no = e.emp_no;

--5)List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select first_name, last_name, sex from employees
where first_name = 'Hercules' and last_name LIKE 'B%';

--6)List all employees in the Sales department, including their employee number, last name, first name, and department name.
create view sales_dept as (
	select dept_name, dept_no from departments
	where dept_name = 'Sales'
	);

select * from sales_dept--Join sales_dept with emp_no, last_name, first_name

create view emp_no_sales as (
	select de.emp_no, sd.dept_name
	from dept_emp as de
	inner join sales_dept as sd ON
	de.dept_no = sd.dept_no
);

select * from emp_no_sales--Join emp_no_sales with employees names

create view sales_emp as (
	select ens.emp_no, ens.dept_name, e.last_name, e.first_name
	from employees as e
	inner join emp_no_sales as ens ON
	ens.emp_no = e.emp_no
);

select * from sales_emp

--7) List all employees in the Sales and Development departments, 
--   including their employee number, last name, first name, and department name.
create view sales_and_dev_depts as (
	select dept_name, dept_no from departments
	where dept_name = 'Sales' or dept_name = 'Development'
	);
	
select * from sales_and_dev_depts

create view sales_and_dev_emp as (
	select de.emp_no, sdd.dept_name
	from dept_emp as de
	inner join sales_and_dev_depts as sdd ON
	de.dept_no = sdd.dept_no
);

select * from sales_and_dev_emp

create view sales_and_dev_names as (
	select sdd.emp_no, sdd.dept_name, e.last_name, e.first_name
	from employees as e
	inner join sales_and_dev_emp as sdd ON
	sdd.emp_no = e.emp_no
);

select * from sales_and_dev_names

--8) In descending order, list the frequency count of employee last names, 
--   i.e., how many employees share each last name.
select count(employees.last_name), employees.last_name
from employees
group by last_name
order by count(employees.last_name) DESC;