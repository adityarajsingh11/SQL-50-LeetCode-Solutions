# LeetCode 1141 - User Activity for the Past 30 Days I

## Difficulty

**Easy**

---

# Question

Table: **Activity**

| Column Name   | Type |
| ------------- | ---- |
| user_id       | int  |
| session_id    | int  |
| activity_date | date |
| activity_type | enum |

Each row represents one activity performed by a user.

Write a solution to find the **daily active users** during the **30-day period ending on `2019-07-27` (inclusive)**.

Return:

* `day`
* `active_users`


## Example

### Input

**Activity**

| user_id | session_id | activity_date | activity_type |
|--------:|-----------:|---------------|---------------|
| 1 | 1 | 2019-07-20 | open_session |
| 1 | 1 | 2019-07-20 | scroll_down |
| 1 | 1 | 2019-07-20 | end_session |
| 2 | 4 | 2019-07-20 | open_session |
| 2 | 4 | 2019-07-21 | send_message |
| 2 | 4 | 2019-07-21 | end_session |
| 3 | 2 | 2019-07-21 | open_session |
| 3 | 2 | 2019-07-21 | send_message |
| 3 | 2 | 2019-07-21 | end_session |
| 4 | 3 | 2019-06-25 | open_session |
| 4 | 3 | 2019-06-25 | end_session |

### Output

| day | active_users |
|------------|-------------:|
| 2019-07-20 | 2 |
| 2019-07-21 | 2 |

### Explanation

The required date range is **2019-06-28** to **2019-07-27**.

- **2019-07-20** → Active users: **1, 2** → **2 users**
- **2019-07-21** → Active users: **2, 3** → **2 users**
- **2019-06-25** is **outside** the 30-day period, so **User 4 is ignored**.

Therefore, the result is:

```text
2019-07-20 → 2
2019-07-21 → 2
```
---

# Problem Summary

For each day between:

```text
2019-06-28
↓

2019-07-27
```

Find the number of **unique users** who performed at least one activity.

---

> 🔴 **This is a WHERE + BETWEEN + GROUP BY + COUNT(DISTINCT) problem.**

---

# Key Observation 

The question asks for

> **Active Users**

NOT

> Total Activities

If a user performs multiple activities on the same day,

he/she is counted **only once**.

Example

| user | session | day   |
| ---- | ------- | ----- |
| 1    | 10      | Jul20 |
| 1    | 11      | Jul20 |
| 2    | 12      | Jul20 |

Active Users

```text
User1

User2

↓

2
```

NOT

```text
3
```

---

# Approach

### Step 1

Take only activities between

```text
2019-06-28

and

2019-07-27
```

using

```sql
WHERE activity_date
BETWEEN ...
```


### Step 2

Group records by date.

```sql
GROUP BY activity_date
```

Now every day becomes one group.


### Step 3

Count unique users.

```sql
COUNT(DISTINCT user_id)
```

---

# Solution

```sql
SELECT
    activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date
BETWEEN '2019-06-28'
AND '2019-07-27'
GROUP BY activity_date;
```

---

# Query Breakdown

## Select Date

```sql
activity_date AS day
```

Renames the column to **day**.



## Count Active Users

```sql
COUNT(DISTINCT user_id)
```

Counts each user only once.


## FROM

```sql
FROM Activity
```

Reads records from the Activity table.



## WHERE

```sql
WHERE activity_date
BETWEEN '2019-06-28'
AND '2019-07-27'
```

Filters records within the required 30-day period.

## GROUP BY

```sql
GROUP BY activity_date
```

Creates one group for every day.

---

# Dry Run

### Activity Table

| user_id | session_id | activity_date | activity_type |
| ------- | ---------- | ------------- | ------------- |
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |



## Step 1 → WHERE

Keep only dates between

```text
2019-06-28

↓

2019-07-27
```

(All rows satisfy the condition.)

## Step 2 → GROUP BY activity_date

### Group 1

```text
2019-07-20
```

Rows

| user |
| ---- |
| 1    |
| 1    |
| 1    |
| 2    |


### Group 2

```text
2019-07-21
```

Rows

| user |
| ---- |
| 2    |
| 3    |
| 3    |


## Step 3 → COUNT(DISTINCT)

### 2019-07-20

Users

```text
1
1
1
2
```

Distinct

```text
1
2
```

Count

```text
2
```


### 2019-07-21

Users

```text
2
3
3
```

Distinct

```text
2
3
```

Count

```text
2
```


## Final Output

| day        | active_users |
| ---------- | -----------: |
| 2019-07-20 |            2 |
| 2019-07-21 |            2 |

---

# SQL Concepts Used

| Concept         | Purpose                  |
| --------------- | ------------------------ |
| WHERE           | Filter rows              |
| BETWEEN         | Select a date range      |
| GROUP BY        | Create one group per day |
| COUNT(DISTINCT) | Count unique users       |
| AS              | Rename output column     |
