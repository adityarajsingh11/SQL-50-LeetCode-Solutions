# LeetCode 1729 - Find Followers Count

## Difficulty

**Easy**

---

# Question

Table: **Followers**

| Column Name | Type |
| ----------- | ---- |
| user_id     | int  |
| follower_id | int  |

The table shows which users follow another user.

Each row means:

```text
follower_id follows user_id
```

Write a solution to find the **number of followers** for each user.

Return the result ordered by **user_id**.



---

# Problem Summary

For every user:

1. Count how many followers they have.
2. Return:

   * `user_id`
   * `followers_count`
3. Sort the result by `user_id`.

---

> 🔴 **This is a GROUP BY + COUNT() + ORDER BY problem.**

---

# Key Observation 

Each row represents **one follower** of a user.

Example

| user_id | follower_id |
| ------- | ----------: |
| 1       |           2 |
| 1       |           3 |
| 1       |           4 |

Means

```text
User 2 follows User 1

User 3 follows User 1

User 4 follows User 1
```

Therefore

```text
Followers of User 1 = 3
```

---

# Approach

### Step 1

Group all rows by user.

```sql
GROUP BY user_id
```

Now each user has one group.


### Step 2

Count followers in each group.

```sql
COUNT(follower_id)
```


### Step 3

Sort users by ID.

```sql
ORDER BY user_id
```

---

# Solution

```sql
SELECT
    user_id,
    COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
```

---

# Query Breakdown

## Select User

```sql
SELECT user_id
```

Displays every user.


## COUNT()

```sql
COUNT(follower_id)
```

Counts how many followers each user has.

Example

| follower_id |
| ----------- |
| 2           |
| 3           |
| 4           |

Count

```text
3
```


## GROUP BY

```sql
GROUP BY user_id
```

Creates one group for every user.


## ORDER BY

```sql
ORDER BY user_id
```

Sorts the result in ascending order.

(Default order is **ASC**.)

---

# Dry Run 

### Followers Table

| user_id | follower_id |
| ------- | ----------: |
| 0       |           1 |
| 1       |           0 |
| 2       |           0 |
| 2       |           1 |


## Step 1 → GROUP BY

### User 0

| follower |
| -------- |
| 1        |

Count

```text
1
```


### User 1

| follower |
| -------- |
| 0        |

Count

```text
1
```



### User 2

| follower |
| -------- |
| 0        |
| 1        |

Count

```text
2
```



## Step 2 → ORDER BY user_id

Result

| user_id | followers_count |
| ------- | --------------: |
| 0       |               1 |
| 1       |               1 |
| 2       |               2 |



## Final Output

| user_id | followers_count |
| ------- | --------------: |
| 0       |               1 |
| 1       |               1 |
| 2       |               2 |

---

# SQL Concepts Used

| Concept  | Purpose                   |
| -------- | ------------------------- |
| GROUP BY | Create one group per user |
| COUNT()  | Count followers           |
| ORDER BY | Sort output by user ID    |

