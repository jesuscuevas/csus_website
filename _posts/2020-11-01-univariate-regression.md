---
tags:
    - stat128
---

- Explain the idea of linear regression with one variable
- Extract the coefficients of a linear model produced by `lm`

123 GO – What’s your favorite Halloween candy?

Announcements:

- Feel free to stay after today and ask me about any of the midterm questions you missed.



## Introduce final project

- Open ended- just use something from the class
- Ideas: dashboard, nice visualization, statistical model, refined data set
- Show your strengths
- Show the reader something interesting
- Groups of 2-3 are OK, but not mandatory
- Use data set from class, or find your own

Proposal due next week, I'll announce details later.


## Statistical Learning

Who has heard of statistical learning? machine learning?

123 GO - Write what it is in 1 sentence.

Statistical learning infers functions from data.
The inputs can be nearly anything: numbers, categorical data, text, images, video.

```{r}
Raw data (image, text, video, numbers)
--- transform ---
vector/matrix of numbers
--- apply function ---
output
```


We're going to start off easy, with univariate functions that will look familiar from math.
In what follows the goal is to infer the function that produces the values on the y axis.


## Linear models

We'll look at a one dimensional linear model, aka linear regression.

Here's some sample data for us to play with.

```{r}
n = 100
x = runif(n)
a = 5
b = -2
ytrue = a*x + b
```

For example, we can look at `ytrue` as a function of `x`.

```{r}
plot(x, ytrue)
```

You don't need statistics to figure out what function is producing these `ytrue` values.
Just a little algebra.

But the data is rarely perfect.
There's typically noise.

```{r}
noise = rnorm(n)

y = a*x + b + noise

plot(x, y)
lines(range(x), range(ytrue), lty = 2)
legend("topleft", legend = c("true"), lty = 2)
```

Incidentally, the code we have above exactly satisfies the assumptions for the standard linear model in statistics.
This is the best possible case for the linear model.

What does it mean to fit a linear model?
We have a bunch of observations of the pairs x, y, those are the data points in our plot.
If we suppose it's a linear model, then the function that we're trying to recover has the form:

$$
y = ax + b
$$

Look at the points on the graph though.

123 GO: Can you draw a straight line that simultaneously intersects all those points?
No way!
So the actual model is:

$$
y = ax + b + \epsilon
$$

Where ε is some random noise term.


## Optimization

What is fitting the model then?
Finding "the best" `a` and `b`.

I could just eyeball it and guess.

```{r}
plot(x, y)
lines(range(x), range(ytrue), lty = 2)
lines(range(x), -1.5 + 4.5 * range(x), lty = 3)
legend("topleft", legend = c("true", "wild guess"), lty = c(2, 3))
```


For standard linear regression the goal is to minimize

$$
sum_{i = 1}^n (y_i - ax_i + b)^2
$$

If there are at least two distinct xi's, then there is a unique solution to minimize this sum of squares.

123 GO: Should the random noise term have mean zero?
Yes.
Otherwise we couldn't decide what `b` is.

This pattern is repeated by almost all statistical learning techniques:

1. Specify / constrain the structure of the function
2. Define what you consider a good fit, your objective or loss function to minimize
3. Estimate the parameters


## Application in R

Recall the formula notation `y ~ x` means to model `y` as a function of `x`.
That's exactly what we want to do.

```{r}
?lm  # lm for linear model

fit = lm(y ~ x)

ahat = coef(fit)["x"]
bhat = coef(fit)["(Intercept)"]

```

```{r}
rx = range(x)
plot(x, y)
lines(rx, ahat * rx + bhat, lty = 1)
lines(rx, a*rx + b, lty = 2)
lines(rx, -1.5 + 4.5 * rx, lty = 3)
legend("topleft", legend = c("least squares estimate", "true", "wild guess"), lty = c(1, 2, 3))
```



