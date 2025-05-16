# SQL-Practice
 This project presents two advanced SQL queries designed to analyze department-level performance using employee and sales data. These queries utilize joins, date filtering, aggregate functions, null handling with COALESCE, and post-aggregation filtering with HAVING.  The queries help assess departmental efficiency, average performance, and total contributions based on historical sales data.
Query Overview
1. Department Sales Overview for 2023

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
📌 Purpose: This query analyzes average, maximum, and minimum sales per department for the year 2023. It includes departments even if they had no sales (via LEFT JOIN), and replaces NULL values with 0 using COALESCE.
📎 Key Details:
	•	LEFT JOIN ensures departments without any sales are still included.
	•	COALESCE(..., 0) handles missing data gracefully.
	•	Filters out departments with low performance (AVG(sale_amount) > 500).
	•	Results are sorted by AVG(sales) in descending order.

2. Department Sales and Efficiency for 2024

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
📌 Purpose: This query evaluates department productivity for the year 2024 by calculating:
	•	Total number of employees
	•	Total sales
	•	Average sales per employee
Only departments with total sales above 2000 are included.
📎 Key Details:
	•	INNER JOIN ensures only active departments and employees with sales data are included.
	•	Calculates a department-level performance ratio (avg_per_employee).
	•	Filters with HAVING to exclude underperforming departments.

🛠 SQL Features Used
	•	JOIN types: LEFT JOIN, INNER JOIN
	•	Date filtering with BETWEEN
	•	Null-safe aggregation with COALESCE
	•	Aggregation: AVG(), MAX(), MIN(), SUM(), COUNT()
	•	HAVING for filtering grouped data
	•	ORDER BY for sorting results

📁 Assumed Table Structures
	•	departments(department_id, department_name)
	•	employees(employee_id, department_id)
	•	sales(sale_id, employee_id, sale_amount, sale_date)

📌 Use Cases
This analysis can be used for:
	•	Departmental performance reviews
	•	Resource allocation decisions
	•	Incentive and bonus calculations
	•	Identifying high- or low-performing teams
