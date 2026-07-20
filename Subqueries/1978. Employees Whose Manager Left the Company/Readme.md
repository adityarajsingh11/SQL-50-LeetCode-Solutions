# LeetCode 1978 - Employees Whose Manager Left the Company

## Difficulty

**Easy**

---

# Question

Table: **Employees**

| Column      | Type    |
| ----------- | ------- |
| employee_id | int     |
| name        | varchar |
| manager_id  | int     |
| salary      | int     |

Return the **employee_id** of employees who satisfy **all** of the following:

* Salary is **less than 30000**
* Their **manager has left the company**
* Sort the result by `employee_id`

---

# Problem Summary

We need to find employees:

✅ Salary < 30000

✅ Manager is **not working in the company anymore**

How do we know?

If the employee's **manager_id does not exist in employee_id**, then the manager has left.

---

# Key Observation 

The **Employees** table stores both:

* Employees
* Managers

Managers are also employees.

So compare

```text id="g0j5wf"
manager_id

WITH

employee_id
```

If

```text id="wv5bx2"
manager_id

NOT IN

employee_id
```

then

```text id="2x2xkh"
Manager Left Company
```

---

# Visual Understanding

Current Employees

| employee_id |
| ----------- |
| 1           |
| 3           |
| 9           |
| 11          |
| 12          |
| 13          |

Now check manager ids

| manager_id |
| ---------- |
| 9          |
| 11         |
| 6          |

Notice

```text id="6mjlwm"
9  ✅ Exists

11 ✅ Exists

6  ❌ Doesn't Exist
```

Manager **6** has left the company.

---

# Approach

### Step 1

Find all current employee IDs.


### Step 2

Check each employee.

If

```text id="30r4d6"
manager_id

NOT IN

employee_id
```

manager has left.


### Step 3

Check

```text id="7fks4y"
salary <30000
```


### Step 4

Ignore employees whose

```text id="djscu7"
manager_id IS NULL
```

because they don't have managers.

---

# Solution

```sql id="1d3a5h"
SELECT
    employee_id
FROM Employees
WHERE salary < 30000
AND manager_id IS NOT NULL
AND manager_id NOT IN
(
    SELECT employee_id
    FROM Employees
)
ORDER BY employee_id;
```

---

# Query Breakdown

## Step 1

```sql id="jlwmn5"
SELECT employee_id
FROM Employees
```

Returns all employees currently working.

Suppose it returns

| employee_id |
| ----------- |
| 1           |
| 3           |
| 9           |
| 11          |
| 12          |
| 13          |


## Step 2

```sql id="j9whyy"
manager_id NOT IN (...)
```

Now SQL checks

```text id="99a4do"
Does manager_id exist
inside employee_id?
```

If No

↓

Manager left company.

## Step 3

```sql id="m4l7c6"
salary <30000
```

Only low salary employees.


## Step 4

```sql id="q6n6g6"
manager_id IS NOT NULL
```

Ignore CEO/top manager.

## Step 5

```sql id="l8v1su"
ORDER BY employee_id
```

Sort the output.

---

# Complete Dry Run

## Original Table

| employee_id | name      | manager_id | salary |
| ----------- | --------- | ---------- | ------ |
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | NULL       | 31000  |
| 13          | Emery     | NULL       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | NULL       | 50937  |
| 11          | Joses     | 6          | 28485  |



## Step 1

Execute inner query

```sql id="n4gvsl"
SELECT employee_id
FROM Employees;
```

Temporary Result

| employee_id |
| ----------- |
| 1           |
| 3           |
| 9           |
| 11          |
| 12          |
| 13          |

Think of this as a temporary list.

```text id="5spw1l"
Current Employees

1

3

9

11

12

13
```


## Step 2

SQL now checks every employee.


### Employee 3

| salary | manager_id |
| ------ | ---------- |
| 60301  | 9          |

Salary

```text id="povfcf"
60301 <30000 ?
```

❌ No

Discard.


### Employee 12

Manager

```text id="hbf1nr"
NULL
```

CEO

Ignore.


### Employee 13

Manager

```text id="kjpdmd"
NULL
```

Ignore.


### Employee 1

| salary | manager |
| ------ | ------- |
| 21241  | 11      |

Salary

✅

Now check

```text id="vhdmn4"
11

IN

1,3,9,11,12,13
```

Yes

Manager still works.

Discard.


### Employee 9

Salary

```text id="6a9ibd"
50937
```

Too high.

Discard.

### Employee 11

Salary

```text id="l40xj4"
28485
```

✅

Manager

```text id="ugwghp"
6
```

Check

```text id="mwvwd2"
6

IN

1,3,9,11,12,13 ?
```

No

Manager left company.

✅ Select.


## Temporary Checking Table

| employee | salary<30000 | manager exists | Selected |
| -------- | ------------ | -------------- | -------- |
| 3        | ❌            | ✅              | ❌        |
| 12       | ❌            | NULL           | ❌        |
| 13       | ❌            | NULL           | ❌        |
| 1        | ✅            | ✅              | ❌        |
| 9        | ❌            | NULL           | ❌        |
| 11       | ✅            | ❌              | ✅        |



# Final Output

| employee_id |
| ----------- |
| 11          |

---

# SQL Concepts Used

| Concept       | Purpose                                                      |
| ------------- | ------------------------------------------------------------ |
| `NOT IN`      | Check whether a value is absent from another query's result. |
| `Subquery`    | Return all current employee IDs.                             |
| `WHERE`       | Apply filtering conditions.                                  |
| `IS NOT NULL` | Ignore employees without managers.                           |
| `ORDER BY`    | Sort output by employee_id.                                  |
