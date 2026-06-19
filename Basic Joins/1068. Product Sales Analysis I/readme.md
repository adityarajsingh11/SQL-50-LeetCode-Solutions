# LeetCode 1068 - Product Sales Analysis I

## Question

Table: **Sales**

| Column Name | Type |
| ----------- | ---- |
| sale_id     | int  |
| product_id  | int  |
| year        | int  |
| quantity    | int  |
| price       | int  |

`sale_id` together with `year` is the primary key.

---

Table: **Product**

| Column Name  | Type    |
| ------------ | ------- |
| product_id   | int     |
| product_name | varchar |

`product_id` is the primary key.

---

Write a solution to report the:

* `product_name`
* `year`
* `price`

for each sale.

Return the result table in any order.

---

## Problem Summary

We have:

### Sales Table

| sale_id | product_id | year | price |
| ------- | ---------- | ---- | ----- |
| 1       | 100        | 2008 | 10    |
| 2       | 100        | 2009 | 12    |
| 7       | 200        | 2011 | 15    |

### Product Table

| product_id | product_name |
| ---------- | ------------ |
| 100        | Nokia        |
| 200        | Apple        |

Need Output:

| product_name | year | price |
| ------------ | ---- | ----- |
| Nokia        | 2008 | 10    |
| Nokia        | 2009 | 12    |
| Apple        | 2011 | 15    |

---

## Key Observation

* `product_name` is in **Product** table.
* `year` and `price` are in **Sales** table.
* Common column = `product_id`.

👉 We need to combine two tables using `product_id`.

---

## Approach

1. Join `Sales` and `Product`.
2. Match rows using `product_id`.
3. Select required columns.

Since every sale has a valid product, an **INNER JOIN** is sufficient.

---

## Solution

```sql
SELECT Product.product_name,
       Sales.year,
       Sales.price
FROM Sales
JOIN Product
ON Sales.product_id = Product.product_id;
```

---

## Query Breakdown

### Select required columns

```sql
SELECT Product.product_name,
       Sales.year,
       Sales.price
```

Returns product name, year, and price.

---

### Base table

```sql
FROM Sales
```

Start from the Sales table.

---

### Join Product table

```sql
JOIN Product
```

Connect Product table.

---

### Matching condition

```sql
ON Sales.product_id = Product.product_id
```

Match records having the same product ID.

---

## Dry Run

### Sales

| product_id | year | price |
| ---------- | ---- | ----- |
| 100        | 2008 | 10    |
| 100        | 2009 | 12    |
| 200        | 2011 | 15    |

### Product

| product_id | product_name |
| ---------- | ------------ |
| 100        | Nokia        |
| 200        | Apple        |

### After JOIN

| product_name | year | price |
| ------------ | ---- | ----- |
| Nokia        | 2008 | 10    |
| Nokia        | 2009 | 12    |
| Apple        | 2011 | 15    |

---


## INNER JOIN vs LEFT JOIN

### INNER JOIN

```sql
SELECT *
FROM Sales
JOIN Product
ON Sales.product_id = Product.product_id;
```

✅ Returns only matching rows.


### LEFT JOIN

```sql
SELECT *
FROM Sales
LEFT JOIN Product
ON Sales.product_id = Product.product_id;
```

✅ Returns all rows from Sales.

For this question, both work because every `product_id` in Sales exists in Product.

---
