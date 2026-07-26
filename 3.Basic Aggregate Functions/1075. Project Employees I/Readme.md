# LeetCode 1075 - Project Employees I

## Question

Table: **Project**

| Column Name | Type |
| ----------- | ---- |
| project_id  | int  |
| employee_id | int  |

`(project_id, employee_id)` is the primary key.



Table: **Employee**

| Column Name      | Type    |
| ---------------- | ------- |
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |

`employee_id` is the primary key.

Write a solution to find the **average experience years** of all employees working on each project.

Round the result to **2 decimal places**.

---

## Problem Summary

For each project:

* Find all employees working on that project.
* Calculate their average experience.
* Return one row for each project.

---

> 🔴 **This is a LEFT JOIN + AVG() + GROUP BY problem.**

---

## Key Observation

The **Project** table contains only employee IDs.

To get each employee's experience, we must join with the **Employee** table.

Then calculate the average experience for every project.

---

## Approach

1. Join `Project` with `Employee`.
2. Match employees using `employee_id`.
3. Calculate the average `experience_years`.
4. Round the answer to 2 decimal places.
5. Group by `project_id`.

---

## Solution

```sql
SELECT
    Project.project_id,
    ROUND(AVG(Employee.experience_years), 2) AS average_years
FROM Project
LEFT JOIN Employee
ON Project.employee_id = Employee.employee_id
GROUP BY Project.project_id;
```

---

## Query Breakdown

### Select Project ID

```sql
SELECT Project.project_id
```

Returns one row per project.



### LEFT JOIN

```sql
LEFT JOIN Employee
```

Connects each project with employee details.



### Join Condition

```sql
ON Project.employee_id = Employee.employee_id
```

Matches each project employee with the corresponding employee record.


### Calculate Average Experience

```sql
AVG(Employee.experience_years)
```

Calculates the average years of experience of employees in a project.



### Round Result

```sql
ROUND(AVG(Employee.experience_years), 2)
```

Rounds the average to **2 decimal places**.

Example:

```text
3.6666 → 3.67
```


### Group by Project

```sql
GROUP BY Project.project_id
```

Calculates one average value for each project.

---

## Dry Run

### Project

| project_id | employee_id |
| ---------- | ----------: |
| 1          |           1 |
| 1          |           2 |
| 1          |           3 |
| 2          |           1 |
| 2          |           4 |

### Employee

| employee_id | experience_years |
| ----------: | ---------------: |
|           1 |                3 |
|           2 |                2 |
|           3 |                5 |
|           4 |                4 |



### After JOIN

| project | employee | experience |
| ------- | -------: | ---------: |
| 1       |        1 |          3 |
| 1       |        2 |          2 |
| 1       |        3 |          5 |
| 2       |        1 |          3 |
| 2       |        4 |          4 |



### AVG()

Project 1

```text
(3 + 2 + 5) / 3 = 3.33
```

Project 2

```text
(3 + 4) / 2 = 3.50
```



### Final Output

| project_id | average_years |
| ---------- | ------------: |
| 1          |          3.33 |
| 2          |          3.50 |

---

## SQL Concepts Used

| Concept   | Purpose                           |
| --------- | --------------------------------- |
| LEFT JOIN | Combine project and employee data |
| ON        | Match employee IDs                |
| AVG()     | Calculate average experience      |
| ROUND()   | Round to 2 decimal places         |
| GROUP BY  | Project-wise calculation          |

