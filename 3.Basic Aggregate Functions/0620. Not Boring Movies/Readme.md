# LeetCode 620 - Not Boring Movies

## Question

Table: **Cinema**

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| movie       | varchar |
| description | varchar |
| rating      | float   |

`id` is the primary key.

Write a solution to:

* Return movies with **odd-numbered IDs**.
* Exclude movies whose description is **"boring"**.
* Sort the result by **rating in descending order**.

---

## Problem Summary

Find movies that:

* Have an **odd ID**.
* Description is **not** `"boring"`.
* Display highest-rated movies first.

---

> 🟡 **This is a Filtering + Sorting problem (No Aggregate Functions).**

---

## Approach

1. Select required columns.
2. Keep only odd IDs.
3. Remove boring movies.
4. Sort by rating (highest first).

---

## Solution

```sql
SELECT
    id,
    movie,
    description,
    rating
FROM Cinema
WHERE id % 2 = 1
AND description != 'boring'
ORDER BY rating DESC;
```

---

## Query Breakdown

### Select Required Columns

```sql
SELECT
id,
movie,
description,
rating
```

Returns only the required columns.



### Choose Table

```sql
FROM Cinema
```

Reads data from the Cinema table.



### Filter Odd IDs

```sql
WHERE id % 2 = 1
```

Keeps only movies with odd IDs.

Example:

| id | Result |
| -: | ------ |
|  1 | ✅      |
|  2 | ❌      |
|  3 | ✅      |
|  4 | ❌      |


### Remove Boring Movies

```sql
AND description != 'boring'
```

Keeps only movies whose description is not `"boring"`.


### Sort by Rating

```sql
ORDER BY rating DESC
```

Displays movies from highest rating to lowest.

---

## Dry Run

### Cinema

| id | movie   | description | rating |
| -: | ------- | ----------- | -----: |
|  1 | War     | great       |    8.9 |
|  2 | Ice Age | boring      |    7.5 |
|  3 | Avatar  | fantastic   |    9.2 |
|  4 | Frozen  | boring      |    8.0 |
|  5 | Titanic | great       |    8.5 |


### After `WHERE`

Odd IDs:

| id | movie   |
| -: | ------- |
|  1 | War     |
|  3 | Avatar  |
|  5 | Titanic |

Remove `"boring"`:

| id | movie   |
| -: | ------- |
|  1 | War     |
|  3 | Avatar  |
|  5 | Titanic |



### After `ORDER BY`

| id | movie   | rating |
| -: | ------- | -----: |
|  3 | Avatar  |    9.2 |
|  1 | War     |    8.9 |
|  5 | Titanic |    8.5 |

---

## SQL Concepts Used

| Concept       | Purpose            |
| ------------- | ------------------ |
| SELECT        | Retrieve columns   |
| FROM          | Specify table      |
| WHERE         | Filter rows        |
| `%` (Modulus) | Check odd/even IDs |
| AND           | Combine conditions |
| `!=`          | Not equal          |
| ORDER BY      | Sort result        |
| DESC          | Descending order   |

