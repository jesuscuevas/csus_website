---
tags:
    - stat128
---

- Describe the rpart regression model at a high level
- Interpret a printed `rpart` object

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-11-06.Rmd)

123 GO – What’s your word of the day

Announcements:

References:

- [rpart vignette](https://cran.r-project.org/web/packages/rpart/vignettes/longintro.pdf)
- [regression trees](https://uc-r.github.io/regression_trees) from UCR

## recursive partitioning

```{r}
library(rpart)

n = 100
#x = sort(3 * runif(n))
x = seq(from = 0, to = 3, length.out = n
y = rep(2, n)
y[x < 1] = 1
y[2 < x] = 3
noise = rnorm(n, sd = 0.2)
y = y + noise
d = data.frame(x, y)

plot(x, y)

```

This model is piecewise constant.

Defaults:

```{r}
fit1 = rpart(y ~ x, data = d)

plot(x, y)
lines(x, predict(fit1))
```

To see the parameters for `rpart`:

```{r}
?rpart.control
```


Greedy algorithms do the best they can at every step.
This means they don't always find the best (optimal) solution.
The following plot illustrates the greedy nature of `rpart`.
The optimal solution with three leaf nodes is to split around 33 and 66.
`rpart` starts out by splitting at 50.5, because that's the best first split.
The best second split is to split the upper half of the data that has 51 points, so around 75.

```{r}
n = 101
x = seq(n)
y = x
fit = rpart(y ~ x, minsplit = 51)

plot(x, y)
lines(x, predict(fit))
```

This isn't a flaw in the algorithm- it's just a property to be aware of.
Optimal solutions can be very elusive, and in practice trees work just fine.
