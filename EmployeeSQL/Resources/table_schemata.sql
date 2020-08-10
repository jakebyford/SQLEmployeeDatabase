create table departments (
	dept_no VARCHAR,
	dept_name VARCHAR
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
