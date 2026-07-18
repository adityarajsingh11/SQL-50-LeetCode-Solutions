# LeetCode 1907 - Count Salary Categories

## Difficulty

**Easy**

---

# Question

Table: **Accounts**

| Column     | Type |
| ---------- | ---- |
| account_id | int  |
| income     | int  |

Classify every account into one of the following salary categories:

| Income                 | Category       |
| ---------------------- | -------------- |
| income < 20000         | Low Salary     |
| 20000 ≤ income ≤ 50000 | Average Salary |
| income > 50000         | High Salary    |

Return the **number of accounts** in each category.

> **Important:** Even if a category has **0 accounts**, it must still appear in the output.

---

# Problem Summary

We need to count the number of accounts in **three fixed salary categories**.

Unlike normal counting problems, **all three categories must always be returned**, even if one category has no employees.

---

# Key Observation 

This problem has **exactly 3 fixed categories**.

```text
Income
   │
   ├── < 20000
   │      │
   │      ▼
   │   Low Salary
   │
   ├── 20000 - 50000
   │      │
   │      ▼
   │ Average Salary
   │
   └── > 50000
          │
          ▼
      High Salary
```

Instead of using `GROUP BY`, we can write **3 separate queries** and combine them using `UNION ALL`.

---

# Why GROUP BY Doesn't Work?

Suppose the table is

| account_id | income |
| ---------- | ------ |
| 1          | 10000  |
| 2          | 70000  |

There is **no Average Salary** employee.

If we use `GROUP BY`, the output will be

| category    | count |
| ----------- | ----- |
| Low Salary  | 1     |
| High Salary | 1     |

❌ **Average Salary is missing.**

But the question expects

| category       | count |
| -------------- | ----- |
| Low Salary     | 1     |
| Average Salary | 0     |
| High Salary    | 1     |

So we need **3 fixed SELECT statements**.

---

# Approach

### Step 1

Count Low Salary employees.



### Step 2

Count Average Salary employees.


### Step 3

Count High Salary employees.

### Step 4

Combine all three results using

```sql
UNION ALL
```

---

# Solution

```sql
SELECT
    'Low Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000

UNION ALL

SELECT
    'Average Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income BETWEEN 20000 AND 50000

UNION ALL

SELECT
    'High Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000;
```

---

# Query Breakdown

## Query 1

```sql
SELECT
    'Low Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income < 20000;
```

Count all employees earning less than **20000**.



## Query 2

```sql
SELECT
    'Average Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income BETWEEN 20000 AND 50000;
```

Count all employees earning between **20000 and 50000**.



## Query 3

```sql
SELECT
    'High Salary' AS category,
    COUNT(*) AS accounts_count
FROM Accounts
WHERE income > 50000;
```

Count all employees earning more than **50000**.


## UNION ALL

```sql
UNION ALL
```

Combine the results of all three queries.

---

# Dry Run

## Accounts Table

| account_id | income |
| ---------- | ------ |
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |


## Step 1

```sql
WHERE income < 20000
```

Matching rows

| income |
| ------ |
| 12747  |

Output

| category   | accounts_count |
| ---------- | -------------- |
| Low Salary | 1              |

---

## Step 2

```sql
WHERE income BETWEEN 20000 AND 50000
```

Matching rows

None

Output

| category       | accounts_count |
| -------------- | -------------- |
| Average Salary | 0              |



## Step 3

```sql
WHERE income > 50000
```

Matching rows

| income |
| ------ |
| 108939 |
| 87709  |
| 91796  |

Output

| category    | accounts_count |
| ----------- | -------------- |
| High Salary | 3              |



## Step 4

`UNION ALL`

Combine all outputs.

| category       | accounts_count |
| -------------- | -------------- |
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |



## Final Output

| category       | accounts_count |
| -------------- | -------------- |
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |

---

# SQL Concepts Used

| Concept                         | Purpose                                      |
| ------------------------------- | -------------------------------------------- |
| `WHERE`                         | Filter rows based on income.                 |
| `COUNT(*)`                      | Count matching rows.                         |
| `BETWEEN`                       | Check if income lies in a range (inclusive). |
| `AS`                            | Rename output columns.                       |
| `UNION ALL`                     | Combine all three query results.             |
| String Literal (`'Low Salary'`) | Return a fixed category name.                |
