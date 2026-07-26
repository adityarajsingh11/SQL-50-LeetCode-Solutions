
# 📊 Advanced String Functions / Regex / Clause - LeetCode SQL 50

This folder contains my solutions and notes for the **Advanced String Functions / Regex / Clause** section of the **LeetCode SQL 50 Study Plan**.

---

## 📈 Progress

**Completed:** 7 / 7 ✅

---

## 📚 Questions

| # | Problem | Difficulty | Concepts | Link |
|---|---------|------------|----------|------|
| 1 | 1667. Fix Names in a Table | Easy | UPPER(), LOWER(), CONCAT(), LEFT(), SUBSTRING() | https://leetcode.com/problems/fix-names-in-a-table/ |
| 2 | 1527. Patients With a Condition | Easy | LIKE, Pattern Matching | https://leetcode.com/problems/patients-with-a-condition/ |
| 3 | 196. Delete Duplicate Emails | Easy | DELETE, Self Join | https://leetcode.com/problems/delete-duplicate-emails/ |
| 4 | 176. Second Highest Salary | Medium | Scalar Subquery, LIMIT, OFFSET, DISTINCT | https://leetcode.com/problems/second-highest-salary/ |
| 5 | 1484. Group Sold Products By The Date | Easy | GROUP BY, GROUP_CONCAT(), COUNT(DISTINCT) | https://leetcode.com/problems/group-sold-products-by-the-date/ |
| 6 | 1327. List the Products Ordered in a Period | Easy | JOIN, GROUP BY, SUM(), HAVING | https://leetcode.com/problems/list-the-products-ordered-in-a-period/ |
| 7 | 1517. Find Users With Valid E-Mails | Easy | REGEXP, Regular Expressions | https://leetcode.com/problems/find-users-with-valid-e-mails/ |

---

# 📘 Advanced String Functions / Regex / Clause

This section focuses on **string manipulation**, **text searching**, **regular expressions**, **subqueries**, **data cleaning**, and **aggregation techniques**. These concepts are widely used in SQL interviews and real-world database applications.

---

## 🧠 SQL Concepts Covered

- ✅ String Functions
- ✅ CONCAT()
- ✅ UPPER()
- ✅ LOWER()
- ✅ LEFT()
- ✅ SUBSTRING()
- ✅ LIKE
- ✅ REGEXP
- ✅ DELETE
- ✅ Self Join
- ✅ Scalar Subquery
- ✅ DISTINCT
- ✅ GROUP_CONCAT()
- ✅ GROUP BY
- ✅ HAVING
- ✅ Aggregate Functions
- ✅ LIMIT
- ✅ OFFSET

---

# 🎯 SQL Patterns Learned

| Pattern | Purpose |
|---------|---------|
| String Formatting | Convert text into proper format |
| LIKE Pattern Matching | Search text using wildcards |
| REGEXP Validation | Validate strings using regular expressions |
| DELETE + Self Join | Remove duplicate rows |
| Scalar Subquery | Return a single value |
| GROUP_CONCAT() | Merge multiple rows into one string |
| GROUP BY + COUNT(DISTINCT) | Count unique values |
| JOIN + GROUP BY + HAVING | Aggregate and filter grouped data |

---

# 1️⃣ String Functions

String functions are used to manipulate and format text values.

### Functions Learned

- CONCAT()
- UPPER()
- LOWER()
- LEFT()
- SUBSTRING()

Example

```sql
SELECT
CONCAT(
UPPER(LEFT(name,1)),
LOWER(SUBSTRING(name,2))
)
FROM Users;
```

Used In

- Fix Names in a Table

---

# 2️⃣ CONCAT()

Combines multiple strings into a single string.

```sql
CONCAT(str1, str2, ...)
```

Example

```sql
CONCAT(first_name,' ',last_name)
```

---

# 3️⃣ UPPER()

Converts text into uppercase.

```sql
UPPER(name)
```

---

# 4️⃣ LOWER()

Converts text into lowercase.

```sql
LOWER(name)
```

---

# 5️⃣ LEFT()

Returns characters from the left side.

```sql
LEFT(name,1)
```

Example

```
John
↓

J
```

---

# 6️⃣ SUBSTRING()

Extracts part of a string.

```sql
SUBSTRING(name,2)
```

Example

```
John
↓

ohn
```

---

# 7️⃣ LIKE

Used for simple pattern matching.

Starts With

```sql
LIKE 'ABC%'
```

Ends With

```sql
LIKE '%ABC'
```

Contains

```sql
LIKE '%ABC%'
```

Word Matching

```sql
LIKE '% DIAB1%'
```

Used In

- Patients With a Condition

---

# 8️⃣ REGEXP

Used for advanced pattern matching.

Example

```sql
mail REGEXP
'^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$'
```

Regex Symbols

| Symbol | Meaning |
|---------|---------|
| ^ | Start of string |
| $ | End of string |
| [] | Character class |
| * | Zero or more |
| + | One or more |
| . | Any character |
| \\. | Literal dot |

Used In

- Find Users With Valid E-Mails

---

# 9️⃣ DELETE

Removes records from a table.

```sql
DELETE
FROM table_name
WHERE condition;
```

Used In

- Delete Duplicate Emails

---

# 🔟 Self Join

A table joined with itself.

Example

```sql
DELETE p2
FROM Person p1
JOIN Person p2
ON p1.email=p2.email
AND p1.id<p2.id;
```

Used when comparing rows of the same table.

---

# 1️⃣1️⃣ Scalar Subquery

Returns only one value.

Example

```sql
SELECT
(
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1
)
```

Used In

- Second Highest Salary

---

# 1️⃣2️⃣ LIMIT

Returns only a fixed number of rows.

```sql
LIMIT 1
```

---

# 1️⃣3️⃣ OFFSET

Skips rows before returning data.

```sql
LIMIT 1 OFFSET 1
```

Used for

- Second Highest Salary

---

# 1️⃣4️⃣ GROUP_CONCAT()

Combines multiple rows into one string.

```sql
GROUP_CONCAT(
DISTINCT product
ORDER BY product
SEPARATOR ','
)
```

Used In

- Group Sold Products By The Date

---

# 1️⃣5️⃣ GROUP BY

Groups rows having the same value.

```sql
GROUP BY sell_date
```

---

# 1️⃣6️⃣ HAVING

Filters groups after GROUP BY.

```sql
HAVING SUM(unit)>=100
```

---

# SQL Patterns Learned

## Pattern 1 — Proper Name Formatting

```sql
CONCAT(
UPPER(LEFT(name,1)),
LOWER(SUBSTRING(name,2))
)
```

Used In

- Fix Names in a Table


## Pattern 2 — Search Text

```sql
LIKE '%text%'
```

Used In

- Patients With a Condition


## Pattern 3 — Validate Email

```sql
REGEXP
'^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$'
```

Used In

- Find Users With Valid E-Mails

---

## Pattern 4 — Delete Duplicates

```sql
DELETE p2
FROM Person p1
JOIN Person p2
ON ...
```

Used In

- Delete Duplicate Emails

## Pattern 5 — Second Highest Value

```sql
ORDER BY salary DESC
LIMIT 1 OFFSET 1
```

Used In

- Second Highest Salary

## Pattern 6 — Merge Rows

```sql
GROUP_CONCAT(...)
```

Used In

- Group Sold Products By The Date

---

## Pattern 7 — Aggregate After Join

```sql
JOIN
↓

GROUP BY
↓

HAVING
```

Used In

- List the Products Ordered in a Period

---

# WHERE vs HAVING

| WHERE | HAVING |
|--------|---------|
| Filters rows | Filters groups |
| Executes before GROUP BY | Executes after GROUP BY |
| Cannot use aggregate functions | Can use aggregate functions |

Execution Order

```text
FROM
   ↓
WHERE
   ↓
GROUP BY
   ↓
HAVING
   ↓
SELECT
   ↓
ORDER BY
```

---

## ✅ Status

**Completed all 7 Advanced String Functions / Regex / Clause problems from LeetCode SQL 50.**

Progress: **50 / 50** 🚀
