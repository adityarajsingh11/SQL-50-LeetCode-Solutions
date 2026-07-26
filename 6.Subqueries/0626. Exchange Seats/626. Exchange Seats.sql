-- Write your MySQL query statement below
select
   case
      when id = (select max(id) from seat) and id % 2 = 1 then id  -- no swap when last id
      when id % 2 = 1 then id + 1   -- when odd id
      else id - 1  -- when id is even
    end as id,
    student  
from Seat 
order by id;
