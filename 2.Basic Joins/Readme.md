# 🔗 Basic Joins - LeetCode SQL 50

This folder contains my solutions and notes for the **Basic Joins** section of the LeetCode SQL 50 Study Plan.

## Progress

**Completed:** 9 / 9 ✅


# What are Joins?

A **JOIN** is used to combine rows from two or more tables based on a related column.

```sql
SELECT columns
FROM TableA
JOIN TableB
ON TableA.id = TableB.id;
```

---

## Questions

| # | Problem | Difficulty | Concepts | Link |
|---|---------|------------|----------|------|
| 1 | 1378. Replace Employee ID With The Unique Identifier | Easy | LEFT JOIN | https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/ |
| 2 | 1068. Product Sales Analysis I | Easy | INNER JOIN | https://leetcode.com/problems/product-sales-analysis-i/ |
| 3 | 1581. Customer Who Visited but Did Not Make Any Transactions | Easy | LEFT JOIN, GROUP BY, COUNT | https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/ |
| 4 | 197. Rising Temperature | Easy | SELF JOIN, DATEDIFF | https://leetcode.com/problems/rising-temperature/ |
| 5 | 1661. Average Time of Process per Machine | Easy | SELF JOIN, AVG, ROUND | https://leetcode.com/problems/average-time-of-process-per-machine/ |
| 6 | 577. Employee Bonus | Easy | LEFT JOIN, NULL Handling | https://leetcode.com/problems/employee-bonus/ |
| 7 | 1280. Students and Examinations | Easy | CROSS JOIN, LEFT JOIN, COUNT | https://leetcode.com/problems/students-and-examinations/ |
| 8 | 570. Managers with at Least 5 Direct Reports | Medium | SELF JOIN, GROUP BY, HAVING | https://leetcode.com/problems/managers-with-at-least-5-direct-reports/ |
| 9 | 1934. Confirmation Rate | Medium | LEFT JOIN, AVG(IF()), GROUP BY | https://leetcode.com/problems/confirmation-rate/ |

---

## SQL Concepts Covered

- ✅ INNER JOIN
- ✅ LEFT JOIN
- ✅ SELF JOIN
- ✅ CROSS JOIN
- ✅ ON Clause
- ✅ GROUP BY
- ✅ HAVING
- ✅ COUNT()
- ✅ AVG()
- ✅ ROUND()
- ✅ IF()
- ✅ DATEDIFF()
- ✅ NULL Handling
- ✅ ORDER BY

---

# INNER JOIN

Returns only the rows that exist in **both** tables.

```sql
SELECT *
FROM Employee
JOIN Bonus
ON Employee.empId = Bonus.empId;
```

### Use When

- Only matching records are required.

---

# LEFT JOIN

Returns **all rows from the left table** and matching rows from the right table.

If no match exists, NULL is returned.

```sql
SELECT *
FROM Employee
LEFT JOIN Bonus
ON Employee.empId = Bonus.empId;
```

### Use When

- Keep all rows from the left table.
- Find missing records.
- Handle NULL values.

---

# SELF JOIN

A table joins with itself.

```sql
FROM Employee manager
JOIN Employee employee
ON manager.id = employee.managerId;
```

### Use When

- Employee ↔ Manager
- Current Row ↔ Previous Row
- Start ↔ End Records

---

# CROSS JOIN

Returns every possible combination of two tables.

```sql
FROM Students
CROSS JOIN Subjects;
```

If:

```
Students = 3
Subjects = 4
```

Result:

```
3 × 4 = 12 rows
```

---

# ON Clause

Defines how two tables are connected.

```sql
ON Employee.empId = Bonus.empId;
```

**Remember**

```
JOIN → Connect tables

ON → Connection rule
```

---

# GROUP BY

Groups rows having the same value.

```sql
GROUP BY manager_id;
```

Used with:

- COUNT()
- AVG()
- SUM()
- MAX()
- MIN()

---

# HAVING

Filters groups after GROUP BY.

```sql
HAVING COUNT(*) >= 5;
```

Difference:

| WHERE | HAVING |
|--------|---------|
| Filters rows | Filters groups |
| Before GROUP BY | After GROUP BY |

---

# COUNT()

Counts rows.

```sql
COUNT(*)
```

Counts every row.

```sql
COUNT(column)
```

Counts only NON-NULL values.

---

# AVG()

Returns the average value.

```sql
AVG(column)
```

Example:

```
80
90
100

AVG = 90
```

---

# ROUND()

Rounds decimal values.

```sql
ROUND(value,2)
```

Example:

```
0.66667

↓

0.67
```

---

# IF()

Conditional function.

```sql
IF(condition,true,false)
```

Example

```sql
IF(action='confirmed',1,0)
```

Returns

```
confirmed → 1

timeout → 0
```

---

# DATEDIFF()

Returns the difference between two dates.

```sql
DATEDIFF(date1,date2)
```

Example

```sql
DATEDIFF('2025-01-02','2025-01-01')
```

Output

```
1
```

---

# NULL Handling

```sql
IS NULL
```

Checks missing values.

```sql
IS NOT NULL
```

Checks existing values.

---

# ORDER BY

Sorts the result.

```sql
ORDER BY student_id;
```

Ascending (Default)

```sql
ORDER BY salary ASC;
```

Descending

```sql
ORDER BY salary DESC;
```
---


## Join Patterns Learned

| Pattern | Used In |
|---------|----------|
| LEFT JOIN | Missing Records |
| INNER JOIN | Matching Records |
| SELF JOIN | Same Table Comparison |
| CROSS JOIN | All Possible Combinations |
| GROUP BY + COUNT | Counting Records |
| GROUP BY + HAVING | Filtering Groups |
| AVG(IF()) | Success / Confirmation Rate |
| DATEDIFF() | Compare Consecutive Dates |

---


## Status

✅ All Basic Join problems completed.

Progress: **14 / 50** 🚀