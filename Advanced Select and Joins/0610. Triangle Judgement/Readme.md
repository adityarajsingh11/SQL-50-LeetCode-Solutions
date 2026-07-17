# LeetCode 610 - Triangle Judgement

## Difficulty

**Easy**

---

# Question

Table: **Triangle**

| Column Name | Type |
| ----------- | ---- |
| x           | int  |
| y           | int  |
| z           | int  |

Each row contains three side lengths.

Return:

* `x`
* `y`
* `z`
* `"Yes"` if the three sides can form a triangle.
* `"No"` otherwise.

---

# Problem Summary

For every row,

check whether the three sides satisfy the **Triangle Inequality Rule**.

If yes,

return

```text
Yes
```

Otherwise,

return

```text
No
```

---

> 🔴 **This is a CASE WHEN + Logical Operators (AND) problem.**

---

# Key Observation 

A triangle is valid **only if all three conditions are true**.

```text
x + y > z

AND

y + z > x

AND

x + z > y
```

If even **one condition fails**,

it is **not** a triangle.

---

# Approach

### Step 1

Read each row.


### Step 2

Check all three triangle conditions.


### Step 3

Use

```sql
CASE WHEN
```

to return

* `"Yes"` if all conditions are true.
* `"No"` otherwise.

---

# Solution

```sql
SELECT
    x,
    y,
    z,
    CASE
        WHEN x + y > z
         AND y + z > x
         AND x + z > y
        THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM Triangle;
```

---

# Query Breakdown

## Step 1 — Select Columns

```sql
SELECT
x,
y,
z
```

Returns all three side lengths.


## Step 2 — CASE

```sql
CASE
```

Used to check conditions.

Think of it like

```text
IF...ELSE
```


## Step 3 — WHEN

```sql
WHEN
x + y > z
AND y + z > x
AND x + z > y
```

Checks whether the sides can form a triangle.

All three conditions must be true.


## Step 4 — THEN

```sql
THEN 'Yes'
```

Return **Yes**.


## Step 5 — ELSE

```sql
ELSE 'No'
```

Return **No**.

## Step 6 — END

```sql
END AS triangle
```

Creates a new column named `triangle`.

---

# Dry Run

## Triangle Table

| x | y | z |
| - | - | - |
| 3 | 4 | 5 |
| 1 | 2 | 3 |
| 5 | 5 | 5 |



### Row 1

```text
3 + 4 > 5 ✅

4 + 5 > 3 ✅

3 + 5 > 4 ✅
```

Result

```text
Yes
```


### Row 2

```text
1 + 2 > 3

3 > 3

❌ False
```

Result

```text
No
```

(No need to check further because one condition already failed.)


### Row 3

```text
5 + 5 > 5 ✅

5 + 5 > 5 ✅

5 + 5 > 5 ✅
```

Result

```text
Yes
```


## Final Output

| x | y | z | triangle |
| - | - | - | -------- |
| 3 | 4 | 5 | Yes      |
| 1 | 2 | 3 | No       |
| 5 | 5 | 5 | Yes      |

---

# SQL Concepts Used

| Concept     | Purpose                            |
| ----------- | ---------------------------------- |
| `CASE WHEN` | Apply conditional logic            |
| `AND`       | Ensure all conditions are true     |
| `THEN`      | Return value if condition is true  |
| `ELSE`      | Return value if condition is false |
| `END`       | End the CASE statement             |
| `AS`        | Rename the output column           |
