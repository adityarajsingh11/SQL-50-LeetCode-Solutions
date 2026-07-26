-- Write your MySQL query statement below
SELECT
    Department.name AS Department,
    Employee.name AS Employee,
    Employee.salary AS Salary
FROM Employee
JOIN Department
ON Employee.departmentId = Department.id
WHERE (
    SELECT COUNT(DISTINCT Employee2.salary)
    FROM Employee Employee2
    WHERE Employee2.departmentId = Employee.departmentId
      AND Employee2.salary > Employee.salary
) < 3;
