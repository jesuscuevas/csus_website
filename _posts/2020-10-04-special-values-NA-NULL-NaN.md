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

Your turn, predict the following:

```{r}
Inf + 1
2 * Inf
-1 * Inf
mean(c(Inf, 1, 2, 3))
```

## `NaN`

How about this?

```{r}
Inf - Inf
```

`NaN` stands for "Not a Number", because it's not well defined mathematically.

How about this `0/0`?

```{r}
zz = 0/0
```

Your turn, predict the following:

```{r}
NaN + 1
NaN - 1
2 * NaN
-1 * NaN
mean(c(NaN, 1, 2, 3))
```

If something is not well defined, then it will __propagate__ through further operations as an unknown.


## `NA`

```{r}
head(airquality)
```

What are these `NA` values that show up in the `Ozone` and `Solar.R` columns?

```{r}
class(airquality$Ozone)
```

It's something numeric, but it is not the same as `NaN`.
Any guesses?

`NA` represents missing data in a vector.
For me personally, `NA` is R's "killer feature" for data analysis.
Missing values are deeply baked into everything that R does.

`NA` values propagate like the others:

```{r}
NA + 1
2 * NA
x = c(NA, 1, 2, 3)
mean(x)
```

Some functions have an argument `na.rm` to remove `NA` values.

```{r}
mean(x, na.rm = TRUE)
```

We can always manually remove them.
```{r}
x2 = x[!is.na(x)]
x2
```
This selects the elements of `x` that are not `NA`.

```{r}
mean(x2)
```


## Imputing missing values

We might want to __impute__ the missing values, which means to fill them in based on some computation.
The easiest and most common thing to do is to replace the missing values with the mean.

Note the values we have before imputation:
```{r}
table(airquality$Ozone)
hist(airquality$Ozone)
```

Impute with mean
```{r}
o2 = airquality$Ozone
o2[is.na(o2)] = mean(o2, na.rm = TRUE)
hist(o2)
table(o2)
as.numeric(table(o2))
```

What do we notice about the new values?
The mean got imputed.


## `NULL`

```{r}
p = plot(1:10)
```

What should `p` be?
It's not a ggplot object, all we did was change what we see on the graphics device.
There's no object at all associated with this.
Yet every function must return something.
We need a placeholder representing "no object".
That's `NULL`.

Why do we need such an object?
One use case is so we can check when it appears using `is.null`, and then write our code to handle these cases.


## Testing for special values

Above we used `is.na(x)` to test for `NA` elements.
What is wrong with the following?

```{r}
x == NA
```

It does elementwise comparison with a missing value.
Because of the propagation rules, this is __always__ `NA`.
Here's the right way:

```{r}
is.na(x)
```

Similarly, see `is.nan`, `is.finite`, `is.null`, etc.


## Other special values

There are a few other values you might consider "special".

0 length vectors
```{r}
numeric()
```

Empty strings
```{r}
s = ""
```


## Summary

Sometimes arithmetic doesn't work out.
If this happens, then we might get one of the numeric special values.

- `Inf` means infinity
- `NaN` means "Not a Number"

There are two other more general special values.

- `NA` represents missing values in a vector
- `NULL` is a placeholder for ambiguous objects
