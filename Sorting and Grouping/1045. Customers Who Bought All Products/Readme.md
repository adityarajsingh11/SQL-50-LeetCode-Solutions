# LeetCode 1045 - Customers Who Bought All Products

## Difficulty

**Medium**

---

# Question

There are two tables:

### Customer

| Column Name | Type |
| ----------- | ---- |
| customer_id | int  |
| product_key | int  |

Each row means a customer bought a product.

### Product

| Column Name | Type |
| ----------- | ---- |
| product_key | int  |

Contains all available products.

Write a solution to find the **customers who bought every product**.

Return the result in any order.

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+

Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+

Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+

---

# Problem Summary

For every customer:

1. Count how many **different products** they bought.
2. Count how many products exist in the **Product** table.
3. If both counts are equal, then that customer bought **all products**.

---

> 🔴 **This is a GROUP BY + COUNT(DISTINCT) + HAVING + Subquery problem.**

---

# Key Observation 

The question asks:

❌ Customer who bought the **most products**

It asks:

✅ Customer who bought **every product**.

Therefore,

We compare

```text
Products Bought By Customer

=

Total Products Available
```

If equal

↓

Customer bought all products.

---

# Approach

### Step 1

Group records by customer.

```sql
GROUP BY customer_id
```

Now every customer has one group.

### Step 2

Count unique products bought.

```sql
COUNT(DISTINCT product_key)
```

### Step 3

Find total products.

```sql
SELECT COUNT(*)
FROM Product
```

### Step 4

Compare both using

```sql
HAVING
```

---

# Solution

```sql
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) =
(
    SELECT COUNT(*)
    FROM Product
);
```

---

# Query Breakdown

## Select Customer

```sql
SELECT customer_id
```

Returns customer IDs.


## GROUP BY

```sql
GROUP BY customer_id
```

Creates one group for each customer.


## COUNT(DISTINCT)

```sql
COUNT(DISTINCT product_key)
```

Counts how many **different products** each customer bought.

Example

Before

```text
5
5
6
7
```

After DISTINCT

```text
5
6
7
```

Count

```text
3
```

## Subquery

```sql
SELECT COUNT(*)
FROM Product
```

Counts total available products.

Suppose

| product |
| ------- |
| 5       |
| 6       |
| 7       |

Count

```text
3
```


## HAVING

```sql
HAVING
COUNT(DISTINCT product_key)

=

(SELECT COUNT(*) FROM Product)
```

Checks

```text
Products Bought

=

Total Products
```

If true

↓

Return customer.

---

# Dry Run

### Customer Table

| customer_id | product_key |
| ----------: | ----------: |
|           1 |           5 |
|           1 |           6 |
|           2 |           5 |
|           2 |           6 |
|           2 |           7 |
|           3 |           5 |


### Product Table

| product_key |
| ----------: |
|           5 |
|           6 |
|           7 |


## Step 1 → GROUP BY

### Customer 1

Products

```text
5
6
```

Count

```text
2
```


### Customer 2

Products

```text
5
6
7
```

Count

```text
3
```

### Customer 3

Products

```text
5
```

Count

```text
1
```


## Step 2 → Total Products

```sql
SELECT COUNT(*)
FROM Product;
```

Result

```text
3
```


## Step 3 → Compare

Customer 1

```text
2 == 3

❌
```

Customer 2

```text
3 == 3

✅
```

Customer 3

```text
1 == 3

❌
```


## Final Output

| customer_id |
| ----------: |
|           2 |

---

# SQL Concepts Used

| Concept         | Purpose                       |
| --------------- | ----------------------------- |
| GROUP BY        | Create one group per customer |
| COUNT(DISTINCT) | Count unique products bought  |
| HAVING          | Filter grouped results        |
| Subquery        | Count total products          |

---

# Pattern Learned

## Pattern 1 — Count Unique Values Per Group

```sql
SELECT
group_column,
COUNT(DISTINCT value_column)
FROM table
GROUP BY group_column;
```

Examples

* Products per Customer
* Subjects per Teacher
* Courses per Student


## Pattern 2 — Compare Group Count With Overall Count

```sql
HAVING
COUNT(DISTINCT value_column)
=
(
SELECT COUNT(*)
FROM another_table
)
```

Examples

* Customers who bought all products
* Students who completed all courses
* Employees who attended all trainings
* Users who watched all videos

---

# Why JOIN is NOT Used?

Many beginners think

```text
Two Tables

↓

JOIN
```

But here we only need

```text
Total Number of Products
```

We do **not** need product details.

So

```sql
SELECT COUNT(*)
FROM Product
```

is enough.

Therefore

```text
JOIN ❌

Subquery ✅
```

