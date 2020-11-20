---
tags:
    - stat128
---

- Simulate data from R's builtin distributions
- Calculate and graph probability density / mass functions

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-11-20.Rmd)

123 GO – Did the student made review videos improve your understanding?

Announcements:

References:

- https://cran.r-project.org/web/views/Distributions.html


## Stand on the shoulders of giants

If X ~ Poisson(140), then the probability mass function is:

$$
P(X = k) = e^{-20} \frac{20^k}{k!}
$$

We can implement the formula:

```{r}
pmf_poisson140 = function(k){
    exp(-140) * 140^k / factorial(k)
}
```

It seems to work fine, it's even vectorized.

```{r}
x = pmf_poisson140(130:143)

plot(x)
```

```{r}
pmf_poisson140(135:145)
```

Uh-oh! A PMF cannot be infinite.
What happened?
```{r}
140^(143:144)
```
Overflow.

R has more capabilities of calculating probabilities for various distributions than any other software I'm aware of.
Use it!

Here's a better way

```{r}
x2 = dpois(135:145, lambda = 140)
plot(x2)
```

What are the reasons for preferring R's builtin probability calculations?

1. clarity - most important IMHO.
    Others can read the code and see what you intended.
    If you call `dpois` I know you're trying to calculate the PMF for a Poisson distribution.
    If you code up some formula, then I either have to read the code or rely on comments.
2. robust
3. accurate
4. efficient

These functions have been refined for decades.
Stand on the shoulders of giants.


## R probability function naming conventions

Base R has 4 different probability functions for 16 different distributions, and external packages on CRAN have many more.
The behavior of the function comes from the prefix.

Prefixes:

- `d` probability density / mass functions
- `p` probability (cumulative) distribution functions
- `q` quantile functions
- `r` random number generation

The distribution comes from the suffix.

Suffixes:

1. `beta` beta
1. `binom` binomial 
1. `cauchy` Cauchy 
1. `chisq` chi-squared 
1. `exp` exponential 
1. `f` Fisher F
1. `gamma` gamma 
1. `geom` geometric 
1. `hyper` hypergeometric 
1. `logis` logistic 
1. `lnorm` lognormal 
1. `nbinom` negative binomial 
1. `norm` normal 
1. `pois` Poisson 
1. `t` Student's t
1. `unif` uniform 
1. `weibull` Weibull 

For example, if we want to calculate the P(Z < -1), where Z ~ Normal(0, 1) we use the cumulative distribution function:

```{r}
pnorm(-1, mean = 0, sd = 1)

pnorm(-1)
```

In this example we are using the defaults.
Not all distributions have defaults.
Be careful with the parameterization- it may be different than your textbook.
