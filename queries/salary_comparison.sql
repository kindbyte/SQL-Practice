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
