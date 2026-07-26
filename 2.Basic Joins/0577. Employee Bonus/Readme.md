# LeetCode 577 - Employee Bonus

## Question

Table: **Employee**

| Column Name | Type    |
| ----------- | ------- |
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |

`empId` is the primary key.

---

Table: **Bonus**

| Column Name | Type |
| ----------- | ---- |
| empId       | int  |
| bonus       | int  |

`empId` is the primary key.

Write a solution to report the **name** and **bonus** of each employee whose bonus is **less than 1000**.

If an employee **does not have a bonus**, return them as well (`NULL` bonus).

Return the result table in any order.

---

## Problem Summary

Find employees who:

* Have a bonus **less than 1000**, OR
* Do **not** have a bonus.

Return:

* Employee name
* Bonus

---

> 🔴 **This is a LEFT JOIN + NULL Handling problem.**

---

## Key Observation

* Every employee may or may not have a bonus.
* Employees without a bonus should also appear in the result.

👉 Therefore, use **LEFT JOIN**.

---

## Solution

```sql
SELECT Employee.name,
       Bonus.bonus
FROM Employee
LEFT JOIN Bonus
ON Employee.empId = Bonus.empId
WHERE Bonus.bonus < 1000
OR Bonus.bonus IS NULL;
```

---

## Query Breakdown

### Select required columns

```sql
SELECT Employee.name,
       Bonus.bonus
```

Returns employee name and bonus.


### Start from Employee table

```sql
FROM Employee
```

Employee is the left table.


### Join Bonus table

```sql
LEFT JOIN Bonus
```

Keeps all employees, even if they have no bonus.


### Join Condition

```sql
ON Employee.empId = Bonus.empId
```

Matches employee records with their bonuses.



### Filter Rows

```sql
WHERE Bonus.bonus < 1000
OR Bonus.bonus IS NULL
```

Keeps employees:

* Bonus less than 1000
* No bonus (`NULL`)

---

## Dry Run

### Employee

| empId | name   |
| ----- | ------ |
| 1     | Brad   |
| 2     | John   |
| 3     | Dan    |
| 4     | Thomas |

### Bonus

| empId | bonus |
| ----- | ----- |
| 2     | 500   |
| 4     | 2000  |


### After LEFT JOIN

| name   | bonus |
| ------ | ----- |
| Brad   | NULL  |
| John   | 500   |
| Dan    | NULL  |
| Thomas | 2000  |


### Apply WHERE

```sql
WHERE Bonus.bonus < 1000
OR Bonus.bonus IS NULL
```

Result:

| name | bonus |
| ---- | ----- |
| Brad | NULL  |
| John | 500   |
| Dan  | NULL  |

---

## SQL Concepts Used

| Concept   | Purpose                       |
| --------- | ----------------------------- |
| LEFT JOIN | Keep all rows from left table |
| ON        | Join condition                |
| WHERE     | Filter rows                   |
| OR        | Either condition can be true  |
| IS NULL   | Check for missing values      |

