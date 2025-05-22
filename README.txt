📊 Advanced SQL Queries for Business Analytics

This repository contains a collection of advanced SQL queries designed to solve real-world business problems involving employees, departments, sales, and clients.

Each query demonstrates practical use of:
- Aggregate functions (`AVG()`, `MAX()`, `MIN()`, `SUM()`)
- Conditional aggregation (`HAVING`, `COALESCE`)
- Joins (including `LEFT JOIN`, `INNER JOIN`)
- Subqueries and correlated subqueries
- Advanced logic for business intelligence scenarios

-

🔍 Query 1: Department Sales Summary (2023)

Goal: Show departments with average sales over 500 for 2023.  
Highlights: Handles missing sales with `COALESCE`.

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

—

📈 Query 2: Total Sales and Productivity per Department (2024)

Goal: Analyze department performance in 2024, showing total sales and average sales per employee.
Highlights: Filters for departments with over 2000 in total sales.

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

—

🧮 Query 3: Department Metrics with Filters

Goal: List departments with:
More than 3 employees
At least one sale over 5000 in 2023
Highlights: Uses COUNT(DISTINCT ...), COALESCE, and multiple conditions in HAVING.

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

—

🌆 Query 4: Above-Average Clients by City

Goal: List clients whose income is above the average for their city.
Highlights: Demonstrates subquery join for comparative filtering.

SELECT c.client_id, c.name, c.city, c.income
FROM clients c
JOIN (
    SELECT city, AVG(income) AS avg_income
    FROM clients
    GROUP BY city
) clients_2 ON clients_2.city = c.city
WHERE c.income > clients_2.avg_income
ORDER BY c.city, c.income DESC;  

—

🧠 Query 5: Salary Comparison (Department vs. Manager)

Goal: Find employees whose salary is:
Above the department average
Below the average salary of their manager (if applicable)
Highlights: Uses correlated subqueries for contextual comparison.

SELECT e.id, e.name
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
AND e.salary < (
    SELECT AVG(e3.salary)
    FROM employees e3
    WHERE e3.id = e.manager_id
);


-

🧠 Query 6: Price_vs_category_average

This query identifies products that are priced above their category’s average price. It calculates the percentage difference and shows relevant product and category details.

🔍 Logic

1. Use a CTE (`WITH average_price`) to calculate the average price per category.
2. Join this CTE with the `products` and `categories` tables.
3. Calculate the **percentage difference** between a product's price and its category's average.
4. Filter to include only products with a price over `$100`.

📌 Columns Returned

| Column         | Description                                      |
|----------------|--------------------------------------------------|
| `id`           | Product ID                                       |
| `name`         | Product name                                     |
| `avg_price`    | Average price of the product’s category          |
| `category`     | Name of the category                             |
| `diff_percent` | % difference between product and avg category price |

🛠️ Use Case

Useful for identifying premium or overpriced products within each category, and for pricing strategy analysis.


-


🧠 Query 7: Monthly Orders and Average Order Amount (2023)

Goal:
Analyze customer purchasing activity in 2023 by showing how many orders were made each month and what was the average order value.

Highlights:

Uses EXTRACT() to break down order dates by month.
Filters data for the calendar year 2023 using BETWEEN.
Groups results by month to calculate:
Total number of orders (COUNT(order_id)),
Average order amount rounded to two decimal places (ROUND(AVG(order_total), 2)).
SELECT 
  EXTRACT(month FROM order_date) AS month,
  COUNT(order_id), 
  ROUND(AVG(order_total), 2) AS avg_amount
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY EXTRACT(month FROM order_date);
Use Case:
Helpful for identifying seasonal trends in order volume and revenue patterns throughout the year.


-

💁🏻‍♀️ Query 8: Order Size Classification

Goal:
Categorize each order based on its total value into size groups: Small, Medium, or Large.

Highlights:

Uses CASE expression to classify order_total into three size categories:
Small — orders less than 500,
Medium — orders between 500 and 1000 (inclusive),
Large — orders greater than 1000.
Returns each order’s ID, total amount, and its corresponding size label.
SELECT order_id, order_total, 
  CASE
    WHEN order_total < 500 THEN 'Small'
    WHEN order_total >= 500 AND order_total <= 1000 THEN 'Medium'
    WHEN order_total > 1000 THEN 'Large'
  END AS order_size
FROM orders;
Use Case:
Useful for segmenting orders by size to tailor marketing, reporting, or operational strategies depending on order value.






