# LeetCode 1667 - Fix Names in a Table

## Difficulty

**Easy**

---

# 📝 Question in Simple Words

Convert every person's name into the correct format:

* **First letter → Uppercase**
* **Remaining letters → Lowercase**

Finally, sort the result by `user_id`.

---

# Easy Understanding

Example

| Original | Correct |
| -------- | ------- |
| aLice    | Alice   |
| bOB      | Bob     |
| CHARLIE  | Charlie |

Only the **first letter** should be capital.

---

# Problem Summary

For every name,

* Take the **first character**
* Convert it to **uppercase**
* Take the remaining characters
* Convert them to **lowercase**
* Join both parts together

---

# Key Observation 

We split the name into **2 parts**.

```text
Name
 │
 ├── First Letter
 │        │
 │        ▼
 │     UPPER()
 │
 └── Remaining Letters
          │
          ▼
       LOWER()
          │
          ▼
       CONCAT()
```

---

# Approach

### Step 1

Take the first character.

### Step 2

Convert it into uppercase.

### Step 3

Take the remaining characters.

### Step 4

Convert them into lowercase.

### Step 5

Join both strings.

### Step 6

Sort by `user_id`.

---

# Solution

```sql
SELECT
    user_id,
    CONCAT(
        UPPER(LEFT(name,1)),
        LOWER(SUBSTRING(name,2))
    ) AS name
FROM Users
ORDER BY user_id;
```

---

# Query Breakdown

## Step 1

```sql
LEFT(name,1)
```

Take the first character.

Example

```text
aLice

↓

a
```



## Step 2

```sql
UPPER(LEFT(name,1))
```

Convert the first letter to uppercase.

Example

```text
a

↓

A
```


## Step 3

```sql
SUBSTRING(name,2)
```

Take the remaining characters.

Example

```text
aLice

↓

Lice
```

## Step 4

```sql
LOWER(SUBSTRING(name,2))
```

Convert remaining letters to lowercase.

Example

```text
Lice

↓

lice
```

## Step 5

```sql
CONCAT(...)
```

Join both parts.

Example

```text
A

+

lice

↓

Alice
```


## Step 6

```sql
ORDER BY user_id
```

Sort the output by `user_id`.

---

# Dry Run

### Users Table

| user_id | name    |
| ------- | ------- |
| 1       | aLice   |
| 2       | bOB     |
| 3       | CHARLIE |


### Row 1

```text
LEFT(name,1)

a

↓

UPPER()

A
```

```text
SUBSTRING(name,2)

Lice

↓

LOWER()

lice
```

```text
CONCAT()

A + lice

↓

Alice
```


### Row 2

```text
bOB

↓

B

+

ob

↓

Bob
```


### Row 3

```text
CHARLIE

↓

C

+

harlie

↓

Charlie
```


## Final Output

| user_id | name    |
| ------- | ------- |
| 1       | Alice   |
| 2       | Bob     |
| 3       | Charlie |

---

# SQL Concepts Used

| Concept       | Purpose                      |
| ------------- | ---------------------------- |
| `LEFT()`      | Extract the first character  |
| `UPPER()`     | Convert to uppercase         |
| `SUBSTRING()` | Extract remaining characters |
| `LOWER()`     | Convert to lowercase         |
| `CONCAT()`    | Join two strings             |
| `ORDER BY`    | Sort by `user_id`            |
