---
tags:
    - stat128
---

- Implement a function based on documentation
- Describe R's formula syntax, `y ~ x`
- Select rows of a data frame by index

123GO - what's your dream job?

Announcements:

- The standards for homework grading are high, to help you grow.
- I'll provide an example of a submission that would earn a full score.

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-09-18.Rmd)


## Defining Functions

Functions are the heart of R.
Everything in R is a function.
To really use R, we need to define our own functions.

Q: What's the mathematical definition of a function?

A: Maps an input to exactly one output. `input ---> output`

Last homework we found the data point that was closest to the mean.
Let's implement this in a general function, `closest_to_mean`.

Q: 123GO - What's a simple example we can test to verify the behavior of our function?
We need an input and output.

A: There are many ways. Here's one: `closest_to_mean(c(10, 11, 12))` should output `11`.

Let's write a placeholder for the function.

```{r}
#' Return the data point in `x` closest to the mean of `x`.
#'
closest_to_mean = function(x)
{
}
```

The empty braces `{}` after `function(x)` mean that this function doesn't do anything yet.
It's like a skeleton or outline, ready for implementation.
We can attempt to use it, and verify it doesn't do anything:

```{r}
> closest_to_mean(precip)
NULL
```

`NULL` means nothing.

In the last homework, we did this calculation for `precip`, and we can implement our function based on this code:

```{r}
diff_from_mean = abs(precip - mean(precip))
closest_index = which.min(diff_from_mean)
precip[closest_index]
```

The code above is written with `precip` as the input.
We need to change it so that `x` is the input, and stick it in the __body__ of the function, the part between the braces `{}`.

```{r}
#' Return the data point in `x` closest to the mean of `x`.
#'
closest_to_mean = function(x)   # <--- function name, arguments
{                               # <--- begin body
    diff_from_mean = abs(x - mean(x))
    closest_index = which.min(diff_from_mean)
    x[closest_index]            # <--- last line of body is the return value
}
```


