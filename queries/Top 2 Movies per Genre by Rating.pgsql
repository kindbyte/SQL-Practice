WITH movie_rank AS (
SELECT id, title, genre, rating,
ROW_NUMBER() OVER (PARTITION BY genre ORDER BY rating DESC) AS row_num
   FROM movies)
     SELECT id, title, genre, rating, row_num
       FROM movie_rank
          WHERE row_num <=2
            ORDER BY genre ASC, rating DESC;  