-- Method 1 - Without Join

SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);

-- Method 2 - With Join

SELECT manager.name
FROM Employee manager
JOIN Employee employee
ON manager.id = employee.managerId
GROUP BY manager.id, manager.name
HAVING COUNT(employee.id) >= 5;