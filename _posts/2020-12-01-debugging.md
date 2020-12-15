---
tags:
    - stat128
---

- Write wrapper functions
- Debug functions that you write

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-12-04.Rmd)

123 GO – What's one item on your Christmas wish list?

Announcements:



## Wrapper functions

Suppose I want to take an existing function and modify it slightly, say by giving the function arguments different defaults.
For example, `pnorm` calculates the cumulative distribution function for the normal distribution:

```{r}
x = seq(from = -4, to = 4, by = 0.1)
plot(x, pnorm(x))

lines(x, pnorm(x, sd = 2))
```

I want to create a function `pnorm2` that behaves just like `pnorm`, but has the default standard deviation (sd) set to 2.
In other words, `pnorm2(x)` should behave exactly like `pnorm(x, sd = 2)`.
How can I do this?

Work through ways...

```{r}
pnorm2 = function(..., sd = 2)
{
    pnorm(..., sd = sd)
}
```

## Group activity

Write a wrapper for `hist` that changes the default title (parameter `main`)to "HISTOGRAM".


## Debugging

References:

- [Debugging in Advanced R](http://adv-r.had.co.nz/Exceptions-Debugging.html)
- [Debugging with Rstudio](https://support.rstudio.com/hc/en-us/articles/200713843?version=1.3.1073&mode=desktop)

If you want to be a good software developer, then learn to debug.

What's a bug in software?

Four kinds of bugs:

1) Syntax Errors- The code isn't syntactically valid R.
1) Runtime Errors- the code throws an error in the middle of evaluation.
2) Code runs, but gives you something obviously incorrect.
3) Code runs, and everything seems fine, but it's wrong.

123 GO - which are the easiest to fix?
The syntax and runtime errors.
The last class is *much* harder to identify and fix.
So you should be happy that you get an error :)


## Errors

The following function from our course Discord history contains at least one error:

```{r}
high = function (x)
{
    win = (x > 18 = 0) & (!x = 0)
    ifelse(win, 1, -1)
}

high(0:36)
```

When we try to run it, we see a mysterious error: `Error in x > 18 = 0 : could not find function "><-"`.
This message tells us exactly where the problem is.
Where is it? 
The expression `x > 18 = 0`.


## Explaining this particular error

123 GO - Is this a syntax or a runtime error?
Runtime, unfortunately.
In this case, R attempted to do functional assignment by pasting together the function call to `>` with the assignment operator `<-` to form a new function call `><-`.
Assignment with `[` behaves the same:

```{r}
x = 1:3
x[1] = 0

# equivalently:
x = `[<-`(x, 1, 0)
```

The error is that the function `><-` is not defined, so R cannot find it.
It doesn't make much sense at all to define such a function, but if we did, then the code would run:

```{r}
`><-` = function(a, b, value) paste("This is crazy.", value)

x > 18 = 0

# > x
# [1] "This is crazy. 0"

rm(`><-`) # Don't let this mess up the lesson :)
```

Bugs happen for a reason, but it takes the right background to understand them.


## Debugging




## Ignoring Errors
