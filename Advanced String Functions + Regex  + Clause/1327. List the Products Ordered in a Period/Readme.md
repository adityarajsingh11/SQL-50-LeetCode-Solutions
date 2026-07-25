# LeetCode 1327 - List the Products Ordered in a Period

## Difficulty

**Easy**

---

# 📝 Question in Simple Words

Find all products that were ordered in **February 2020** and whose **total ordered units are at least 100**.

Return the **product name** and **total units ordered**.

---

# Easy Understanding

### Products Table

| product_id | product_name          |
| ---------- | --------------------- |
| 1          | Leetcode Solutions    |
| 2          | Jewels of Stringology |

### Orders Table

| product_id | order_date | unit |
| ---------- | ---------- | ---: |
| 1          | 2020-02-05 |   60 |
| 1          | 2020-02-10 |   70 |
| 2          | 2020-02-15 |   30 |

Output

| product_name       | unit |
| ------------------ | ---: |
| Leetcode Solutions |  130 |

Because:

* February orders only
* 60 + 70 = 130 ≥ 100

---

# Problem Summary

For each product:

* Get product name from **Products** table.
* Consider only orders from **February 2020**.
* Calculate total units ordered.
* Return only products whose total units are **100 or more**.

---

# Key Observation 

This problem is solved in **5 steps**.

```text
    Products
        +
    Orders
        │
        ▼
    JOIN
        │
        ▼
    Filter February Orders
        │
        ▼
    GROUP BY Product
        │
        ▼
    SUM(Unit)
        │
        ▼
    HAVING SUM(Unit) >= 100
```

---

# Approach

### Step 1

Join both tables using `product_id`.

### Step 2

Filter only February 2020 orders.


### Step 3

Group rows by product.


### Step 4

Calculate total units for each product.


### Step 5

Keep only products whose total units are at least 100.

---

# Solution

```sql
SELECT
    Products.product_name,
    SUM(Orders.unit) AS unit
FROM Products
JOIN Orders
ON Products.product_id = Orders.product_id
WHERE Orders.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY Products.product_name
HAVING SUM(Orders.unit) >= 100;
```

---

# Query Breakdown

## Step 1

```sql
FROM Products
JOIN Orders
ON Products.product_id = Orders.product_id
```

Join both tables to get the product name along with its orders.


## Step 2

```sql
WHERE Orders.order_date
BETWEEN '2020-02-01'
AND '2020-02-29'
```

Keep only orders placed in **February 2020**.


## Step 3

```sql
GROUP BY Products.product_name
```

Create one group for each product.


## Step 4

```sql
SUM(Orders.unit)
```

Calculate the total units ordered for each product.

Example

| Product            | Units |
| ------------------ | ----: |
| Leetcode Solutions |    60 |
| Leetcode Solutions |    70 |

Result

```text
130
```


## Step 5

```sql
HAVING SUM(Orders.unit) >= 100
```

Keep only those products whose total ordered units are at least **100**.

---
You can use this in your notes.

---

# Dry Run

### Input

**Products**

| product_id | product_name          | product_category |
| ---------- | --------------------- | ---------------- |
| 1          | Leetcode Solutions    | Book             |
| 2          | Jewels of Stringology | Book             |
| 3          | HP                    | Laptop           |
| 4          | Lenovo                | Laptop           |
| 5          | Leetcode Kit          | T-shirt          |

**Orders**

| product_id | order_date | unit |
| ---------- | ---------- | ---: |
| 1          | 2020-02-05 |   60 |
| 1          | 2020-02-10 |   70 |
| 2          | 2020-01-18 |   30 |
| 2          | 2020-02-11 |   80 |
| 3          | 2020-02-17 |    2 |
| 3          | 2020-02-24 |    3 |
| 4          | 2020-03-01 |   20 |
| 4          | 2020-03-04 |   30 |
| 4          | 2020-03-04 |   60 |
| 5          | 2020-02-25 |   50 |
| 5          | 2020-02-27 |   50 |
| 5          | 2020-03-01 |   50 |

---

### Output

| product_name       | unit |
| ------------------ | ---: |
| Leetcode Solutions |  130 |
| Leetcode Kit       |  100 |

## Explanation

* **Leetcode Solutions**

  * February orders = 60 + 70 = **130** ✅
* **Jewels of Stringology**

  * February orders = 80 ❌ (< 100)
* **HP**

  * February orders = 2 + 3 = **5** ❌
* **Lenovo**

  * No February orders ❌
* **Leetcode Kit**

  * February orders = 50 + 50 = **100** ✅

Therefore, the final answer is:

| product_name       | unit |
| ------------------ | ---: |
| Leetcode Solutions |  130 |
| Leetcode Kit       |  100 |

## Step 1: Join Both Tables

```sql
FROM Products
JOIN Orders
ON Products.product_id = Orders.product_id
```

After joining:

| product_name          | order_date | unit |
| --------------------- | ---------- | ---: |
| Leetcode Solutions    | 2020-02-05 |   60 |
| Leetcode Solutions    | 2020-02-10 |   70 |
| Jewels of Stringology | 2020-01-18 |   30 |
| Jewels of Stringology | 2020-02-11 |   80 |
| HP                    | 2020-02-17 |    2 |
| HP                    | 2020-02-24 |    3 |
| Lenovo                | 2020-03-01 |   20 |
| Lenovo                | 2020-03-04 |   30 |
| Lenovo                | 2020-03-04 |   60 |
| Leetcode Kit          | 2020-02-25 |   50 |
| Leetcode Kit          | 2020-02-27 |   50 |
| Leetcode Kit          | 2020-03-01 |   50 |



## Step 2: Apply WHERE

```sql
WHERE Orders.order_date
BETWEEN '2020-02-01'
AND '2020-02-29'
```

Remove January and March orders.

Remaining rows:

| product_name          | order_date | unit |
| --------------------- | ---------- | ---: |
| Leetcode Solutions    | 2020-02-05 |   60 |
| Leetcode Solutions    | 2020-02-10 |   70 |
| Jewels of Stringology | 2020-02-11 |   80 |
| HP                    | 2020-02-17 |    2 |
| HP                    | 2020-02-24 |    3 |
| Leetcode Kit          | 2020-02-25 |   50 |
| Leetcode Kit          | 2020-02-27 |   50 |



## Step 3: GROUP BY product_name

SQL creates one group for each product.

### Group 1

```text
Leetcode Solutions

60
70
```

### Group 2

```text
Jewels of Stringology

80
```

### Group 3

```text
HP

2
3
```

### Group 4

```text
Leetcode Kit

50
50
```

## Step 4: SUM(unit)

Calculate total units for each group.

| Product               | Calculation | Total |
| --------------------- | ----------- | ----: |
| Leetcode Solutions    | 60 + 70     |   130 |
| Jewels of Stringology | 80          |    80 |
| HP                    | 2 + 3       |     5 |
| Leetcode Kit          | 50 + 50     |   100 |


## Step 5: HAVING SUM(unit) >= 100

Check every group.

| Product               | Total | Keep? |
| --------------------- | ----: | :---: |
| Leetcode Solutions    |   130 |   ✅   |
| Jewels of Stringology |    80 |   ❌   |
| HP                    |     5 |   ❌   |
| Leetcode Kit          |   100 |   ✅   |

Only these remain.


## Final Output

| product_name       | unit |
| ------------------ | ---: |
| Leetcode Solutions |  130 |
| Leetcode Kit       |  100 |

---

# SQL Concepts Used

| Concept    | Purpose                            |
| ---------- | ---------------------------------- |
| `JOIN`     | Combine Products and Orders tables |
| `ON`       | Match rows using `product_id`      |
| `WHERE`    | Filter orders from February 2020   |
| `BETWEEN`  | Select dates within a range        |
| `GROUP BY` | Group rows by product              |
| `SUM()`    | Calculate total ordered units      |
| `HAVING`   | Filter groups based on total units |

---

# Pattern Learned

### Pattern 1 — Join Tables

```sql
JOIN Orders
ON Products.product_id = Orders.product_id
```

### Pattern 2 — Filter by Date

```sql
WHERE order_date BETWEEN start_date AND end_date
```


### Pattern 3 — Group Records

```sql
GROUP BY product_name
```

### Pattern 4 — Calculate Total

```sql
SUM(unit)
```


### Pattern 5 — Filter Aggregate Values

```sql
HAVING SUM(unit) >= 100
```
