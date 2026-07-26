# LeetCode 185 - Department Top Three Salaries

## Difficulty

**Hard**

---

# 📝 Question

Write a solution to find the employees who have the **top three highest distinct salaries** in **each department**.

Return:

* Department Name
* Employee Name
* Salary

---

# 📖 Easy Understanding

The question **does not ask** for the top 3 employees.

It asks for:

> **Top 3 DISTINCT salaries in every department.**

If multiple employees have the same salary, **return all of them.**

---

## Example

### Department

| id | name |
| -: | ---- |
|  1 | IT   |
|  2 | HR   |

### Employee

| name | salary | departmentId |
| ---- | -----: | -----------: |
| A    |   9000 |            1 |
| B    |   8000 |            1 |
| C    |   8000 |            1 |
| D    |   7000 |            1 |
| E    |   6000 |            1 |
| F    |   5000 |            2 |
| G    |   4000 |            2 |
| H    |   3000 |            2 |


### Output

| Department | Employee | Salary |
| ---------- | -------- | -----: |
| IT         | A        |   9000 |
| IT         | B        |   8000 |
| IT         | C        |   8000 |
| IT         | D        |   7000 |
| HR         | F        |   5000 |
| HR         | G        |   4000 |
| HR         | H        |   3000 |

---

# Problem Summary

For every employee:

* Look only inside their department.
* Count how many **distinct salaries are greater** than their salary.
* If the count is **less than 3**, include that employee.

---

# Key Observation 

Instead of finding the **Top 3 salaries**, count **how many salaries are greater** than the current employee's salary.

If

* 0 salaries are greater → Rank 1 ✅
* 1 salary is greater → Rank 2 ✅
* 2 salaries are greater → Rank 3 ✅
* 3 or more salaries are greater → Not Top 3 ❌

```text
Employee
    │
    ▼
Same Department
    │
    ▼
Count DISTINCT Higher Salaries
    │
    ▼
Count < 3 ?
    │
 ┌──┴──┐
 │     │
Yes    No
 │     │
Keep Ignore
```

---

# Approach

### Step 1

Join Employee and Department tables.


### Step 2

For every employee, check only employees in the same department.


### Step 3

Count distinct salaries greater than the current employee's salary.

### Step 4

If the count is less than 3, return the employee.

---

# Solution

```sql
SELECT
    Department.name AS Department,
    Employee.name AS Employee,
    Employee.salary AS Salary
FROM Employee
JOIN Department
ON Employee.departmentId = Department.id
WHERE (
    SELECT COUNT(DISTINCT Employee2.salary)
    FROM Employee Employee2
    WHERE Employee2.departmentId = Employee.departmentId
      AND Employee2.salary > Employee.salary
) < 3;
```

---

# Query Breakdown

## Step 1

```sql
SELECT
    Department.name AS Department,
    Employee.name AS Employee,
    Employee.salary AS Salary
```

Return

* Department Name
* Employee Name
* Salary


## Step 2

```sql
FROM Employee
JOIN Department
ON Employee.departmentId = Department.id
```

Join both tables.

Result

| Department | Employee | Salary |
| ---------- | -------- | -----: |
| IT         | A        |   9000 |
| IT         | B        |   8000 |
| IT         | C        |   8000 |
| IT         | D        |   7000 |
| IT         | E        |   6000 |

## Step 3

```sql
WHERE
```

Filter employees who belong to the Top 3 salaries.


## Step 4

```sql
SELECT COUNT(DISTINCT Employee2.salary)
```

Count how many **distinct salaries** are greater than the current employee.

Example

Current Employee

```text
Salary = 7000
```

Greater salaries

```text
9000
8000
8000
```

After `DISTINCT`

```text
9000
8000
```

Count

```text
2
```


## Step 5

```sql
Employee2.departmentId = Employee.departmentId
```

Compare employees **only within the same department**.

Example

Current employee is in **IT**.

Ignore all employees from **HR**.



## Step 6

```sql
Employee2.salary > Employee.salary
```
##### Employee2 same Department ka table h of current Eployee means Will IT ka h tho Employee2 m IT wale hi Employee rehenge and unse hi compare karenge

Find salaries greater than the current employee's salary.

Example

Current Salary

```text
7000
```

Greater salaries

```text
9000
8000
```



## Step 7

```sql
) < 3
```

If fewer than 3 distinct salaries are greater,

Keep the employee.

---

# Dry Run

## Employee Table

| id | name  | salary | departmentId |
| -: | ----- | -----: | -----------: |
|  1 | Joe   |  85000 |            1 |
|  2 | Henry |  80000 |            2 |
|  3 | Sam   |  60000 |            2 |
|  4 | Max   |  90000 |            1 |
|  5 | Janet |  69000 |            1 |
|  6 | Randy |  85000 |            1 |
|  7 | Will  |  70000 |            1 |

## Department Table

| id | name  |
| -: | ----- |
|  1 | IT    |
|  2 | Sales |

---

# Step 1

```sql
FROM Employee
JOIN Department
ON Employee.departmentId = Department.id
```

After JOIN

| Current Employee | Salary | Department |
| ---------------- | -----: | ---------- |
| Joe              |  85000 | IT         |
| Henry            |  80000 | Sales      |
| Sam              |  60000 | Sales      |
| Max              |  90000 | IT         |
| Janet            |  69000 | IT         |
| Randy            |  85000 | IT         |
| Will             |  70000 | IT         |



## 🔹Iteration 1

Current Employee = **Joe**

Outer Query

| Employee | Salary | Dept |
| -------- | -----: | ---- |
| Joe      |  85000 | IT   |

Subquery

```sql
SELECT COUNT(DISTINCT Employee2.salary)
FROM Employee Employee2
WHERE Employee2.departmentId = Employee.departmentId
```

Employee2 after department filter

| Employee2 | Salary |
| --------- | -----: |
| Joe       |  85000 |
| Max       |  90000 |
| Janet     |  69000 |
| Randy     |  85000 |
| Will      |  70000 |

Next condition

```sql
Employee2.salary > Employee.salary
```

Current salary = **85000**

| Employee2 | Salary | >85000 ? |
| --------- | -----: | -------- |
| Joe       |  85000 | ❌        |
| Max       |  90000 | ✅        |
| Janet     |  69000 | ❌        |
| Randy     |  85000 | ❌        |
| Will      |  70000 | ❌        |

Remaining salaries

| Salary |
| -----: |
|  90000 |

COUNT(DISTINCT)

```
1
```

Check

```
1 < 3 ✅
```

Joe is selected.


## 🔹Iteration 2

Current Employee = **Henry**

Outer

| Employee | Salary | Dept  |
| -------- | -----: | ----- |
| Henry    |  80000 | Sales |

Employee2 after filter

| Employee2 | Salary |
| --------- | -----: |
| Henry     |  80000 |
| Sam       |  60000 |

Compare

```
Salary > 80000
```

| Employee2 | Result |
| --------- | ------ |
| Henry     | ❌      |
| Sam       | ❌      |

Count

```
0
```

```
0 < 3 ✅
```

Henry selected.


## 🔹Iteration 3

Current Employee = **Sam**

Employee2

| Employee2 | Salary |
| --------- | -----: |
| Henry     |  80000 |
| Sam       |  60000 |

Compare

```
Salary > 60000
```

| Employee2 | Result |
| --------- | ------ |
| Henry     | ✅      |
| Sam       | ❌      |

Distinct salaries

| Salary |
| -----: |
|  80000 |

Count

```
1
```

```
1 < 3 ✅
```

Sam selected.


## 🔹Iteration 4

Current Employee = **Max**

Employee2

| Employee2 | Salary |
| --------- | -----: |
| Joe       |  85000 |
| Max       |  90000 |
| Janet     |  69000 |
| Randy     |  85000 |
| Will      |  70000 |

Compare

```
Salary > 90000
```

Koi nahi.

Count

```
0
```

```
0 < 3 ✅
```

Max selected.


## 🔹Iteration 5

Current Employee = **Janet**

Employee2

| Employee2 | Salary |
| --------- | -----: |
| Joe       |  85000 |
| Max       |  90000 |
| Janet     |  69000 |
| Randy     |  85000 |
| Will      |  70000 |

Compare

```
Salary > 69000
```

| Employee2 | Result |
| --------- | ------ |
| Joe       | ✅      |
| Max       | ✅      |
| Janet     | ❌      |
| Randy     | ✅      |
| Will      | ✅      |

Remaining salaries

```
85000
90000
85000
70000
```

DISTINCT

```
85000
90000
70000
```

Count

```
3
```

```
3 < 3 ❌
```

Janet rejected.



## 🔹Iteration 6

Current Employee = **Randy**

Compare with IT employees

Greater salaries

```
90000
```

Count

```
1
```

```
1 < 3 ✅
```

Randy selected.



## 🔹Iteration 7

Current Employee = **Will**

Employee2

| Employee2 | Salary |
| --------- | -----: |
| Joe       |  85000 |
| Max       |  90000 |
| Janet     |  69000 |
| Randy     |  85000 |
| Will      |  70000 |

Compare

```
Salary > 70000
```

| Employee2 | Result |
| --------- | ------ |
| Joe       | ✅      |
| Max       | ✅      |
| Janet     | ❌      |
| Randy     | ✅      |
| Will      | ❌      |

Remaining salaries

```
85000
90000
85000
```

DISTINCT

```
85000
90000
```

Count

```
2
```

```
2 < 3 ✅
```

Will selected.


## Final Output

| Department | Employee | Salary |
| ---------- | -------- | -----: |
| IT         | Joe      |  85000 |
| IT         | Max      |  90000 |
| IT         | Randy    |  85000 |
| IT         | Will     |  70000 |
| Sales      | Henry    |  80000 |
| Sales      | Sam      |  60000 |

---

# SQL Concepts Used

| Concept             | Purpose                                   |
| ------------------- | ----------------------------------------- |
| `JOIN`              | Combine Employee and Department tables    |
| Correlated Subquery | Runs once for every employee              |
| `COUNT(DISTINCT)`   | Count unique higher salaries              |
| `WHERE`             | Filter Top 3 salary employees             |
| Comparison (`>`)    | Find salaries greater than current salary |
