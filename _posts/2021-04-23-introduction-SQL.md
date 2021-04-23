---
tags:
    - stat196k
---

- Write SQL queries

Quick facts

- A __query__ is a valid, complete SQL statement that produces a table from a database.
- SQL is case insensitive, so `SELECT * FROM table` is the same as `select * from table`.

Today, we will cover the basics of writing queries, which you must do to access data.
There's much more to it.
A DBA (database administrator) or data engineer might spend their entire career managing databases and doing all kinds of fun things with them.

SQL has a rich and interesting mathematical background, and you can learn about that in a class on databases.


## Basic

The most basic SQL query is

```sql
SELECT columns
FROM table
```

We'll add `LIMIT` to most of our results, because we're working with large data sets and we just want to see small samples.

Example:

```sql
SELECT *
FROM covidcast_data
LIMIT 10;
```


## Conditions

`WHERE` filters the rows produced by the query.

```sql
SELECT columns
FROM table
WHERE condition
```

Example:

```sql
SELECT *
FROM covidcast_data
WHERE geo_value = 'ca'
LIMIT 10;
```


We can combine multiple conditions using `AND` and `OR`.

```sql
SELECT columns
FROM table
WHERE condition1 AND condition2 AND condition3
```

Example:

```sql
SELECT *
FROM covidcast_data
WHERE geo_value = 'ca' AND time_value = 20210302
LIMIT 10;
```


## Ordering

`ORDER BY` returns the rows in sorted order.

```sql
SELECT columns
FROM table
ORDER BY columns
```

Example:

```sql
SELECT geo_value, COUNT(*) as number_obs FROM covidcast_data
WHERE geo_type = 'state'
GROUP BY geo_value
```


## Joins

Joins are the "killer feature" of databases.
They allow us to combine multiple tables into one.

```sql
SELECT table1.column, table2.column
FROM table1, table2
```

Example:

```sql
SELECT *
FROM covidcast_data, us_state_abbreviations AS states
WHERE covidcast_data.geo_value = LOWER(states.abbreviation)
LIMIT 10;
```

## Aggregation

`GROUP BY` allows us to calculate aggregate statistics on subgroups of data, such as the minimum, mean, or counts.

```sql
SELECT aggregating_function(col1), grouping_column
FROM table
GROUP BY grouping_column
```

Example:

```sql
SELECT geo_value, COUNT(*) as number_obs FROM covidcast_data
WHERE geo_type = 'state'
GROUP BY geo_value
```

