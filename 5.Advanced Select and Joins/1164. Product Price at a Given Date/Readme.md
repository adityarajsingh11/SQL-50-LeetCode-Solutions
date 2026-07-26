# LeetCode 1164 - Product Price at a Given Date

## Difficulty

**Medium**

---

# Question

Table: **Products**

| Column      | Type |
| ----------- | ---- |
| product_id  | int  |
| new_price   | int  |
| change_date | date |

Every row represents a **price change** of a product.

Return the **price of every product on `2019-08-16`**.

### Rules

* If a product's price changed **on or before `2019-08-16`**, return its **latest price**.
* If a product **never changed** before or on `2019-08-16`, return **10** (default price).

---

# Problem Summary

We need to find the **price of every product on a specific date (2019-08-16).**

There are **2 possible cases**:

1. Product has at least one price change **on or before** `2019-08-16`.

   * Return the **latest (`MAX(change_date)`) price**.

2. Product has **no price change** before or on `2019-08-16`.

   * Return the **default price = 10**.

---

# Key Observation 

Every product belongs to **one of two groups**:

```text
Product
   │
   ├── Price changed on/before 16 Aug
   │          │
   │          ▼
   │    Take latest price
   │
   └── No change before 16 Aug
              │
              ▼
          Price = 10
```

---

# Approach

### Step 1

Find products whose **first change happened after 16 Aug**.

These products still have their default price.

```sql
HAVING MIN(change_date) > '2019-08-16'
```


### Step 2

Find products whose price changed **before or on 16 Aug**.

Take the **latest change**.

```sql
MAX(change_date)
```


### Step 3

Combine both results.

```sql
UNION ALL
```

---

# Solution

```sql
SELECT
    product_id,
    10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16'

UNION ALL

SELECT
    product_id,
    new_price AS price
FROM Products
WHERE (product_id, change_date) IN
(
    SELECT
        product_id,
        MAX(change_date)
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
);
```

---

# Query Breakdown

## First Query

```sql
SELECT
    product_id,
    10 AS price
```

Return products whose default price is still **10**.


```sql
GROUP BY product_id
```

Group all records of the same product.


```sql
HAVING MIN(change_date) > '2019-08-16'
```

If the earliest change is **after** `2019-08-16`, then the product had **no price update** before that date.

Return

```text
Price = 10
```



## Second Query

```sql
SELECT
    product_id,
    new_price AS price
```

Return the latest price.


```sql
WHERE (product_id, change_date) IN
```

Match the row having

* same product
* latest valid date


### Subquery

```sql
SELECT
    product_id,
    MAX(change_date)
FROM Products
WHERE change_date <= '2019-08-16'
GROUP BY product_id;
```

For every product,

find the **latest price change before or on 16 Aug**.


## UNION ALL

```sql
UNION ALL
```

Combine

* Default price products
* Updated price products

---

# Dry Run

## Original Table

| product_id | new_price | change_date |
| ---------- | --------- | ----------- |
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |

Question:

```text
Price on 2019-08-16
```



## Step 1

First query

```sql
SELECT
product_id,
10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16'
```

### Product 1

Dates

```text
14 Aug
15 Aug
16 Aug
```

Minimum

```text
14 Aug
```

Is

```text
14 > 16 ?
```

❌ No

Not Selected.



### Product 2

Dates

```text
14 Aug
17 Aug
```

Minimum

```text
14 Aug
```

```text
14 > 16 ?
```

❌ No

Not Selected.


### Product 3

Dates

```text
18 Aug
```

Minimum

```text
18 Aug
```

```text
18 > 16 ?
```

✅ Yes

Return

| product_id | price |
| ---------- | ----- |
| 3          | 10    |


## Step 2

Now SQL executes **only this part**:

```sql
SELECT
product_id,
MAX(change_date)
FROM Products
WHERE change_date <= '2019-08-16'
GROUP BY product_id;
```

Notice carefully

Before `MAX()` runs,

SQL first applies

```sql
WHERE change_date <= '2019-08-16'
```



### After WHERE

Rows after filtering

| product_id | new_price | change_date |
| ---------- | --------- | ----------- |
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |

These rows are **removed** because they are after 16 Aug:

| product_id | new_price | change_date |           |
| ---------- | --------- | ----------- | --------- |
| 2          | 65        | 2019-08-17  | ❌ Removed |
| 3          | 20        | 2019-08-18  | ❌ Removed |


## Now GROUP BY

### Product 1

Remaining dates

```text
14 Aug

15 Aug

16 Aug
```

MAX

```text
16 Aug
```


### Product 2

Remaining dates

```text
14 Aug
```

Why only 14?

Because

```text
17 Aug

>

16 Aug
```

was removed by the `WHERE` clause.

So MAX becomes

```text
14 Aug
```


### Product 3

No rows remain after filtering.

So Product 3 doesn't appear in this query.

## Result of Subquery

| product_id | MAX(change_date) |
| ---------- | ---------------- |
| 1          | 2019-08-16       |
| 2          | 2019-08-14       |


## Step 3

Now SQL matches

```sql
WHERE (product_id, change_date) IN (...)
```

Meaning

```text
(Product 1, 16 Aug)

(Product 2, 14 Aug)
```

Find these rows.

| product_id | new_price | change_date |   |
| ---------- | --------- | ----------- | - |
| 1          | 35        | 2019-08-16  | ✅ |
| 2          | 50        | 2019-08-14  | ✅ |

Output

| product_id | price |
| ---------- | ----- |
| 1          | 35    |
| 2          | 50    |



## Step 4

UNION ALL combines both queries.

First Query

| product_id | price |
| ---------- | ----- |
| 3          | 10    |

Second Query

| product_id | price |
| ---------- | ----- |
| 1          | 35    |
| 2          | 50    |

Final Answer

| product_id | price |
| ---------- | ----- |
| 1          | 35    |
| 2          | 50    |
| 3          | 10    |

---

# SQL Concepts Used

| Concept     | Purpose                                  |
| ----------- | ---------------------------------------- |
| `GROUP BY`  | Group rows by product.                   |
| `MIN()`     | Find first price change.                 |
| `MAX()`     | Find latest valid price change.          |
| `HAVING`    | Filter grouped data.                     |
| `WHERE`     | Filter rows before grouping.             |
| `IN`        | Match `(product_id, change_date)` pairs. |
| `Subquery`  | Get latest change date for each product. |
| `UNION ALL` | Combine both result sets.                |
| `AS`        | Rename output column.                    |
