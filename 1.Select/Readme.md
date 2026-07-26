# LeetCode SQL 50 - SELECT Basics

This repository contains my solutions to the LeetCode SQL 50 Study Plan.

## Progress

Completed: 5/50 ✅

---

## SELECT Basics

| # | Problem | Difficulty | Concepts |
|---|----------|------------|----------|
| 1757 | Recyclable and Low Fat Products | Easy | SELECT, WHERE, AND |
| 584 | Find Customer Referee | Easy | SELECT, WHERE, OR, NULL |
| 595 | Big Countries | Easy | SELECT, WHERE, OR |
| 1148 | Article Views I | Easy | SELECT, DISTINCT, ORDER BY |
| 1683 | Invalid Tweets | Easy | SELECT, WHERE, LENGTH() |

---

## Problems

### 1. Recyclable and Low Fat Products
🔗 https://leetcode.com/problems/recyclable-and-low-fat-products/

**Concepts**
- SELECT
- WHERE
- AND

---

### 2. Find Customer Referee
🔗 https://leetcode.com/problems/find-customer-referee/

**Concepts**
- SELECT
- WHERE
- OR
- IS NULL

---

### 3. Big Countries
🔗 https://leetcode.com/problems/big-countries/

**Concepts**
- SELECT
- WHERE
- OR
- Comparison Operators

---

### 4. Article Views I
🔗 https://leetcode.com/problems/article-views-i/

**Concepts**
- SELECT
- DISTINCT
- ORDER BY
- Column Comparison

---

### 5. Invalid Tweets
🔗 https://leetcode.com/problems/invalid-tweets/

**Concepts**
- SELECT
- WHERE
- LENGTH()

---

## SQL Concepts Learned

### SELECT
Used to retrieve columns from a table.

```sql
SELECT column_name
FROM table_name;
```

### WHERE
Used to filter rows.

```sql
SELECT *
FROM table_name
WHERE condition;
```

### AND

```sql
WHERE condition1
AND condition2;
```

### OR

```sql
WHERE condition1
OR condition2;
```

### NULL Handling

```sql
WHERE column_name IS NULL;
```

```sql
WHERE column_name IS NOT NULL;
```

### DISTINCT

```sql
SELECT DISTINCT column_name
FROM table_name;
```

### ORDER BY

```sql
SELECT column_name
FROM table_name
ORDER BY column_name;
```

### LENGTH()

```sql
SELECT *
FROM table_name
WHERE LENGTH(column_name) > 15;
```

---

## Patterns Covered

✅ Single Table Filtering

✅ Multiple Conditions (AND / OR)

✅ NULL Handling

✅ Column Comparison

✅ Removing Duplicates (DISTINCT)

✅ String Functions (LENGTH)

---

### Completion Status

- [x] 1757. Recyclable and Low Fat Products
- [x] 584. Find Customer Referee
- [x] 595. Big Countries
- [x] 1148. Article Views I
- [x] 1683. Invalid Tweets

Progress: **5 / 50** 🚀