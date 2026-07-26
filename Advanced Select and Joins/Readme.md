# 📊 Advanced Select and Joins - LeetCode SQL 50

This folder contains my solutions and notes for the **Advanced Select and Joins** section of the **LeetCode SQL 50 Study Plan**.

## 📈 Progress

**Completed:** 7 / 7 ✅

---

## 📚 Questions

| # | Problem | Difficulty | Concepts | Link |
|---|---------|------------|----------|------|
| 1 | 1731. The Number of Employees Which Report to Each Employee | Easy | Self Join, GROUP BY, COUNT(), AVG(), ROUND() | https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/ |
| 2 | 1789. Primary Department for Each Employee | Easy | WHERE, GROUP BY, HAVING, Subquery | https://leetcode.com/problems/primary-department-for-each-employee/ |
| 3 | 610. Triangle Judgement | Easy | CASE WHEN | https://leetcode.com/problems/triangle-judgement/ |
| 4 | 180. Consecutive Numbers | Medium | Self Join | https://leetcode.com/problems/consecutive-numbers/ |
| 5 | 1164. Product Price at a Given Date | Medium | UNION ALL, GROUP BY, MAX(), Subquery | https://leetcode.com/problems/product-price-at-a-given-date/ |
| 6 | 1204. Last Person to Fit in the Bus | Medium | Window Function, SUM() OVER(), ORDER BY | https://leetcode.com/problems/last-person-to-fit-in-the-bus/ |
| 7 | 1907. Count Salary Categories | Medium | UNION ALL, WHERE | https://leetcode.com/problems/count-salary-categories/ |

---

# 📘 Advanced Select and Joins - Notes

This section focuses on solving SQL problems using **joins**, **conditional logic**, **subqueries**, **window functions**, **UNION ALL**, and **aggregation**. These techniques are commonly used in SQL interviews and real-world database queries.

---

## 🧠 SQL Concepts Covered

- ✅ SELF JOIN
- ✅ GROUP BY
- ✅ COUNT()
- ✅ AVG()
- ✅ ROUND()
- ✅ CASE WHEN
- ✅ WHERE
- ✅ HAVING
- ✅ Subquery
- ✅ UNION ALL
- ✅ MAX()
- ✅ Window Functions
- ✅ SUM() OVER()
- ✅ ORDER BY
- ✅ Running Total
- ✅ Conditional Filtering

---

# 🎯 SQL Patterns Learned

| Pattern | Purpose |
|---------|---------|
| Self Join | Compare rows from the same table |
| GROUP BY + Aggregate Functions | Calculate statistics for each group |
| CASE WHEN | Return values based on conditions |
| UNION ALL | Combine multiple query results |
| GROUP BY + MAX() | Find latest record in each group |
| Window Function | Running total without collapsing rows |
| Subquery | Solve complex problems step-by-step |

---

# 1️⃣ SELF JOIN

A **Self Join** joins a table with itself. It is useful when rows within the same table have relationships.

Syntax

```sql
SELECT ...
FROM table t1
JOIN table t2
ON t1.column = t2.column;
```

Used In

- The Number of Employees Which Report to Each Employee
- Consecutive Numbers


## Example 1 — Employee Reports

```sql
SELECT
manager.employee_id,
manager.name,
COUNT(employee.employee_id)
FROM Employees manager
JOIN Employees employee
ON manager.employee_id = employee.reports_to
GROUP BY manager.employee_id;
```

Here,

- `manager` → Manager rows
- `employee` → Employees reporting to that manager


## Example 2 — Consecutive Numbers

```sql
SELECT DISTINCT l1.num
FROM Logs l1
JOIN Logs l2
ON l1.id + 1 = l2.id
JOIN Logs l3
ON l2.id + 1 = l3.id
WHERE l1.num=l2.num
AND l2.num=l3.num;
```

The table is joined three times to compare **three consecutive rows**.

---

# 2️⃣ GROUP BY

Groups rows having the same value.

Syntax

```sql
GROUP BY column_name;
```

Example

```sql
GROUP BY manager.employee_id,
manager.name;
```

Used In

- Employees Which Report to Each Employee
- Product Price at a Given Date
- Primary Department for Each Employee

---

# 3️⃣ COUNT()

Counts rows in each group.

```sql
COUNT(*)
```

Counts every row.

```sql
COUNT(column)
```

Counts only NON-NULL values.

Example

```sql
COUNT(employee.employee_id)
```

Used In

- Employees Which Report to Each Employee

---

# 4️⃣ AVG()

Calculates the average value.

Syntax

```sql
AVG(column)
```

Example

```sql
AVG(employee.age)
```

Used In

- Employees Which Report to Each Employee

---

# 5️⃣ ROUND()

Rounds numeric values.

Syntax

```sql
ROUND(number, decimal_places)
```

Example

```sql
ROUND(AVG(employee.age),0)
```

Rounds the average age to the nearest integer.

---

# 6️⃣ CASE WHEN

Returns different values based on conditions.

Syntax

```sql
CASE
WHEN condition THEN value
ELSE value
END
```

Example

```sql
CASE
WHEN x+y>z
AND y+z>x
AND x+z>y
THEN 'Yes'
ELSE 'No'
END
```

Used In

- Triangle Judgement

---

# 7️⃣ WHERE

Filters rows before grouping.

Syntax

```sql
WHERE condition
```

Example

```sql
WHERE income < 20000
```

Used In

- Product Price at a Given Date
- Count Salary Categories

---

# 8️⃣ HAVING

Filters groups after GROUP BY.

Syntax

```sql
GROUP BY employee_id
HAVING COUNT(*)=1;
```

Used In

- Primary Department for Each Employee

Unlike `WHERE`, `HAVING` works with aggregate functions.

---

# 9️⃣ Subquery

A query inside another query.

Syntax

```sql
SELECT ...
FROM
(
SELECT ...
) AS temp;
```

Execution

```text
Inner Query
      ↓
Temporary Result
      ↓
Outer Query
```

Used In

- Primary Department for Each Employee
- Product Price at a Given Date

---

# 🔟 MAX()

Returns the largest value.

Syntax

```sql
MAX(column)
```

Example

```sql
MAX(change_date)
```

Used to find the **latest price before a given date**.

Used In

- Product Price at a Given Date

---

# 1️⃣1️⃣ UNION ALL

Combines results of multiple SELECT statements.

Syntax

```sql
SELECT ...
UNION ALL
SELECT ...
```

Unlike `UNION`, **UNION ALL keeps duplicate rows** and is faster because it doesn't remove duplicates.

Used In

- Product Price at a Given Date
- Count Salary Categories

---

# 1️⃣2️⃣ Window Functions

Window functions perform calculations across related rows **without grouping them**.

Syntax

```sql
SUM(column)
OVER(...)
```

Unlike `GROUP BY`, window functions keep every row in the result.

Used In

- Last Person to Fit in the Bus

---

# 1️⃣3️⃣ SUM() OVER()

Calculates a running total.

Example

```sql
SUM(weight)
OVER(ORDER BY turn)
```

Running Total

```text
Turn   Weight   Running Sum

1        200        200
2        150        350
3        300        650
4        400       1050
```

Used to determine how many people can enter the bus before reaching **1000 kg**.

---

# 1️⃣4️⃣ ORDER BY

Sorts the final result.

Syntax

```sql
ORDER BY column_name;
```

Ascending (Default)

```sql
ORDER BY employee_id;
```

Descending

```sql
ORDER BY turn DESC;
```

Used In

- The Number of Employees Which Report to Each Employee
- Last Person to Fit in the Bus

---

# SQL Patterns Learned

## Pattern 1 — Manager & Employee Relationship (Self Join)

```sql
SELECT
manager.employee_id,
manager.name,
COUNT(employee.employee_id),
ROUND(AVG(employee.age),0)
FROM Employees manager
JOIN Employees employee
ON manager.employee_id = employee.reports_to
GROUP BY manager.employee_id,
manager.name;
```

Used In

- The Number of Employees Which Report to Each Employee

Purpose

- Compare rows from the same table.
- Find employees reporting to each manager.
- Calculate statistics for each manager.

---

## Pattern 2 — Primary Record Selection

```sql
SELECT employee_id,
department_id
FROM Employee
WHERE primary_flag='Y'

OR employee_id IN
(
SELECT employee_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(*)=1
);
```

Used In

- Primary Department for Each Employee

Purpose

- Return the primary department.
- If an employee belongs to only one department, return it directly.

---

## Pattern 3 — Conditional Classification

```sql
CASE
WHEN condition THEN value
ELSE value
END
```

Example

```sql
CASE
WHEN x+y>z
AND y+z>x
AND x+z>y
THEN 'Yes'
ELSE 'No'
END
```

Used In

- Triangle Judgement

Purpose

- Return values based on logical conditions.

---

## Pattern 4 — Consecutive Rows

```sql
SELECT DISTINCT l1.num
FROM Logs l1
JOIN Logs l2
ON l1.id+1=l2.id
JOIN Logs l3
ON l2.id+1=l3.id
WHERE l1.num=l2.num
AND l2.num=l3.num;
```

Used In

- Consecutive Numbers

Purpose

- Compare adjacent rows.
- Detect values appearing three consecutive times.

---

## Pattern 5 — Latest Record Before a Given Date

```sql
SELECT
product_id,
10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date)>'2019-08-16'

UNION ALL

SELECT
product_id,
new_price AS price
FROM Products
WHERE (product_id,change_date) IN
(
SELECT
product_id,
MAX(change_date)
FROM Products
WHERE change_date<='2019-08-16'
GROUP BY product_id
);
```

Used In

- Product Price at a Given Date

Purpose

- Return the latest available price before a specific date.
- Return the default price (10) for products that had no price changes before that date.

---

## Pattern 6 — Running Total (Window Function)

```sql
SELECT
person_name,
SUM(weight)
OVER(ORDER BY turn)
AS running_sum
FROM Queue;
```

Used In

- Last Person to Fit in the Bus

Purpose

- Calculate cumulative weight.
- Find the last passenger before the total exceeds **1000**.

---

## Pattern 7 — Manual Categorization

```sql
SELECT
'Low Salary',
COUNT(*)
FROM Accounts
WHERE income<20000

UNION ALL

SELECT
'Average Salary',
COUNT(*)
FROM Accounts
WHERE income BETWEEN 20000 AND 50000

UNION ALL

SELECT
'High Salary',
COUNT(*)
FROM Accounts
WHERE income>50000;
```

Used In

- Count Salary Categories

Purpose

- Divide rows into multiple categories.
- Combine the results into one output.

---

# SELF JOIN vs JOIN

| JOIN | SELF JOIN |
|------|-----------|
| Joins two different tables | Joins the same table |
| Different aliases optional | Different aliases required |
| Used for related tables | Used for parent-child or row comparisons |

Examples

JOIN

```sql
Products
JOIN Orders
```

SELF JOIN

```sql
Employees manager
JOIN Employees employee
```

---

# UNION vs UNION ALL

| UNION | UNION ALL |
|--------|-----------|
| Removes duplicate rows | Keeps duplicate rows |
| Slower | Faster |
| Uses DISTINCT internally | No duplicate checking |

Use **UNION ALL** when duplicate removal is **not required**.

---

# GROUP BY vs Window Function

| GROUP BY | Window Function |
|-----------|-----------------|
| Returns one row per group | Keeps every row |
| Collapses rows | Does not collapse rows |
| Aggregate result | Running calculations |

Example

GROUP BY

```sql
SELECT
department,
AVG(salary)
FROM Employee
GROUP BY department;
```

Window Function

```sql
SELECT
employee_id,
salary,
SUM(salary)
OVER(ORDER BY employee_id)
FROM Employee;
```

---

# WHERE vs HAVING vs CASE

| WHERE | HAVING | CASE |
|--------|---------|------|
| Filters rows | Filters groups | Returns values based on conditions |
| Before GROUP BY | After GROUP BY | Inside SELECT |
| Cannot use aggregate functions | Can use aggregate functions | Used for conditional output |

---

# SQL Execution Order

```text
FROM
   ↓
JOIN
   ↓
ON
   ↓
WHERE
   ↓
GROUP BY
   ↓
HAVING
   ↓
SELECT
   ↓
WINDOW FUNCTION
   ↓
UNION / UNION ALL
   ↓
ORDER BY
   ↓
LIMIT
```
---

## ✅ Status

**Completed all 7 Advanced Select and Joins problems from LeetCode SQL 50.**

Progress: **43 / 50** 🚀

