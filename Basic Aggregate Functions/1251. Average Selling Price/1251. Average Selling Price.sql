-- Write your MySQL query statement below

select Prices.product_id , 
    ROUND(
        IFNULL(
            SUM(Prices.price * UnitsSold.units) / SUM(UnitsSold.units),
        0),
    2) as average_price

from Prices
Left Join UnitsSold
ON Prices.product_id  = UnitsSold.product_id 
AND UnitsSold.purchase_date between Prices.start_date and Prices.end_date
group by Prices.product_id
 