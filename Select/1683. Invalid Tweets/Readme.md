# LeetCode 1683 - Invalid Tweets

## Question

Table: **Tweets**

| Column Name | Type    |
| ----------- | ------- |
| tweet_id    | int     |
| content     | varchar |

`tweet_id` is the primary key.

A tweet is considered **invalid** if the number of characters in its content is **strictly greater than 15**.

Write a solution to find the IDs of invalid tweets.

Return the result table in any order.

---

## Problem Summary

Find all tweets whose content length is **more than 15 characters**.

Return only the `tweet_id`.

---

## Approach

1. Calculate the length of each tweet using `LENGTH()`.
2. Check if the length is greater than `15`.
3. Return the corresponding `tweet_id`.


## Solution

```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

---

## Query Breakdown

### Select tweet IDs

```sql
SELECT tweet_id
```

Returns only the tweet IDs.

### Choose the table

```sql
FROM Tweets
```

Fetches data from the Tweets table.

### Filter invalid tweets

```sql
WHERE LENGTH(content) > 15
```

Keeps only tweets whose content contains more than 15 characters.

---

## Dry Run

### Input

| tweet_id | content                 |
| -------- | ----------------------- |
| 1        | Vote for Biden          |
| 2        | Let us Code             |
| 3        | More than fifteen chars |

### Length Calculation

| tweet_id | Length |
| -------- | ------ |
| 1        | 14     |
| 2        | 11     |
| 3        | 23     |

Condition:

```sql
LENGTH(content) > 15
```

### Output

| tweet_id |
| -------- |
| 3        |

---

## Interview Note

**Question Clue:** "Number of characters", "Length of string", "Text size"

👉 Immediately think of:

```sql
LENGTH(column_name)
```
