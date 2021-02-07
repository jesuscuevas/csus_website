---
tags:
    - stat128
---

- Write reproducible data analyses
- Maintain consistency between written code and global environment
- Ask precise questions about programming
- Predict when variables will be available in function bodies and global environment

Announcements:

- Glad to see more code and chatter in the Discord.
    It's good to post your broken code here, so we can fix it.


Resources:

- Stack Overflow on [minimal reproducible example](https://stackoverflow.com/help/minimal-reproducible-example)

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-09-21.Rmd)


## Sharing workflow tips in RStudio

Workflow is __how__ you develop your programs.
Workflow can make the difference between a pleasant experience and endless frustration.

How are you currently using RStudio?
What is working, and what are you struggling with when you write your code?
Work in your (new semipermanent!) small groups and come up with one thing that works, and one place where you're having trouble.
Share with the class.


## How to ask a precise question

When asking questions, copy and paste the code and output that gives you trouble.
Not a screenshot, unless you're asking about 
For example...

Example should be minimal, complete, and reproducible.


## Reproducible data analyses

These are two separate stages to writing a report: development, and producing the final report.

Q: When you go to produce your final report, should it matter what you have in your global environment?

A: NO. The code should contain everything to perform the analysis, so that it's self contained, and other people can run it and see what it does.
Other people includes future you. :)

Q: Can you think of anything that should not be contained in the code, but rather kept private?

A: Passwords! For example, some data sources require authentication.

When you are developing a report with Rmarkdown, you can use the interactive R console to help you understand, check, verify, and quickly experiment.

When you knit an Rmd document, or run an R script, a new R session starts up and runs every line of code in order.
That's all it does.
For the final report to work, all the code must be in chunks in the right order in the Rmd document.
Because it's a new R session, any of the objects in your global environment

It's possible that the state of your global environment does not match the state of your program when you run all the chunks.
Rstudio has a bunch of ways for you to run chunks.

Some chunks may not be finished.
In this case, you should use comments, prefacing your code with `#`.

Q: Check them out. Which method is most similar to what happens 
One handy feature is "Restart R and Run all chunks", since this is most similar


## Function Scope

Last lecture introduced writing functions with some simple examples.
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
