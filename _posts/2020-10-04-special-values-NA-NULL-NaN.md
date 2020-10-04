---
tags:
    - stat128
---

- Compare and contrast special values `Inf`, `NaN`, `NA`, `NULL`
- Predict propagation of `NA` through vectorized operations
- Test for presence of special values

Announcements:

- Data science career panel coming up next Friday.

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-05.Rmd)

References:


## `Inf`

What does the graph of `1/x` look like?

```{r}
curve(1/x)
```

What is the value of `1/0`?

```{r}
oz = 1/0
```

```{r}
?Inf
```

> The basic rule should be that calls and relations with ‘Inf’s really are statements with a proper mathematical _limit_.


## `NaN`

## `NA`


## `NULL`

```{r}
p = plot(1:10)
```


## Propagation of special values


## Testing for special values


## 0 length vectors


## Summary

Sometimes arithmetic doesn't work out.
If this happens, then we might get one of the numeric special values.

- `Inf` means infinity
- `NaN` means "Not a Number"

There are two other more general special values.

- `NA` represents missing values in a vector
- `NULL` is a placeholder for ambiguous objects
