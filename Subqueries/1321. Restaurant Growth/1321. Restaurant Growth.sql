-- Write your MySQL query statement below

WITH daily_sales AS
(
    SELECT
        visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
)

SELECT
    d1.visited_on,
    SUM(d2.amount) AS amount,
    ROUND(SUM(d2.amount) / 7, 2) AS average_amount
FROM daily_sales d1
JOIN daily_sales d2
ON DATEDIFF(d1.visited_on, d2.visited_on) BETWEEN 0 AND 6
GROUP BY d1.visited_on
HAVING COUNT(*) = 7
ORDER BY d1.visited_on;