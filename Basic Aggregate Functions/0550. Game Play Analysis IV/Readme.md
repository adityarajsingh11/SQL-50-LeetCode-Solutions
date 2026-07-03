# LeetCode 550 - Game Play Analysis IV

## Difficulty

**Medium**

---

# Question

Table: **Activity**

| Column Name  | Type |
| ------------ | ---- |
| player_id    | int  |
| device_id    | int  |
| event_date   | date |
| games_played | int  |

Each row represents a player logging into the game.

Write a solution to find the **fraction of players** who logged in **again exactly one day after their first login**.

Round the answer to **2 decimal places**.

---

# Problem Summary

For each player:

1. Find the **first login date**.
2. Check if the player logged in **exactly one day later**.
3. Count such players.
4. Divide by the total number of players.

---

> 🔴 **This is a GROUP BY + MIN() + JOIN + DATEDIFF() + COUNT(DISTINCT) problem.**

---

# Key Observation

The question **does NOT** ask:

❌ Did the player ever log in again?

It asks:

✅ Did the player log in **exactly one day after the first login?**

---

# Formula

```text
Fraction

=
(Number of Players who logged in on the next day)
-------------------------------------------------
(Total Number of Players)
```

---

# Approach

### Step 1

Find every player's **first login**.

```sql
MIN(event_date)
```



### Step 2

Join the result with the original Activity table.

Reason:

`MIN(event_date)` only returns the first login date.

To check whether the player logged in on the **next day**, we need the original rows.


### Step 3

Keep only rows where

```sql
DATEDIFF(Activity.event_date, first_login) = 1
```



### Step 4

Count unique players.

```sql
COUNT(DISTINCT Activity.player_id)
```


### Step 5

Divide by total players.

```sql
SELECT COUNT(DISTINCT player_id)
FROM Activity
```



### Step 6

Round to 2 decimal places.

---

# Solution

```sql
SELECT
    ROUND(
        COUNT(DISTINCT Activity.player_id) /
        (
            SELECT COUNT(DISTINCT player_id)
            FROM Activity
        ),
        2
    ) AS fraction
FROM Activity
JOIN
(
    SELECT
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) AS first_login
ON Activity.player_id = first_login.player_id
AND DATEDIFF(Activity.event_date, first_login.first_login) = 1;
```

---

# Query Breakdown

### Find First Login

```sql
SELECT
player_id,
MIN(event_date)
```

Returns the earliest login date for each player.



### GROUP BY

```sql
GROUP BY player_id
```

Creates one row for every player.



### JOIN

```sql
JOIN first_login
```

Connects the first login table with the original Activity table.

Why?

Because

```text
MIN(event_date)

↓

Only returns first_login

Need original rows

↓

JOIN
```



### Join Condition

```sql
ON Activity.player_id = first_login.player_id
```

Matches the same player.



```sql
AND DATEDIFF(Activity.event_date,
             first_login.first_login)=1
```

Keeps only players who logged in exactly one day later.



### COUNT(DISTINCT)

```sql
COUNT(DISTINCT Activity.player_id)
```

Counts successful players.



### Total Players

```sql
SELECT COUNT(DISTINCT player_id)
FROM Activity
```

Counts all players.


### ROUND()

```sql
ROUND(value,2)
```

Rounds the fraction to two decimal places.

---

# Dry Run 

### Activity Table

| player_id | device_id | event_date | games_played |
| --------- | --------- | ---------- | ------------ |
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |



## Step 1 → Find First Login

```sql
SELECT
player_id,
MIN(event_date)
FROM Activity
GROUP BY player_id;
```

Output

| player_id | first_login |
| --------- | ----------- |
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |



## Step 2 → JOIN

Join Condition

```sql
Activity.player_id = first_login.player_id
```

Now check

```sql
DATEDIFF(Activity.event_date,
         first_login.first_login)=1
```



### Player 1

| event_date | first_login | DATEDIFF |
| ---------- | ----------- | -------: |
| 2016-03-01 | 2016-03-01  |      0 ❌ |
| 2016-03-02 | 2016-03-01  |      1 ✅ |

Player 1 is counted.



### Player 2

| event_date | first_login | DATEDIFF |
| ---------- | ----------- | -------: |
| 2017-06-25 | 2017-06-25  |      0 ❌ |

No login on the next day.

Player 2 is **not counted**.



### Player 3

| event_date | first_login | DATEDIFF |
| ---------- | ----------- | -------: |
| 2016-03-02 | 2016-03-02  |      0 ❌ |
| 2018-07-03 | 2016-03-02  |    489 ❌ |

No login exactly one day later.

Player 3 is **not counted**.



## Step 3 → Successful Players

| Player |
| ------ |
| 1      |

```text
COUNT(DISTINCT player_id)

=

1
```



## Step 4 → Total Players

```text
Player 1
Player 2
Player 3
```

Total

```text
3
```


## Step 5 → Fraction

```text
1
-
3

=

0.3333
```



## Step 6 → ROUND()

```text
0.3333

↓

0.33
```



## Final Output

| fraction |
| -------- |
| 0.33     |

---

# SQL Concepts Used

| Concept         | Purpose                |
| --------------- | ---------------------- |
| MIN()           | Find first login date  |
| GROUP BY        | One row per player     |
| JOIN            | Retrieve original rows |
| DATEDIFF()      | Check next-day login   |
| COUNT(DISTINCT) | Count unique players   |
| ROUND()         | Round answer           |

