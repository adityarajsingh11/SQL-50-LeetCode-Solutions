# LeetCode 1321 - Restaurant Growth

## Difficulty

**Medium**

---

# Question

Table: **Customer**

| Column      | Type    |
| ----------- | ------- |
| customer_id | int     |
| name        | varchar |
| visited_on  | date    |
| amount      | int     |

A restaurant records the amount spent by each customer every day.

For **each day from the 7th day onward**, calculate:

* Total amount earned during the **current day and previous 6 days**
* Average daily amount during those 7 days

Return the result ordered by `visited_on`.

---

# Problem Summary

Multiple customers can visit on the same day.

So first we calculate the **total sales of each day**.

Then, for every day, calculate:

* Sum of the last **7 consecutive days**
* Average of those **7 days**

---

# Key Observation

The solution has **two major steps**.

```text
Customer Table
      │
      ▼
GROUP BY visited_on
      │
      ▼
Daily Sales
      │
      ▼
Join Daily Sales With Itself
      │
      ▼
Keep Previous 6 Days + Current Day
      │
      ▼
SUM()
      │
      ▼
Average = SUM / 7
```

---

# Visual Understanding

Suppose daily sales are

| Date  | Sales |
| ----- | ----: |
| 1 Jan |   100 |
| 2 Jan |   200 |
| 3 Jan |   300 |
| 4 Jan |   250 |
| 5 Jan |   180 |
| 6 Jan |   220 |
| 7 Jan |   150 |
| 8 Jan |   260 |

For **7 Jan**

```text
1 2 3 4 5 6 7
```

For **8 Jan**

```text
2 3 4 5 6 7 8
```

Every day the window slides one step.

---

# Approach

### Step 1

Calculate total sales for each day.


### Step 2

Join the daily sales table with itself.


### Step 3

Keep only rows where the difference between dates is **0 to 6 days**.


### Step 4

Calculate total sales using `SUM()`.

### Step 5

Calculate average.

### Step 6

Return only complete 7-day windows.

---

# Solution

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
    SUM(d2.amount) AS amount,
    ROUND(SUM(d2.amount) / 7, 2) AS average_amount
FROM daily_sales d1
JOIN daily_sales d2
ON DATEDIFF(d1.visited_on, d2.visited_on) BETWEEN 0 AND 6
GROUP BY d1.visited_on
HAVING COUNT(*) = 7
ORDER BY d1.visited_on;
```

---

# Query Breakdown

## Step 1

```sql
WITH daily_sales AS
```

Create a temporary table.


## Step 2

```sql
SELECT
    visited_on,
    SUM(amount) AS amount
FROM Customer
GROUP BY visited_on;
```

Calculate total sales of every day.

Example

| Date  | Daily Sales |
| ----- | ----------: |
| 1 Jan |         220 |
| 2 Jan |          80 |
| 3 Jan |         150 |
| 4 Jan |         200 |


## Step 3

```sql
FROM daily_sales d1
JOIN daily_sales d2
```

Join the table with itself.

Think

```text
d1 → Current Day

d2 → Previous Days
```


## Step 4

```sql
ON DATEDIFF(d1.visited_on,d2.visited_on)
BETWEEN 0 AND 6
```

Keep only

```text
Current Day

+

Previous 6 Days
```

Example

If

```text
d1 = 8 Jan
```

SQL keeps

| d2 Date |
| ------- |
| 8 Jan   |
| 7 Jan   |
| 6 Jan   |
| 5 Jan   |
| 4 Jan   |
| 3 Jan   |
| 2 Jan   |


## Step 5

```sql
SUM(d2.amount)
```

Calculate total sales of these seven days.


## Step 6

```sql
ROUND(SUM(d2.amount)/7,2)
```

Calculate average.


## Step 7

```sql
GROUP BY d1.visited_on
```

One output row for every date.


## Step 8

```sql
HAVING COUNT(*) = 7
```

Ignore the first six days because they don't have a complete 7-day window.


## Step 9

```sql
ORDER BY visited_on
```

Sort by date.

---

# Complete Dry Run

## Step 1

Daily Sales

| Date | Amount |
| ---- | -----: |
| 1    |    100 |
| 2    |    200 |
| 3    |    300 |
| 4    |    250 |
| 5    |    180 |
| 6    |    220 |
| 7    |    150 |
| 8    |    260 |

---

## Step 2

Current Day

```text
d1 = Day 7
```

Join condition

```text
DATEDIFF BETWEEN 0 AND 6
```

Rows selected

| Day | Amount |
| --- | -----: |
| 1   |    100 |
| 2   |    200 |
| 3   |    300 |
| 4   |    250 |
| 5   |    180 |
| 6   |    220 |
| 7   |    150 |


## Step 3

Calculate Sum

```text
100+200+300+250+180+220+150

=1400
```

Average

```text
1400 / 7

=200
```

Output

| visited_on | amount | average_amount |
| ---------- | -----: | -------------: |
| 7          |   1400 |         200.00 |


## Step 4

Current Day

```text
d1 = Day 8
```

Rows selected

| Day |
| --- |
| 2   |
| 3   |
| 4   |
| 5   |
| 6   |
| 7   |
| 8   |

Sum

```text
200+300+250+180+220+150+260

=1560
```

Average

```text
1560 / 7

=222.86
```

Output

| visited_on | amount | average_amount |
| ---------- | -----: | -------------: |
| 8          |   1560 |         222.86 |


## Final Output

| visited_on | amount | average_amount |
| ---------- | -----: | -------------: |
| 7          |   1400 |         200.00 |
| 8          |   1560 |         222.86 |

---

# SQL Concepts Used

| Concept      | Purpose                                  |
| ------------ | ---------------------------------------- |
| `WITH (CTE)` | Create a temporary table of daily sales. |
| `SUM()`      | Calculate total sales.                   |
| `GROUP BY`   | Group rows by date.                      |
| `Self JOIN`  | Compare each day with previous days.     |
| `DATEDIFF()` | Find the difference between two dates.   |
| `HAVING`     | Keep only complete 7-day windows.        |
| `ROUND()`    | Display average up to 2 decimal places.  |
| `ORDER BY`   | Sort by date.                            |

---

# Pattern Learned

### Pattern 1 — Daily Aggregation

```sql
GROUP BY visited_on
```

Convert multiple customer transactions into one daily total.


### Pattern 2 — Self Join

```sql
FROM table d1
JOIN table d2
```

Compare the current row with previous rows.



### Pattern 3 — Sliding Window

```sql
DATEDIFF(...)
BETWEEN 0 AND 6
```

Keep the current day and previous six days.


### Pattern 4 — Complete Window

```sql
HAVING COUNT(*) = 7
```

Ensure exactly 7 days are included.

---
---
---

### ⭐ Why do we use `HAVING COUNT(*) = 7`?

`DATEDIFF BETWEEN 0 AND 6` **only selects rows within the last 7 days**. It **does not guarantee** that all 7 days are present.

`HAVING COUNT(*) = 7` ensures that **exactly 7 rows (7 days)** exist in the group.

---

### Example

For `d1 = 4 Jan`

```text
Rows after DATEDIFF:

1 Jan
2 Jan
3 Jan
4 Jan

COUNT(*) = 4 ❌
```

This row is removed because the 7-day window is incomplete.

---

For `d1 = 7 Jan`

```text
Rows after DATEDIFF:

1 Jan
2 Jan
3 Jan
4 Jan
5 Jan
6 Jan
7 Jan

COUNT(*) = 7 ✅
```

This row is kept.


```text
DATEDIFF → Select rows within 7-day range.

HAVING COUNT(*) = 7 → Ensure the window is complete (all 7 days).
```
