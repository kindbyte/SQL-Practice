SELECT departments.department_name, 
              COALESCE(AVG(sales.sale_amount), 0) AS avg_sales,
              COALESCE(MAX(sales.sale_amount), 0) AS max_sales,
              COALESCE(MIN(sales.sale_amount), 0) AS min_sales 
                  FROM employees 
                       LEFT JOIN departments ON departments.department_id = employees.department_id 
                       LEFT JOIN sales ON employees.employee_id = sales.employee_id 
                               AND sales.sale_date BETWEEN ‘2023-01-01’ AND ‘2023-12-31’ 
                                    GROUP BY departments.department_name 
                                           HAVING AVG(sales.sale_amount) > 500 
                                                  ORDER BY AVG(sales.sale_amount) DESC;
