# LeetCode 197 - Rising Temperature

## Question

Table: **Weather**

| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| recordDate  | date |
| temperature | int  |

`id` is the primary key.

Write a solution to find all dates' IDs where the temperature was **higher than the previous day's temperature**.

Return the result table in any order.

---

## Problem Summary

We need to find days where:

```text
Today's Temperature > Yesterday's Temperature
```

Return the `id` of those days.

---

## Example

### Input

| id | recordDate | temperature |
| -- | ---------- | ----------- |
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |

### Comparison

```text
Jan 2 (25) > Jan 1 (10) ✅
Jan 3 (20) > Jan 2 (25) ❌
Jan 4 (30) > Jan 3 (20) ✅
```

### Output

| id |
| -- |
| 2  |
| 4  |

---

## Key Observation

To compare today's temperature with yesterday's temperature, we need to compare rows from the **same table**.

<p style="color:red;">👉 This is a SELF JOIN problem.</p>

---

## Approach

1. Use the Weather table twice.
2. Let:

   * `w1` = Current Day
   * `w2` = Previous Day
3. Match rows where dates differ by 1 day.
4. Compare temperatures.
5. Return IDs where today's temperature is higher.

---

## Solution

```sql
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;
```

---

## Query Breakdown

### Self Join

```sql
FROM Weather w1
JOIN Weather w2
```

Use the same table twice.

```text
w1 = Current Day
w2 = Previous Day
```



### Match Consecutive Days

```sql
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
```

Matches rows where:

```text
Current Date - Previous Date = 1 day
```

Example:

```text
2015-01-02 - 2015-01-01 = 1
```


### Compare Temperatures

```sql
WHERE w1.temperature > w2.temperature
```

Checks whether today's temperature is greater than yesterday's.

---

## Dry Run 

### Weather Table

| id | recordDate | temperature |
| -- | ---------- | ----------- |
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |


## Step 1: SELF JOIN

```sql
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate,w2.recordDate) = 1
```

Meaning:

```text
w1 = Current Day
w2 = Previous Day
```

Find rows where:

```text
Current Date - Previous Date = 1 day
```

### Matching Pairs

| w1.id | w1.date    | w1.temp | w2.id | w2.date    | w2.temp |
| ----- | ---------- | ------- | ----- | ---------- | ------- |
| 2     | 2015-01-02 | 25      | 1     | 2015-01-01 | 10      |
| 3     | 2015-01-03 | 20      | 2     | 2015-01-02 | 25      |
| 4     | 2015-01-04 | 30      | 3     | 2015-01-03 | 20      |

Why?

```text
2015-01-02 - 2015-01-01 = 1 ✅
2015-01-03 - 2015-01-02 = 1 ✅
2015-01-04 - 2015-01-03 = 1 ✅
```


## Step 2: Apply WHERE

```sql
WHERE w1.temperature > w2.temperature
```

Check each pair:

### Pair 1

| Current | Previous |
| ------- | -------- |
| 25      | 10       |

```text
25 > 10 ✅
```

Keep:

```text
id = 2
```


### Pair 2

| Current | Previous |
| ------- | -------- |
| 20      | 25       |

```text
20 > 25 ❌
```

Remove.



### Pair 3

| Current | Previous |
| ------- | -------- |
| 30      | 20       |

```text
30 > 20 ✅
```

Keep:

```text
id = 4
```



## Step 3: SELECT

```sql
SELECT w1.id
```

Output:

| id |
| -- |
| 2  |
| 4  |

---

## Pattern Learned

### SELF JOIN Pattern

```sql
SELECT ...
FROM Table t1
JOIN Table t2
ON condition
WHERE comparison;
```

Used when comparing rows within the same table.

---

## DATEDIFF()

### Syntax

```sql
DATEDIFF(date1, date2)
```

Returns:

```text
date1 - date2
```

Example:

```sql
DATEDIFF('2015-01-02', '2015-01-01')
```

Output:

```text
1
```

