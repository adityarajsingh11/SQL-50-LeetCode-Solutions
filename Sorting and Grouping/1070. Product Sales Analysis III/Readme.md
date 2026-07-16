# LeetCode 1070 - Product Sales Analysis III

## Difficulty

**Easy**

---

# Question

Table: **Sales**

| Column Name | Type |
| ----------- | ---- |
| product_id  | int  |
| year        | int  |
| quantity    | int  |
| price       | int  |

Each row represents the sales information of a product in a particular year.

Write a solution to find:

* `product_id`
* `first_year`
* `quantity`
* `price`

for the **first year** each product was sold.

Example 1:

Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+

Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+

---

# Problem Summary

For every product:

1. Find the **earliest (minimum) year**.
2. Return the complete row corresponding to that first year.
3. Display:

   * product_id
   * first_year
   * quantity
   * price

---

> 🔴 **This is a GROUP BY + MIN() + JOIN problem.**

---

# Key Observation 

The question is **not asking**:

❌ Minimum year only

It is asking:

✅ Minimum year **along with quantity and price**.

Example

### Sales

| product_id | year | quantity | price |
| ---------- | ---- | -------: | ----: |
| 1          | 2018 |      100 |    10 |
| 1          | 2019 |      120 |    12 |

Output

| product_id | first_year | quantity | price |
| ---------- | ---------: | -------: | ----: |
| 1          |       2018 |      100 |    10 |

Notice:

We need **quantity** and **price** of the first year.

---
Haan, ye wala example README ke liye perfect rahega.

---

# Why JOIN is Used? 

`MIN(year)` only returns the **first year**, not the complete row.

### Example

### Sales Table

| product_id | year | quantity | price |
| ---------- | ---- | -------: | ----: |
| 1          | 2018 |      100 |    10 |
| 1          | 2019 |      120 |    12 |
| 2          | 2019 |       80 |    15 |
| 2          | 2020 |       90 |    18 |


### Using Only `MIN()`

```sql
SELECT
    product_id,
    MIN(year)
FROM Sales
GROUP BY product_id;
```

Output

| product_id | first_year |
| ---------- | ---------: |
| 1          |       2018 |
| 2          |       2019 |

❓ But where are **quantity** and **price**?

SQL doesn't know whether to return:

For Product 1

```text
Year = 2018 ✅

Quantity = 100 ❓ or 120 ❓

Price = 10 ❓ or 12 ❓
```

That's why this query **cannot** return the correct `quantity` and `price`.



## Solution → Use JOIN

```text
Sales Table
      ↓
GROUP BY + MIN(year)
      ↓
Find First Year
      ↓
JOIN Original Sales Table
      ↓
Get Quantity & Price of that First Year
```

Final Output

| product_id | first_year | quantity | price |
| ---------- | ---------: | -------: | ----: |
| 1          |       2018 |      100 |    10 |
| 2          |       2019 |       80 |    15 |


> **Rule:** If `GROUP BY + MIN()/MAX()` gives only the minimum/maximum value but the question asks for other columns from the **same row**, use **JOIN** with the original table.

---

# Approach

### Step 1

Find the first year of every product.

```sql
MIN(year)
```


### Step 2

Group by product.

```sql
GROUP BY product_id
```


### Step 3

Join with the original Sales table.

Reason

```text
Need quantity and price
of the first sale.
```

### Step 4

Return

* product_id
* first_year
* quantity
* price

---

# Solution

```sql
SELECT
    Sales.product_id,
    Sales.year AS first_year,
    Sales.quantity,
    Sales.price
FROM Sales
JOIN
(
    SELECT
        product_id,
        MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id
) AS first_sale
ON Sales.product_id = first_sale.product_id
AND Sales.year = first_sale.first_year;
```

---

# Query Breakdown

## Step 1 — Find First Year

```sql
SELECT
    product_id,
    MIN(year) AS first_year
FROM Sales
GROUP BY product_id;
```

Output

| product_id | first_year |
| ---------- | ---------: |
| 1          |       2018 |
| 2          |       2019 |


## Step 2 — Temporary Table

The subquery creates a temporary table.

```text
first_sale
```

| product_id | first_year |
| ---------- | ---------: |
| 1          |       2018 |
| 2          |       2019 |


## Step 3 — JOIN

```sql
JOIN first_sale
```

Connects the temporary table with the original Sales table.



## Step 4 — ON

```sql
Sales.product_id = first_sale.product_id
```

Matches the same product.



```sql
Sales.year = first_sale.first_year
```

Keeps only the row where the year is the first year.

---

# Dry Run

### Sales Table

| product_id | year | quantity | price |
| ---------- | ---- | -------: | ----: |
| 1          | 2018 |      100 |    10 |
| 1          | 2019 |      120 |    12 |
| 2          | 2019 |       80 |    15 |
| 2          | 2020 |       90 |    18 |

## Step 1 → GROUP BY + MIN()

```sql
SELECT
product_id,
MIN(year)
FROM Sales
GROUP BY product_id;
```

Output

| product_id | first_year |
| ---------- | ---------: |
| 1          |       2018 |
| 2          |       2019 |

## Step 2 → Temporary Table

| product_id | first_year |
| ---------- | ---------: |
| 1          |       2018 |
| 2          |       2019 |


## Step 3 → JOIN

Condition

```sql
Sales.product_id = first_sale.product_id
```

AND

```sql
Sales.year = first_sale.first_year
```

Matching rows

| product_id | year | quantity | price |
| ---------- | ---- | -------: | ----: |
| 1          | 2018 |      100 |    10 |
| 2          | 2019 |       80 |    15 |


## Final Output

| product_id | first_year | quantity | price |
| ---------- | ---------: | -------: | ----: |
| 1          |       2018 |      100 |    10 |
| 2          |       2019 |       80 |    15 |

---

# SQL Concepts Used

| Concept  | Purpose                          |
| -------- | -------------------------------- |
| MIN()    | Find first year                  |
| GROUP BY | One row per product              |
| Subquery | Store first year of each product |
| JOIN     | Get quantity and price           |
| ON       | Match product and first year     |

---

# Pattern Learned

## Pattern 1 — Find First Record

```sql
SELECT
group_column,
MIN(column)
FROM table
GROUP BY group_column;
```

Examples

* First Login
* First Sale
* First Order
* Earliest Purchase


## Pattern 2 — Get Complete First Record

```sql
SELECT ...
FROM OriginalTable
JOIN
(
GROUP BY
+
MIN()
)
ON ...
```

Use this whenever the question asks:

* First sale details
* First order details
* First login details
* Earliest purchase details

---
