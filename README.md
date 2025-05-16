

This document describes four SQL queries that analyze sales data across departments, employees, and time periods, plus a client income analysis. The queries provide various business intelligence metrics.


Query 1: Departmental Sales Metrics for 2023


SELECT departments.department_name, 
       COALESCE(AVG(sales.sale_amount), 0) AS avg_sales,
       COALESCE(MAX(sales.sale_amount), 0) AS max_sales,
       COALESCE(MIN(sales.sale_amount), 0) AS min_sales 
FROM employees 
LEFT JOIN departments ON departments.department_id = employees.department_id 
LEFT JOIN sales ON employees.employee_id = sales.employee_id 
       AND sales.sale_date BETWEEN '2023-01-01' AND '2023-12-31' 
GROUP BY departments.department_name 
HAVING AVG(sales.sale_amount) > 500 
ORDER BY AVG(sales.sale_amount) DESC;
Purpose:
Retrieves average, maximum, and minimum sales amounts by department for 2023, filtering departments with average sales > 500.

Output:

department_name: Department name
avg_sales: Average sale amount (nulls as 0)
max_sales: Highest single sale (nulls as 0)
min_sales: Lowest single sale (nulls as 0)
Filters:

2023 sales only
Departments must have average sales > 500
Ordered by average sales (highest first)





Query 2: 2024 Department Performance Metrics


SELECT departments.department_name, 
       COUNT(employees.employee_id) AS employee_count, 
       SUM(sales.sale_amount) AS total_sales,
       SUM(sales.sale_amount)/COUNT(employees.employee_id) AS avg_per_employee 
FROM employees 
INNER JOIN departments ON employees.department_id = departments.department_id
INNER JOIN sales ON employees.employee_id = sales.employee_id 
WHERE sale_date BETWEEN '2024-01-01' AND '2024-12-31' 
GROUP BY departments.department_name 
HAVING SUM(sales.sale_amount) > 2000 
ORDER BY total_sales DESC;
Purpose:
Analyzes 2024 sales performance with per-employee metrics.

Output:

department_name: Department name
employee_count: Number of employees
total_sales: Sum of all sales
avg_per_employee: Sales per employee ratio
Filters:

2024 sales only
Departments must have total sales > 2000
Ordered by total sales (highest first)





Query 3: Comprehensive 2023 Department Analysis


SELECT d.department_name, 
       COALESCE(COUNT(DISTINCT e.employee_id),0) AS count_employee,
       COALESCE(COUNT(DISTINCT s.sale_amount),0) AS count_distinct_sale,
       COALESCE(MAX(s.sale_amount),0) AS max_sale,
       COALESCE(AVG(s.sale_amount), 0) AS avg_sale
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
LEFT JOIN sales s ON s.employee_id = e.employee_id 
       AND s.sale_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY d.department_name
HAVING COUNT(DISTINCT e.employee_id) > 3
       AND COALESCE(MAX(s.sale_amount), 0) > 5000
ORDER BY avg_sale DESC;
Purpose:
Identifies high-performing departments in 2023 with specific size and sales thresholds.

Output:

department_name: Department name
count_employee: Distinct employees (nulls as 0)
count_distinct_sale: Unique sale amounts (nulls as 0)
max_sale: Highest sale (nulls as 0)
avg_sale: Average sale (nulls as 0)
Filters:

Must have > 3 employees
Maximum sale must exceed 5000
Ordered by average sale (highest first)




Query 4: High-Income Client Identification


SELECT c.client_id, c.name, c.city, c.income
FROM clients c
JOIN (
      SELECT city, AVG(income) AS avg_income
      FROM clients
      GROUP BY city
     ) clients_2 ON clients_2.city = c.city
WHERE c.income > clients_2.avg_income
ORDER BY c.city, c.income DESC;
Purpose:
Identifies clients earning above their city's average income.

Output:

client_id: Client identifier
name: Client name
city: Client location
income: Client income amount
Filters:

Only clients earning above their city's average
Ordered by city then income (highest first)
Database Schema Notes

The queries assume these relationships:

Departments → Employees (one-to-many)
Employees → Sales (one-to-many)
Clients table with city-based income data
Tables contain at minimum:

departments: department_id, department_name
employees: employee_id, department_id
sales: sale_amount, employee_id, sale_date
clients: client_id, name, city, income