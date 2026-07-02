# LeetCode 1193 - Monthly Transactions I

## Question

Table: **Transactions**

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| country     | varchar |
| state       | enum    |
| amount      | int     |
| trans_date  | date    |

`state` can be:

* `"approved"`
* `"declined"`

Write a solution to find, for each **month** and **country**:

* Total number of transactions.
* Number of approved transactions.
* Total transaction amount.
* Total approved transaction amount.

Return the result in any order.

## Input

### Transactions

| id  | country | state    | amount | trans_date |
| --- | ------- | -------- | -----: | ---------- |
| 121 | US      | approved |   1000 | 2018-12-18 |
| 122 | US      | declined |   2000 | 2018-12-19 |
| 123 | US      | approved |   2000 | 2019-01-01 |
| 124 | DE      | approved |   2000 | 2019-01-07 |

## Final Output

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------: | -------------: | -----------------: | --------------------: |
| 2018-12 | US      |           2 |              1 |               3000 |                  1000 |
| 2019-01 | US      |           1 |              1 |               2000 |                  2000 |
| 2019-01 | DE      |           1 |              1 |               2000 |                  2000 |


---

## Problem Summary

For every **month** and **country**, calculate:

* Total transactions
* Approved transactions
* Total amount
* Approved amount

---

> 🔴 **This is a GROUP BY + SUM(IF()) + DATE_FORMAT() problem.**

---

## Approach

1. Convert the transaction date into **YYYY-MM**.
2. Group records by **month** and **country**.
3. Count all transactions.
4. Count approved transactions.
5. Sum all transaction amounts.
6. Sum only approved transaction amounts.

---

## Solution

```sql
SELECT
    DATE_FORMAT(trans_date,'%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    SUM(IF(state='approved',1,0)) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state='approved',amount,0)) AS approved_total_amount
FROM Transactions
GROUP BY month, country;
```

---

## Query Breakdown

### Convert Date into Month

```sql
DATE_FORMAT(trans_date,'%Y-%m')
```

Example

| trans_date | month   |
| ---------- | ------- |
| 2019-01-15 | 2019-01 |
| 2019-01-28 | 2019-01 |
| 2019-02-05 | 2019-02 |


### Group by Month and Country

```sql
GROUP BY month, country
```

Groups records having the same:

* Month
* Country

Example

| month   | country |
| ------- | ------- |
| 2019-01 | US      |
| 2019-01 | India   |
| 2019-02 | US      |

Each `(month, country)` combination becomes one group.



### Count Total Transactions

```sql
COUNT(*)
```

Counts every transaction.



### Count Approved Transactions

```sql
SUM(IF(state='approved',1,0))
```

Logic:

| State    | Value |
| -------- | ----: |
| approved |     1 |
| declined |     0 |

Example:

```
1
0
1
1
```

Sum

```
3
```



### Total Transaction Amount

```sql
SUM(amount)
```

Adds all transaction amounts.



### Approved Transaction Amount

```sql
SUM(IF(state='approved',amount,0))
```

Example

| State    | Amount | Value Added |
| -------- | -----: | ----------: |
| approved |    100 |         100 |
| declined |    200 |           0 |
| approved |    150 |         150 |

Total

```
250
```

---

# Dry Run 

### Transactions

| id  | country | state    | amount | trans_date |
| --- | ------- | -------- | -----: | ---------- |
| 121 | US      | approved |   1000 | 2018-12-18 |
| 122 | US      | declined |   2000 | 2018-12-19 |
| 123 | US      | approved |   2000 | 2019-01-01 |
| 124 | DE      | approved |   2000 | 2019-01-07 |

---

## Step 1 - Extract Month

Using

```sql
DATE_FORMAT(trans_date,'%Y-%m')
```

Result

| month   | country | state    | amount |
| ------- | ------- | -------- | -----: |
| 2018-12 | US      | approved |   1000 |
| 2018-12 | US      | declined |   2000 |
| 2019-01 | US      | approved |   2000 |
| 2019-01 | DE      | approved |   2000 |

---

## Step 2 - GROUP BY month, country

Groups created

### Group 1

```text
(2018-12 , US)
```

Rows

| state    | amount |
| -------- | -----: |
| approved |   1000 |
| declined |   2000 |



### Group 2

```text
(2019-01 , US)
```

Rows

| state    | amount |
| -------- | -----: |
| approved |   2000 |


### Group 3

```text
(2019-01 , DE)
```

Rows

| state    | amount |
| -------- | -----: |
| approved |   2000 |



## Step 3 - Calculate Values

### Group (2018-12, US)

```text
COUNT(*) = 2

SUM(IF(state='approved',1,0))
= 1 + 0
= 1

SUM(amount)
=1000+2000
=3000

SUM(IF(state='approved',amount,0))
=1000+0
=1000
```

Result

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------: | -------------: | -----------------: | --------------------: |
| 2018-12 | US      |           2 |              1 |               3000 |                  1000 |



### Group (2019-01, US)

```text
COUNT(*) = 1

Approved Count = 1

SUM(amount)=2000

Approved Amount=2000
```

Result

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------: | -------------: | -----------------: | --------------------: |
| 2019-01 | US      |           1 |              1 |               2000 |                  2000 |



### Group (2019-01, DE)

```text
COUNT(*) = 1

Approved Count = 1

SUM(amount)=2000

Approved Amount=2000
```

Result

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------: | -------------: | -----------------: | --------------------: |
| 2019-01 | DE      |           1 |              1 |               2000 |                  2000 |



## Final Output

| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------: | -------------: | -----------------: | --------------------: |
| 2018-12 | US      |           2 |              1 |               3000 |                  1000 |
| 2019-01 | US      |           1 |              1 |               2000 |                  2000 |
| 2019-01 | DE      |           1 |              1 |               2000 |                  2000 |

---

## What I Learned

* `DATE_FORMAT()` extracts the month from a date.
* `GROUP BY month, country` creates one group for each **(month, country)** combination.
* `COUNT(*)` counts all transactions.
* `SUM(IF(state='approved',1,0))` counts only approved transactions.
* `SUM(amount)` calculates the total transaction amount.
* `SUM(IF(state='approved',amount,0))` calculates the total amount of approved transactions.

