---
tags:
    - stat128
---

- Create data visualizations using ggplot2
- Explain the idea of declarative graphics

Announcements:

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-02.Rmd)

References:

- [R for Data Science Visualization chapter](https://r4ds.had.co.nz/data-visualisation.html)

<iframe width="560" height="315" src="https://www.youtube.com/embed/uiTc55clwuA" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


## Context

CRAN is the "Comprehensive R Archive Network".
If you write a package in R, you can share it publicly through CRAN.

Check out the [ggplot2 CRAN page](https://cran.r-project.org/package=ggplot2).
Any idea what all those "reverse depends", "reverse imports" mean?
This is the most downloaded package on CRAN behind Rcpp.
Many packages use Rcpp "under the hood", so it's fairly safe to say that ggplot2 is the most popular package on CRAN catered to end users.


## ggplot2 philosophy

From CRAN page, ggplot2 is:

> A system for 'declaratively' creating graphics, based on "The Grammar of Graphics".
> You provide the data, tell 'ggplot2' how to map variables to aesthetics, what graphical primitives to use, and it takes care of the details.

In other words, ggplot2 is designed to be high level.
You tell ggplot2 what to do, not how to do it.

This works well for at least 90% of applications.
Occasionally you want to change low level details, and you'll have to use a lower level tool, like the grid package, which ggplot2 is built on.
With grid, you get access to all the internals, i.e. an object representing a single point on a graph, which is usually way more than you want.

ggplot2 only works on data frames, and it's very particular about the format of the data frame.
If your data is not in the right format, then ggplot2 won't really work.
Often, you'll need to massage your data into the correct format, and we'll learn more about those techniques later.


## Examples

Let's play with the simulated roulette data from our homework.
We need some code.

```{r}
even = function(x)
{
    win = (x %% 2 == 0) & (x != 0)
    ifelse(win, 1, -1)
}


column1 = function(x)
{
    ifelse(x %% 3 == 1, 2, -1)
}


straightup = function(x, d = 1)
{
    ifelse(x == d, 35, -1)
}


# Construct a simple betting strategy
simple_strategy = function(bet = even)
{
    function(x) cumsum(bet(x))
}


#' Simulate plays from a betting strategy
#'
#' @param strategy
#' @param nplayers number of players to use this strategy
#' @param ntimes number of times each player should play
play = function(strategy = simple_strategy()
    , nplayers = 100L
    , ntimes = 1000L
    , ballvalues = 0:36
){
    out = replicate(nplayers
            , strategy(sample(ballvalues, size = ntimes, replace = TRUE))
            , simplify = FALSE
    )
    data.frame(winnings = do.call(c, out)
            , player = rep(seq(nplayers), each = ntimes)
            , time = rep(seq(ntimes), times = nplayers)
    )
}
```

Now we can get into the plotting code.
Before we can use ggplot2 we need to load the package with `library`.

```{r}
library(ggplot2)
theme_set(theme_bw())
```

I also set the theme here.
The theme sets all the defaults for how your plot displays.
There are several others, feel free to try them out.

Before we can plot we need some data.
I'll use the code above to generate some.


```{r}
set.seed(893)
TIMES = 20
d = play(strategy = simple_strategy(even), nplayers = 1, ntimes = TIMES)
```

What kind of object is `d`?
It's a data frame, perfect for use in ggplot2.

Let's plot it.

```{r}
g = ggplot(data = d, mapping = aes(x = time, y = winnings))
class(g)
```

`g` is an object representing our visualization.
When we print it, we should see the graph.

```{r}
print(g)
```

Nothing yet!
Three elements are required for any ggplot:

1. data
2. mapping
3. geom

123 GO - look at the code above, which one did we forget?

Iteratively building up our graph now.

```{r}
g = ggplot(data = d, mapping = aes(x = time, y = winnings)) +
    geom_point()
```

Note how we finish our lines with `+`.
That tells R, "hang on, wait, the code doesn't end yet, you still need to add more".

This gave us essentially the same visualization as the following simpler code.

```{r}
with(d, plot(time, winnings))
```

The builtin default `plot` function is not ggplot.
If all we want is a quick scatterplot, `plot` works fine.
The benefits of ggplot are not yet clear.

For this data, the line plot makes much more sense, because it connects our movement at every point in time.

```{r}
g = ggplot(data = d, mapping = aes(x = time, y = winnings)) +
    geom_line()
```

## More data

Suppose we want to compare multiple betting strategies by drawing two lines on the same plot.
We need more data.

```{r}
dc = play(strategy = simple_strategy(column1), nplayers = 1, ntimes = TIMES)
```

`d` came from the evens strategy, and `dc` came from the column strategy.
Let's add that information to our data in a way that ggplot will like.

```{r}
d$strategy = "even"
dc$strategy = "column"
```

We've added a column `strategy` to both data frames describing what strategy we used to generate this data.
Now we need to combine these two data frames by stacking them on top of each other.
It doesn't matter which one comes on top.

```{r}
d2 = rbind(d, dc)
```

`d2` contains the data from `d` and `dc`.
Let's plot them:

```{r}
g = ggplot(data = d2, mapping = aes(x = time, y = winnings)) +
    geom_line()
```

That's a weird looking plot!
We want two lines, one for each strategy.
Adding a `group` aesthetic will give us this, and this is what you would use to plot many players using the same strategy simultaneously.

```{r}
g = ggplot(data = d2, mapping = aes(x = time, y = winnings)) +
    geom_line(aes(group = strategy))
```

However, we don't know which line is which.
Let's map the color to `strategy`.

```{r}
g = ggplot(data = d2, mapping = aes(x = time, y = winnings)) +
    geom_line(aes(color = strategy))
```

Nice.

I wonder what the `geom_step` looks like?

```{r}
g = ggplot(data = d2, mapping = aes(x = time, y = winnings)) +
    geom_step(aes(color = strategy))
```

Now we start to see the power of ggplot2.
Once you get over the hump and write something that works, the legend and these kinds of different aesthetics come easily.
