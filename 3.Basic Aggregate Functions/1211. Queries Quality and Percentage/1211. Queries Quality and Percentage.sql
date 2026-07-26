-- Write your MySQL query statement below

select query_name , 
       Round(Avg(rating / position),2) as quality,
       Round(Avg(IF(rating < 3,1,0)) * 100,2) as poor_query_percentage
from Queries
group by query_name;


