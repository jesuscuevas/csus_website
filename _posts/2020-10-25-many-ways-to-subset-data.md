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

## index

```{r}
x[c(5, 9)]
```

And negative index:

```{r}
x[-c(5, 9)]
```

## logical

```{r}
x[x < 0.5]
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

```{r}
mtcars[
```


## index

```{r}
# First five rows
mtcars[1:5, ]

# First five columns
mtcars[, 1:5]
```

Negative index

```{r}
mtcars[-(1:5), ]

mtcars[, -(1:5)]
```


## names


