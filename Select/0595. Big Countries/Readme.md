
# LeetCode 595 - Big Countries

## Question

Table: **World**

| Column Name | Type    |
| ----------- | ------- |
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |

`name` is the primary key.

A country is considered **big** if:

* it has an area of at least **3,000,000 km²**, or
* it has a population of at least **25,000,000**.

Write a solution to find the **name, population, and area** of the big countries.

Return the result table in any order.


### Input

| name        | area    | population |
| ----------- | ------- | ---------- |
| Afghanistan | 652230  | 25500100   |
| Albania     | 28748   | 2831741    |
| Algeria     | 2381741 | 37100000   |

Condition:

```sql
area >= 3000000
OR population >= 25000000
```

### Output

| name        | population | area    |
| ----------- | ---------- | ------- |
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |


---

## Approach

We need countries that satisfy **at least one** of the conditions:

* `area >= 3000000`
* `population >= 25000000`

Since either condition is enough, we use **OR**.

---

## Solution

```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000
OR population >= 25000000;
```

---

## Query Breakdown

### Select required columns

```sql
SELECT name, population, area
```

Returns only the required columns.

### Choose the table

```sql
FROM World
```

Fetches data from the World table.

### Apply filtering condition

```sql
WHERE area >= 3000000
OR population >= 25000000
```

Returns countries that satisfy at least one condition.

---

## SQL Concepts Used

| Concept | Purpose                             |
| ------- | ----------------------------------- |
| SELECT  | Retrieve columns                    |
| FROM    | Specify table                       |
| WHERE   | Filter rows                         |
| OR      | At least one condition must be true |
| >=      | Greater than or equal to            |

