# LeetCode 1251 - Average Selling Price

## Question

Table: **Prices**

| Column Name | Type |
| ----------- | ---- |
| product_id  | int  |
| start_date  | date |
| end_date    | date |
| price       | int  |

`(product_id, start_date, end_date)` is the primary key.

---

Table: **UnitsSold**

| Column Name   | Type |
| ------------- | ---- |
| product_id    | int  |
| purchase_date | date |
| units         | int  |

Each row represents units sold on a specific date.

Write a solution to find the **average selling price** for each product.

If a product has no sales, return **0**.

Round the answer to **2 decimal places**.

---

## Problem Summary

For every product:

* Find the correct price on the purchase date.
* Calculate total revenue.
* Divide by total units sold.
* If no sales exist, return `0`.

---

> 🔴 **This is a LEFT JOIN + SUM() + GROUP BY + Weighted Average problem.**

---

## Key Observation

The selling price depends on the **purchase date**.

A product may have different prices during different time periods.

So first, match the sale with the correct price.

---

## Formula

```text
Average Selling Price

=
Total Revenue
--------------
Total Units Sold
```

Where,

```text
Revenue = Price × Units
```

So,

```text
SUM(price × units)
------------------
SUM(units)
```

This is called a **Weighted Average**.

---

## Solution

```sql
SELECT
    Prices.product_id,
    ROUND(
        IFNULL(
            SUM(Prices.price * UnitsSold.units) /
            SUM(UnitsSold.units),
        0),
    2) AS average_price
FROM Prices
LEFT JOIN UnitsSold
ON Prices.product_id = UnitsSold.product_id
AND UnitsSold.purchase_date
BETWEEN Prices.start_date
    AND Prices.end_date
GROUP BY Prices.product_id;
```

---

## Query Breakdown

### Select Product

```sql
SELECT Prices.product_id
```

Returns one row per product.



### LEFT JOIN

```sql
LEFT JOIN UnitsSold
```

Keeps all products.

If a product has no sales, it still appears in the result.



### Match Product

```sql
ON Prices.product_id = UnitsSold.product_id
```

Matches sales with the correct product.



### Match Correct Price Period

```sql
UnitsSold.purchase_date
BETWEEN Prices.start_date
AND Prices.end_date
```

Ensures the sale uses the price valid on the purchase date.



### Calculate Revenue

```sql
SUM(Prices.price * UnitsSold.units)
```

Formula:

```text
Revenue = Price × Units
```


### Calculate Total Units

```sql
SUM(UnitsSold.units)
```

Returns total units sold.



### Calculate Average Selling Price

```sql
SUM(price × units)
/
SUM(units)
```

This is the **Weighted Average Price**.



### Handle NULL

```sql
IFNULL(value,0)
```

If no units were sold,

return **0**.



### Round Answer

```sql
ROUND(value,2)
```

Rounds to two decimal places.



### Group Products

```sql
GROUP BY Prices.product_id
```

Calculates one average price per product.

---

## Dry Run

### Prices

| product | price | start | end   |
| ------- | ----: | ----- | ----- |
| 1       |     5 | Jan1  | Jan31 |
| 1       |    10 | Feb1  | Feb28 |

### UnitsSold

| product | date  | units |
| ------- | ----- | ----: |
| 1       | Jan10 |     2 |
| 1       | Feb15 |     3 |



### After JOIN

| price | units |
| ----: | ----: |
|     5 |     2 |
|    10 |     3 |



### Revenue

```text
5 × 2 = 10

10 × 3 = 30

Total Revenue = 40
```


### Total Units

```text
2 + 3 = 5
```



### Average Selling Price

```text
40 / 5 = 8.00
```

Output:

| product_id | average_price |
| ---------- | ------------: |
| 1          |          8.00 |

---

## SQL Concepts Used

| Concept   | Purpose                               |
| --------- | ------------------------------------- |
| LEFT JOIN | Keep all products                     |
| ON        | Match product IDs                     |
| BETWEEN   | Match purchase date with price period |
| SUM()     | Calculate revenue and units           |
| GROUP BY  | Product-wise calculation              |
| ROUND()   | Round to 2 decimals                   |
| IFNULL()  | Return 0 when no sales exist          |
