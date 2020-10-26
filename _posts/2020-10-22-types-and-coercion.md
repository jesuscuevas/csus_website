---
tags:
    - stat128
---

- Describe R's type hierarchy
- Predict behavior from implicit coercion

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-23.Rmd)

## classes and types

The `class` of an object describes how it behaves.

```{r}
d = Sys.Date()
class(d)
typeof(d)
```

`d` is a `Date`, stored as a double precision floating point number.
Because it's an object of class `Date`, it makes sense to call a function that works on dates.

```{r}
weekdays(d)
```

The `type` of an object describes how it is stored.
Sometimes they're the same.
Today, we're talking more about `types`.


## doubles

Most numeric calculations in any language happen with __double precision floating point numbers__.
These are an efficient way to approximately represent real numbers using 64 bits (1's and 0's).
The details are beyond the scope of this class, but we can get a taste of them.

Doubles do NOT have the same properties as the real numbers, and this can be disconcerting if you've studied lots of math.
We can only use 64 bits.
This implies:

- There are a finite number of them, not more than `2^64`
- There is a maximum and a minimum

```{r}
# Epsilon
.Machine$double.eps

# 52 digits in mantissa
1 / (2^52)
```


## explicit coercion

We can explicitly coerce, or convert, between types.

```{r}
dc = as.character(Sys.Date())
class(dc)

paste(dc, "is a wonderful day to learn about coercion.")
```


## implicit coercion

What will happen if I don't explicitly change the object to the right type?

```{r}
paste(Sys.Date(), "is a wonderful day to learn about coercion.")
```

Suppose we add several objects of different types together.
What happens?

```{r}
typeof(1L)
typeof(TRUE)
typeof(1.0)

TRUE + 1L

1L + 1.0

TRUE + 1L + 1.0
```


## type hierarchy

Try to order these in terms of when it makes sense to coerce one type to another.

- character `"hello"`
- logical `TRUE`
- numeric `2.83`
- integer `seq(5)`


## Group activity

Alphabetically, first person's turn to explain

1. Explain what is the type of a literal `NA`, and why?
2. Why are these numbers not equal?
```
(0.1 + 0.05) == 0.15
```
3. What is the type of an object with class `data.frame`, and what does this imply?


https://stackoverflow.com/questions/9508518/why-are-these-numbers-not-equal
