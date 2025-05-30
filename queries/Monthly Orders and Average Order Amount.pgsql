SELECT 
EXTRACT(month FROM order_date) AS month,
COUNT(order_id), ROUND(AVG(order_total), 2) AS avg_amount
    FROM orders
      WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31'
          GROUP BY EXTRACT(month FROM order_date);