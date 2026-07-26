# LeetCode 1581 - Customer Who Visited but Did Not Make Any Transactions

## Question

Table: **Visits**

| Column Name | Type |
| ----------- | ---- |
| visit_id    | int  |
| customer_id | int  |

`visit_id` is the primary key.


Table: **Transactions**

| Column Name    | Type |
| -------------- | ---- |
| transaction_id | int  |
| visit_id       | int  |

`transaction_id` is the primary key.



Write a solution to find the IDs of customers who visited the mall **without making any transactions** and the number of times they made these visits.

Return the result table in any order.

---

## Problem Summary

We need to find:

* Customers who visited the mall.
* But did **not** make a transaction.
* Count how many such visits each customer made.

---

## Key Observation

Every transaction belongs to a visit.

If a visit has **no matching record** in the `Transactions` table, then that visit did not result in a transaction.

👉 This is a **"Find Missing Records"** problem.

---

## Approach

1. Keep all visits using `LEFT JOIN`.
2. Match visits with transactions using `visit_id`.
3. Keep only visits where no transaction exists.
4. Group by customer.
5. Count such visits.

---

## Solution

```sql
SELECT Visits.customer_id,
       COUNT(*) AS count_no_trans
FROM Visits
LEFT JOIN Transactions
ON Visits.visit_id = Transactions.visit_id
WHERE Transactions.transaction_id IS NULL
GROUP BY Visits.customer_id;
```

---

## Query Breakdown

### Match visits and transactions

```sql
ON Visits.visit_id = Transactions.visit_id
```

Matches records having the same `visit_id`.



### Keep only visits without transactions

```sql
WHERE Transactions.transaction_id IS NULL
```

If no matching transaction exists, `transaction_id` becomes `NULL`.

These are exactly the visits we need.


### Group by customer

```sql
GROUP BY Visits.customer_id
```

Groups all visits belonging to the same customer.


### Count visits

```sql
COUNT(*)
```

Counts how many visits had no transaction.

---

### Example Input

### Visits

| visit_id | customer_id |
| -------- | ----------- |
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |

### Transactions

| transaction_id | visit_id |
| -------------- | -------- |
| 2              | 5        |
| 3              | 5        |
| 9              | 5        |
| 12             | 1        |
| 13             | 2        |


## Step 1: LEFT JOIN

```sql id="rjtl2i"
FROM Visits
LEFT JOIN Transactions
ON Visits.visit_id = Transactions.visit_id
```

### Result

| visit_id | customer_id | transaction_id |
| -------- | ----------- | -------------- |
| 1        | 23          | 12             |
| 2        | 9           | 13             |
| 4        | 30          | NULL           |
| 5        | 54          | 2              |
| 5        | 54          | 3              |
| 5        | 54          | 9              |
| 6        | 96          | NULL           |
| 7        | 54          | NULL           |
| 8        | 54          | NULL           |

Notice:

```text id="9md3bc"
visit_id = 4
visit_id = 6
visit_id = 7
visit_id = 8
```

have no transaction.

So their transaction_id becomes NULL.


## Step 2: Apply WHERE

```sql id="t0ejf5"
WHERE Transactions.transaction_id IS NULL
```

Keep only rows with no transaction.

### Result

| visit_id | customer_id |
| -------- | ----------- |
| 4        | 30          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |


## Step 3: GROUP BY

```sql id="x89ljq"
GROUP BY Visits.customer_id
```

Group rows customer-wise.

### Groups

Customer 30

| customer_id |
| ----------- |
| 30          |

Customer 96

| customer_id |
| ----------- |
| 96          |

Customer 54

| customer_id |
| ----------- |
| 54          |
| 54          |


## Step 4: COUNT

```sql id="8vuhp8"
COUNT(*)
```

Count visits without transactions.

### Final Output

| customer_id | count_no_trans |
| ----------- | -------------- |
| 30          | 1              |
| 54          | 2              |
| 96          | 1              |



### Why Customer 54 → 2 ?

Customer 54 visited:

```text id="20y3nf"
visit_id = 5  → Transaction exists ❌
visit_id = 7  → No transaction ✅
visit_id = 8  → No transaction ✅
```

So:

```text id="6ldohf"
count_no_trans = 2
```

Meaning:

👉 **Find records that exist in the left table but are missing in the right table, then count them.**

---

## SQL Concepts Used

| Concept       | Purpose                       |
| ------------- | ----------------------------- |
| LEFT JOIN     | Keep all rows from left table |
| ON            | Join condition                |
| WHERE IS NULL | Find unmatched rows           |
| GROUP BY      | Create groups                 |
| COUNT()       | Count rows                    |

---


## Memory Trick

```text
LEFT JOIN
      +
WHERE right_table.column IS NULL
```

👉 Find rows that exist in the left table but not in the right table.

Examples:

* Customers with no orders
* Employees with no manager
* Visits with no transactions

---

## Key Learning

* Use `LEFT JOIN` when you need all records from the left table.
* Use `IS NULL` to find missing matches.
* Use `GROUP BY` and `COUNT()` to count occurrences.
