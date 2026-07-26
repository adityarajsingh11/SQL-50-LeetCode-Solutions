# LeetCode 1204 - Last Person to Fit in the Bus

## Difficulty

**Medium**

---

# Question

Table: **Queue**

| Column      | Type    |
| ----------- | ------- |
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |

* `turn` represents the order in which passengers enter the bus.
* The bus can carry **at most 1000 kg**.

Return the **name of the last person who can still enter the bus** without exceeding **1000 kg**.

---

# Problem Summary

Passengers enter the bus one by one according to their `turn`.

We keep adding their weights.

If the total weight becomes **more than 1000**, that passenger cannot enter.

Return the **last passenger whose running total weight is ≤ 1000**.

---

# Key Observation 

This is a **Running Sum (Cumulative Sum)** problem.

We need to calculate

```text
Current Weight

+

Previous Total Weight
```

So we use

```sql
SUM(weight) OVER(ORDER BY turn)
```

---

# Approach

### Step 1

Calculate the **running total weight**.


### Step 2

Store this result in a **temporary table (subquery)**.


### Step 3

Select only passengers whose running weight is **≤ 1000**.


### Step 4

Among them, choose the passenger with the **highest turn**.


# Solution

```sql
SELECT person_name
FROM
(
    SELECT
        person_name,
        turn,
        SUM(weight) OVER(ORDER BY turn) AS running_sum
    FROM Queue
) running_weight
WHERE running_sum <= 1000
ORDER BY turn DESC
LIMIT 1;
```

---

# Query Breakdown

### Step 1

```sql
SELECT
person_name,
turn,
SUM(weight) OVER(ORDER BY turn) AS running_sum
```

Calculate running total.



### Step 2

```sql
FROM Queue
```

Read all passengers.


### Step 3

```sql
) running_weight
```

Create a **temporary table** named `running_weight`.

This table stores:

* person_name
* turn
* running_sum


### Step 4

```sql
WHERE running_sum <=1000
```

Keep only passengers who can enter the bus.


### Step 5

```sql
ORDER BY turn DESC
```

Bring the **last passenger** to the top.


### Step 6

```sql
LIMIT 1
```

Return only one row.

---

#  Dry Run

## Original Queue Table

| person_name | weight | turn |
| ----------- | ------ | ---- |
| Alice       | 250    | 1    |
| Bob         | 175    | 2    |
| Alex        | 350    | 3    |
| John        | 400    | 4    |



## Step 1

Run only the inner query

```sql
SELECT
    person_name,
    turn,
    SUM(weight) OVER(ORDER BY turn) AS running_sum
FROM Queue;
```



## Temporary Table Created

Let's name it

```text
running_weight
```

Now SQL creates this table.

| person_name | turn | running_sum |
| ----------- | ---- | ----------- |
| Alice       | 1    | 250         |
| Bob         | 2    | 425         |
| Alex        | 3    | 775         |
| John        | 4    | 1175        |

### How did SQL calculate this?

#### Row 1

```text
Alice

250

Running Sum

250
```


#### Row 2

```text
Previous Running Sum

250

+

Bob Weight

175

=

425
```


#### Row 3

```text
Previous Running Sum

425

+

Alex Weight

350

=

775
```


#### Row 4

```text
Previous Running Sum

775

+

John Weight

400

=

1175
```

## Temporary Table Looks Like

#### running_weight

| person_name | turn | running_sum |
| ----------- | ---- | ----------- |
| Alice       | 1    | 250         |
| Bob         | 2    | 425         |
| Alex        | 3    | 775         |
| John        | 4    | 1175        |

Now SQL treats this just like a normal table.


## Step 2

Outer Query

```sql
SELECT person_name
FROM running_weight
WHERE running_sum <=1000;
```

Rows remaining

| person_name | turn | running_sum |
| ----------- | ---- | ----------- |
| Alice       | 1    | 250         |
| Bob         | 2    | 425         |
| Alex        | 3    | 775         |

John is removed because

```text
1175

>

1000
```


## Step 3

Now execute

```sql
ORDER BY turn DESC
```

Result

| person_name | turn |
| ----------- | ---- |
| Alex        | 3    |
| Bob         | 2    |
| Alice       | 1    |



## Step 4

Execute

```sql
LIMIT 1
```

Result

| person_name |
| ----------- |
| Alex        |


## Final Output

| person_name |
| ----------- |
| Alex        |

---

# SQL Concepts Used

| Concept                    | Purpose                                   |
| -------------------------- | ----------------------------------------- |
| `SUM() OVER()`             | Calculate running total (cumulative sum). |
| `ORDER BY` (inside `OVER`) | Decide running sum order.                 |
| `Subquery`                 | Create a temporary table.                 |
| `WHERE`                    | Filter passengers within weight limit.    |
| `ORDER BY DESC`            | Bring the last valid passenger first.     |
| `LIMIT 1`                  | Return only one passenger.                |
| `AS`                       | Rename the running sum column.            |
