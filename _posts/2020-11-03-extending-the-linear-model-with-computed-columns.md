---
tags:
    - stat128
---

- Interpret the results of `predict` on fitted models with old and new data
- Extend the univariate linear model with computed columns

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-11-04.Rmd)

Announcements:

- I'm teaching a new experimental course "Big Data" next semester, same time, MWF 12.

## linear models using data frames

Usually we fit models to data that starts out in a data frame.
What follows is essentially what we had yesterday.

```{r}
n = 100
x = sort(runif(n))
d = data.frame(x)
noise = rnorm(n)
d$ylinear = 10 * x + 2 + noise

with(d, plot(x, ylinear))
```

Q: Anyone know why I'm sorting my `x` values to start with?
A: Because I want the line plots to come out pretty :)
  In most cases the ordering of the rows in the data frames doesn't matter.

For data in a data frame, we can use the data argument to `lm`.

```{r}
fit_linear = lm(ylinear ~ x, data = d)
fit_linear
```

The true values are 10 and 2, did it get close?
123 GO.


## Prediction

If we have a data frame with an `x` column, then we can use our model to make predictions.

```{r}
dnew = data.frame(x = seq(from = 0, to = 1, by = 0.1))

yhat = predict(fit_linear, dnew)

with(d, plot(x, ylinear))
lines(dnew$x, yhat)
```


## Extending the linear model

We can add nonlinear terms into a linear model, and simultaneously fit them.
Here's an example of data where a nonlinear model seems appropriate.

```{r}
x = sort(10 * runif(n))
noise = rnorm(n, sd = 0.2)
d = data.frame(x, y = 0.5*x + sin(x) + 6 + noise)

with(d, plot(x, y))
```

If we have reason to suspect that there's a `sin(x)` term in there, we can add a term for this in the linear model.
Side note- the fitted model keeps the data around, and that's what `predict` uses if we call it with just one argument.

```{r}
fit2 = lm(y ~ x + sin(x), data = d)

with(d, plot(x, y))
lines(d$x, predict(fit2))
```

How did it work?
Nailed it!

But how can we be so sure that the model actually includes `sin(x)` with this arbitrary period?
We'd need some motivation from the data generating process.

We don't need to make such strong assumptions.
For example, we might only assume that the function we are fitting is smooth.
Then we can fit the data with a smoothing spline.

## Splines

The idea of smoothing splines is to approximate any smooth function with a bunch of piecewise third degree polynomials.

```{r}
fit3 = smooth.spline(d)
#fit3 = smooth.spline(d$x, d$y)
p3 = predict(fit3)

with(d, plot(x, y))
lines(d$x, predict(fit2))
lines(d$x, p3$y, lwd = 2, col = "blue")
```

Note that `smooth.spline` has a different interface than `lm`- it doesn't use the formula interface.
One reason is that it only makes sense to fit this cubic spline to pairs of `x` and `y`, so it's sufficient to pass in a list containing values of `x` and `y`, which is what we have in `d`.


## Group Activity

Part of modeling is evaluating how well a model performs.
The linear model minimizes the sum of squared error.

```{r}
# Simulate data
n = 200
d = data.frame(x = runif(n))
d$y = 10 * d$x + 2 + rnorm(n)

# Test / train split
test_index = sample(n, size = round(n/2))
dtrain = d[test_index, ]
dtest = d[-test_index, ]

fit = lm(y ~ x, data = dtrain)
```

Come up with a function that calculates the mean squared error for an `lm` object predicting some new test data.

```{r}
#' Calculate the mean squared error of the model on testdata
#'
#' @param model fitted model object
#' @param testdata data frame containing a column y representing the true values to compare the fitted values against
mse = function(model, testdata)
{
}

# Usage
mse(fit, dtest)
```



## Object oriented programming

How does `predict` know what to do?
It must be a really intelligent function.

```{r}
```


