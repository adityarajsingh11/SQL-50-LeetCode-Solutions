# LeetCode 1527 - Patients With a Condition

## Difficulty

**Easy**

---

# 📝 Question in Simple Words

Find all patients whose **conditions contain a disease code starting with `DIAB1`**.

Return:

* `patient_id`
* `patient_name`
* `conditions`


### Patients Table

| patient_id | patient_name | conditions   |
| ---------- | ------------ | ------------ |
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        | DIAB100 MYOP |
| 3          | Bob          | DIAB100      |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |



## Output

| patient_id | patient_name | conditions   |
| ---------- | ------------ | ------------ |
| 2          | Alice        | DIAB100 MYOP |
| 3          | Bob          | DIAB100      |
| 4          | George       | ACNE DIAB100 |

---

# Easy Understanding

The `conditions` column contains **multiple disease codes** separated by spaces.

Example

| conditions   |
| ------------ |
| DIAB100 MYOP |
| ACNE DIAB100 |
| DIAB201      |

We need to find only codes that **start with `DIAB1`**.

---

# Example

### ✅ Match

```text
DIAB100
DIAB101
DIAB199
ACNE DIAB100
```


### ❌ Don't Match

```text
DIAB201
MYOP ACNE
```

---

# Problem Summary

A patient should be selected if:

* `DIAB1` is the **first condition**
* OR `DIAB1` appears **after a space**

---

# Key Observation 

There are only **two possible positions** for `DIAB1`.

```text
Condition String
        │
        ├── Starts with DIAB1
        │        │
        │        ▼
        │   LIKE 'DIAB1%'
        │
        └── Appears Later
                 │
                 ▼
        LIKE '% DIAB1%'
```

---

# Approach

### Step 1

Check if `conditions` starts with `DIAB1`.


### Step 2

Check if `DIAB1` appears after a space.


### Step 3

Return matching patients.

---

# Solution

```sql
SELECT
    patient_id,
    patient_name,
    conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%'
   OR conditions LIKE '% DIAB1%';
```

---

# Query Breakdown

## Step 1

```sql
SELECT
    patient_id,
    patient_name,
    conditions
FROM Patients
```

Select the required columns.


## Step 2

```sql
conditions LIKE 'DIAB1%'
```

Checks whether the **first word** starts with `DIAB1`.

Example

```text
DIAB100 MYOP
```

✅ Match


## Step 3

```sql
conditions LIKE '% DIAB1%'
```

Checks whether `DIAB1` appears **after a space**.

Example

```text
ACNE DIAB100
```

✅ Match


## Step 4

```sql
OR
```

If either condition is true, include the patient.

---

# Dry Run

### Patients Table

| patient_id | patient_name | conditions   |
| ---------- | ------------ | ------------ |
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        | DIAB100 MYOP |
| 3          | Bob          | DIAB100      |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |


### Row 1

```text
YFEV COUGH
```

Starts with DIAB1?

❌ No

Contains " DIAB1"?

❌ No

Result

❌ Excluded


### Row 2

```text
DIAB100 MYOP
```

Starts with DIAB1?

✅ Yes

Result

✅ Included



### Row 3

```text
DIAB100
```

Starts with DIAB1?

✅ Yes

Result

✅ Included


### Row 4

```text
ACNE DIAB100
```

Starts with DIAB1?

❌ No

Contains " DIAB1"?

✅ Yes

Result

✅ Included

### Row 5

```text
DIAB201
```

Starts with DIAB1?

❌ No

Contains " DIAB1"?

❌ No

Result

❌ Excluded


## Final Output

| patient_id | patient_name | conditions   |
| ---------- | ------------ | ------------ |
| 2          | Alice        | DIAB100 MYOP |
| 3          | Bob          | DIAB100      |
| 4          | George       | ACNE DIAB100 |

---

# SQL Concepts Used

| Concept  | Purpose                          |
| -------- | -------------------------------- |
| `LIKE`   | Pattern matching                 |
| `%`      | Matches any number of characters |
| `OR`     | Either condition can be true     |
| `SELECT` | Retrieve required columns        |

---

# Pattern Learned

### Pattern 1 — Starts With

```sql
LIKE 'text%'
```

Find strings that start with a specific text.



### Pattern 2 — Word Appears Later

```sql
LIKE '% text%'
```

Find a word appearing after a space.


### Pattern 3 — Multiple Pattern Check

```sql
condition1
OR
condition2
```

Accept rows if either pattern matches.
