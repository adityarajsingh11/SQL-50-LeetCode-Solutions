# LeetCode 1633 - Percentage of Users Attended a Contest

## Question

Table: **Users**

| Column Name | Type    |
| ----------- | ------- |
| user_id     | int     |
| user_name   | varchar |

`user_id` is the primary key.


Table: **Register**

| Column Name | Type |
| ----------- | ---- |
| contest_id  | int  |
| user_id     | int  |

Each row indicates that a user registered for a contest.

Write a solution to find the **percentage of users** who registered for each contest.

Round the answer to **2 decimal places**.

Sort the result by:

* Percentage **descending**
* If percentages are equal, **contest_id ascending**

---

## Problem Summary

For every contest:

* Count registered users.
* Find total users.
* Calculate registration percentage.
* Round to 2 decimal places.
* Sort by percentage.

---

> 🔴 **This is a GROUP BY + COUNT() + Subquery + ROUND() problem.**

---

## Formula

```text
Percentage

=

(Number of Registered Users × 100)
-----------------------------------
Total Number of Users
```

---

## Approach

1. Count registered users for each contest.
2. Count total users from the Users table.
3. Divide both values.
4. Multiply by 100.
5. Round to 2 decimal places.
6. Sort by percentage.

---

## Solution

```sql
SELECT
    contest_id,
    ROUND(
        COUNT(user_id) * 100.0 /
        (SELECT COUNT(*) FROM Users),
        2
    ) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC,
         contest_id;
```

---

## Query Breakdown

### Count Registered Users

```sql
COUNT(user_id)
```

Returns the number of users registered in each contest.


### Total Users

```sql
(SELECT COUNT(*) FROM Users)
```

Returns the total number of users.

Example:

| user_id |
| ------- |
| 1       |
| 2       |
| 3       |
| 4       |
| 5       |

Total Users = **5**

### Calculate Percentage

```sql
COUNT(user_id) * 100.0
/
(SELECT COUNT(*) FROM Users)
```

Example:

Contest has **3 users**

Total users = **5**

```text
3 × 100 / 5

=

60%
```

### Round Answer

```sql
ROUND(value,2)
```

Example

```text
66.6666

↓

66.67
```

### Group by Contest

```sql
GROUP BY contest_id
```

Calculates one percentage for each contest.

### Sort Output

```sql
ORDER BY percentage DESC,
         contest_id;
```

Meaning:

1. Higher percentage comes first.
2. If percentages are equal, smaller `contest_id` comes first (default **ASC**).

---

## Dry Run

### Users

| user_id |
| ------- |
| 1       |
| 2       |
| 3       |
| 4       |
| 5       |

Total Users = **5**



### Register

| contest_id | user_id |
| ---------- | ------- |
| 101        | 1       |
| 101        | 2       |
| 101        | 3       |
| 102        | 1       |
| 102        | 5       |



### COUNT()

| contest_id | Registered Users |
| ---------- | ---------------: |
| 101        |                3 |
| 102        |                2 |



### Percentage

Contest 101

```text
3 × 100 / 5

=

60.00
```

Contest 102

```text
2 × 100 / 5

=

40.00
```

### Final Output

| contest_id | percentage |
| ---------- | ---------: |
| 101        |      60.00 |
| 102        |      40.00 |

---

## SQL Concepts Used

| Concept  | Purpose                   |
| -------- | ------------------------- |
| COUNT()  | Count registered users    |
| Subquery | Count total users         |
| GROUP BY | Contest-wise calculation  |
| ROUND()  | Round to 2 decimal places |
| ORDER BY | Sort results              |
| DESC     | Highest percentage first  |

