# LeetCode 1934 - Confirmation Rate

## Question

Table: **Signups**

| Column Name | Type     |
| ----------- | -------- |
| user_id     | int      |
| time_stamp  | datetime |

`user_id` is the primary key.

---

Table: **Confirmations**

| Column Name | Type                        |
| ----------- | --------------------------- |
| user_id     | int                         |
| time_stamp  | datetime                    |
| action      | ENUM('confirmed','timeout') |

Each row represents a confirmation request.

Write a solution to find the **confirmation rate** of each user.

The confirmation rate is:

```text
(Number of confirmed requests)
÷
(Total confirmation requests)
```

If a user never requested a confirmation, the rate should be **0**.

Round the answer to **2 decimal places**.

---

## Problem Summary

For every user:

* Count confirmed requests.
* Divide by total requests.
* If no requests exist, return `0`.

---

> 🔴 **This is a LEFT JOIN + AVG(IF()) + GROUP BY problem.**

---

## Key Observation

Convert each action into:

```text
confirmed → 1
timeout   → 0
```

Then,

```text
Average of (1,0,1,1...)
=
Confirmation Rate
```

---

## Approach

1. Keep all users using `LEFT JOIN`.
2. Match confirmation records.
3. Convert actions into `1` and `0` using `IF()`.
4. Calculate average using `AVG()`.
5. Round the result.

---

## Solution

```sql
SELECT
    Signups.user_id,
    ROUND(
        AVG(IF(Confirmations.action = 'confirmed', 1, 0)),
        2
    ) AS confirmation_rate
FROM Signups
LEFT JOIN Confirmations
ON Signups.user_id = Confirmations.user_id
GROUP BY Signups.user_id;
```

---

## Query Breakdown

### Keep All Users

```sql
FROM Signups
LEFT JOIN Confirmations
```

Returns every user, even if they have no confirmation requests.



### Join Condition

```sql
ON Signups.user_id = Confirmations.user_id
```

Matches confirmation records with users.



### Convert Action into 1 or 0

```sql
IF(Confirmations.action = 'confirmed', 1, 0)
```

| Action    | Value |
| --------- | ----: |
| confirmed |     1 |
| timeout   |     0 |



### Find Average

```sql
AVG(IF(...))
```

Example:

Values:

```text
1
0
1
```

Average:

```text
(1 + 0 + 1) / 3
=
0.67
```

This is the confirmation rate.



### Round Answer

```sql
ROUND(value, 2)
```

Example:

```text
0.6667 → 0.67
```



### Group by User

```sql
GROUP BY Signups.user_id
```

Calculates one confirmation rate per user.

---

## Dry Run

### Signups

| user_id |
| ------- |
| 1       |
| 2       |

### Confirmations

| user_id | action    |
| ------- | --------- |
| 1       | confirmed |
| 1       | timeout   |
| 1       | confirmed |



### After LEFT JOIN

| user | action    |
| ---- | --------- |
| 1    | confirmed |
| 1    | timeout   |
| 1    | confirmed |
| 2    | NULL      |


### IF()

| action    | value |
| --------- | ----: |
| confirmed |     1 |
| timeout   |     0 |
| confirmed |     1 |
| NULL      |     0 |



### AVG()

User 1

```text
(1 + 0 + 1) / 3
=
0.67
```

User 2

```text
0
```



### Final Output

| user_id | confirmation_rate |
| ------- | ----------------- |
| 1       | 0.67              |
| 2       | 0.00              |

---

## SQL Concepts Used

| Concept   | Purpose                       |
| --------- | ----------------------------- |
| LEFT JOIN | Keep all users                |
| ON        | Match user records            |
| IF()      | Convert condition into 1 or 0 |
| AVG()     | Calculate confirmation rate   |
| ROUND()   | Round to 2 decimal places     |
| GROUP BY  | User-wise calculation         |

