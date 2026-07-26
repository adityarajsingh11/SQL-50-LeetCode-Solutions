
# LeetCode 1148 - Article Views I

## Question

Table: **Views**

| Column Name | Type |
| ----------- | ---- |
| article_id  | int  |
| author_id   | int  |
| viewer_id   | int  |
| view_date   | date |

There is no primary key for this table.

Each row indicates that a viewer viewed an article on a specific date.

**Write a solution to find all authors who viewed at least one of their own articles.**

Return the result table sorted by `id` in ascending order.

---

## Approach

We need rows where:

```sql
author_id = viewer_id
```

This means the author viewed their own article.

Since an author may view their own article multiple times, use:

```sql
DISTINCT
```

to avoid duplicates.

Finally, sort the result using:

```sql
ORDER BY id
```

---

## Solution

```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;
```

---

## Query Breakdown

### Select unique authors

```sql
SELECT DISTINCT author_id AS id
```

* `DISTINCT` removes duplicates.
* `AS id` renames the column to `id`.

### Choose the table

```sql
FROM Views
```

Reads data from the Views table.

### Find self-views

```sql
WHERE author_id = viewer_id
```

Keeps only rows where the author viewed their own article.

### Sort the result

```sql
ORDER BY id
```

Returns authors in ascending order.

---

## SQL Concepts Used

| Concept  | Purpose           |
| -------- | ----------------- |
| SELECT   | Retrieve columns  |
| DISTINCT | Remove duplicates |
| AS       | Rename a column   |
| WHERE    | Filter rows       |
| =        | Compare values    |
| ORDER BY | Sort results      |

---

## Dry Run

### Input

| article_id | author_id | viewer_id |
| ---------- | --------- | --------- |
| 1          | 3         | 5         |
| 1          | 3         | 3         |
| 2          | 7         | 7         |
| 2          | 7         | 6         |

Condition:

```sql
author_id = viewer_id
```

Matching rows:

| author_id |
| --------- |
| 3         |
| 7         |

Output:

| id |
| -- |
| 3  |
| 7  |



---

#### DISTINCT = "Different Only"

Agar same value baar-baar aa rahi ho aur sirf unique values chahiye ho, to DISTINCT use karo. 🚀

Examples:

* Unique author IDs
* Unique customer IDs
* Unique country names
* Unique department names

---