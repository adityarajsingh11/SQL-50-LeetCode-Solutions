# LeetCode 602 - Friend Requests II: Who Has the Most Friends

## Difficulty

**Medium**

---

# Question

Table: **RequestAccepted**

| Column       | Type |
| ------------ | ---- |
| requester_id | int  |
| accepter_id  | int  |
| accept_date  | date |

Each row represents an accepted friend request.

Find the **person who has the highest number of friends**.

Return:

* `id`
* `num` (number of friends)

---

# Problem Summary

Each friendship involves **two people**:

* Requester
* Accepter

Both become friends after the request is accepted.

So, we must count how many times each person appears in **both columns**.

---

# Key Observation

Both columns represent **people**.

So first combine them into **one column**, then count occurrences.

```text
requester_id
      │
      ▼
   UNION ALL
      ▲
      │
accepter_id
      │
      ▼
Single Column (id)
      │
      ▼
GROUP BY id
      │
      ▼
COUNT(*)
      │
      ▼
Highest Count
```

---

# Approach

### Step 1

Take all `requester_id`.

### Step 2

Take all `accepter_id`.

### Step 3

Combine both using `UNION ALL`.

### Step 4

Group by person id.

### Step 5

Count how many times each person appears.

### Step 6

Return the highest count.

---

# Solution

```sql
SELECT
    id,
    COUNT(*) AS num
FROM
(
    SELECT requester_id AS id
    FROM RequestAccepted

    UNION ALL

    SELECT accepter_id AS id
    FROM RequestAccepted
) friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;
```

---

# Query Breakdown

### Step 1

```sql
SELECT requester_id AS id
FROM RequestAccepted
```

Take all requester IDs.


### Step 2

```sql
SELECT accepter_id AS id
FROM RequestAccepted
```

Take all accepter IDs.


### Step 3

```sql
UNION ALL
```

Merge both columns into one.

Example

| id |
| -- |
| 1  |
| 1  |
| 2  |
| 2  |
| 3  |
| 3  |

Now every friendship is represented in one column.


### Step 4

```sql
GROUP BY id
```

Create one group for each person.

### Step 5

```sql
COUNT(*)
```

Count how many times each person appears.

That equals the number of friends.

### Step 6

```sql
ORDER BY num DESC
LIMIT 1
```

Sort by highest friend count and return only the top person.

---
# Dry Run

## Initial Table

| requester_id | accepter_id |
| ------------ | ----------- |
| 1            | 2           |
| 1            | 3           |
| 2            | 3           |
| 3            | 4           |


## Step 1: Select all `requester_id`

```sql id="mmsvjg"
SELECT requester_id AS id
FROM RequestAccepted;
```

Output

| id |
| -- |
| 1  |
| 1  |
| 2  |
| 3  |


## Step 2: Select all `accepter_id`

```sql id="z1w7lb"
SELECT accepter_id AS id
FROM RequestAccepted;
```

Output

| id |
| -- |
| 2  |
| 3  |
| 3  |
| 4  |

---

## Step 3: `UNION ALL`

```sql id="0nyfh2"
SELECT requester_id AS id
FROM RequestAccepted

UNION ALL

SELECT accepter_id AS id
FROM RequestAccepted;
```

Output

| id |
| -- |
| 1  |
| 1  |
| 2  |
| 3  |
| 2  |
| 3  |
| 3  |
| 4  |

Think of it as:

```text
Requester IDs : 1  1  2  3
                     +
Accepter IDs  : 2  3  3  4
--------------------------------
Combined IDs  : 1  1  2  3  2  3  3  4
```


## Step 4: `GROUP BY id`

Now SQL groups the same IDs together.

| id | Rows    |
| -- | ------- |
| 1  | 1, 1    |
| 2  | 2, 2    |
| 3  | 3, 3, 3 |
| 4  | 4       |


## Step 5: `COUNT(*)`

Count the number of rows in each group.

| id | COUNT(*) |
| -- | -------: |
| 1  |        2 |
| 2  |        2 |
| 3  |        3 |
| 4  |        1 |


## Step 6: `ORDER BY num DESC`

Sort by friend count.

| id | num |
| -- | --: |
| 3  |   3 |
| 1  |   2 |
| 2  |   2 |
| 4  |   1 |

## Step 7: `LIMIT 1`

Return only the first row.

| id | num |
| -- | --: |
| 3  |   3 |


## Final Output

| id | num |
| -- | --: |
| 3  |   3 |

---

# SQL Concepts Used

| Concept     | Purpose                                        |
| ----------- | ---------------------------------------------- |
| `UNION ALL` | Combine requester and accepter into one column |
| `Subquery`  | Create a temporary combined table              |
| `GROUP BY`  | Group rows by person ID                        |
| `COUNT(*)`  | Count total friends                            |
| `ORDER BY`  | Sort by highest friend count                   |
| `LIMIT`     | Return only one result                         |

---

# Pattern Learned

### Pattern 1 – Merge Similar Columns

```sql
SELECT col1
UNION ALL
SELECT col2
```

Used when two columns represent the **same type of data**.


### Pattern 2 – Frequency Count

```sql
GROUP BY id
COUNT(*)
```

Count how many times each value appears.


### Pattern 3 – Top Record

```sql
ORDER BY count DESC
LIMIT 1
```

Return the highest value.

