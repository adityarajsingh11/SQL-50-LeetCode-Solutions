# LeetCode 626 - Exchange Seats

## Difficulty

**Medium**

---

# Question

Table: **Seat**

| Column  | Type    |
| ------- | ------- |
| id      | int     |
| student | varchar |

The `id` column is a continuous sequence starting from **1**.

Swap the seat of **every two consecutive students**.

* Swap seat **1 ↔ 2**
* Swap seat **3 ↔ 4**
* If the number of students is **odd**, the last student remains in the same seat.

Return the result ordered by **id**.

---

# Problem Summary

We need to **exchange every pair of adjacent seats**.

Example

Original

| id | student |
| -- | ------- |
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |

Output

| id | student |
| -- | ------- |
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |

---

# Key Observation 

We **do not swap the student names**.

Instead, we **assign a new id** to every student.

```text
Odd id  → id + 1

Even id → id - 1

Last Odd id → Keep Same
```

Finally,

```sql
ORDER BY id
```

automatically makes it look like the students swapped seats.

---

# Visual Understanding

Original

| id | student |
| -- | ------- |
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |

Assign new ids

| New id | student |
| ------ | ------- |
| 2      | Abbot   |
| 1      | Doris   |
| 4      | Emerson |
| 3      | Green   |
| 5      | Jeames  |

After

```sql
ORDER BY id
```

Final Output

| id | student |
| -- | ------- |
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |

---

# Approach

### Step 1

Find whether the current seat is

* Odd
* Even

using

```sql
id % 2
```


### Step 2

If id is odd,

assign

```sql
id + 1
```

### Step 3

If id is even,

assign

```sql
id - 1
```

### Step 4

Special case

If

* id is the last row
* id is odd

keep it unchanged.


### Step 5

Sort using

```sql
ORDER BY id
```

---

# Solution

```sql
SELECT
    CASE
        WHEN id = (SELECT MAX(id) FROM Seat)
             AND id % 2 = 1
        THEN id

        WHEN id % 2 = 1
        THEN id + 1

        ELSE id - 1
    END AS id,
    student
FROM Seat
ORDER BY id;
```

---

# Query Breakdown

## Step 1

```sql
SELECT MAX(id)
FROM Seat;
```

Find the last seat number.

Example

```text
MAX(id) = 5
```


## Step 2

```sql
CASE
```

Start conditional logic.


## Step 3

```sql
WHEN id = MAX(id)
AND id % 2 = 1
THEN id
```

If this is the **last odd seat**, don't swap it.


## Step 4

```sql
WHEN id % 2 = 1
THEN id + 1
```

Odd seats move to the next seat.

Example

```text
1 → 2

3 → 4
```


## Step 5

```sql
ELSE id - 1
```

Even seats move back one seat.

Example

```text
2 → 1

4 → 3
```


## Step 6

```sql
ORDER BY id
```

Arrange rows using the new ids.

---

# Complete Dry Run

## Original Table

| id | student |
| -- | ------- |
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |


### Step 1

Find

```sql
SELECT MAX(id)
FROM Seat;
```

Output

```text
5
```

### Step 2

Apply CASE

| Original id | Student | Rule Applied | New id |
| ----------- | ------- | ------------ | ------ |
| 1           | Abbot   | Odd → +1     | 2      |
| 2           | Doris   | Even → -1    | 1      |
| 3           | Emerson | Odd → +1     | 4      |
| 4           | Green   | Even → -1    | 3      |
| 5           | Jeames  | Last Odd     | 5      |

Temporary Result

| New id | student |
| ------ | ------- |
| 2      | Abbot   |
| 1      | Doris   |
| 4      | Emerson |
| 3      | Green   |
| 5      | Jeames  |


### Step 3

Sort

```sql
ORDER BY id
```

Final Result

| id | student |
| -- | ------- |
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |



## Final Output

| id | student |
| -- | ------- |
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |

---

# SQL Concepts Used

| Concept      | Purpose                                    |
| ------------ | ------------------------------------------ |
| `CASE WHEN`  | Apply conditional logic.                   |
| `MAX()`      | Find the last seat number.                 |
| `Subquery`   | Get `MAX(id)` inside the `CASE` statement. |
| `%` (Modulo) | Check whether the seat id is odd or even.  |
| `ORDER BY`   | Arrange rows using the new ids.            |
| `AS`         | Rename the calculated column as `id`.      |
