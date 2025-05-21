📊 Advanced SQL Query Collection


This repository contains a set of advanced SQL queries designed to demonstrate the use of aggregation functions, grouping, filtering with HAVING, subqueries, and sorting techniques in real-world business scenarios.


🧠 Query Descriptions

1. 🗺️ Completed Orders by Region

SELECT region, COUNT(*), COUNT(DISTINCT customer_id) 
FROM orders 
WHERE status = 'completed' 
GROUP BY region 
ORDER BY COUNT(*) DESC;
	•	Purpose: Count the total number of completed orders and distinct customers per region.
	•	Highlights: Use of COUNT(*) vs COUNT(DISTINCT ...), grouped by region, with descending order of total orders.

2. 📚 Top Authors with High-Priced Books

SELECT author, COUNT(id) 
FROM books 
WHERE price > 700 
GROUP BY author 
HAVING COUNT(id) > 2 
ORDER BY COUNT(id) DESC;
	•	Purpose: Find authors who have written more than 2 books priced over 700.
	•	Highlights: Combination of WHERE and HAVING, ordered by the number of qualifying books.

3. 🧮 Product Sales Under Threshold

SELECT product_id, SUM(price) AS total_sales, SUM(quantity_sold) AS total_quantity 
FROM sales 
WHERE quantity_sold < 30 
GROUP BY product_id 
HAVING SUM(price) < 2000 
ORDER BY total_quantity DESC, total_sales ASC;
	•	Purpose: Analyze low-quantity, low-value product sales.
	•	Highlights: Multi-condition filtering and multi-level ORDER BY.

4. 👤 Salesperson Performance in 2024

SELECT salesperson, 
       SUM(amount) AS total_sales, 
       AVG(amount) AS avg_sale, 
       MAX(amount) AS max_sale 
FROM sales 
WHERE year = 2024 
GROUP BY salesperson 
HAVING SUM(amount) > 10000 
ORDER BY avg_sale DESC;
	•	Purpose: Evaluate salespeople with over 10,000 in total 2024 sales.
	•	Highlights: Aggregation with SUM, AVG, MAX, and filtering via HAVING.

5. 🧑‍💼 High Earners Between Peers and Managers

SELECT e.id, e.name
FROM employees e
WHERE e.salary > (
      SELECT AVG(e2.salary)
      FROM employees e2
      WHERE e2.department_id = e.department_id)
  AND e.salary < (
      SELECT AVG(e3.salary)
      FROM employees e3
      WHERE e3.id = e.manager_id);
	•	Purpose: Select employees earning more than their department’s average but less than their manager’s average.
	•	Highlights: Use of correlated subqueries for comparative analysis.



🧩 Topics Covered
	•	Aggregation: SUM(), AVG(), COUNT(), MAX()
	•	Filtering: WHERE, HAVING
	•	Grouping: GROUP BY
	•	Sorting: ORDER BY
	•	Subqueries (including correlated subqueries)
