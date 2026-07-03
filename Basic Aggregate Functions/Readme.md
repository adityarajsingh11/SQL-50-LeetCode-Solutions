# 📊 Basic Aggregate Functions - LeetCode SQL 50

This folder contains my solutions and notes for the **Basic Aggregate Functions** section of the **LeetCode SQL 50 Study Plan**.

---

## 📈 Progress

**Completed:** 8 / 8 ✅

---

# What are Aggregate Functions?

Aggregate functions perform calculations on **multiple rows** and return **one summarized value**.

Example

```
10
20
30

↓

SUM = 60
AVG = 20
MIN = 10
COUNT = 3
```

---

## 📚 Questions

| # | Problem | Difficulty | Concepts | Link |
|---|---------|------------|----------|------|
| 1 | 620. Not Boring Movies | Easy | WHERE, ORDER BY, Modulus (%) | https://leetcode.com/problems/not-boring-movies/ |
| 2 | 1251. Average Selling Price | Easy | SUM(), LEFT JOIN, BETWEEN, IFNULL(), ROUND() | https://leetcode.com/problems/average-selling-price/ |
| 3 | 1075. Project Employees I | Easy | AVG(), GROUP BY, LEFT JOIN | https://leetcode.com/problems/project-employees-i/ |
| 4 | 1633. Percentage of Users Attended a Contest | Easy | COUNT(), GROUP BY, Subquery, ROUND() | https://leetcode.com/problems/percentage-of-users-attended-a-contest/ |
| 5 | 1211. Queries Quality and Percentage | Easy | AVG(), IF(), ROUND(), GROUP BY | https://leetcode.com/problems/queries-quality-and-percentage/ |
| 6 | 1193. Monthly Transactions I | Medium | SUM(), COUNT(), IF(), DATE_FORMAT(), GROUP BY | https://leetcode.com/problems/monthly-transactions-i/ |
| 7 | 1174. Immediate Food Delivery II | Medium | MIN(), GROUP BY, JOIN, AVG(IF()) | https://leetcode.com/problems/immediate-food-delivery-ii/ |
| 8 | 550. Game Play Analysis IV | Medium | MIN(), JOIN, DATEDIFF(), COUNT(DISTINCT), GROUP BY | https://leetcode.com/problems/game-play-analysis-iv/ |

---

## 🧠 SQL Concepts Covered

- ✅ COUNT()
- ✅ SUM()
- ✅ AVG()
- ✅ MIN()
- ✅ GROUP BY
- ✅ ROUND()
- ✅ IF()
- ✅ IFNULL()
- ✅ DATE_FORMAT()
- ✅ DATEDIFF()
- ✅ BETWEEN
- ✅ COUNT(DISTINCT)
- ✅ Subqueries
- ✅ Conditional Aggregation
- ✅ Weighted Average
- ✅ Percentage Calculation

---

## 🎯 Aggregate Function Patterns Learned

| Pattern | Purpose |
|---------|---------|
| COUNT(*) | Count all rows |
| COUNT(DISTINCT column) | Count unique values |
| SUM(column) | Total value |
| AVG(column) | Average value |
| MIN(column) | Earliest / Smallest value |
| SUM(IF(condition,1,0)) | Conditional Count |
| SUM(IF(condition,column,0)) | Conditional Sum |
| AVG(IF(condition,1,0))*100 | Percentage Calculation |
| SUM(value × weight)/SUM(weight) | Weighted Average |
| GROUP BY + MIN() | First Record Per Group |
| GROUP BY + Aggregate | Group-wise Calculations |


---

# COUNT()

Counts rows.

```sql
COUNT(*)
```

Counts every row.

```sql
COUNT(column)
```

Counts only NON-NULL values.

```sql
COUNT(DISTINCT column)
```

Counts unique values.

Used In

- Percentage of Users Attended a Contest
- Game Play Analysis IV

---

# SUM()

Returns the total value.

```sql
SUM(column)
```

Example

```
100
200
300

↓

600
```

Used In

- Average Selling Price
- Monthly Transactions I

---

# AVG()

Returns the average value.

```sql
AVG(column)
```

Can also calculate the average of an expression.

```sql
AVG(rating/position)
```

Used In

- Project Employees I
- Queries Quality and Percentage

---

# MIN()

Returns the smallest value.

```sql
MIN(column)
```

Very useful for finding:

- First Login
- First Order
- Earliest Purchase

Used In

- Immediate Food Delivery II
- Game Play Analysis IV

---

# ROUND()

Rounds decimal values.

```sql
ROUND(value,2)
```

Example

```
3.66666

↓

3.67
```

---

# IF()

Conditional function.

```sql
IF(condition,true,false)
```

Example

```sql
IF(state='approved',1,0)
```

---

# IFNULL()

Replaces NULL values.

```sql
IFNULL(value,0)
```

Used when there is no matching record.

---

# DATE_FORMAT()

Extracts parts of a date.

```sql
DATE_FORMAT(trans_date,'%Y-%m')
```

Example

```
2019-01-15

↓

2019-01
```

---

# DATEDIFF()

Returns the difference between two dates.

```sql
DATEDIFF(date1,date2)
```

Example

```
2019-01-02
2019-01-01

↓

1
```

---

# BETWEEN

Checks whether a value lies within a range.

```sql
purchase_date
BETWEEN start_date
AND end_date
```

---

# GROUP BY

Groups rows having the same value.

```sql
GROUP BY column;
```

Can group using multiple columns.

```sql
GROUP BY month,country;
```

---

# Aggregate Patterns Learned


## Pattern 1

### Group-wise Average

```sql
AVG(column)
GROUP BY column
```

Example

Project Employees I


## Pattern 2

### Percentage

```sql
AVG(IF(condition,1,0))*100
```

Examples

- Confirmation Rate
- Queries Quality
- Immediate Food Delivery II



## Pattern 3

### Conditional Count

```sql
SUM(IF(condition,1,0))
```

Example

Monthly Transactions I


## Pattern 4

### Conditional Sum

```sql
SUM(IF(condition,column,0))
```

Example

Monthly Transactions I



## Pattern 5

### Weighted Average

```sql
SUM(price*units)
/
SUM(units)
```

Example

Average Selling Price



## Pattern 6

### First Record Per Group

```sql
GROUP BY

+

MIN()
```

Examples

- First Login
- First Order



## Pattern 7

### Retrieve Complete First Record

```sql
JOIN

(

GROUP BY
MIN()

)
```

Examples

- Immediate Food Delivery II
- Game Play Analysis IV



## Pattern 8

### Count Unique Records

```sql
COUNT(DISTINCT column)
```

Example

Game Play Analysis IV


## Pattern 9

### Monthly Reports

```sql
DATE_FORMAT()

+

GROUP BY
```

Example

Monthly Transactions I

---

## ✅ Status

**Completed all 8 Basic Aggregate Function problems from LeetCode SQL 50.**

Progress: 22 / 50 🚀