---
tags:
    - stat128
---

- Describe the use cases for different ways to select subsets of data

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-26.Rmd)

Announcements:

Midterm in two parts.
In class part of midterm through Canvas quizzes on Friday, October 30th.
Multiple choice / true false, etc.
Low stakes, low pressure.
Take home part of midterm due Sunday, November 1st.
Let me know ASAP if you have technical / internet / scheduling issues.
Watch the review videos, the questions will be on those concepts.


Plan today:

- Review mid quarter check in.
- Showcase some of the unique plots from Q3 in the Roulette homework.
- Group activity to review all the ways to subset a data frame.

Goal today is to step back and review / compare and contrast all the ways we know to select subsets of a data frame.

## Group activity

Come up with all the ways you know how to select subsets of a vector or data frame.
We'll do examples with the `mtcars` data set, because cars are on my mind right now. 😁
We'll take what you come up with and try to make a somewhat comprehensive list of the ways to subset a data frame.


# Vectors

Here's a vector for us to play with.

```{r}
x = 1:10 / 10
```

## logical

```{r}
x[x < 0.5]
```

## index

```{r}
x[c(5, 9)]
```

And negative index:

```{r}
x[-c(5, 9)]
```

## names

If the vector has names we can use them.

```{r}
x = seq_along(letters)
names(x) = letters

x[c("a", "b")]
```


# Data Frames

Recall the general form is 

```{r}
DATA[ROWS, COLUMNS]
```


## logical

Selection through logical critieria is the most generally useful for data analysis.

For example, "cars that have greater than 30 mpg"

```{r}
mtcars[30 < mtcars$mpg, ]
```

Some variants:

```{r}
subset(mtcars, 30 < mpg)

with(mtcars, mtcars[30 < mpg, ])
```


## index

```{r}
# First five rows
mtcars[1:5, ]

# First four columns
mtcars[, 1:4]

# columns and rows
mtcars[1:5, 1:4]
```

Negative index

```{r}
mtcars[-(1:5), ]

mtcars[, -(1:5)]
```


## names

```{r}
mtcars[, "mpg"]

mtcars["Honda Civic", ]

mtcars["Honda Civic", "mpg"]
```

Then there is the `$` operator.

```{r}
mtcars$mpg
```

Will this partial match work?

```{r}
mtcars$mp
```

Yes- it's useful for interactive situations, say when a column name has 20 characters.
Check out the difference between `[` and `$` if we try to use a column that doesn't exist.

```{r}
mtcars$stat128

mtcars[, "stat128"]
```
