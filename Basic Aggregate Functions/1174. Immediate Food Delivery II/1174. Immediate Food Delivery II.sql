-- Write your MySQL query statement below

SELECT
    ROUND(AVG(IF(Delivery.order_date = Delivery.customer_pref_delivery_date,1,0)) * 100,2) AS immediate_percentage
FROM Delivery
JOIN
(
    SELECT
        customer_id,
        MIN(order_date) AS first_order
    FROM Delivery
    GROUP BY customer_id
) AS first_orders
ON Delivery.customer_id = first_orders.customer_id
AND Delivery.order_date = first_orders.first_order;
