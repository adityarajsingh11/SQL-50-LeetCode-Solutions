# LeetCode 1378 - Replace Employee ID With The Unique Identifier

## Question

Table: **Employees**

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |

`id` is the primary key.

---

Table: **EmployeeUNI**

| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| unique_id   | int  |

`(id, unique_id)` is the primary key.

Write a solution to show the **unique ID of each user**. If a user does not have a unique ID, show `NULL` instead.

Return the result table in any order.

---

## Problem Summary

We have two tables:

### Employees

| id | name  |
| -- | ----- |
| 1  | Alice |
| 7  | Bob   |
| 11 | Meir  |

### EmployeeUNI

| id | unique_id |
| -- | --------- |
| 11 | 2         |

We need to display:

* Employee name
* Employee unique ID
* If no unique ID exists → show `NULL`

---

## Approach

* Start with the `Employees` table.
* Match employees with `EmployeeUNI` using `id`.
* Keep all employees, even if no matching unique ID exists.
* Therefore, use **LEFT JOIN**.

---

## Solution

```sql
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id;
```

---

## Query Breakdown

### Select required columns

```sql
SELECT EmployeeUNI.unique_id, Employees.name
```

Returns:

* unique_id from EmployeeUNI
* name from Employees



### Base table

```sql
FROM Employees
```

Employees is the left table.


### Join second table

```sql
LEFT JOIN EmployeeUNI
```

Connect EmployeeUNI with Employees.


### Matching condition

```sql
ON Employees.id = EmployeeUNI.id
```

Match rows having the same employee ID.

---

## Dry Run

### Employees

| id | name  |
| -- | ----- |
| 1  | Alice |
| 7  | Bob   |
| 11 | Meir  |

### EmployeeUNI

| id | unique_id |
| -- | --------- |
| 11 | 2         |

### After LEFT JOIN

| unique_id | name  |
| --------- | ----- |
| NULL      | Alice |
| NULL      | Bob   |
| 2         | Meir  |

---

## Why LEFT JOIN?

Question says:

> Show the unique ID of each user. If a user does not have a unique ID, show NULL.

This means all employees must appear in the output.

### INNER JOIN (Ckeck krne k liye)

```sql
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id;
```

Output:

| unique_id | name |
| --------- | ---- |
| 2         | Meir |

❌ Alice and Bob are missing.

---

### LEFT JOIN

```sql
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id;
```

Output:

| unique_id | name  |
| --------- | ----- |
| NULL      | Alice |
| NULL      | Bob   |
| 2         | Meir  |

✅ All employees are included.

---

### `ON` Clause 

**Purpose:** Specifies the condition used to join two tables.

### Syntax

```sql
SELECT *
FROM TableA
JOIN TableB
ON TableA.id = TableB.id;
```


### Meaning

```text
ON = How the two tables are connected.
```

### Memory Trick

```text
JOIN = Connect tables
ON   = Connection rule
```
---