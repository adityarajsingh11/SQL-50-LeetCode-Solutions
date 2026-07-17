# LeetCode 1789 - Primary Department for Each Employee

## Difficulty

**Easy**

---

# Question

Table: **Employee**

| Column Name   | Type            |
| ------------- | --------------- |
| employee_id   | int             |
| department_id | int             |
| primary_flag  | enum ('Y', 'N') |

Each row represents an employee working in a department.

* `primary_flag = 'Y'` → Primary department.
* `primary_flag = 'N'` → Not the primary department.

If an employee belongs to **only one department**, then that department is considered the **primary department**, even if `primary_flag = 'N'`.

Return:

* `employee_id`
* `department_id`

---

# Problem Summary

For every employee:

### Case 1

If

```text
primary_flag = 'Y'
```

Return that department.


### Case 2

If the employee belongs to **only one department**,

return that department even if

```text
primary_flag = 'N'
```

---

> 🔴 **This is a WHERE + OR + GROUP BY + HAVING + Subquery problem.**

---

# Key Observation

There are only **2 possible cases**.

```text
Primary Flag = 'Y'
        OR
Employee has only one department
```

If either condition is true,

return that row.

---

# Approach

### Step 1

Return all rows where

```sql
primary_flag = 'Y'
```

### Step 2

Find employees having only one department.

```sql
GROUP BY employee_id
HAVING COUNT(*) = 1
```



### Step 3

Use

```sql
OR
```

to combine both conditions.

---

# Solution

```sql
SELECT
    employee_id,
    department_id
FROM Employee
WHERE primary_flag = 'Y'

OR employee_id IN
(
    SELECT employee_id
    FROM Employee
    GROUP BY employee_id
    HAVING COUNT(*) = 1
);
```

---

# Query Breakdown

## Step 1 — Select Columns

```sql
SELECT
employee_id,
department_id
```

Returns employee ID and department ID.


## Step 2 — Primary Department

```sql
WHERE primary_flag = 'Y'
```

Keeps all employees whose primary department is already marked.

Example

| employee | department | flag |
| -------- | ---------- | ---- |
| 2        | 1          | Y    |

Return

```text
Employee 2 → Department 1
```


## Step 3 — Subquery

```sql
SELECT employee_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(*) = 1
```

Find employees who belong to only one department.

Example

| employee | Departments |
| -------- | ----------: |
| 1        |           1 |
| 2        |           2 |
| 3        |           1 |

Result

```text
1
3
```


## Step 4 — IN

```sql
employee_id IN (...)
```

Checks whether the employee belongs to the list returned by the subquery.


## Step 5 — OR

```sql
WHERE primary_flag='Y'

OR

employee_id IN(...)
```

Meaning

```text
Return if

Primary Department

OR

Only One Department
```

---

# Dry Run

## Employee Table

| employee_id | department_id | primary_flag |
| ----------: | ------------: | ------------ |
|           1 |             1 | N            |
|           2 |             1 | Y            |
|           2 |             2 | N            |
|           3 |             3 | N            |
|           4 |             2 | Y            |
|           4 |             3 | N            |


## Step 1

Execute the subquery

```sql id="6gqj0k"
SELECT employee_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(*) = 1;
```

### GROUP BY

| employee_id | Number of Departments |
| ----------: | --------------------: |
|           1 |                     1 |
|           2 |                     2 |
|           3 |                     1 |
|           4 |                     2 |


### HAVING COUNT(*) = 1

Keep only employees having **one department**.

Result

| employee_id |
| ----------: |
|           1 |
|           3 |


## Step 2

Main Query

```sql id="bg0g4j"
WHERE primary_flag = 'Y'

OR employee_id IN (1,3)
```

Now check every row.

| employee_id | department_id | primary_flag | Condition         | Keep? |
| ----------: | ------------: | ------------ | ----------------- | ----- |
|           1 |             1 | N            | Employee in (1,3) | ✅     |
|           2 |             1 | Y            | primary_flag='Y'  | ✅     |
|           2 |             2 | N            | False             | ❌     |
|           3 |             3 | N            | Employee in (1,3) | ✅     |
|           4 |             2 | Y            | primary_flag='Y'  | ✅     |
|           4 |             3 | N            | False             | ❌     |


## Final Output

| employee_id | department_id |
| ----------: | ------------: |
|           1 |             1 |
|           2 |             1 |
|           3 |             3 |
|           4 |             2 |

---

# SQL Concepts Used

| Concept | Purpose |
|---------|---------|
| `WHERE` | Filter rows based on a condition. |
| `OR` | Return rows if either condition is true. |
| `GROUP BY` | Group rows by `employee_id`. |
| `HAVING` | Filter groups after `GROUP BY`. |
| `COUNT(*)` | Count the number of departments for each employee. |
| `Subquery` | Find employees who belong to only one department. |
| `IN` | Check if an employee exists in the subquery result. |

