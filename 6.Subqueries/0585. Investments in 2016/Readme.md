# LeetCode 585 - Investments in 2016

## Difficulty

**Medium**

---

# 📝 Question in Simple Words 

We need to calculate the **total (`SUM`) of `tiv_2016`** only for those insurance policies that satisfy **both** conditions:

1. Their **`tiv_2015` value is duplicated** (appears more than once).
2. Their **location (`lat`, `lon`) is unique** (appears exactly once).


## Insurance Table

| pid | tiv_2015 | tiv_2016 | lat | lon |
| --: | -------: | -------: | --: | --: |
|   1 |     10.0 |      5.0 |  10 |  10 |
|   2 |     20.0 |     20.0 |  20 |  20 |
|   3 |     10.0 |     30.0 |  20 |  20 |
|   4 |     10.0 |     40.0 |  30 |  30 |


## Final Output

| tiv_2016 |
| -------: |
|    45.00 |



---

# Easy Understanding

Think like this:

```text
Duplicate 2015 Investment
          +
Unique Location
          ↓
   Add tiv_2016
```

---

# Problem Summary

The question gives two conditions.

### ✅ Condition 1

`tiv_2015` should be **duplicate**.

Example

| pid | tiv_2015 |
| --- | -------: |
| 1   |       10 |
| 2   |       20 |
| 3   |       10 |
| 4   |       10 |

Duplicate value

```text
10 ✅
20 ❌
```


### ✅ Condition 2

Location `(lat, lon)` should be **unique**.

Example

| pid | lat | lon |
| --- | --- | --- |
| 1   | 10  | 10  |
| 2   | 20  | 20  |
| 3   | 30  | 30  |
| 4   | 10  | 10  |

Unique locations

```text
(20,20) ✅

(30,30) ✅

(10,10) ❌
```

### Final Step

Only rows satisfying **both conditions** are selected.

Then calculate

```sql
SUM(tiv_2016)
```

---

# Key Observation

The problem is solved in **3 steps**.

```text
Insurance Table
        │
        ▼
Find Duplicate tiv_2015
        │
        ▼
Find Unique (lat, lon)
        │
        ▼
Rows satisfying BOTH
        │
        ▼
SUM(tiv_2016)
```

---

# Approach

### Step 1

Find all duplicated `tiv_2015`.


### Step 2

Find all unique `(lat, lon)`.


### Step 3

Keep rows satisfying both conditions.


### Step 4

Calculate the total `tiv_2016`.

---

# Solution

```sql
SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN
(
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND (lat, lon) IN
(
    SELECT lat, lon
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1
);
```

---

# Query Breakdown

## Step 1

```sql
SELECT tiv_2015
FROM Insurance
GROUP BY tiv_2015
HAVING COUNT(*) > 1;
```

Find all duplicated `tiv_2015`.

Example

| tiv_2015 |
| -------: |
|       10 |

Only policies having `tiv_2015 = 10` are considered.


## Step 2

```sql
SELECT lat, lon
FROM Insurance
GROUP BY lat, lon
HAVING COUNT(*) = 1;
```

Find all unique locations.

Example

| lat | lon |
| --- | --- |
| 20  | 20  |
| 30  | 30  |

Only these locations are valid.

## Step 3

```sql
WHERE tiv_2015 IN (...)
```

Keep only rows whose `tiv_2015` is duplicated.


## Step 4

```sql
AND (lat, lon) IN (...)
```

Keep only rows having unique locations.

Both conditions must be true.


## Step 5

```sql
SUM(tiv_2016)
```

Add all selected `tiv_2016` values.


## Step 6

```sql
ROUND(SUM(tiv_2016),2)
```

Round the answer to 2 decimal places.

---

# Dry Run


## Insurance Table

| pid | tiv_2015 | tiv_2016 | lat | lon |
| --: | -------: | -------: | --: | --: |
|   1 |     10.0 |      5.0 |  10 |  10 |
|   2 |     20.0 |     20.0 |  20 |  20 |
|   3 |     10.0 |     30.0 |  20 |  20 |
|   4 |     10.0 |     40.0 |  30 |  30 |


## Step 1: Find Duplicate `tiv_2015`

Query

```sql
SELECT tiv_2015
FROM Insurance
GROUP BY tiv_2015
HAVING COUNT(*) > 1;
```

### Group By Result

| tiv_2015 | Count |
| -------: | ----: |
|     10.0 |   3 ✅ |
|     20.0 |   1 ❌ |

Output

| tiv_2015 |
| -------: |
|     10.0 |

Only rows having **tiv_2015 = 10.0** are eligible.

Eligible rows:

| pid |
| --: |
|   1 |
|   3 |
|   4 |


## Step 2: Find Unique Locations

Query

```sql
SELECT lat, lon
FROM Insurance
GROUP BY lat, lon
HAVING COUNT(*) = 1;
```

### Group By Result

| lat | lon | Count |
| --: | --: | ----: |
|  10 |  10 |   1 ✅ |
|  20 |  20 |   2 ❌ |
|  30 |  30 |   1 ✅ |

Output

| lat | lon |
| --: | --: |
|  10 |  10 |
|  30 |  30 |

Eligible rows:

| pid |
| --: |
|   1 |
|   4 |


## Step 3: Apply Both Conditions

Condition 1 (Duplicate `tiv_2015`)

```text
pid1 ✅
pid3 ✅
pid4 ✅
```

Condition 2 (Unique Location)

```text
pid1 ✅
pid4 ✅
```

Common rows

```text
pid1
pid4
```

## Step 4: Take `tiv_2016`

| pid | tiv_2016 |
| --: | -------: |
|   1 |      5.0 |
|   4 |     40.0 |


## Step 5: Calculate Sum

```text
5.0 + 40.0 = 45.0
```


## Step 6: ROUND()

```sql
ROUND(45.0, 2)
```

Output

```text
45.00
```

## Final Output

| tiv_2016 |
| -------: |
|    45.00 |

---

# SQL Concepts Used

| Concept                | Purpose                               |
| ---------------------- | ------------------------------------- |
| `GROUP BY`             | Group same values together            |
| `HAVING COUNT(*) > 1`  | Find duplicate values                 |
| `HAVING COUNT(*) = 1`  | Find unique values                    |
| `IN`                   | Filter rows based on subquery results |
| `SUM()`                | Calculate total investment            |
| `ROUND()`              | Round answer to 2 decimal places      |
| Composite `(lat, lon)` | Treat two columns as one location     |

---

# Pattern Learned

### Pattern 1 — Find Duplicate Values

```sql
GROUP BY column
HAVING COUNT(*) > 1
```


### Pattern 2 — Find Unique Values

```sql
GROUP BY column
HAVING COUNT(*) = 1
```



### Pattern 3 — Filter Using Subquery

```sql
WHERE column IN
(
    SELECT ...
)
```

### Pattern 4 — Aggregate Result

```sql
SUM(column)
```
