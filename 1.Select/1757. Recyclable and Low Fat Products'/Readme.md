## LeetCode 1757 - Recyclable and Low Fat Products

### Problem Summary

Given a `Products` table, find the `product_id` of products that are:

1. Low fat (`low_fats = 'Y'`)
2. Recyclable (`recyclable = 'Y'`)

Both conditions must be true.

#### Products Table

| product_id | low_fats | recyclable |
| ---------- | -------- | ---------- |
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |

Output:

```text
1
3
```

---

### SQL Concepts Used

* **SELECT** → Retrieves specific columns.
* **FROM** → Specifies the table.
* **WHERE** → Filters rows based on conditions.
* **AND** → Combines multiple conditions.

---

### Solution

```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y'
AND recyclable = 'Y';
```

---

### Explanation

#### Step 1: Select the required column

```sql
SELECT product_id
```

Returns only the `product_id` column.

#### Step 2: Choose the table

```sql
FROM Products
```

Fetches data from the `Products` table.

#### Step 3: Filter low-fat products

```sql
WHERE low_fats = 'Y'
```

Keeps only products marked as low fat.

#### Step 4: Filter recyclable products

```sql
AND recyclable = 'Y'
```

Further filters the result to include only recyclable products.

---

### Dry Run

#### Products Table

| product_id | low_fats | recyclable |
| ---------- | -------- | ---------- |
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |

Condition:

```sql
low_fats = 'Y'
AND recyclable = 'Y'
```

Matching rows:

| product_id |
| ---------- |
| 1          |
| 3          |

Output:

```text
1
3
```

