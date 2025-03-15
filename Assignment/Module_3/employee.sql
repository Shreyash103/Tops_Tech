-- create the database 
CREATE DATABASE EmployeeDB;

-- use the database 
USE EmployeeDB;

-- Create the table 
CREATE TABLE employees (
    id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    age INT,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- --------------- CRUD Operations --------

-- Create (INSERT) the data 
-- Insert data into the employees table
INSERT INTO employees (id, emp_name, age, department, salary)
VALUES
    (1, 'John Doe', 30, 'Engineering', 55000.00),
    (2, 'Jane Smith', 40, 'Marketing', 62000.00),
    (3, 'Samuel Adams', 25, 'Sales', 45000.00);
    
-- Read the data select all the data from the table 
SELECT * 
FROM employees;

-- for specific data read
SELECT * 
FROM employees 
WHERE department='Engineering';

-- UPDATE Operations 
UPDATE employees 
SET salary = 60000
WHERE id=1;

-- DELETE Operations - delete the raw where id=3
DELETE FROM employees 
WHERE id=3;


-- Check the table after Operations 
SELECT * 
FROM employees;








