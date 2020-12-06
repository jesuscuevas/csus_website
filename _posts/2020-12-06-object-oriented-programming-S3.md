---
tags:
    - stat128
---

- Describe R's S3 object oriented programming system
- Define new methods for generic functions like `plot`
- Use `::`, the namespace operator, to find functions in a namespace

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-12-07.Rmd)

123 GO – What are you going to do when finals are over?

Announcements:

- next class Q&A on final project and review for final


## 

## How does `plot` work?

Set up:

```{r}
x = 1:10
y = x + rnorm(length(x))
h = hist(x, plot = FALSE)
fit = lm(y ~ x)
```

The function `plot` behaves differently depending on what kind of arguments we pass into it.

```{r}
par(mfrow = c(2, 2))
plot(x)
plot(x, y)
plot(h)
plot(fit, which = 1)
```

What's going on?
There must be a lot of code in `plot` to handle all of these different cases, right?
We can look at it, just print the function out:

```{r}
> plot
function (x, y, ...)
UseMethod("plot")
<bytecode: 0x7fcb48a5f638>
<environment: namespace:base>
```

No.
The entire `plot` function is just a single function call: `UseMethod("plot")`.
The actual implementation happens in the plotting methods, namely:

- `plot.default`
- `graphics:::plot.histogram`
- `stats:::plot.lm`

