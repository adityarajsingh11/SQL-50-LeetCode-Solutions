-- Write your MySQL query statement below


select contest_id , Round(COUNT(*) *100 / (select count(*) from Users),2) as percentage

from register
group by contest_id

order by percentage desc,contest_id;


