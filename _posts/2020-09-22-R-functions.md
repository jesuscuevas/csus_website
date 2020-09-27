---
tags:
    - stat128
---

- Predict when variables will be available in function bodies and global environment
- Determine whether a function is vectorized.

Announcements:

- Recall late policy on assignments.
- Minor change to question on HW template just now

Assignment feedback

- Many discovered the formula interface for `plot(y ~ x, data = d)`.
- Only necessary to convert date column one time at the beginning of your analysis.
- Summaries are fine, but don't print long vectors.
- Color should be semantically meaningful. We'll talk about color in graphs next week.
- `x == "TRUE"` You probably will never need to do this, and you certainly never need to do this: `x == TRUE`

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-09-23.Rmd)


## Function Scope

Last week lecture introduced writing functions with some simple examples.
Let's get a little deeper into what's actually happening.
Suppose you __define__ the function:

```{r}
axpy = function(x, a = 1, y = 0)
{
    a*x + y
}
```

123 GO: Look at the function body, and predict the result of the following call:

```{r}
axpy(x = 10, a = 5, y = 2)
```


123 GO: What arguments does `axpy` accept?

A: `x, a, y`.

What happens when we don't specify some of these arguments?
For example, we might write:

```{r}
axpy(x = 10, y = 2)
```

`a = 1` is a __default value__, so when we don't specify a value for `a`, the function uses this default.

When R calls a function, it goes through and runs every line until it hits a `return()` or the very last line, which it returns as a result.
The R code inside the function can freely use the arguments, `x, a, y`, which are the only variables in the __call frame__, which you can think of informally as the set of all variables that are specific to a particular function call.

```{r}
axpy = function(x, a = 1, y = 0)
{
    print(a)
    a*x + y
}
```

Columns as variable names make sense in the context of a data frame, so you can think of a data frame as similar to a call frame.
For example, `trees` is a data frame included with R, and it has columns `Volume` and `Height`, so it makes sense to write:

```{r}
with(trees, Height + Volume)
```

We access columns `Volume` and `Height` as variables.

Suppose we define a new variable `ax` in our function.

```{r}
axpy = function(x, a = 1, y = 0)
{
    ax = a*x
    ax + y
}
```

123 GO: Do you think this variable will exist in our global environment?

A: No.
It exists only in the function's __scope__.
My dictionary defines "scope" as: "the extent of the area or subject matter that something deals with or to which it is relevant."
Scope in functions is the same idea.
The variable `ax` only makes sense within the body of `axpy`, and outside it has no meaning.
We can verify that there's no global definition by trying to look it up in the console:

```{r}
> ax
Error: object 'ax' not found
```

### Globals

We can go the other way by using global variables inside our functions, and it will work:

```{r}
z = 100
axpy2 = function(x, a = 1, y = 0)
{
    a*x + y + z
}

axpy2(10)
```

In other words, `z` is not an argument to `axpy2`, but R found it in our global environment when we evaluated the function.

Q: How can this behavior hurt us?

A: Using global variables unintentionally is one of the most common kinds of errors.
For example, you're doing the reasonable thing of modifying some existing code to put it into a function, and you forget to change one of the variable names:

```{r}
#' Return the data point in `x` closest to the mean of `x`.
#'
closest_to_mean = function(x)
{
    diff_from_mean = abs(x - mean(x))
    closest_index = which.min(diff_from_mean)
    precip[closest_index]            # <--- FORGOT TO CHANGE TO X!!!!!! }
``` 

Beware :)

One way you can find globals, and check if all looks as it should, is:

```{r}
> library(codetools)
> findGlobals(closest_to_mean)
[1] "-"         "["         "{"         "="         "abs"       "mean"
[7] "precip"    "which.min"
```

`precip` is out of place, compared to the standard builtin functions.
We may talk more about this in a future lecture.


### Vectorized functions

At a high level, vectorized functions work elementwise on vectors.
The following are all examples of vectorized functions:

```{r}
# Something to work with:
x = 1:10

# Vectorized functions:
x + 1
2 * x
x < 5.6
```

We can also use them with several vectors at once.

```{r}
y = 2 * x

x + y
x - y
x * y
```

Vectorized functions make your R code clean to read and fast to run.
