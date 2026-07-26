# 📊 Sorting and Grouping - LeetCode SQL 50

This folder contains my solutions and notes for the **Sorting and Grouping** section of the **LeetCode SQL 50 Study Plan**.

## 📈 Progress

**Completed:** 7 / 7 ✅

---
## 📚 Questions

| # | Problem | Difficulty | Concepts | Link |
|---|---------|------------|----------|------|
| 1 | 2356. Number of Unique Subjects Taught by Each Teacher | Easy | GROUP BY, COUNT(DISTINCT) | https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/ |
| 2 | 1141. User Activity for the Past 30 Days I | Easy | WHERE, BETWEEN, GROUP BY, COUNT(DISTINCT) | https://leetcode.com/problems/user-activity-for-the-past-30-days-i/ |
| 3 | 1070. Product Sales Analysis III | Medium | GROUP BY, MIN(), JOIN, Subquery | https://leetcode.com/problems/product-sales-analysis-iii/ |
| 4 | 596. Classes With at Least 5 Students | Easy | GROUP BY, HAVING, COUNT() | https://leetcode.com/problems/classes-with-at-least-5-students/ |
| 5 | 1729. Find Followers Count | Easy | GROUP BY, COUNT(), ORDER BY | https://leetcode.com/problems/find-followers-count/ |
| 6 | 619. Biggest Single Number | Easy | GROUP BY, HAVING, MAX(), Subquery | https://leetcode.com/problems/biggest-single-number/ |
| 7 | 1045. Customers Who Bought All Products | Medium | GROUP BY, COUNT(DISTINCT), HAVING, Subquery | https://leetcode.com/problems/customers-who-bought-all-products/ |

---


# 📘 Sorting and Grouping - Notes

This section focuses on organizing data into groups, performing calculations on each group, filtering grouped data, and sorting the final result.

---

## 🧠 SQL Concepts Covered

- ✅ GROUP BY
- ✅ ORDER BY
- ✅ COUNT()
- ✅ COUNT(DISTINCT)
- ✅ MIN()
- ✅ MAX()
- ✅ HAVING
- ✅ Subqueries
- ✅ JOIN
- ✅ BETWEEN
- ✅ DISTINCT
- ✅ Aggregate Functions
- ✅ First Record Per Group
- ✅ Filtering Groups

---
## 🎯 SQL Patterns Learned

| Pattern | Purpose |
|---------|---------|
| GROUP BY | Divide rows into groups |
| ORDER BY | Sort the final result |
| COUNT(*) | Count rows in each group |
| COUNT(DISTINCT column) | Count unique values |
| GROUP BY + HAVING | Filter grouped data |
| GROUP BY + MIN() | Find first record per group |
| GROUP BY + MIN() + JOIN | Retrieve complete first record |
| GROUP BY + HAVING + MAX() | Largest value after filtering |
| GROUP BY + COUNT(DISTINCT) | Count unique records per group |
| GROUP BY + HAVING + Subquery | Compare group values with overall values |

---

# 1️⃣ GROUP BY

Used to divide rows into groups having the same value.

```sql
GROUP BY column_name;
```

### Example

```sql
SELECT teacher_id,
       COUNT(DISTINCT subject_id)
FROM Teacher
GROUP BY teacher_id;
```

Each teacher becomes one group.

---

# 2️⃣ ORDER BY

Sorts the final output.

```sql
ORDER BY column_name;
```

Ascending (Default)

```sql
ORDER BY user_id;
```

Descending

```sql
ORDER BY salary DESC;
```

---

# 3️⃣ COUNT()

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

# 4️⃣ COUNT(DISTINCT)

Counts only unique values.

```sql
COUNT(DISTINCT subject_id)
```

Used In

- Number of Unique Subjects Taught by Each Teacher
- User Activity for the Past 30 Days I
- Customers Who Bought All Products

---

# 5️⃣ HAVING

Filters groups after GROUP BY.

```sql
GROUP BY class
HAVING COUNT(*) >= 5;
```

Use HAVING whenever aggregate functions are involved.

Examples

- At least 5 students
- More than 10 orders
- Employees greater than 5

---

# 6️⃣ MIN()

Returns the smallest value.

```sql
MIN(year)
```

Used for finding

- First Sale
- First Login
- Earliest Order

---

# 7️⃣ MAX()

Returns the largest value.

```sql
MAX(num)
```

Used in

- Biggest Single Number

---

# 8️⃣ Subquery

A query inside another query.

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
Temporary Table
      ↓
Outer Query
```

---

# 9️⃣ JOIN

JOIN is used when GROUP BY + MIN()/MAX() returns only one column but we need the complete row.

Example

```text
Find First Year
        ↓
Need Quantity & Price
        ↓
JOIN Original Table
```

Used In

- Product Sales Analysis III

---

# 🔟 BETWEEN

Filters values within a range.

```sql
WHERE activity_date
BETWEEN '2019-06-28'
AND '2019-07-27'
```

Used In

- User Activity for the Past 30 Days I

---

# SQL Patterns Learned


## Pattern 1 — Count Unique Values

```sql
SELECT
group_column,
COUNT(DISTINCT column)
FROM table
GROUP BY group_column;
```

Examples

- Subjects per Teacher
- Products per Customer
- Followers per User


## Pattern 2 — Filter Groups

```sql
SELECT group_column
FROM table
GROUP BY group_column
HAVING COUNT(*) >= value;
```

Examples

- Classes with at least 5 students
- Managers with at least 5 employees


## Pattern 3 — First Record Per Group

```sql
SELECT
group_column,
MIN(column)
FROM table
GROUP BY group_column;
```

Used to find

- First Login
- First Sale
- Earliest Order

## Pattern 4 — Complete First Record

```sql
SELECT ...
FROM OriginalTable
JOIN
(
    SELECT
        group_column,
        MIN(column)
    FROM table
    GROUP BY group_column
) AS temp
ON ...;
```

Used when the question asks for other columns of the first record.


## Pattern 5 — Largest Value After Filtering

```sql
SELECT MAX(column)
FROM
(
    ...
) AS temp;
```

Used In

- Biggest Single Number


## Pattern 6 — Compare Group Count with Total Count

```sql
HAVING COUNT(DISTINCT column) =
(
SELECT COUNT(*)
FROM another_table
);
```

Used In

- Customers Who Bought All Products


## Pattern 7 — Daily Active Users

```sql
SELECT
date_column,
COUNT(DISTINCT user_id)
FROM table
WHERE date_column BETWEEN ...
GROUP BY date_column;
```

Used In

- User Activity for the Past 30 Days I

---

# WHERE vs HAVING

| WHERE | HAVING |
|--------|---------|
| Filters rows | Filters groups |
| Executes before GROUP BY | Executes after GROUP BY |
| Cannot use aggregate functions | Can use aggregate functions |

Execution Order

```text
FROM
   ↓
WHERE
   ↓
GROUP BY
   ↓
HAVING
   ↓
SELECT
   ↓
ORDER BY
```

---

## ✅ Status

**Completed all 7 Sorting and Grouping problems from LeetCode SQL 50.**

Progress: 29 / 50 🚀