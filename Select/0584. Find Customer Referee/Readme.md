## LeetCode 584 - Find Customer Referee

### Question

Table: **Customer**

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |
| referee_id  | int     |

Each row indicates the ID of a customer, their name, and the ID of the customer who referred them.

**Write a solution to find the names of customers who were not referred by the customer with `id = 2`.**

Return the result table in any order.

---

### Example

#### Input

| id | name | referee_id |
| -- | ---- | ---------- |
| 1  | Will | NULL       |
| 2  | Jane | NULL       |
| 3  | Alex | 2          |
| 4  | Bill | NULL       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |

#### Output

| name |
| ---- |
| Will |
| Jane |
| Bill |
| Zack |

#### Explanation

* Alex and Mark were referred by customer `2`, so they are excluded.
* Will, Jane, and Bill have no referee (`NULL`).
* Zack was referred by customer `1`.

---

## Approach

We need customers whose:

* `referee_id` is **not equal to 2**, OR
* `referee_id` is **NULL**.

Since NULL cannot be compared using `=` or `!=`, we use `IS NULL`.

---

## Solution

```sql
SELECT name
FROM Customer
WHERE referee_id != 2
OR referee_id IS NULL;
```

---

## Query Breakdown

### Select the required column

```sql
SELECT name
```

Returns only customer names.

### Choose the table

```sql
FROM Customer
```

Fetches data from the Customer table.

### Filter customers

```sql
WHERE referee_id != 2
```

Keeps customers not referred by customer 2.

### Include NULL values

```sql
OR referee_id IS NULL
```

Includes customers who do not have a referee.

---

## SQL Concepts Used

| Concept | Purpose                             |
| ------- | ----------------------------------- |
| SELECT  | Retrieve columns                    |
| FROM    | Specify table                       |
| WHERE   | Filter rows                         |
| OR      | At least one condition must be true |
| IS NULL | Check for NULL values               |
| !=      | Not equal to                        |


