# LeetCode 596 - Classes With at Least 5 Students

## Difficulty

**Easy**

---

# Question

Table: **Courses**

| Column Name | Type    |
| ----------- | ------- |
| student     | varchar |
| class       | varchar |

Each row indicates that a student is enrolled in a class.

Write a solution to find **all classes that have at least 5 students**.

Return the result in any order.

Example 1:

Input: 
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
Output: 
+---------+
| class   |
+---------+
| Math    |
+---------+


---

# Problem Summary

For every class:

1. Count the number of students.
2. Return only those classes having **5 or more students**.

---

> 🔴 **This is a GROUP BY + HAVING + COUNT() problem.**

---

# Key Observation 

The question asks:

❌ Count of students

It asks for:

✅ **Class names** having at least **5 students**.

---

# Approach

### Step 1

Group all rows by class.

```sql id="h0gqj6"
GROUP BY class
```

Now every class becomes one group.


### Step 2

Count students inside each group.

```sql id="5n3cmu"
COUNT(*)
```


### Step 3

Keep only those groups having

```sql id="jhvjlwm"
COUNT(*) >= 5
```

using

```sql id="onjlwm"
HAVING
```

---

# Solution

```sql id="fvjlwm"
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(*) >= 5;
```

---

# Query Breakdown

## Select Class

```sql id="9q2jlwm"
SELECT class
```

Returns the class name.


## GROUP BY

```sql id="5jlwmv"
GROUP BY class
```

Creates one group for each class.

Example

### Math Group

| student |
| ------- |
| A       |
| B       |
| C       |
| D       |
| E       |


### English Group

| student |
| ------- |
| F       |
| G       |

---

## COUNT()

```sql id="6jlwm8"
COUNT(*)
```

Counts the number of students in each class.

Math

```text id="wvjlwm"
5
```

English

```text id="0jlwm7"
2
```

---

## HAVING

```sql id="jlwm91"
HAVING COUNT(*) >= 5
```

Filters the groups.

Math

```text id="jlwm92"
5 ≥ 5

✅ Keep
```

English

```text id="jlwm93"
2 ≥ 5

❌ Remove
```

---

# Dry Run

### Courses Table

| student | class    |
| ------- | -------- |
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |



## Step 1 → GROUP BY class

### Math

```text id="jlwm94"
A
C
E
G
H
I
```

Count

```text id="jlwm95"
6
```


### English

```text id="jlwm96"
B
```

Count

```text id="jlwm97"
1
```


### Biology

```text id="jlwm98"
D
```

Count

```text id="jlwm99"
1
```


### Computer

```text id="jlwm9a"
F
```

Count

```text id="jlwm9b"
1
```

---

## Step 2 → HAVING

Math

```text id="jlwm9c"
6 ≥ 5

✅
```

English

```text id="jlwm9d"
1 ≥ 5

❌
```

Biology

```text id="jlwm9e"
1 ≥ 5

❌
```

Computer

```text id="jlwm9f"
1 ≥ 5

❌
```



## Final Output

| class |
| ----- |
| Math  |

---

# SQL Concepts Used

| Concept  | Purpose                                 |
| -------- | --------------------------------------- |
| GROUP BY | Create one group per class              |
| COUNT(*) | Count students in each class            |
| HAVING   | Filter groups based on aggregate values |

