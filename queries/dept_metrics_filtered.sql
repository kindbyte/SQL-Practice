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
                           
