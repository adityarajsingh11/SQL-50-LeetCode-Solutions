# LeetCode 619 - Biggest Single Number

## Difficulty

**Easy**

---

# Question

Table: **MyNumbers**

| Column Name | Type |
| ----------- | ---- |
| num         | int  |

Each row contains one integer.

A **single number** is a number that appears **exactly once**.

Write a solution to find the **largest single number**.

If there is no single number, return **NULL**.

#### Example 1:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+

---

# Problem Summary

We need to:

1. Find numbers that appear **only once**.
2. Among those numbers, find the **largest** one.
3. If no such number exists, return **NULL**.

---

> 🔴 **This is a GROUP BY + HAVING + Subquery + MAX() problem.**

---

# Key Observation ⭐

The question is **not asking**:

❌ Largest number

It is asking:

✅ Largest number that appears **exactly one time**.

Example

| num |
| --- |
| 8   |
| 8   |
| 5   |
| 3   |
| 2   |
| 2   |

Single Numbers

```text
5
3
```

Largest

```text
5
```

---

# Solution

```sql
SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
) AS temp;
```

---

# Query Breakdown

## Step 1 — Inner Query (Subquery)

```sql
SELECT num
FROM MyNumbers
GROUP BY num
HAVING COUNT(*) = 1;
```

### What does it do?

Groups the same numbers together.

Then keeps only those numbers whose count is **1**.


### Example

#### Original Table

| num |
| --- |
| 8   |
| 8   |
| 3   |
| 2   |
| 2   |
| 5   |


### GROUP BY

| num | Count |
| --- | ----: |
| 2   |     2 |
| 3   |     1 |
| 5   |     1 |
| 8   |     2 |


### HAVING

```sql
HAVING COUNT(*) = 1
```

Keep only

| num |
| --- |
| 3   |
| 5   |

This result becomes a **temporary table**.



## Step 2 — Temporary Table

SQL stores the subquery result temporarily.

```text
temp
```

contains

| num |
| --- |
| 3   |
| 5   |

We write

```sql
AS temp
```

to give this temporary table a name.

## Step 3 — Outer Query

```sql
SELECT MAX(num)
FROM temp;
```

Now SQL simply finds

```text
MAX(3,5)
```

↓

```text
5
```

Final Output

| num |
| --- |
| 5   |

---

# Complete Execution Flow

```text
Original Table

        8
        8
        3
        2
        2
        5

        │
        ▼

GROUP BY num

        │
        ▼

Count Every Number

    2 → 2 Times

    3 → 1 Time

    5 → 1 Time

    8 → 2 Times

        │
        ▼

HAVING COUNT(*) = 1

        │
        ▼

Temporary Table (temp)

        3
        5

        │
        ▼

     MAX(num)

        │
        ▼

        5
```

---

# Dry Run

### MyNumbers

| num |
| --- |
| 8   |
| 8   |
| 3   |
| 2   |
| 2   |
| 5   |


## Step 1

Execute

```sql
GROUP BY num
```

Result

| num | Count |
| --- | ----: |
| 2   |     2 |
| 3   |     1 |
| 5   |     1 |
| 8   |     2 |


## Step 2

Execute

```sql
HAVING COUNT(*) = 1
```

Remaining rows

| num |
| --- |
| 3   |
| 5   |


## Step 3

This becomes

```text
Temporary Table (temp)

3
5
```



## Step 4

Execute

```sql
SELECT MAX(num)
FROM temp;
```

Result

```text
MAX(3,5)

↓

5
```

---

# Edge Case (Most Important)

### Input

| num |
| --- |
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |



## Step 1

GROUP BY

| num | Count |
| --- | ----: |
| 3   |     2 |
| 7   |     2 |
| 8   |     2 |


## Step 2

HAVING

```sql
COUNT(*) = 1
```

Result

```text
Empty Table
```


## Step 3

Temporary Table

```text
temp

↓

Empty
```


## Step 4

```sql
SELECT MAX(num)
FROM temp;
```

SQL asks:

```text
Maximum value of an empty table?
```

Answer

```text
NULL
```

Final Output

| num  |
| ---- |
| NULL |

---

# Why NOT ORDER BY + LIMIT?

Example

```sql
SELECT num
FROM MyNumbers
GROUP BY num
HAVING COUNT(*) = 1
ORDER BY num DESC
LIMIT 1;
```

Works when a single number exists.

But if no single number exists,

Result

```text
No Rows
```

Question expects

```text
NULL
```

Therefore

```text
ORDER BY + LIMIT

❌ Not enough
```

Whereas

```text
MAX()

↓

Empty Table

↓

NULL

✅ Correct
```

---

# SQL Concepts Used

| Concept  | Purpose                            |
| -------- | ---------------------------------- |
| GROUP BY | Group same numbers                 |
| COUNT(*) | Count frequency of each number     |
| HAVING   | Keep only numbers appearing once   |
| Subquery | Create a temporary result          |
| MAX()    | Find the largest single number     |
| AS       | Give a name to the temporary table |
