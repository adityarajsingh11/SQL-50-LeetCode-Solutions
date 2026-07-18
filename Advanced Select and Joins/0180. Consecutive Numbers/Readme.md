# LeetCode 180 - Consecutive Numbers

## Difficulty

**Medium**

---

# Question

Table: **Logs**

| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| num         | int  |

* `id` is the primary key.
* `id` values are in ascending order.

Return all numbers that appear **at least three times consecutively**.

---

# Problem Summary

We need to find numbers that appear **3 consecutive times**.

> 🔴 **This is a SELF JOIN problem (comparing adjacent rows).**

---

# Key Observation

The question asks for **consecutive**, **not frequency**.

Example

| id | num |
| -- | --- |
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |

Output

```text
1
```

---

### Example 2

| id | num |
| -- | --- |
| 1  | 1   |
| 2  | 2   |
| 3  | 1   |
| 4  | 1   |
| 5  | 1   |

Output

```text
1
```

Although `1` appears **4 times**, only the last **3 are consecutive**.

---

# Why GROUP BY Doesn't Work?

Suppose

| id | num |
| -- | --- |
| 1  | 1   |
| 2  | 2   |
| 3  | 1   |
| 4  | 1   |
| 5  | 1   |

If we write

```sql
SELECT num
FROM Logs
GROUP BY num;
```

Result

| num | Count |
| --- | ----- |
| 1   | 4     |
| 2   | 1     |

`GROUP BY` only counts occurrences.

It **cannot check whether they are consecutive**.

---

# Key Idea

We need to compare

```text
Current Row

↓

Next Row

↓

Next Next Row
```

That means

```text
Previous / Next Row Comparison
```

Since SQL cannot directly access neighboring rows (without window functions), we use **SELF JOIN**.

---

# Approach

### Step 1

Create three copies of the Logs table.

```text
Logs l1

Logs l2

Logs l3
```


### Step 2

Join consecutive rows.

```sql
l1.id + 1 = l2.id

l2.id + 1 = l3.id
```

Meaning

```text
l1

↓

Next Row

↓

Next Next Row
```


### Step 3

Check whether all three numbers are equal.

```sql
l1.num = l2.num

AND

l2.num = l3.num
```


### Step 4

Use

```sql
DISTINCT
```

to remove duplicate answers.

---

# Solution

```sql
SELECT DISTINCT
    l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2
ON l1.id + 1 = l2.id
JOIN Logs l3
ON l2.id + 1 = l3.id
WHERE
    l1.num = l2.num
AND l2.num = l3.num;
```

---

# Query Breakdown

## Step 1 — Select

```sql
SELECT DISTINCT
l1.num AS ConsecutiveNums
```

Returns the number appearing consecutively.

`DISTINCT` removes duplicate values.


## Step 2 — First Table

```sql
FROM Logs l1
```

Current row.


## Step 3 — First JOIN

```sql
JOIN Logs l2
ON l1.id + 1 = l2.id
```

Moves to the **next row**.

Example

| l1.id | l2.id |
| ----- | ----- |
| 1     | 2     |
| 2     | 3     |
| 3     | 4     |


## Step 4 — Second JOIN

```sql
JOIN Logs l3
ON l2.id + 1 = l3.id
```

Moves to the **next next row**.

Example

| l2.id | l3.id |
| ----- | ----- |
| 2     | 3     |
| 3     | 4     |
| 4     | 5     |


## Step 5 — WHERE

```sql
WHERE
l1.num = l2.num
AND
l2.num = l3.num
```

Checks whether

```text
Current

=

Next

=

Next Next
```

If all are equal,

the number appears three consecutive times.

---

# Dry Run

## Original Table

| id | num |
| -- | --- |
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |



## Step 1

First JOIN

```sql
ON l1.id + 1 = l2.id
```

Result

| l1.id | l1.num | l2.id | l2.num |
| ----- | ------ | ----- | ------ |
| 1     | 1      | 2     | 1      |
| 2     | 1      | 3     | 1      |
| 3     | 1      | 4     | 2      |
| 4     | 2      | 5     | 1      |



## Step 2

Second JOIN

```sql
ON l2.id + 1 = l3.id
```

Now every row gets the **next-next row**.

| l1.id | l1.num | l2.id | l2.num | l3.id | l3.num |
| ----- | ------ | ----- | ------ | ----- | ------ |
| 1     | 1      | 2     | 1      | 3     | 1      |
| 2     | 1      | 3     | 1      | 4     | 2      |
| 3     | 1      | 4     | 2      | 5     | 1      |

Notice:

### First Row

```text
l1 → id = 1

↓

l2 → id = 2

↓

l3 → id = 3
```

Numbers

```text
1
1
1
```

✅ Consecutive


### Second Row

```text
l1 → id = 2

↓

l2 → id = 3

↓

l3 → id = 4
```

Numbers

```text
1
1
2
```

❌ Not equal


### Third Row

```text
l1 → id = 3

↓

l2 → id = 4

↓

l3 → id = 5
```

Numbers

```text
1
2
1
```

❌ Not equal


## WHERE

```sql
WHERE l1.num = l2.num
AND l2.num = l3.num
```

Only the first row satisfies the condition.

| l1.id | l2.id | l3.id | Numbers | Result |
| ----- | ----- | ----- | ------- | ------ |
| 1     | 2     | 3     | 1,1,1   | ✅      |
| 2     | 3     | 4     | 1,1,2   | ❌      |
| 3     | 4     | 5     | 1,2,1   | ❌      |

### Final Output

| ConsecutiveNums |
| --------------- |
| 1               |

---

# SQL Concepts Used

| Concept     | Purpose                                    |
| ----------- | ------------------------------------------ |
| `SELF JOIN` | Compare rows from the same table.          |
| `JOIN`      | Connect consecutive rows using `id`.       |
| `WHERE`     | Check whether all three numbers are equal. |
| `AND`       | Ensure all conditions are true.            |
| `DISTINCT`  | Remove duplicate numbers.                  |
| `AS`        | Rename the output column.                  |
