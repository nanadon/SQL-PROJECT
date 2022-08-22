#HR Database Exercises –

#1.Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"
select first_name as "First Name" ,last_name as "Last Name" from employees

#Write a query to get unique department ID from employee table
select distinct department_id from employees

#Write a query to get all employee details from the employee table order by first name, descending
select * from employees order by first_name

#Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary
select employee_id,first_name,last_name,salary from employees order by salary asc

#6. Write a query to get the total salaries payable to employees
select sum(salary) from employees

#Write a query to get the maximum and minimum salary from employees table
select max(salary),min(salary) from employees

#Write a query to get the average salary and number of employees in the employees table
select avg(salary),count(employee_id) from employees

#Write a query to get the number of employees working with the company
select count(employee_id) from employees

#Write a query to get the number of jobs available in the employees table
select count(job_id) from employees

#Write a query get all first name from employees table in upper case
select ucase(first_name) from employees

#Write a query to get the first 3 characters of first name from employees table
select left(first_name,3) from employees

#Write a query to get the length of the employee names (first_name, last_name) from employees table
SELECT first_name,last_name, LENGTH(first_name)+LENGTH(last_name)  'Length of  Names' 
FROM employees;

#Write a query to check if the first_name fields of the employees table contains numbers
SELECT * 
   FROM employees 
   WHERE  first_name REGEXP  '[0-9]';

#Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000
select first_name,salary from employees where salary between 10000 and 15000

#Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order
select first_name,last_name,department_id from employees where department_id in (30, 100) order by department_id asc

#Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100
(SELECT first_name, last_name, salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000, (select department_id from empoyees where department_id in (30, 100));

#Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE YEAR(hire_date)  LIKE '1987%';

#Write a query to display the first_name of all employees who have both "b" and "c" in their first name
select first_name from employees where first_name like "%b%c%"

#Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,00
SELECT last_name, job_id, salary
FROM employees
WHERE job_id IN ('IT_PROG', 'SH_CLERK')
AND salary NOT IN (4500,10000, 15000);

#Write a query to display the last name of employees whose names have exactly 6 characters
SELECT last_name FROM employees WHERE last_name LIKE '______';

#Write a query to display the last name of employees having 'e' as the third character
SELECT last_name FROM employees WHERE last_name LIKE '__e%';

#Write a query to get the job_id and related employee's id
Partial output of the query :
job_id
Employees ID
AC_ACCOUNT
206
AC_MGR
205
AD_ASST
200
AD_PRES
100
AD_VP
101 ,102
FI_ACCOUNT
110 ,113 ,111 ,109 ,112
25.
SELECT job_id, GROUP_CONCAT(employee_id, ' ')  'Employees ID' 
FROM employees GROUP BY job_id;

#Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999
UPDATE employees 
SET phone_number = REPLACE(phone_number, '124', '999') 
WHERE phone_number LIKE '%124%';

#Write a query to get the details of the employees where the length of the first name greater than or equal to 8
SELECT * 
FROM employees
WHERE LENGTH(first_name) >= 8;

#Write a query to append '@example.com' to email field
UPDATE employees SET email = CONCAT(email, '@example.com');

#Write a query to extract the last 4 character of phone numbers
SELECT RIGHT(phone_number, 4) as 'Ph.No.' FROM employees;

#Write a query to get the last word of the street address
SELECT location_id, street_address, 

#Write a query to get the locations that have minimum street length
SELECT * FROM locations
WHERE LENGTH(street_address) <= (SELECT  MIN(LENGTH(street_address)) 
FROM locations);

#Write a query to display the first word from those job titles which contains more than one words
SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
FROM jobs;

#Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position
SELECT first_name, last_name FROM employees WHERE INSTR(last_name,'C') > 2;

#Write a query that displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names
SELECT first_name "Name",
LENGTH(first_name) "Length"
FROM employees
WHERE first_name LIKE 'J%'
OR first_name LIKE 'M%'
OR first_name LIKE 'A%'
ORDER BY first_name ;

#Write a query to display the first name and salary for all employees. Format the salary to be 10 characters long, left-padded with the $ symbol. Label the column SALARY
SELECT first_name,
LPAD(salary, 10, '$') SALARY
FROM employees;

#Write a query to display the first eight characters of the employees' first names and indicates the amounts of their salaries with '$' sign. Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary
SELECT left(first_name, 8),
REPEAT('$', FLOOR(salary/1000)) 
'SALARY($)', salary
FROM employees
ORDER BY salary DESC;

#Write a query to display the employees with their code, first name, last name and hire date who hired either on seventh day of any month or seventh month in any year
SELECT employee_id,first_name,last_name,hire_date 
FROM employees 
WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;

