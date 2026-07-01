# LeetCode 1211 - Queries Quality and Percentage

## Question

Table: **Queries**

| Column Name | Type    |
| ----------- | ------- |
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |

Each row represents the result of a query.

Write a solution to find, for each `query_name`:

* **quality**
* **poor_query_percentage**

Round both values to **2 decimal places**.

---

## Problem Summary

For every `query_name`:

1. Calculate **Quality**.
2. Calculate **Poor Query Percentage**.

Return one row for each query.

---

> 🔴 **This is a GROUP BY + AVG() + IF() + ROUND() problem.**

---

# Formula 1 - Quality

```text
Quality

=

Average of

(rating / position)
```

SQL

```sql
AVG(rating / position)
```

---

# Formula 2 - Poor Query Percentage

Poor Query means

```text
rating < 3
```

Formula

```text
(Number of Poor Queries ×100)
------------------------------
Total Queries
```

SQL Trick

```sql
AVG(IF(rating < 3,1,0))*100
```

---

## Approach

1. Group rows by `query_name`.
2. Calculate average of `rating / position`.
3. Convert poor queries into `1` and others into `0`.
4. Calculate their average.
5. Multiply by `100`.
6. Round both answers.

---

## Solution

```sql
SELECT
    query_name,
    ROUND(AVG(rating / position), 2) AS quality,
    ROUND(AVG(IF(rating < 3, 1, 0)) * 100, 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
```

---

## Query Breakdown

### Group by Query

```sql
GROUP BY query_name
```

Calculates results separately for each query.



### Calculate Quality

```sql
AVG(rating / position)
```

Example

| Rating | Position | rating/position |
| -----: | -------: | --------------: |
|      5 |        1 |             5.0 |
|      3 |        2 |             1.5 |
|      1 |        5 |             0.2 |

Average

```text
(5 + 1.5 + 0.2)

÷3

=

2.23
```


### Convert Poor Queries

```sql
IF(rating < 3,1,0)
```

| Rating | Value |
| -----: | ----: |
|      5 |     0 |
|      3 |     0 |
|      1 |     1 |



### Calculate Percentage

```sql
AVG(IF(rating<3,1,0))*100
```

Example

Values

```text
0
0
1
```

Average

```text
(0+0+1)/3

=

0.3333
```

Multiply

```text
0.3333 ×100

=

33.33%
```



### Round Answer

```sql
ROUND(value,2)
```

Rounds the answer to two decimal places.

---

## Dry Run

### Queries

| query_name | rating | position |
| ---------- | -----: | -------: |
| Dog        |      5 |        1 |
| Dog        |      3 |        2 |
| Dog        |      1 |        5 |


### Quality

```text
5/1 = 5

3/2 = 1.5

1/5 = 0.2
```

Average

```text
(5+1.5+0.2)

÷3

=

2.23
```



### Poor Percentage

Ratings

```text
5

3

1
```

Convert

```text
0

0

1
```

Average

```text
1/3

=

0.3333
```

Multiply

```text
33.33%
```

---

## Final Output

| query_name | quality | poor_query_percentage |
| ---------- | ------: | --------------------: |
| Dog        |    2.23 |                 33.33 |

---

## SQL Concepts Used

| Concept               | Purpose                       |
| --------------------- | ----------------------------- |
| AVG()                 | Calculate average             |
| IF()                  | Convert condition into 1 or 0 |
| ROUND()               | Round decimal values          |
| GROUP BY              | Query-wise calculation        |
| Arithmetic Expression | `rating / position`           |

