-- Write your MySQL query statement below
select person_name
from 
(
    select
        person_name,
        turn,
        SUM(weight) OVER(ORDER BY turn) as running_sum
    from Queue
) running_weight
where running_sum <= 1000
order by turn desc
limit 1;

