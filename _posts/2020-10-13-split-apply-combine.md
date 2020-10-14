---
tags:
    - stat128
---

- Split data, apply functions, and combine results

Announcements:

- Data science panel Friday, thanks for submitting questions
- Homework hint- for the questions on the martingale, it may be easiest to modify the `doublebet` strategy function.
    Ask me on Discord and I'll help you with this, because we haven't covered control flow like loops and conditional statements.

Resources:

- [The Split-Apply-Combine Strategy for Data Analysis](https://www.jstatsoft.org/article/view/v040i01) by Hadley Wickham

## Review

Last class we looked again at the roulette simulations.

```{r}
source("https://raw.githubusercontent.com/clarkfitzg/stat128/master/roulette.R")

set.seed(1380)
d = play(simple_strategy(even), nplayers = 500L, ntimes = 1000L)
```

Our eventual goal was to compute a couple summary statistics for every value of time in a specific form, so we wrote a function `summary_at_time` to do this for one particular time.

```{r}
#' Returns several summary statistics at a particular time
#'
#' @param dt data frame with only one distinct time value
#' @return output: data frame with one row containing columns mean, sd, and time
summary_at_time = function(dt)
{
    time = unique(dt$time)
    data.frame(time, mean = mean(dt$winnings), sd = sd(dt$winnings))
}
```

We can use our function as follows:

```{r}
d1 = d[d$time == 1, ]
s1 = summary_at_time(d1)
```

Let's do a few more time points.

```{r}
d2 = d[d$time == 2, ]
s2 = summary_at_time(d2)
d3 = d[d$time == 3, ]
s3 = summary_at_time(d3)
```

`s1`, `s2`, and `s3` contain the data we want, so we just need to "stack" all these data frames into one using `rbind`, and then we can make our plot, at least for three data points.

```{r}
rbind(s1, s2, s3)
```

We have 1000 times to do, so we need to repeat the above code 1000 times, right? 😜

```{r}
s1 = summary_at_time(d[d$time == 1, ])
s2 = summary_at_time(d[d$time == 2, ])
s3 = summary_at_time(d[d$time == 3, ])
s4 = summary_at_time(d[d$time == 4, ])
s5 = summary_at_time(d[d$time == 5, ])
s6 = summary_at_time(d[d$time == 6, ])
s7 = summary_at_time(d[d$time == 7, ])
s8 = summary_at_time(d[d$time == 8, ])
# ...
```

No way!
There's a better way.
Recall the DRY principle- "Don't Repeat Yourself"

## `lapply`

`lapply` is used to apply the same function to many data elements.
Let's see it in action.

What does `seq` do?

```{r}
seq(2)
seq(5)
```

Suppose we need many sequences.

```{r}
seq15 = lapply(1:5, seq)
```

## lists

What is this `seq15` object?
Could it be in a data frame?
Columns in a data frame should all have the same length, so it doesn't make sense to put it in a data frame.

```{r}
class(seq15)
```

It's a `list`, which is a general purpose data container.
Any element of a list can be any kind of object, including another list.
```{r}
seq15[[2]] = letters
```

Q: It's often more convenient to have results in a data frame or vector, so why return a list?
A: Because the list is so general, it's always safe for `lapply` to return a list.
    It means `lapply` doesn't need to make any assumptions about what your code does, and this is a great general principle in software engineering:
    Make as few assumptions as you can :)


## `lapply` details

`lapply` is roughly equivalent to this code:

```{r}
lapply_idea = function(X, FUN, ...)
{
    result = vector(mode = "list", length = length(X))
    for(i in X){
        result[[i]] = FUN(X[[i]], ...)
    }
    result
}

lapply_idea(1:5, seq)
```

You might ask, why use `lapply` instead of just a loop then?
There are a few answers:

1) `lapply` uses less code than the loop, which means less opportunities for bugs.
2) `lapply` is fast and idiomatic.
3) `lapply` is easy to make faster through parallel programming.


## `split`

We have a data frame with `time` as a column.
If we could split our data frame apart into a list based on the unique values in the `time` column, then we would be able to use our function with `lapply`.
Let's try `split`.

```{r}
ds = split(d, d$time)
```

`ds` should have as many elements as the distinct elements in the time column.
Let's verify.

```{r}
length(unique(d$time))

length(ds)
```

Let's take a look at some element in `ds`.
It should be a data frame where all the `time` values are the same.

```{r}
head(ds[[234]])
```

Wonderful, now we can apply our summary function.

```{r}
ds2 = lapply(ds, summary_at_time)

head(ds2)
```

## Combining

We have our result, we just need to combine all the rows together.
`rbind` works just fine to combine the first few:

```{r}
rbind(ds2[[1]], ds2[[2]], ds2[[3]], ds2[[4]])
```

But we're not going to put 1000 numbers in there- that would violate DRY.
How do we do it?
Check out the documentation for `rbind`.

```{r}
?rbind

rbind(..., deparse.level = 1, make.row.names = TRUE,
    stringsAsFactors = default.stringsAsFactors(), factor.exclude = TRUE)

Arguments:

     ...: (generalized) vectors or matrices.
```

The first argument is `...`, read as "dot-dot-dot" or "ellipsis".
This means `rbind` accepts an arbitrary number of arguments, and operates on them all, which is a general idiom in R.

We want ALL of the elements in `ds2` to appear as arguments to `rbind`.
In other words, we have a function to call, and a list of all the arguments that we would like to call that function with.
That's the purpose of `do.call`.

```{r}
dfinal = do.call(rbind, ds2)
```

This says, call the function `rbind` with the arguments in `ds2`.
Let's look at it and make sure it's what we want.
NEVER assume something worked :)

```{r}
dim(dfinal)
head(dfinal)
tail(dfinal)
```


## Putting it all together

`d` contains all our data.

```{r}
ds = split(d, d$time)
ds2 = lapply(ds, summary_at_time)
dfinal = do.call(rbind, ds2)
```

In the future we'll look at packages data.table and dplyr, they can make this kind of operation simpler and faster.
The purpose of studying it in detail is to learn the concepts, along with some standard R idioms.

Now we can happily create our plot with ggplot2.

```{r}
library(ggplot2)

g = ggplot(data = dfinal, mapping = aes(x = time, y = mean)) +
    geom_line()

print(g)
```
