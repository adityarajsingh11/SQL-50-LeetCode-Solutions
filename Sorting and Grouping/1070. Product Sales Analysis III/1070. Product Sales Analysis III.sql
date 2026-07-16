-- Write your MySQL query statement below
SELECT
    Sales.product_id,
    Sales.year AS first_year,
    Sales.quantity,
    Sales.price
FROM Sales
JOIN
(
    SELECT
        product_id,
        MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) AS first_sale
ON Sales.product_id = first_sale.product_id
AND Sales.year = first_sale.first_year;
