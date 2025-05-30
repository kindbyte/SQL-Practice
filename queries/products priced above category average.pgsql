   WITH average_price AS ( 
    SELECT category_id, AVG(price) AS avg_price 
        FROM products GROUP BY category_id) 

            SELECT p.id, p.name, ap.avg_price, c.name AS category, 
              ROUND ((p.price - ap.avg_price) / ap.avg_price * 100, 2) AS diff_percent 
                  FROM products p 
                       JOIN categories c ON p.category_id = c.id 
                             JOIN average_price ap ON p.category_id = ap.category_id 
                                    WHERE p.price > 100;