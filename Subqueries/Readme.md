# 📊 Subqueries - LeetCode SQL 50

This folder contains my solutions and notes for the **Subqueries** section of the **LeetCode SQL 50 Study Plan**.

## 📈 Progress

**Completed:** 7 / 7 ✅

---

## 📚 Questions

| # | Problem | Difficulty | Concepts | Link |
|---|---------|------------|----------|------|
| 1 | 1978. Employees Whose Manager Left the Company | Easy | Subquery, WHERE, NOT IN | https://leetcode.com/problems/employees-whose-manager-left-the-company/ |
| 2 | 626. Exchange Seats | Medium | CASE WHEN, ORDER BY | https://leetcode.com/problems/exchange-seats/ |
| 3 | 1341. Movie Rating | Medium | JOIN, GROUP BY, ORDER BY, AVG(), UNION ALL | https://leetcode.com/problems/movie-rating/ |
| 4 | 1321. Restaurant Growth | Medium | CTE, Self Join, GROUP BY, DATEDIFF(), SUM(), ROUND() | https://leetcode.com/problems/restaurant-growth/ |
| 5 | 602. Friend Requests II: Who Has the Most Friends | Medium | UNION ALL, GROUP BY, COUNT() | https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/ |
| 6 | 585. Investments in 2016 | Medium | Subquery, GROUP BY, HAVING, COUNT(), SUM() | https://leetcode.com/problems/investments-in-2016/ |
| 7 | 185. Department Top Three Salaries | Hard | Correlated Subquery, Self Join Concept, COUNT(DISTINCT) | https://leetcode.com/problems/department-top-three-salaries/ |

---

# 📘 Subqueries - Notes

This section focuses on solving SQL problems using **Subqueries**, **Correlated Subqueries**, **CTEs**, **CASE statements**, **UNION ALL**, **aggregation**, and **ranking techniques**. These concepts are widely used in SQL interviews and real-world database applications.

---

## 🧠 SQL Concepts Covered

- ✅ Subquery
- ✅ Correlated Subquery
- ✅ Common Table Expression (CTE)
- ✅ WITH Clause
- ✅ CASE WHEN
- ✅ UNION ALL
- ✅ GROUP BY
- ✅ HAVING
- ✅ COUNT()
- ✅ COUNT(DISTINCT)
- ✅ SUM()
- ✅ AVG()
- ✅ ROUND()
- ✅ DATEDIFF()
- ✅ ORDER BY
- ✅ LIMIT
- ✅ JOIN
- ✅ Self Join Concept
- ✅ IN
- ✅ NOT IN

---

# 🎯 SQL Patterns Learned

| Pattern | Purpose |
|---------|---------|
| Simple Subquery | Filter rows using another query |
| Correlated Subquery | Compare current row with other rows |
| CTE (WITH) | Improve readability using temporary result |
| UNION ALL | Merge multiple result sets |
| CASE WHEN | Conditional output |
| Rolling Window | Calculate moving totals |
| Ranking Without Window Function | Top-N records using Correlated Subquery |

---

# 1️⃣ Subquery

A **Subquery** is a query written inside another query.

Syntax

```sql
SELECT ...
FROM table
WHERE column IN
(
SELECT ...
FROM table2
);
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

- Employees Whose Manager Left the Company
- Investments in 2016

---

## Example

```sql
SELECT employee_id
FROM Employees
WHERE manager_id NOT IN
(
SELECT employee_id
FROM Employees
);
```

The inner query returns all valid employee IDs.

The outer query finds employees whose manager ID does not exist.

---

# 2️⃣ Correlated Subquery

A **Correlated Subquery** depends on the current row of the outer query.

Unlike a normal subquery, it executes once for every row processed by the outer query.

Syntax

```sql
SELECT ...
FROM table t1
WHERE
(
SELECT ...
FROM table t2
WHERE t2.column=t1.column
);
```

Used In

- Department Top Three Salaries

---

## Example

```sql
SELECT COUNT(DISTINCT Employee2.salary)
FROM Employee Employee2
WHERE Employee2.departmentId=Employee.departmentId
AND Employee2.salary>Employee.salary;
```

Here,

- `Employee` → Current employee
- `Employee2` → Other employees in the same department

The subquery counts how many distinct salaries are higher than the current employee's salary.

---

# 3️⃣ Common Table Expression (CTE)

A CTE creates a temporary named result set that can be reused.

Syntax

```sql
WITH temp AS
(
SELECT ...
)
SELECT ...
FROM temp;
```

Used In

- Restaurant Growth

---

## Example

```sql
WITH daily_sales AS
(
SELECT
visited_on,
SUM(amount) AS amount
FROM Customer
GROUP BY visited_on
)
```

Instead of repeating the aggregation multiple times, it is stored once and reused.

---

# 4️⃣ WITH Clause

The `WITH` keyword starts a Common Table Expression.

Example

```sql
WITH daily_sales AS
(
...
)
```

Advantages

- Improves readability
- Reduces repeated queries
- Makes complex SQL easier to understand

---

# 5️⃣ CASE WHEN

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
WHEN id=(SELECT MAX(id) FROM Seat)
AND id%2=1
THEN id
WHEN id%2=1
THEN id+1
ELSE id-1
END
```

Used In

- Exchange Seats

---

# 6️⃣ UNION ALL

Combines multiple SELECT statements into one result.

Syntax

```sql
SELECT ...
UNION ALL
SELECT ...
```

Unlike UNION, **UNION ALL** keeps duplicate rows and performs better.

Used In

- Movie Rating
- Friend Requests II

---

# 7️⃣ GROUP BY

Groups rows having the same value.

Syntax

```sql
GROUP BY column_name;
```

Used In

- Movie Rating
- Restaurant Growth
- Friend Requests II
- Investments in 2016

---

# 8️⃣ HAVING

Filters groups after GROUP BY.

Syntax

```sql
GROUP BY column
HAVING COUNT(*)>1;
```

Used In

- Investments in 2016
- Restaurant Growth

Unlike WHERE, HAVING works with aggregate functions.

---

# 9️⃣ COUNT()

Counts rows.

Syntax

```sql
COUNT(*)
```

or

```sql
COUNT(column)
```

Used In

- Friend Requests II
- Investments in 2016

---

# 🔟 COUNT(DISTINCT)

Counts only unique values.

Syntax

```sql
COUNT(DISTINCT salary)
```

Used In

- Department Top Three Salaries

It prevents duplicate salaries from affecting the ranking.

---

# 1️⃣1️⃣ SUM()

Calculates the total.

Syntax

```sql
SUM(column)
```

Used In

- Restaurant Growth
- Investments in 2016

---

# 1️⃣2️⃣ AVG()

Calculates the average.

Syntax

```sql
AVG(column)
```

Used In

- Movie Rating

---

# 1️⃣3️⃣ ROUND()

Rounds numeric values.

Syntax

```sql
ROUND(number,2)
```

Example

```sql
ROUND(SUM(amount)/7,2)
```

Used In

- Restaurant Growth
- Investments in 2016

---

# 1️⃣4️⃣ DATEDIFF()

Calculates the difference between two dates.

Syntax

```sql
DATEDIFF(date1,date2)
```

Example

```sql
DATEDIFF(d1.visited_on,d2.visited_on)
BETWEEN 0 AND 6
```

Used In

- Restaurant Growth

It helps calculate a rolling 7-day window.

---
# 1️⃣5️⃣ ORDER BY

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
ORDER BY salary DESC;
```

Used In

- Employees Whose Manager Left the Company
- Movie Rating
- Restaurant Growth
- Friend Requests II

---

# 1️⃣6️⃣ LIMIT

Returns only a fixed number of rows.

Syntax

```sql
LIMIT n;
```

Example

```sql
LIMIT 1;
```

Used In

- Movie Rating
- Friend Requests II

---

# SQL Patterns Learned

## Pattern 1 — Filter Using a Subquery

```sql
SELECT employee_id
FROM Employees
WHERE manager_id NOT IN
(
SELECT employee_id
FROM Employees
);
```

Used In

- Employees Whose Manager Left the Company

Purpose

- Filter rows using the result of another query.
- Useful when comparing values with another table or the same table.

---

## Pattern 2 — Conditional Row Transformation

```sql
CASE
WHEN id=(SELECT MAX(id) FROM Seat)
AND id%2=1
THEN id
WHEN id%2=1
THEN id+1
ELSE id-1
END
```

Used In

- Exchange Seats

Purpose

- Swap adjacent rows.
- Handle special cases using conditional logic.

---

## Pattern 3 — Combine Multiple Results

```sql
SELECT ...
UNION ALL
SELECT ...
```

Used In

- Movie Rating
- Friend Requests II

Purpose

- Merge multiple query results into one output.
- Keep duplicate rows when required.

---

## Pattern 4 — Rolling Window Using CTE

```sql
WITH daily_sales AS
(
SELECT
visited_on,
SUM(amount) AS amount
FROM Customer
GROUP BY visited_on
)

SELECT
d1.visited_on,
SUM(d2.amount)
FROM daily_sales d1
JOIN daily_sales d2
ON DATEDIFF(d1.visited_on,d2.visited_on)
BETWEEN 0 AND 6
GROUP BY d1.visited_on;
```

Used In

- Restaurant Growth

Purpose

- Calculate a rolling 7-day total.
- Compute moving averages.

---

## Pattern 5 — Count Relationships

```sql
SELECT
id,
COUNT(*) AS num
FROM
(
SELECT requester_id AS id
FROM RequestAccepted

UNION ALL

SELECT accepter_id
FROM RequestAccepted
) friends
GROUP BY id;
```

Used In

- Friend Requests II

Purpose

- Combine multiple relationships.
- Count occurrences for each person.

---

## Pattern 6 — Filter Groups Using Subqueries

```sql
SELECT
ROUND(SUM(tiv_2016),2)
FROM Insurance
WHERE tiv_2015 IN
(
SELECT tiv_2015
FROM Insurance
GROUP BY tiv_2015
HAVING COUNT(*)>1
)

AND (lat,lon) IN
(
SELECT lat,lon
FROM Insurance
GROUP BY lat,lon
HAVING COUNT(*)=1
);
```

Used In

- Investments in 2016

Purpose

- Filter duplicate values.
- Keep only unique locations.
- Perform aggregation after filtering.

---

## Pattern 7 — Ranking Without Window Function

```sql
SELECT
Department.name,
Employee.name,
Employee.salary
FROM Employee
JOIN Department
ON Employee.departmentId=Department.id

WHERE
(
SELECT COUNT(DISTINCT Employee2.salary)
FROM Employee Employee2
WHERE Employee2.departmentId=Employee.departmentId
AND Employee2.salary>Employee.salary
)<3;
```

Used In

- Department Top Three Salaries

Purpose

- Rank employees within each department.
- Find Top 3 distinct salaries without using window functions.

---

# Subquery vs Correlated Subquery

| Subquery | Correlated Subquery |
|-----------|---------------------|
| Executes once | Executes once for every outer row |
| Independent | Depends on outer query |
| Faster | Usually slower |
| Simpler | More flexible |

Example

Subquery

```sql
WHERE manager_id NOT IN
(
SELECT employee_id
FROM Employees
)
```

Correlated Subquery

```sql
SELECT COUNT(DISTINCT Employee2.salary)
FROM Employee Employee2
WHERE Employee2.departmentId=Employee.departmentId
AND Employee2.salary>Employee.salary
```

---

# CTE vs Subquery

| CTE | Subquery |
|------|----------|
| Named temporary result | Anonymous query |
| Improves readability | Suitable for simple queries |
| Can be reused | Usually written once |

Example

```sql
WITH daily_sales AS (...)
```

---

# UNION vs UNION ALL

| UNION | UNION ALL |
|--------|-----------|
| Removes duplicates | Keeps duplicates |
| Slower | Faster |
| Uses DISTINCT internally | No duplicate checking |

Use **UNION ALL** when duplicate removal is **not required**.

---

# WHERE vs HAVING vs Correlated Subquery

| WHERE | HAVING | Correlated Subquery |
|--------|---------|--------------------|
| Filters rows | Filters groups | Compares each row with related rows |
| Before GROUP BY | After GROUP BY | Executes per outer row |
| Cannot use aggregates directly | Can use aggregates | Uses outer query values |

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
UNION / UNION ALL
   ↓
ORDER BY
   ↓
LIMIT
```

---

## ✅ Status

**Completed all 7 Subqueries problems from LeetCode SQL 50.**

Progress: **43 / 50** 🚀