# LeetCode 1174 - Immediate Food Delivery II

## Difficulty

**Medium**

---

# Question

Table: **Delivery**

| Column Name                 | Type |
| --------------------------- | ---- |
| delivery_id                 | int  |
| customer_id                 | int  |
| order_date                  | date |
| customer_pref_delivery_date | date |

* `delivery_id` is the primary key.
* Each row represents one order placed by a customer.

A delivery is:

* **Immediate** → `order_date = customer_pref_delivery_date`
* **Scheduled** → `order_date != customer_pref_delivery_date`

The **first order** of a customer is the order with the **earliest order_date**.

Find the **percentage of immediate first orders** among all customers.

Round the answer to **2 decimal places**.


### Delivery Table

| delivery_id | customer | order_date | pref_date |
| ----------- | -------- | ---------- | --------- |
| 1           | 1        | Aug1       | Aug2      |
| 2           | 2        | Aug2       | Aug2      |
| 3           | 1        | Aug11      | Aug12     |
| 4           | 3        | Aug24      | Aug24     |
| 5           | 3        | Aug21      | Aug22     |
| 6           | 2        | Aug11      | Aug13     |
| 7           | 4        | Aug9       | Aug9      |


## Final Output

| immediate_percentage |
| -------------------: |
|                50.00 |


---

# Problem Summary

For every customer:

1. Find the **first order** (earliest order date).
2. Check whether it is **Immediate** or **Scheduled**.
3. Calculate

```text
Immediate First Orders
---------------------- ×100
 Total Customers
```

---

# Key Observation ⭐⭐⭐

The biggest trick of this problem is:

> **First order means the earliest `order_date`, NOT the smallest `delivery_id`.**

Example

| delivery_id | customer | order_date |
| ----------- | -------- | ---------- |
| 4           | 3        | 2019-08-24 |
| 5           | 3        | 2019-08-21 |

Although

```text
delivery_id 4 < 5
```

the first order is

```text
2019-08-21
```

because

```text
21 Aug < 24 Aug
```

---

# Step-by-Step Thinking

## Step 1

Find the first order of every customer.

How?

```sql
MIN(order_date)
```

```sql
SELECT
customer_id,
MIN(order_date)
FROM Delivery
GROUP BY customer_id;
```

Output

| customer | first_order |
| -------- | ----------- |
| 1        | 2019-08-01  |
| 2        | 2019-08-02  |
| 3        | 2019-08-21  |
| 4        | 2019-08-09  |



## Step 2

Problem

This table contains only

* customer_id
* first_order

But we also need

```text
customer_pref_delivery_date
```

to check

```text
Immediate ?

order_date == customer_pref_delivery_date
```

Where will it come from?

👉 Original Delivery table.

So we JOIN.



### Why JOIN?

Suppose

Original Table

| customer | order_date | pref_date |
| -------- | ---------- | --------- |
| 1        | Aug1       | Aug2      |
| 1        | Aug11      | Aug12     |
| 2        | Aug2       | Aug2      |
| 3        | Aug21      | Aug22     |
| 3        | Aug24      | Aug24     |

After

```sql
MIN(order_date)
```

we get

| customer | first_order |
| -------- | ----------- |
| 1        | Aug1        |
| 2        | Aug2        |
| 3        | Aug21       |

Notice

```text
pref_date ❌ Missing
```

Without pref_date

Can we check

```text
Immediate?

order_date = pref_date
```

No.

Therefore

```text
Need JOIN
```


#### Join

```sql
ON Delivery.customer_id = first_orders.customer_id
AND Delivery.order_date = first_orders.first_order
```

Result

| customer | order_date | pref_date |
| -------- | ---------- | --------- |
| 1        | Aug1       | Aug2      |
| 2        | Aug2       | Aug2      |
| 3        | Aug21      | Aug22     |
| 4        | Aug9       | Aug9      |

Now every customer's **first order row** is available.



## Step 3

Convert

Immediate

↓

1

Scheduled

↓

0

Using

```sql
IF(
order_date=customer_pref_delivery_date,
1,
0
)
```

Result

| customer | Immediate? | Value |
| -------- | ---------- | ----: |
| 1        | No         |     0 |
| 2        | Yes        |     1 |
| 3        | No         |     0 |
| 4        | Yes        |     1 |



## Step 4

Calculate Percentage

Instead of

```text
Count Immediate

÷

Total Customers
```

we use

```sql
AVG(IF(...))
```

Because

```text
0
1
0
1
```

Average

```text
(0+1+0+1)

÷4

=

0.5
```

Multiply

```text
0.5 ×100

=

50%
```

---

# Final Query

```sql
SELECT
    ROUND(
        AVG(
            IF(
                Delivery.order_date =
                Delivery.customer_pref_delivery_date,
                1,
                0
            )
        ) * 100,
        2
    ) AS immediate_percentage
FROM Delivery
JOIN
(
    SELECT
        customer_id,
        MIN(order_date) AS first_order
    FROM Delivery
    GROUP BY customer_id
) AS first_orders
ON Delivery.customer_id = first_orders.customer_id
AND Delivery.order_date = first_orders.first_order;
```

---

# Query Breakdown

## 1️⃣ Find First Order

```sql
SELECT
customer_id,
MIN(order_date)
```

Returns the earliest order date for every customer.



## 2️⃣ GROUP BY

```sql
GROUP BY customer_id
```

Creates one row for every customer.


## 3️⃣ JOIN

```sql
JOIN first_orders
```

Why?

Because

```text
MIN(order_date)

↓

Returns only

customer_id

first_order
```

Need

```text
customer_pref_delivery_date
```

Therefore

JOIN original table.



## 4️⃣ ON

```sql
Delivery.customer_id
=
first_orders.customer_id
```

Matches same customer.

---

```sql
Delivery.order_date
=
first_orders.first_order
```

Keeps only the first order row.



## 5️⃣ IF()

```sql
IF(
order_date=
customer_pref_delivery_date,
1,
0
)
```

Immediate

↓

1

Scheduled

↓

0



## 6️⃣ AVG()

```sql
AVG(IF(...))
```

Average

```text
1

0

1

0
```

↓

```text
2/4

=

0.5
```



## 7️⃣ Multiply by 100

```sql
AVG(...)*100
```

Percentage



## 8️⃣ ROUND()

```sql
ROUND(value,2)
```

Rounds to two decimal places.



# Dry Run

### Delivery Table

| delivery_id | customer | order_date | pref_date |
| ----------- | -------- | ---------- | --------- |
| 1           | 1        | Aug1       | Aug2      |
| 2           | 2        | Aug2       | Aug2      |
| 3           | 1        | Aug11      | Aug12     |
| 4           | 3        | Aug24      | Aug24     |
| 5           | 3        | Aug21      | Aug22     |
| 6           | 2        | Aug11      | Aug13     |
| 7           | 4        | Aug9       | Aug9      |



## Step 1

Find first order

| customer | first_order |
| -------- | ----------- |
| 1        | Aug1        |
| 2        | Aug2        |
| 3        | Aug21       |
| 4        | Aug9        |



## Step 2

JOIN

Result

| customer | order | pref  |
| -------- | ----- | ----- |
| 1        | Aug1  | Aug2  |
| 2        | Aug2  | Aug2  |
| 3        | Aug21 | Aug22 |
| 4        | Aug9  | Aug9  |



## Step 3

IF()

| customer | Immediate | Value |
| -------- | --------- | ----: |
| 1        | No        |     0 |
| 2        | Yes       |     1 |
| 3        | No        |     0 |
| 4        | Yes       |     1 |



## Step 4

AVG()

```text
(0+1+0+1)

÷4

=

0.5
```



## Step 5

Percentage

```text
0.5 ×100

=

50
```



## Step 6

ROUND()

```text
50.00
```


## Final Output

| immediate_percentage |
| -------------------: |
|                50.00 |

---

# SQL Concepts Used

| Concept  | Purpose                                  |
| -------- | ---------------------------------------- |
| MIN()    | Find first order date                    |
| GROUP BY | One row per customer                     |
| JOIN     | Retrieve complete first-order row        |
| ON       | Match customer and first order           |
| IF()     | Convert Immediate/Scheduled to 1/0       |
| AVG()    | Calculate proportion of immediate orders |
| ROUND()  | Round percentage to 2 decimals           |

