# LeetCode 1280 - Students and Examinations

## Question

Table: **Students**

| Column Name  | Type    |
| ------------ | ------- |
| student_id   | int     |
| student_name | varchar |

`student_id` is the primary key.


Table: **Subjects**

| Column Name  | Type    |
| ------------ | ------- |
| subject_name | varchar |

`subject_name` is the primary key.



Table: **Examinations**

| Column Name  | Type    |
| ------------ | ------- |
| student_id   | int     |
| subject_name | varchar |

Each row indicates that a student attended an examination for a subject.

Write a solution to find the **number of times each student attended each exam**.

Return the result ordered by:

* `student_id`
* `subject_name`

---

## Problem Summary

For **every student** and **every subject**, show:

* Student ID
* Student Name
* Subject Name
* Number of exams attended

Even if a student never attended a subject, display **0**.

---

> 🔴 **This is a CROSS JOIN + LEFT JOIN + GROUP BY + COUNT() problem.**

---

## Key Observation

We need **every possible combination** of:

* Students
* Subjects

Then check whether an exam record exists.

---

## Approach

1. Create all Student × Subject combinations using **CROSS JOIN**.
2. Match examination records using **LEFT JOIN**.
3. Count the number of matching exams.
4. Group the result.
5. Sort the output.

---

## Solution

```sql id="gm7xyr"
SELECT
    Students.student_id,
    Students.student_name,
    Subjects.subject_name,
    COUNT(Examinations.subject_name) AS attended_exams
FROM Students
CROSS JOIN Subjects
LEFT JOIN Examinations
ON Students.student_id = Examinations.student_id
AND Subjects.subject_name = Examinations.subject_name
GROUP BY
    Students.student_id,
    Students.student_name,
    Subjects.subject_name
ORDER BY
    Students.student_id,
    Subjects.subject_name;
```

---

## Query Breakdown

### Create Every Student-Subject Pair

```sql id="r7z9xd"
FROM Students
CROSS JOIN Subjects
```

Creates every possible combination.

Example:

Students

| Student |
| ------- |
| Alice   |
| Bob     |

Subjects

| Subject |
| ------- |
| Math    |
| Physics |

After CROSS JOIN:

| Student | Subject |
| ------- | ------- |
| Alice   | Math    |
| Alice   | Physics |
| Bob     | Math    |
| Bob     | Physics |



### Match Examination Records

```sql id="hzbv1w"
LEFT JOIN Examinations
```

Connects exam records with each student-subject pair.



### Join Condition

```sql id="f4n8vr"
ON Students.student_id = Examinations.student_id
AND Subjects.subject_name = Examinations.subject_name
```

Matches:

* Same student
* Same subject



### Count Exams

```sql id="87ut8v"
COUNT(Examinations.subject_name)
```

Counts how many times the student attended that subject.

If no record exists,

```text id="rpoh3g"
COUNT = 0
```

because `COUNT(column)` ignores `NULL`.



### Group Results

```sql id="yc6s8i"
GROUP BY
Students.student_id,
Students.student_name,
Subjects.subject_name
```

Creates one row for each student-subject pair.



### Sort Output

```sql id="i5pmq7"
ORDER BY
Students.student_id,
Subjects.subject_name
```

Sorts by student ID and subject name.

---

## Dry Run

### Students

| id | name  |
| -- | ----- |
| 1  | Alice |
| 2  | Bob   |

### Subjects

| subject |
| ------- |
| Math    |
| Physics |



### After CROSS JOIN

| Student | Subject |
| ------- | ------- |
| Alice   | Math    |
| Alice   | Physics |
| Bob     | Math    |
| Bob     | Physics |


### Examinations

| student | subject |
| ------- | ------- |
| Alice   | Math    |
| Alice   | Math    |
| Bob     | Physics |



### After LEFT JOIN

| Student | Subject | Match |
| ------- | ------- | ----- |
| Alice   | Math    | ✔     |
| Alice   | Math    | ✔     |
| Alice   | Physics | NULL  |
| Bob     | Math    | NULL  |
| Bob     | Physics | ✔     |


### GROUP BY + COUNT

| Student | Subject | Count |
| ------- | ------- | ----: |
| Alice   | Math    |     2 |
| Alice   | Physics |     0 |
| Bob     | Math    |     0 |
| Bob     | Physics |     1 |

---

## SQL Concepts Used

| Concept    | Purpose                           |
| ---------- | --------------------------------- |
| CROSS JOIN | Create every possible combination |
| LEFT JOIN  | Keep all combinations             |
| ON         | Match student and subject         |
| COUNT()    | Count exam records                |
| GROUP BY   | Group by student and subject      |
| ORDER BY   | Sort output                       |


---

## Memory Trick

```text id="1vuwg4"
Students
      ×
Subjects
      ↓
CROSS JOIN
      ↓
LEFT JOIN Examinations
      ↓
COUNT()
      ↓
GROUP BY
      ↓
ORDER BY
```

---
---


# <p style="color:red;">Note</p>


Ye confusion **bahut common** hai. Tumne achha question pucha. 

### Tumne socha:

```sql id="rkt2na"
LEFT JOIN Examinations
```

to matlab

> **Examinations table ka pura data chahiye.**

❌ Aisa nahi hota.



## Rule

`LEFT JOIN` me **LEFT** ka matlab hota hai:

> **FROM ke baad jo result hai**, uske **saare rows** chahiye.

Ye zaroori nahi ki sirf ek table ho.


### Is question me

```sql id="z79o9j"
FROM Students
CROSS JOIN Subjects
```

Sabse pehle ye execute hota hai.

Result ban jata hai:

| Student | Subject |
| ------- | ------- |
| Alice   | Math    |
| Alice   | Physics |
| Bob     | Math    |
| Bob     | Physics |

Ab ye pura result **LEFT TABLE** ban gaya.

Fir SQL padhta hai:

```sql id="e5q4tx"
LEFT JOIN Examinations
```

Matlab:

```text id="1rbdgp"
Student × Subject
        LEFT JOIN
     Examinations
```

Yaani **Student × Subject** wale **saare rows** rakhne hain.

Examinations se sirf matching data lana hai.

---
