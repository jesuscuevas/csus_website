---
tags:
    - stat128
---

- Describe R's type hierarchy
- Predict behavior from implicit coercion

Announcements:


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


## type hierarchy

Try to order these in terms of when it makes sense to coerce one type to another.

- logical `TRUE`
- integer `seq(5)`
- numeric `2.83`
- character `"hello"`


## Group activity

1. Explain what the value of a literal `NA` is, and why.
2. Why are these numbers not equal?
```
(0.1 + 0.05) == 0.15
```


https://stackoverflow.com/questions/9508518/why-are-these-numbers-not-equal
