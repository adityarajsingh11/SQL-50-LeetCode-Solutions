-- Write your MySQL query statement below
select 
    manager.employee_id,
    manager.name,
    count(employee.employee_id) as reports_count,
    Round(AVG(employee.age),0) as average_age
from Employees manager
Join Employees employee
on manager.employee_id = employee.reports_to
group by manager.employee_id,
        manager.name
order by manager.employee_id
