# LeetCode 1661 - Average Time of Process per Machine

## Question

Table: **Activity**

| Column Name   | Type  |
| ------------- | ----- |
| machine_id    | int   |
| process_id    | int   |
| activity_type | enum  |
| timestamp     | float |

The table shows when a process starts and ends on a machine.

* `activity_type = 'start'`
* `activity_type = 'end'`

Each `(machine_id, process_id)` pair has exactly one start record and one end record.

Write a solution to find the **average processing time of each machine**.

The processing time of a process is:

```text
Processing Time = End Time - Start Time
```

Return the result table with:

| machine_id | processing_time |

rounded to **3 decimal places**.

---

## Problem Summary

For each machine:

1. Find the processing time of every process.

```text
End Time - Start Time
```

2. Calculate the average processing time.

---

> 🔴 **This is a SELF JOIN + GROUP BY + AVG() problem.**

---

## Key Observation

The start and end records are stored in the **same table**.

Example:

| machine_id | process_id | activity_type | timestamp |
| ---------- | ---------- | ------------- | --------- |
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |

Need:

```text
1.520 - 0.712 = 0.808
```

Since both records are in the same table,

👉 Use **SELF JOIN**.

---

## Solution

```sql
SELECT a1.machine_id,
       ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time
FROM Activity a1
JOIN Activity a2
ON a1.machine_id = a2.machine_id
AND a1.process_id = a2.process_id
WHERE a1.activity_type = 'start'
AND a2.activity_type = 'end'
GROUP BY a1.machine_id;
```

---

## Query Breakdown

### Self Join

```sql
FROM Activity a1
JOIN Activity a2
```

* `a1` → Start Record
* `a2` → End Record

---

### Match Same Process

```sql
ON a1.machine_id = a2.machine_id
AND a1.process_id = a2.process_id
```

Ensures start and end belong to the same process.

---

### Keep Start and End Rows

```sql
WHERE a1.activity_type = 'start'
AND a2.activity_type = 'end'
```

Filters only valid start-end pairs.

---

### Calculate Processing Time

```sql
a2.timestamp - a1.timestamp
```

Formula:

```text
Processing Time = End Time - Start Time
```

---

### Find Average

```sql
AVG(a2.timestamp - a1.timestamp)
```

Calculates average processing time for each machine.

---

### Round Result

```sql
ROUND(value, 3)
```

Rounds answer to 3 decimal places.

Example:

```text
0.89423 → 0.894
```

---

## Dry Run 

### Activity Table

| machine_id | process_id | activity_type | timestamp |
| ---------- | ---------- | ------------- | --------- |
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |


## Step 1: SELF JOIN

```sql
FROM Activity a1
JOIN Activity a2
ON a1.machine_id = a2.machine_id
AND a1.process_id = a2.process_id
```

Match same:

```text
machine_id
process_id
```

Result:

| a1.machine | a1.process | a1.type | a1.time | a2.type | a2.time |
| ---------- | ---------- | ------- | ------- | ------- | ------- |
| 0          | 0          | start   | 0.712   | end     | 1.520   |
| 0          | 0          | end     | 1.520   | start   | 0.712   |
| 0          | 1          | start   | 3.140   | end     | 4.120   |
| 0          | 1          | end     | 4.120   | start   | 3.140   |
| 1          | 0          | start   | 0.550   | end     | 1.550   |
| 1          | 0          | end     | 1.550   | start   | 0.550   |
| 1          | 1          | start   | 0.430   | end     | 1.420   |
| 1          | 1          | end     | 1.420   | start   | 0.430   |

Notice:

```text
Each process matched twice.
```



## Step 2: WHERE Filter

```sql
WHERE a1.activity_type = 'start'
AND a2.activity_type = 'end'
```

Keep only:

| machine | process | start | end   |
| ------- | ------- | ----- | ----- |
| 0       | 0       | 0.712 | 1.520 |
| 0       | 1       | 3.140 | 4.120 |
| 1       | 0       | 0.550 | 1.550 |
| 1       | 1       | 0.430 | 1.420 |

Now every row represents:

```text
Start Time → End Time
```

for one process.



## Step 3: Calculate Processing Time

```sql
a2.timestamp - a1.timestamp
```

### Machine 0

Process 0

```text
1.520 - 0.712 = 0.808
```

Process 1

```text
4.120 - 3.140 = 0.980
```

### Machine 1

Process 0

```text
1.550 - 0.550 = 1.000
```

Process 1

```text
1.420 - 0.430 = 0.990
```

Table becomes:

| machine_id | processing_time |
| ---------- | --------------- |
| 0          | 0.808           |
| 0          | 0.980           |
| 1          | 1.000           |
| 1          | 0.990           |


## Step 4: GROUP BY

```sql
GROUP BY a1.machine_id
```

Groups:

### Machine 0

```text
0.808
0.980
```

### Machine 1

```text
1.000
0.990
```


## Step 5: AVG()

```sql
AVG(a2.timestamp - a1.timestamp)
```

### Machine 0

```text
(0.808 + 0.980) / 2
= 0.894
```

### Machine 1

```text
(1.000 + 0.990) / 2
= 0.995
```



## Step 6: ROUND()

```sql
ROUND(value, 3)
```

Results:

| machine_id | processing_time |
| ---------- | --------------- |
| 0          | 0.894           |
| 1          | 0.995           |

---

## Visual Flow

```text
START ROW
      ↓
SELF JOIN
      ↓
END ROW
      ↓
End - Start
      ↓
GROUP BY Machine
      ↓
AVG()
      ↓
ROUND( ,3)
```

---

## Learned 

### AVG()

```sql
AVG(column)
```

Returns average value.


### ROUND()

```sql
ROUND(value, 3)
```

Rounds to 3 decimal places.


### GROUP BY

```sql
GROUP BY machine_id
```

Creates one result per machine.
