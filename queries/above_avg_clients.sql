SELECT c.client_id, c.name, c.city, c.income
FROM clients c
      JOIN (
            SELECT city, AVG(income) AS avg_income
            FROM clients
            GROUP BY city
            )clients_2 ON clients_2.city = c.city
               WHERE c.income > clients_2.avg_income
                  ORDER BY c.city, c.income DESC;  
                  
