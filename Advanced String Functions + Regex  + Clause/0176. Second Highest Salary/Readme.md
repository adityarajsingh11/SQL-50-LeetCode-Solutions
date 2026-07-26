
# LeetCode 176 - Second Highest Salary

## Difficulty

**Medium**

---

# 📝 Question

Write a solution to find the **second highest distinct salary** from the `Employee` table.

If there is **no second highest salary**, return **NULL**.

---

# 📖 Easy Understanding

We need to find:

* Highest salary ❌
* **Second Highest Salary** ✅
* Ignore duplicate salaries.
* If only one distinct salary exists, return `NULL`.

---

## Example

### Input

| id | salary |
| -: | -----: |
|  1 |    100 |
|  2 |    200 |
|  3 |    300 |

### Output

| SecondHighestSalary |
| ------------------: |
|                 200 |


### Example 2

| id | salary |
| -: | -----: |
|  1 |    100 |

### Output

| SecondHighestSalary |
| ------------------: |
|                NULL |

---

# Problem Summary

We need to:

* Remove duplicate salaries.
* Sort salaries in descending order.
* Skip the highest salary.
* Return the next salary.
* If it doesn't exist, return `NULL`.

---

# Key Observation ⭐

The question says **Second Highest DISTINCT Salary**.

So first remove duplicates, then find the second highest value.

```text
Employee
   │
   ▼
DISTINCT Salary
   │
   ▼
Sort DESC
   │
   ▼
Skip Highest
   │
   ▼
Return Next Salary
```

---

# Approach

### Step 1

Select distinct salaries.

### Step 2

Sort salaries in descending order.

### Step 3

Skip the first (highest) salary.


### Step 4

Return only one salary.


### Step 5

If no second salary exists, SQL automatically returns `NULL`.

---

# Solution

```sql
SELECT
(
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```

---

# Query Breakdown

## Step 1

```sql
SELECT DISTINCT salary
```

Remove duplicate salaries.

Example

Before

| salary |
| -----: |
|    300 |
|    300 |
|    200 |
|    100 |

After

| salary |
| -----: |
|    300 |
|    200 |
|    100 |


## Step 2

```sql
ORDER BY salary DESC
```

Sort from highest to lowest.

| salary |
| -----: |
|    300 |
|    200 |
|    100 |


## Step 3

```sql
OFFSET 1
```

Skip the first row.

Skipped:

```text
300
```

Remaining

| salary |
| -----: |
|    200 |
|    100 |


## Step 4

```sql
LIMIT 1
```

Return only one row.

Output

| salary |
| -----: |
|    200 |


## Step 5

```sql
AS SecondHighestSalary
```

Rename the output column.

---

# Dry Run

### Employee Table

| id | salary |
| -: | -----: |
|  1 |    100 |
|  2 |    200 |
|  3 |    300 |
|  4 |    300 |



### After DISTINCT

| salary |
| -----: |
|    300 |
|    200 |
|    100 |



### After ORDER BY DESC

| salary |
| -----: |
|    300 |
|    200 |
|    100 |


### After OFFSET 1

| salary |
| -----: |
|    200 |
|    100 |


### After LIMIT 1

| SecondHighestSalary |
| ------------------: |
|                 200 |

---

# Edge Case

### Input

| salary |
| -----: |
|    100 |

Distinct Salary

| salary |
| -----: |
|    100 |

Skip first row → No rows remain.

Output

| SecondHighestSalary |
| ------------------: |
|                NULL |

---

# SQL Concepts Used

| Concept         | Purpose                              |
| --------------- | ------------------------------------ |
| `DISTINCT`      | Remove duplicate salaries            |
| `ORDER BY DESC` | Sort salaries from highest to lowest |
| `OFFSET`        | Skip rows                            |
| `LIMIT`         | Return a fixed number of rows        |
| Scalar Subquery | Returns a single value               |
| `AS`            | Rename the output column             |
