# LeetCode 1517 - Find Users With Valid E-Mails

## Difficulty

**Easy**

---

# 📝 Question

Find all users whose email addresses are **valid** according to the given rules.

Return the complete user information (`user_id`, `name`, and `mail`).

---

# 📖 Easy Understanding

A valid email must satisfy **all** of these rules:

1. The username **must start with a letter** (`A-Z` or `a-z`).
2. After the first letter, it may contain:

   * Letters (`A-Z`, `a-z`)
   * Digits (`0-9`)
   * Underscore (`_`)
   * Dot (`.`)
   * Hyphen (`-`)
3. The email **must end with** `@leetcode.com`.

---

## Example

### Input

| user_id | name      | mail                                                |
| ------: | --------- | --------------------------------------------------- |
|       1 | Winston   | [winston@leetcode.com](mailto:winston@leetcode.com) |
|       2 | Jonathan  | jonathanisgreat                                     |
|       3 | Annabelle | [bella-@leetcode.com](mailto:bella-@leetcode.com)   |
|       4 | Sally     | [1sally@leetcode.com](mailto:1sally@leetcode.com)   |
|       5 | Bob       | [bob@gmail.com](mailto:bob@gmail.com)               |


### Output

| user_id | name      | mail                                                |
| ------: | --------- | --------------------------------------------------- |
|       1 | Winston   | [winston@leetcode.com](mailto:winston@leetcode.com) |
|       3 | Annabelle | [bella-@leetcode.com](mailto:bella-@leetcode.com)   |

---

# Problem Summary

We need to:

* Check whether an email follows the required format.
* Keep only valid emails.
* Ignore invalid emails.

---

# Key Observation 

Instead of checking every character one by one, we use **Regular Expressions (REGEXP)**.

```text
Users Table
      │
      ▼
Check Email Format
      │
      ▼
   REGEXP
      │
      ▼
Valid Email?
      │
 ┌────┴────┐
 │         │
Yes       No
 │         │
Keep    Ignore
```

---

# Approach

### Step 1

Read every email.

### Step 2

Check whether it matches the required pattern.


### Step 3

Return only valid emails.

---

# Solution

```sql
SELECT *
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$';
```

> **Note:** Some MySQL environments treat `REGEXP` as case-insensitive. On LeetCode, if a test with `@leetcode.COM` fails, use `REGEXP_LIKE(..., 'c')` (case-sensitive). The regex pattern itself remains the same.

---

# Query Breakdown

## Step 1

```sql
SELECT *
```

Return all columns.

Output:

* user_id
* name
* mail

## Step 2

```sql
FROM Users
```

Read data from the `Users` table.

## Step 3

```sql
WHERE
```

Filter only those rows whose email is valid.


## Step 4

```sql
mail REGEXP
```

`REGEXP` compares a string with a **Regular Expression (Regex)**.

If the email matches the pattern → Keep the row.

Otherwise → Remove it.

---

# Understanding the Regex

```regex
^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$
```

Let's break it into parts.


## Part 1

```regex
^
```

### Meaning

Start checking from the **beginning of the string**.

Example

```text
abc@leetcode.com
^
```

Checking starts from `a`.


## Part 2

```regex
[A-Za-z]
```

### Meaning

The **first character must be a letter**.

Allowed

```text
A
B
Z
a
b
z
```

Not Allowed

```text
1
@
_
.
-
```

Example

```text
abc@leetcode.com
^
```

`a` is a letter ✅


Example

```text
1abc@leetcode.com
^
```

`1` is not a letter ❌

Reject.


## Part 3

```regex
[A-Za-z0-9_.-]*
```

### Meaning

After the first letter, the username may contain:

* Letters
* Numbers
* `_`
* `.`
* `-`

The symbol

```regex
*
```

means

> **Zero or more times**

Examples

```text
abc123
```

✅ Valid


```text
abc_123
```

✅ Valid


```text
abc.-_
```

✅ Valid

```text
abc#123
```

❌ Invalid (`#` is not allowed)


## Part 4

```regex
@leetcode\.com
```

### Meaning

The email **must contain exactly**

```text
@leetcode.com
```

Examples

```text
abc@leetcode.com
```

✅ Valid


```text
abc@gmail.com
```

❌ Invalid



### Why `\.` ?

In Regex,

```regex
.
```

means

```text
Any Character
```

Examples

```text
a
1
#
@
```

all match `.`.

But we need the actual dot (`.`).

So we escape it:

```regex
\.
```

Inside a SQL string, backslash itself must be escaped.

So we write:

```sql
\\.
```


## Part 5

```regex
$
```

### Meaning

The string **must end here**.

Nothing should appear after

```text
@leetcode.com
```

Example

```text
abc@leetcode.com
                $
```

✅ Valid


Example

```text
abc@leetcode.com.in
```

❌ Invalid

Because extra `.in` appears after `.com`.

---

# Complete Regex Meaning

```text
^
│
Start

↓

[A-Za-z]
│
First character must be a letter

↓

[A-Za-z0-9_.-]*
│
Remaining username

↓

@leetcode.com
│
Fixed domain

↓

$
│
End of string
```

---

# Dry Run

### Input

| Email                                               |
| --------------------------------------------------- |
| [winston@leetcode.com](mailto:winston@leetcode.com) |
| [1abc@leetcode.com](mailto:1abc@leetcode.com)       |
| [abc_123@leetcode.com](mailto:abc_123@leetcode.com) |
| [abc@gmail.com](mailto:abc@gmail.com)               |
| abc#[123@leetcode.com](mailto:123@leetcode.com)     |
| [abc@leetcode.com.in](mailto:abc@leetcode.com.in)   |

### Check 1

```text
winston@leetcode.com
```

Starts with letter ✅

Username valid ✅

Correct domain ✅

Ends correctly ✅

✔ Keep


### Check 2

```text
1abc@leetcode.com
```

Starts with number ❌

Remove


### Check 3

```text
abc_123@leetcode.com
```

Starts with letter ✅

Allowed characters ✅

Correct domain ✅

✔ Keep


### Check 4

```text
abc@gmail.com
```

Wrong domain ❌

Remove


### Check 5

```text
abc#123@leetcode.com
```

`#` not allowed ❌

Remove


### Check 6

```text
abc@leetcode.com.in
```

Extra `.in` ❌

Remove


## Final Output

| Email                                               |
| --------------------------------------------------- |
| [winston@leetcode.com](mailto:winston@leetcode.com) |
| [abc_123@leetcode.com](mailto:abc_123@leetcode.com) |

---

# SQL Concepts Used

| Concept  | Purpose                                   |
| -------- | ----------------------------------------- |
| `REGEXP` | Match a string using a regular expression |
| `^`      | Start of string                           |
| `$`      | End of string                             |
| `[]`     | Character set (allowed characters)        |
| `*`      | Zero or more repetitions                  |
| `.`      | Any character in regex                    |
| `\.`     | Match a literal dot (`.`)                 |


---
---
---


## ⚠️ Note

LeetCode accepts the following solution because `REGEXP_LIKE()` with `'c'` performs **case-sensitive** matching.

```sql
SELECT *
FROM Users
WHERE REGEXP_LIKE(
    mail,
    '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\\.com$',
    'c'
);
```

* `'c'` → **Case-sensitive match**
* Rejects emails like `winston@leetcode.COM`
* Accepts only emails ending with **`@leetcode.com`** exactly.

---
---
---

# doubt of  `\\.` use 

## Step 1: Tum kya match karna chahte ho?

Email me ye part:

```text
@leetcode.com
```

Isme ek **dot (`.`)** hai.

Tum bas ye dot match karna chahte ho.



## Step 2: Problem kya hai?

Regex language me **dot (`.`)** ka matlab **dot nahi hota**.

Regex me

```text
.
```

ka matlab hota hai

> **Koi bhi ek character**

Example:

```
a
1
@
#
$
```

Ye sab `.` se match ho sakte hain.


## Step 3: Agar main likhu

```text
@leetcode.com
```

Regex isko aise samjhega:

```
@leetcode(any character)com
```

To ye galat emails bhi accept kar dega.

Example:

```
@leetcodeXcom   ✅
@leetcode1com   ✅
@leetcode#com   ✅
```

Hume ye nahi chahiye.


## Step 4: To real dot kaise likhen?

Regex ko bolte hain:

> "Ye special dot nahi, **real dot** hai."

Uske liye dot ke aage backslash lagate hain.

```
\.
```

Bas itna yaad rakho:

```text
.   → Any character

\.  → Real dot (.)
```



## Step 5: Ab `\\.` kahan se aaya?

Ye SQL ki wajah se aaya.

Hum regex ko SQL ke andar string ke form me likhte hain.

```sql
'@leetcode\\.com'
```

SQL isko andar hi andar convert kar deta hai:

```text
@leetcode\.com
```

Aur regex fir isko samajhta hai:

```text
@leetcode.com
```

---

## Isko abhi aise hi yaad kar lo 📌

```
Regex:
\.  = Real dot

SQL:
\\. = Regex wala \.
```
