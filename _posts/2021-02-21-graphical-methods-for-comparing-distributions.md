---
tags:
    - stat196k
---

- create and interpret QQ plots
- sample from probability distributions to test statistical methods

## Announcements

- I have an idea for a summer project

Important meta technique for understanding statistical methods: simulate data that exactly matches the assumptions and check that it works as expected.

Motivation: We would like to characterize a data generating process with a distribution, i.e. uniform, normal, Poisson, etc.
Why do we want to do this?


## Resources

- We already have code in Julia to do the [QQ plot](https://github.com/JuliaPlots/StatsPlots.jl#quantile-quantile-plots)


## Chi Squared Distribution


## histograms


## QQ plots

The QQ (quantile - quantile) plot is a useful visual tool to check if whether a particular distribution models data well.
If the QQ plot follows the line y = x reasonably well, then it means that the reference distribution is a reasonable model for the data.

Let's simulate from a uniform distribution.

```julia
U1k = Uniform(0, 1000)

x = rand(U1k, 50)
```

`quantile` gives us the quantile function.

```julia
quantile(U1k, 0.5)
```

123 GO- which quantiles should we plot for these 1000 data points?
If we plot the sorted data against these theoretical quantiles, we should see line along y = x.

```julia
GR.title("data comes from distribution - GOOD")
q1k = quantile(U1k, range(0, 1, length = length(x)))
#GR.scatter(q1k, sort(x))
plot(q1k, sort(x))
```

This is the best case scenario.

Let's try this on a distribution that we know is wrong.

```julia
function qqplot(d::UnivariateDistribution, x)
    rng = range(0, 1, length = length(x) + 2)[2:(end-1)]
    q = quantile(d, rng)
    GR.scatter(q, sort(x))
end

GR.title("data not from distribution - BAD")
qqplot(U1k, x)

normalD = Normal(mean(x), std(x))

qqplot(normalD, x)
```

How about sampling data that looks __too good__?


## Exercise


Pick two statistical distributions that look completely different.
For example, the uniform distribution looks different from the Chi squared distribution.
Generate data from one distribution, and create two QQ plots for this same data plotted against the quantiles of two different distributions.

Turn in these two QQ plots.
They can be on the same axes, or different.

Use any software you like.
