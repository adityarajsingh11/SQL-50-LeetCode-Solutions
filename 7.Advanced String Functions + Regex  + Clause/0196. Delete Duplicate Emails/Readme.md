# LeetCode 196 - Delete Duplicate Emails

## Difficulty

**Easy**

---

# 📝 Question in Simple Words

Delete all duplicate email records from the `Person` table.

If the same email appears multiple times, **keep only the record with the smallest `id`** and delete the rest.

---

# Easy Understanding

Suppose the table is:

| id | email                                 |
| -- | ------------------------------------- |
| 1  | [john@mail.com](mailto:john@mail.com) |
| 2  | [bob@mail.com](mailto:bob@mail.com)   |
| 3  | [john@mail.com](mailto:john@mail.com) |

Both rows **1** and **3** have the same email.

Since **id = 1** is smaller,

✅ Keep **id = 1**

❌ Delete **id = 3**

---

# Problem Summary

The question asks us to:

* Find duplicate emails.
* Compare their IDs.
* Keep the smallest ID.
* Delete the larger IDs.

---

# Key Observation 

We compare the table **with itself**.

```text
Person Table
      │
      ▼
Self Join
      │
      ▼
Same Email?
      │
      ▼
Compare IDs
      │
      ▼
Delete Larger ID
```

---

# Approach

### Step 1

Join the `Person` table with itself.


### Step 2

Find rows having the same email.


### Step 3

Compare their IDs.

### Step 4

Delete the row having the larger ID.

---

# Solution

```sql
DELETE p2
FROM Person p1
JOIN Person p2
ON p1.email = p2.email
AND p1.id < p2.id;
```

---

# Query Breakdown

## Step 1

```sql
DELETE p2
```

Delete rows from alias **p2**.


## Step 2

```sql
FROM Person p1
JOIN Person p2
```

Join the table with itself.

Think

```text
Person

 p1          p2
```

Now every row is compared with every other row.


## Step 3

```sql
p1.email = p2.email
```

Find duplicate emails.

Example

| p1.email | p2.email |
| -------- | -------- |
| john     | john     |

Same email ✅


## Step 4

```sql
p1.id < p2.id
```

Compare IDs.

Example

| p1.id | p2.id |
| ----- | ----- |
| 1     | 3     |

Since **1 < 3**

Keep **1**

Delete **3**

---

# Dry Run



## Initial Table

| id | email                                 |
| -- | ------------------------------------- |
| 1  | [john@mail.com](mailto:john@mail.com) |
| 2  | [bob@mail.com](mailto:bob@mail.com)   |
| 3  | [john@mail.com](mailto:john@mail.com) |

We need to **keep the smallest id** and **delete duplicate emails**.

## Step 1: Self Join

```sql
FROM Person p1
JOIN Person p2
```

Think of the table as two copies.

| p1     | p2     |
| ------ | ------ |
| Person | Person |

Now every row of `p1` is compared with every row of `p2`.

## Step 2: Same Email

Condition

```sql
p1.email = p2.email
```

Matching rows:

| p1.id | p1.email | p2.id | p2.email |
| ----: | -------- | ----: | -------- |
|     1 | john     |     1 | john     |
|     1 | john     |     3 | john     |
|     2 | bob      |     2 | bob      |
|     3 | john     |     1 | john     |
|     3 | john     |     3 | john     |


## Step 3: Compare IDs

Condition

```sql
p1.id < p2.id
```

Check each row:

| p1.id | p2.id | Result           |
| ----: | ----: | ---------------- |
|     1 |     1 | ❌ 1 < 1 is False |
|     1 |     3 | ✅ 1 < 3 is True  |
|     2 |     2 | ❌ 2 < 2 is False |
|     3 |     1 | ❌ 3 < 1 is False |
|     3 |     3 | ❌ 3 < 3 is False |

Only **one row** remains.

| p1.id | p2.id |
| ----: | ----: |
|     1 |     3 |

## Step 4: DELETE p2

```sql
DELETE p2
```

Which row is `p2`?

```text
p2.id = 3
```

So SQL deletes

| id | email                                 |
| -- | ------------------------------------- |
| 3  | [john@mail.com](mailto:john@mail.com) |


## Final Table

| id | email                                 |
| -- | ------------------------------------- |
| 1  | [john@mail.com](mailto:john@mail.com) |
| 2  | [bob@mail.com](mailto:bob@mail.com)   |


---

# SQL Concepts Used

| Concept          | Purpose                            |
| ---------------- | ---------------------------------- |
| `DELETE`         | Remove rows from a table           |
| `Self JOIN`      | Compare rows within the same table |
| `JOIN`           | Match related rows                 |
| `ON`             | Specify join conditions            |
| `Alias (p1, p2)` | Refer to the same table twice      |
| Comparison (`<`) | Keep the smallest ID               |

---

# Pattern Learned

### Pattern 1 — Self Join

```sql
FROM table t1
JOIN table t2
```

Compare rows of the same table.


### Pattern 2 — Find Duplicate Records

```sql
t1.column = t2.column
```

Match duplicate values.


### Pattern 3 — Keep Smallest ID

```sql
t1.id < t2.id
```

Keep the row with the smaller ID.

### Pattern 4 — Delete Duplicate Row

```sql
DELETE t2
```

Delete the row having the larger ID.
