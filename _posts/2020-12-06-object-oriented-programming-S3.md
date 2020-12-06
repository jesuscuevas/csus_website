---
tags:
    - stat128
---

- Define new methods for generic functions like `plot`
- Use `::` and `:::` to find objects in a namespace
- Predict when 

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-12-07.Rmd)

123 GO – What are you going to do when finals are over?

Announcements:

- next class Q&A on final project and review for final


## The search path

When we start a fresh R session, there are no objects in our global workspace.
We can check with `ls`, list objects.

```{r}
ls()
```

In particular, there are no functions.
Yet we can still call functions, like `ls`.
What's going on?
R must be finding these functions somewhere.

R finds objects by looking through packages in a particular order.
That order is called the __search path__, and we can inspect it with `search()`.

```{r}
> search()
[1] ".GlobalEnv"        "package:stats"     "package:graphics"
[4] "package:grDevices" "package:utils"     "package:datasets"
[7] "package:methods"   "Autoloads"         "package:base"
```

Every time R encounters an object name it looks through the search path to find that object.
For example, `ls` comes from the base package, which we see in the bottom of the function implementation if we print it out:

```{r}
> ls
function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE,
    pattern, sorted = TRUE)
{
    if (!missing(name)) {

    ... Omitting implementation

    else all.names
}
<bytecode: 0x7fcb45630d68>
<environment: namespace:base>    # <--- Where this function was defined
```

To find `ls`, R first searched in our global environment.
R didn't find `ls` in the global environment, so it moved on to the next entry in the search path, the stats package.
R didn't find `ls` in the stats package, so it moved on to the graphics package.
And so on, all the way down to the very last place, the base package.

Suppose we define our own `ls` function.

```{r}
ls = function(...) "Bad idea. How you gonna find the other ls()?"
```

123 GO: What will happen?

```{r}
ls()
```

R looked first in the global environment, found our newly defined `ls`, and used it.
We can use `::`, the namespace operator, to pick out an object from a namespace.

```{r}
base::ls()
```

Our new definition of `ls` didn't change `ls` in the base package- that would be crazy if it did. :)

123 GO: What do you think will happen to my search path after attaching a package with `library`?

```{r}
search()
library(ggplot2)
search()
```

How can this error happen?

```{r}
> foo
Error: object 'foo' not found
```

R looks through everything in the search path, and doesn't find the object `foo`.
That's the only way.


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
plot(exp)
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
- `grahpics::plot.function`
- `graphics:::plot.histogram`
- `stats:::plot.lm`

In contrast to `::`, the `:::` "triple colon" picks out objects which are not exported from packages.
These objects are not exported by design- everything works fine without them.
You shouldn't use `:::` in your own code, but it's useful to understand where the objects are, and for debugging.

Let's look at the class of `x`, `h`, and `fit` to see what's going on.

```{r}
class(x)
class(h)
class(fit)
```

R's S3 object oriented system is informal, and it dispatches on the class of the object.
For example:

```{r}
plot(h)

graphics:::plot.histogram(h)
```

In other words, `plot` does the right thing when we pass in an object with class `histogram`.
Why is this behavior useful?

- Users have to remember fewer functions
- The language stays at a higher level

We can extend this system by defining our own methods.
For example, suppose we want to attach units to a numeric vector, say seconds.
There are packages to do this, so this is just an example.

Here's a direct way to create an object with a new class.
Usually, we would write a constructor function, but one step at a time.

```{r}
x = 1:10
class(x) = c("units", class(x))
attr(x, "units") = "seconds"
```

Our method definition sets the x label based on the units, and then calls the next method.

```{r}
plot.units = function(x, y, xlab = attr(x, "units"), ...)
{
    NextMethod(xlab = xlab)
}
```

`NextMethod` does some deep stuff, but it amounts to calling the next method for `plot` with all the same arguments, except with a new default for `xlab`.

Let's use the method:

```{r}
y = rnorm(length(x))
plot(x, y)
```

Because of the way that we wrote our method, we can still override the behavior:

```{r}
plot(x, y, xlab = "SEC")
```
