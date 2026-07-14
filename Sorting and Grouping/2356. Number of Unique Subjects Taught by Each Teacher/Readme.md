# LeetCode 2356 - Number of Unique Subjects Taught by Each Teacher

## Difficulty

**Easy**

---

# Question

Table: **Teacher**

| Column Name | Type |
| ----------- | ---- |
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |

There is no primary key.

Each row indicates that a teacher teaches a subject in a department.

Write a solution to calculate **the number of unique subjects each teacher teaches**.

Return the result in any order.

Input: 
Teacher table:
+------------+------------+---------+
| teacher_id | subject_id | dept_id |
+------------+------------+---------+
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 3          | 1       |
| 2          | 4          | 1       |
+------------+------------+---------+
Output:  
+------------+-----+
| teacher_id | cnt |
+------------+-----+
| 1          | 2   |
| 2          | 4   |
+------------+-----+

---

# Problem Summary

For every teacher:

1. Find all subjects taught by that teacher.
2. Remove duplicate subjects.
3. Count the remaining unique subjects.

---

> 🔴 **This is a GROUP BY + COUNT(DISTINCT) problem.**

---

# Key Observation ⭐

The same teacher can teach the **same subject** in different departments.

Example

| teacher | subject | dept |
| ------- | ------- | ---- |
| 1       | 2       | 3    |
| 1       | 2       | 4    |

Teacher **1** teaches **Subject 2** in two departments.

But Subject **2** should be counted **only once**.

Therefore,

```sql
COUNT(DISTINCT subject_id)
```

---

# Approach

### Step 1

Group records by teacher.

```sql
GROUP BY teacher_id
```

Now every teacher has one group.


### Step 2

Remove duplicate subjects.

```sql
DISTINCT subject_id
```


### Step 3

Count remaining subjects.

```sql
COUNT(DISTINCT subject_id)
```

---

# Solution

```sql
SELECT
    teacher_id,
    COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
```

---

# Query Breakdown

## Select Teacher

```sql
SELECT teacher_id
```

Returns one row for every teacher.


## GROUP BY

```sql
GROUP BY teacher_id
```

Creates one group for every teacher.

Example

Teacher 1

| subject |
| ------- |
| 2       |
| 2       |
| 3       |

Teacher 2

| subject |
| ------- |
| 1       |
| 2       |
| 2       |


## DISTINCT

```sql
DISTINCT subject_id
```

Removes duplicate subjects.

Example

Before

```text
2
2
3
```

After

```text
2
3
```



## COUNT()

```sql
COUNT(DISTINCT subject_id)
```

Counts unique subjects.

---

# Dry Run

### Teacher Table

| teacher_id | subject_id | dept_id |
| ---------- | ---------- | ------- |
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 2          | 2       |

---

## Step 1 → GROUP BY

### Teacher 1

| subject |
| ------- |
| 2       |
| 2       |
| 3       |


### Teacher 2

| subject |
| ------- |
| 1       |
| 2       |
| 2       |


## Step 2 → DISTINCT

Teacher 1

```text
2
2
3
```

↓

```text
2
3
```

Teacher 2

```text
1
2
2
```

↓

```text
1
2
```

## Step 3 → COUNT

Teacher 1

```text
2 Subjects
```

Teacher 2

```text
2 Subjects
```


## Final Output

| teacher_id | cnt |
| ---------- | --: |
| 1          |   2 |
| 2          |   2 |

---

# SQL Concepts Used

| Concept         | Purpose                      |
| --------------- | ---------------------------- |
| GROUP BY        | Create one group per teacher |
| DISTINCT        | Remove duplicate subjects    |
| COUNT(DISTINCT) | Count unique subjects        |

