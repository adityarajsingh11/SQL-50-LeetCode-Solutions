# LeetCode 570 - Managers with at Least 5 Direct Reports

## Question

Table: **Employee**

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |

`id` is the primary key.

Each employee has a manager represented by `managerId`.

Write a solution to find the **names of managers** who have **at least 5 direct reports**.

Return the result table in any order.

---

## Problem Summary

Find managers who have **5 or more employees directly reporting to them**.

Return only the manager's **name**.

---

> 🔴 **This is a SELF JOIN + GROUP BY + HAVING problem.**

---

## Key Observation

Both managers and employees are stored in the **same Employee table**.

Example:

| id  | name  | managerId |
| --- | ----- | --------- |
| 101 | John  | NULL      |
| 102 | Dan   | 101       |
| 103 | James | 101       |
| 104 | Amy   | 101       |
| 105 | Anne  | 101       |
| 106 | Ron   | 101       |

Here,

```text id="vnj34d"
John manages:

Dan
James
Amy
Anne
Ron
```

Total Direct Reports = **5**

So John should be returned.

---

## Approach

1. Use **SELF JOIN**.
2. Treat one copy as **Manager**.
3. Treat the other copy as **Employee**.
4. Match `manager.id` with `employee.managerId`.
5. Count employees for each manager.
6. Keep managers with at least 5 direct reports.

---

## Solution

```sql id="0ozs0p"
SELECT manager.name
FROM Employee manager
JOIN Employee employee
ON manager.id = employee.managerId
GROUP BY manager.id, manager.name
HAVING COUNT(employee.id) >= 5;
```

---

## Query Breakdown

### SELF JOIN

```sql id="kt4wkh"
FROM Employee manager
JOIN Employee employee
```

Use the same table twice.

* `manager` → Manager records
* `employee` → Employee records



### Join Condition

```sql id="e4d5uv"
ON manager.id = employee.managerId
```

Matches each employee with their manager.

Example:

| Manager | Employee |
| ------- | -------- |
| John    | Dan      |
| John    | James    |
| John    | Amy      |
| John    | Anne     |
| John    | Ron      |



### Group by Manager

```sql id="fhq8qb"
GROUP BY manager.id, manager.name
```

Creates one group for each manager.



### Count Direct Reports

```sql id="5aw1wg"
COUNT(employee.id)
```

Counts how many employees report to each manager.

Example:

| Manager | Count |
| ------- | ----: |
| John    |     5 |
| Dan     |     4 |



### Filter Managers

```sql id="m1vg7s"
HAVING COUNT(employee.id) >= 5
```

Keeps only managers with **5 or more direct reports**.

---

## Dry Run

### Employee Table

| id  | name  | managerId |
| --- | ----- | --------- |
| 101 | John  | NULL      |
| 102 | Dan   | 101       |
| 103 | James | 101       |
| 104 | Amy   | 101       |
| 105 | Anne  | 101       |
| 106 | Ron   | 101       |



### After SELF JOIN

| Manager | Employee |
| ------- | -------- |
| John    | Dan      |
| John    | James    |
| John    | Amy      |
| John    | Anne     |
| John    | Ron      |



### GROUP BY

| Manager |
| ------- |
| John    |



### COUNT()

| Manager | Direct Reports |
| ------- | -------------: |
| John    |              5 |



### HAVING

```sql id="fwlk1d"
HAVING COUNT(employee.id) >= 5
```

Result:

| name |
| ---- |
| John |

---

## SQL Concepts Used

| Concept   | Purpose                     |
| --------- | --------------------------- |
| SELF JOIN | Join a table with itself    |
| ON        | Match manager with employee |
| GROUP BY  | Create manager-wise groups  |
| COUNT()   | Count direct reports        |
| HAVING    | Filter grouped results      |

---

## Memory Trick

```text id="5nkr8u"
Employee Table
      ↓
SELF JOIN
      ↓
Manager ↔ Employee
      ↓
GROUP BY Manager
      ↓
COUNT Employees
      ↓
HAVING COUNT >= 5
```
