# 1731. The Number of Employees Which Report to Each Employee

## Difficulty

**Easy**

---

# Question

Given the `Employees` table, find:

* Manager's `employee_id`
* Manager's `name`
* Number of employees reporting to the manager (`reports_count`)
* Average age of employees reporting to the manager (`average_age`)

Return the result ordered by `employee_id`.

## Employees Table

| employee_id | name    | reports_to | age |
| ----------- | ------- | ---------- | --- |
| 1           | Alice   | NULL       | 45  |
| 2           | Bob     | 1          | 25  |
| 3           | Charlie | 1          | 30  |
| 4           | David   | 1          | 35  |
| 5           | Eva     | 2          | 28  |


## Output

| employee_id | name  | reports_count | average_age |
| ----------- | ----- | ------------- | ----------- |
| 1           | Alice | 3             | 30          |
| 2           | Bob   | 1             | 28          |



---

# Problem Summary

🔴 We need to find information **about managers**, but the manager information and employee information are stored in the **same table**.

This is a **SELF JOIN** problem.

---

# Key Observation 

The column `reports_to` stores the **employee_id of the manager**.

Example:

| employee_id | name    | reports_to |
| ----------- | ------- | ---------- |
| 2           | Bob     | 1          |
| 3           | Charlie | 1          |
| 4           | David   | 1          |

Here,

* Bob reports to Employee 1
* Charlie reports to Employee 1
* David reports to Employee 1

So,

Employee **1** is the manager.

---

# Why SELF JOIN?

The Employees table contains both:

* Employee Details
* Manager Details

We need to compare the table with itself.

```
Employees
    │
reports_to
    │
Employees

```

Therefore,

**SELF JOIN** is required.

---

# Approach

### Step 1

Join the Employees table with itself.

```
Manager.employee_id
       =
Employee.reports_to
```


### Step 2

Count employees reporting to each manager.

```
COUNT(employee.employee_id)
```


### Step 3

Find average age.

```
AVG(employee.age)
```

Round it.

```
ROUND(AVG(employee.age),0)
```


### Step 4

Group by manager.

```
GROUP BY
employee_id,
name
```


### Step 5

Sort by employee_id.

```
ORDER BY employee_id
```

---

# Solution

```sql

SELECT
    manager.employee_id,
    manager.name,
    COUNT(employee.employee_id) AS reports_count,
    ROUND(AVG(employee.age),0) AS average_age
FROM Employees manager
JOIN Employees employee
ON manager.employee_id = employee.reports_to
GROUP BY
    manager.employee_id,
    manager.name
ORDER BY
    manager.employee_id;

```

---

# Query Breakdown

## Step 1 — Select Required Columns

```sql
SELECT
    manager.employee_id,
    manager.name,
    COUNT(employee.employee_id) AS reports_count,
    ROUND(AVG(employee.age),0) AS average_age
```

### Meaning

* `manager.employee_id` → Manager's ID
* `manager.name` → Manager's Name
* `COUNT(employee.employee_id)` → Number of employees reporting to the manager
* `AVG(employee.age)` → Average age of reporting employees
* `ROUND(...,0)` → Round the average age to the nearest integer


## Step 2 — First Employees Table

```sql
FROM Employees manager
```

### Meaning

Treat the `Employees` table as the **Manager** table.

This table provides:

* Manager ID
* Manager Name


## Step 3 — SELF JOIN

```sql
JOIN Employees employee
ON manager.employee_id = employee.reports_to
```

### Meaning

Compare the same table with itself.

```text
manager.employee_id
        =
employee.reports_to
```

This means:

* Every employee has a `reports_to` value.
* That value stores the **manager's employee_id**.
* The JOIN matches each employee with their manager.

Example

| Manager ID | Employee | reports_to |
| ---------- | -------- | ---------- |
| 1          | Bob      | 1          |
| 1          | Charlie  | 1          |
| 1          | David    | 1          |

Here,

Bob, Charlie and David all report to Manager **1**.


## Step 4 — Count Employees

```sql
COUNT(employee.employee_id)
```

### Meaning

Counts how many employees report to each manager.

Example

```text
Bob
Charlie
David

↓

COUNT = 3
```


## Step 5 — Average Age

```sql
AVG(employee.age)
```

### Meaning

Calculates the average age of employees reporting to a manager.

Example

```text
Ages

25
30
35

↓

Average

(25 + 30 + 35) / 3

↓

30
```

## Step 6 — ROUND()

```sql
ROUND(AVG(employee.age),0)
```

### Meaning

Rounds the average age to the nearest whole number.

Example

```text
27.33

↓

27
```

```text
27.67

↓

28
```

## Step 7 — GROUP BY

```sql
GROUP BY
    manager.employee_id,
    manager.name
```

### Meaning

Creates one group for each manager.

Each group's aggregate values (`COUNT`, `AVG`) are calculated separately.

Example

```text
Manager 1

↓

Bob
Charlie
David

↓

COUNT = 3

AVG = 30
```


## Step 8 — ORDER BY

```sql
ORDER BY
    manager.employee_id;
```

### Meaning

Sorts the final output by **Manager ID** in ascending order.

Example

```text
1
2
3
4
...
```

---

# Dry Run

## Employees Table

| employee_id | name    | reports_to | age |
| ----------- | ------- | ---------- | --- |
| 1           | Alice   | NULL       | 45  |
| 2           | Bob     | 1          | 25  |
| 3           | Charlie | 1          | 30  |
| 4           | David   | 1          | 35  |
| 5           | Eva     | 2          | 28  |


### Step 1: JOIN

```sql
manager.employee_id = employee.reports_to
```

After JOIN

| Manager | Employee | Age |
| ------- | -------- | --- |
| Alice   | Bob      | 25  |
| Alice   | Charlie  | 30  |
| Alice   | David    | 35  |
| Bob     | Eva      | 28  |


### Step 2: GROUP BY

**Group 1 → Alice**

Employees:

* Bob
* Charlie
* David

**Group 2 → Bob**

Employees:

* Eva


### Step 3: COUNT()

Alice → **3**

Bob → **1**


### Step 4: AVG()

Alice

```text
(25 + 30 + 35) / 3 = 30
```

Bob

```text
28 / 1 = 28
```

## Step 5: Final Output

| employee_id | name  | reports_count | average_age |
| ----------- | ----- | ------------- | ----------- |
| 1           | Alice | 3             | 30          |
| 2           | Bob   | 1             | 28          |
