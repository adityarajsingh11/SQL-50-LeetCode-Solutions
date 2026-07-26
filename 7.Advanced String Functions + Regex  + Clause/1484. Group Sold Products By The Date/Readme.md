# LeetCode 1484 - Group Sold Products By The Date

## Difficulty

**Easy**

---

# 📝 Question in Simple Words

For each **sell date**, find:

* The number of **unique products** sold.
* All unique product names in **alphabetical order**, separated by commas.

---

# Easy Understanding

Suppose the table is

| sell_date  | product    |
| ---------- | ---------- |
| 2020-05-30 | Headphone  |
| 2020-05-30 | Basketball |
| 2020-05-30 | Basketball |

Output should be

| sell_date  | num_sold | products             |
| ---------- | -------: | -------------------- |
| 2020-05-30 |        2 | Basketball,Headphone |

Notice:

* Basketball is counted only once.
* Products are sorted alphabetically.

---

# Problem Summary

For every date:

* Group all products.
* Remove duplicate products.
* Count unique products.
* Merge product names into one string.
* Sort product names alphabetically.

---

# Key Observation

This problem is solved in **4 steps**.

```text
Activities
      │
      ▼
GROUP BY sell_date
      │
      ▼
Remove Duplicate Products
      │
      ▼
COUNT + GROUP_CONCAT
      │
      ▼
Sort Alphabetically
```

---

# Approach

### Step 1

Group records by `sell_date`.

### Step 2

Count unique products.


### Step 3

Merge all unique product names into one string.

### Step 4

Sort products alphabetically.

---

# Solution

```sql
SELECT
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(
        DISTINCT product
        ORDER BY product
        SEPARATOR ','
    ) AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date;
```

---

# Query Breakdown

## Step 1

```sql
GROUP BY sell_date
```

Create one group for each date.

Example

| sell_date  |
| ---------- |
| 2020-05-30 |
| 2020-06-01 |


## Step 2

```sql
COUNT(DISTINCT product)
```

Count only unique products.

Example

| Product |
| ------- |
| Mask    |
| Mask    |
| Mask    |

Result

```text
1
```

## Step 3

```sql
GROUP_CONCAT(DISTINCT product)
```

Merge all unique product names into one string.

Example

| Product |
| ------- |
| Bible   |
| Pencil  |

Output

```text
Bible,Pencil
```


## Step 4

```sql
ORDER BY product
```

Sort products alphabetically inside `GROUP_CONCAT`.

Example

Before

```text
Pencil
Bible
Mask
```

After

```text
Bible
Mask
Pencil
```


## Step 5

```sql
SEPARATOR ','
```

Join products using commas.

Output

```text
Bible,Mask,Pencil
```

## Step 6

```sql
ORDER BY sell_date
```

Sort the final result by date.

---

# Dry Run

### Activities Table

| sell_date  | product    |
| ---------- | ---------- |
| 2020-05-30 | Headphone  |
| 2020-06-01 | Pencil     |
| 2020-06-02 | Mask       |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible      |
| 2020-06-02 | Mask       |


## Step 1

Group by date.

### Group 1

```text
2020-05-30

Headphone
Basketball
```


### Group 2

```text
2020-06-01

Pencil
Bible
```

### Group 3

```text
2020-06-02

Mask
Mask
```

## Step 2

Remove duplicates.

| Date       | Products              |
| ---------- | --------------------- |
| 2020-05-30 | Headphone, Basketball |
| 2020-06-01 | Pencil, Bible         |
| 2020-06-02 | Mask                  |

## Step 3

Count products.

| Date       | Count |
| ---------- | ----: |
| 2020-05-30 |     2 |
| 2020-06-01 |     2 |
| 2020-06-02 |     1 |

## Step 4

Sort alphabetically.

| Date       | Products              |
| ---------- | --------------------- |
| 2020-05-30 | Basketball, Headphone |
| 2020-06-01 | Bible, Pencil         |
| 2020-06-02 | Mask                  |

## Step 5

Join into one string.

| sell_date  | products             |
| ---------- | -------------------- |
| 2020-05-30 | Basketball,Headphone |
| 2020-06-01 | Bible,Pencil         |
| 2020-06-02 | Mask                 |


## Final Output

| sell_date  | num_sold | products             |
| ---------- | -------: | -------------------- |
| 2020-05-30 |        2 | Basketball,Headphone |
| 2020-06-01 |        2 | Bible,Pencil         |
| 2020-06-02 |        1 | Mask                 |

---

# SQL Concepts Used

| Concept                            | Purpose                                     |
| ---------------------------------- | ------------------------------------------- |
| `GROUP BY`                         | Group rows by date                          |
| `COUNT(DISTINCT)`                  | Count unique products                       |
| `GROUP_CONCAT()`                   | Merge multiple rows into one string         |
| `DISTINCT`                         | Remove duplicate products                   |
| `ORDER BY` (inside `GROUP_CONCAT`) | Sort product names alphabetically           |
| `SEPARATOR`                        | Specify the separator between product names |
| `ORDER BY`                         | Sort final output by date                   |

---

# Pattern Learned

### Pattern 1 — Group Data

```sql
GROUP BY sell_date
```

### Pattern 2 — Count Unique Values

```sql
COUNT(DISTINCT column)
```

### Pattern 3 — Merge Rows into One String

```sql
GROUP_CONCAT(column)
```


### Pattern 4 — Remove Duplicates While Merging

```sql
GROUP_CONCAT(DISTINCT column)
```


### Pattern 5 — Sort Inside `GROUP_CONCAT`

```sql
GROUP_CONCAT(
    column
    ORDER BY column
)
```
