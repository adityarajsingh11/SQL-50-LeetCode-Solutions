# LeetCode 1341 - Movie Rating

## Difficulty

**Medium**

---

# Question

You are given three tables:

### Users

| user_id | name |
| ------- | ---- |

### Movies

| movie_id | title |
| -------- | ----- |

### MovieRating

| movie_id | user_id | rating | created_at |

Return **two rows**:

1. **The name of the user who rated the greatest number of movies.**

   * If there is a tie, return the **lexicographically smallest name**.

2. **The movie with the highest average rating in February 2020.**

   * If there is a tie, return the **lexicographically smallest movie title**.

---

# Problem Summary

This problem has **two completely independent tasks**.

### Task 1

Find the **most active user** (who gave the maximum number of ratings).

### Task 2

Find the **highest-rated movie** (highest average rating) **only in February 2020**.

Finally, combine both answers using

```sql
UNION ALL
```

---

# Key Observation 

There are **two different calculations**.

```text
Task 1

    User
      ↓
    COUNT(ratings)
      ↓
    Maximum Count
      ↓
    Return Name

-----------------------------

Task 2

    Movie
      ↓
    Only February 2020
      ↓
    AVG(rating)
      ↓
    Maximum Average
       ↓
    Return Title

-----------------------------

    Combine

    ↓

    UNION ALL
```

---

# Approach

## Task 1

* Join Users and MovieRating.
* Count ratings given by each user.
* Sort by highest count.
* If tied, choose the smallest name.
* Return one row.



## Task 2

* Join Movies and MovieRating.
* Filter ratings from February 2020.
* Calculate average rating.
* Sort by highest average.
* If tied, choose the smallest title.
* Return one row.


## Final Step

Combine both answers using

```sql
UNION ALL
```

---

# Solution

```sql
(
SELECT
    u.name AS results
FROM Users u
JOIN MovieRating mr
ON u.user_id = mr.user_id
GROUP BY u.user_id, u.name
ORDER BY COUNT(*) DESC, u.name ASC
LIMIT 1
)

UNION ALL

(
SELECT
    m.title AS results
FROM Movies m
JOIN MovieRating mr
ON m.movie_id = mr.movie_id
WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY m.movie_id, m.title
ORDER BY AVG(rating) DESC, m.title ASC
LIMIT 1
);
```

---

# Query Breakdown

## Query 1

```sql
SELECT
    u.name AS results
```

Return the user's name.


```sql
FROM Users u
JOIN MovieRating mr
ON u.user_id = mr.user_id
```

Connect every rating with the user who gave it.


```sql
GROUP BY
u.user_id,
u.name
```

Create one group for every user.



```sql
COUNT(*)
```

Count how many ratings each user has given.

Example

| User   | Ratings Given |
| ------ | ------------- |
| Daniel | 5             |
| Monica | 3             |
| Maria  | 5             |


```sql
ORDER BY
COUNT(*) DESC,
u.name ASC
```

Sort

1. Highest rating count first.
2. If tied, alphabetical order.


```sql
LIMIT 1
```

Return only one user.

---

# Query 2

```sql
SELECT
m.title AS results
```

Return movie title.


```sql
FROM Movies m
JOIN MovieRating mr
ON m.movie_id = mr.movie_id
```

Connect ratings with movies.


```sql
WHERE created_at
BETWEEN '2020-02-01'
AND '2020-02-29'
```

Keep only February 2020 ratings.

```sql
GROUP BY
m.movie_id,
m.title
```

One group per movie.


```sql
AVG(rating)
```

Calculate average rating.

Example

| Movie  | Ratings | Average |
| ------ | ------- | ------- |
| Frozen | 5,4     | 4.5     |
| Joker  | 5,5     | 5.0     |



```sql
ORDER BY
AVG(rating) DESC,
m.title ASC
```

Highest average first.

If tied,

smallest movie title.


```sql
LIMIT 1
```

Return one movie.



## UNION ALL

```sql
UNION ALL
```

Combine

* User Name
* Movie Title

into one result.

---

# Complete Dry Run

## Users

| user_id | name   |
| ------- | ------ |
| 1       | Daniel |
| 2       | Monica |
| 3       | Maria  |


## Movies

| movie_id | title  |
| -------- | ------ |
| 1        | Frozen |
| 2        | Joker  |


## MovieRating

| user | movie | rating | date       |
| ---- | ----- | ------ | ---------- |
| 1    | 1     | 5      | 2020-02-01 |
| 1    | 2     | 4      | 2020-02-02 |
| 2    | 1     | 5      | 2020-02-05 |
| 3    | 2     | 5      | 2020-02-06 |
| 3    | 1     | 4      | 2020-03-01 |



## Task 1

Group by user

| User   | Count |
| ------ | ----- |
| Daniel | 2     |
| Monica | 1     |
| Maria  | 2     |

Sort

| User   | Count |
| ------ | ----- |
| Daniel | 2     |
| Maria  | 2     |
| Monica | 1     |

Daniel comes first because

```text
Daniel < Maria
```

Answer

```text
Daniel
```


## Task 2

Keep February only

| Movie  | Rating |
| ------ | ------ |
| Frozen | 5      |
| Joker  | 4      |
| Frozen | 5      |
| Joker  | 5      |

March row removed.


Group

| Movie  | Average |
| ------ | ------- |
| Frozen | 5.0     |
| Joker  | 4.5     |

Highest

```text
Frozen
```


## UNION ALL

Final Result

| results |
| ------- |
| Daniel  |
| Frozen  |


## Final Output

| results |
| ------- |
| Daniel  |
| Frozen  |

---

# SQL Concepts Used

| Concept     | Purpose                                |
| ----------- | -------------------------------------- |
| `JOIN`      | Combine related tables.                |
| `GROUP BY`  | Create one group per user/movie.       |
| `COUNT(*)`  | Count ratings given by each user.      |
| `AVG()`     | Calculate average movie rating.        |
| `WHERE`     | Filter only February 2020 ratings.     |
| `BETWEEN`   | Select dates within a range.           |
| `ORDER BY`  | Sort by count/average and handle ties. |
| `LIMIT`     | Return only the top result.            |
| `UNION ALL` | Combine the two independent answers.   |

---

# Pattern Learned

### Pattern 1 — Find Most Frequent

```sql
GROUP BY column
ORDER BY COUNT(*) DESC
LIMIT 1
```



### Pattern 2 — Find Highest Average

```sql
GROUP BY column
ORDER BY AVG(column) DESC
LIMIT 1
```


### Pattern 3 — Handle Ties

```sql
ORDER BY
COUNT(*) DESC,
name ASC
```

or

```sql
ORDER BY
AVG(rating) DESC,
title ASC
```


### Pattern 4 — Combine Independent Queries

```sql
Query 1

UNION ALL

Query 2
```
