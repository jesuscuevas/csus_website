STAT 50 - 13 November 2020

123 GO- what's been on your radio lately?

#### Outcomes:

- Calculate probabilities for binomial random variables
- Graph the probability mass function PMF for a binomial random variable

Announcements:

- STAT 196K "Analyzing and Processing Big Data" next semester
- Next HW on binomial random variables 


For the final section in this class we will study several different well known named random variables.
R can calculate standard probabilities for these, as can many other software packages.

## The probability mass function

Let X be the sum of `n` independent bernoulli random variables, each with probability of success `p`.
Then X is distributed as bin(n, p).

The binomial distribution has the following probability mass function:

$$
P(X = k) = \binom{n}{k} p^{k}(1-p)^{n-k}  \quad \text{for } k = 0, 1, \dots, n
$$

Example: Suppose that X ~ bin(10, 0.3).
Find P(X = 3).

Implementing the formula:
```{r}
n = 10
p = 0.3
k = 3
choose(n, k) * p^k * (1-p)^(n-k)
```

More directly:
```{r}
dbinom(3, size = 10, prob = 0.3)
```

123GO: which do you like better?


## Plotting

What does this probability mass function look like?

```{r}
k = 0:10
probability = dbinom(k, size = 10, prob = 0.3)
plot(k, probability, ylim = c(0, 0.4))

p2 = dbinom(k, size = 10, prob = 0.8)
points(k, p2, pch = 2)
```

Q: What's the probability that X = 1?

Q: Why is P(X = 10) so small?

Q: Can you give me a value for p for Y ~ bin(10, p) that will make P(Y = 10) > P(X = 10)?


## Cumulative Distribution Function

If X ~ bin(n, p)
What is the CDF F(k) = P(X <= k)?
Just sum up the PMF:

$$
P(X \leq i) = \sum_{i = 0}^k \binom{n}{k} p^{k}(1-p)^{n-k} 
$$

To be concrete, take X ~ bin(10, 0.3) and let's find P(X <= 3).

We can implement this from the PMF.

```{r}
d0123 = dbinom(0:3, size = 10, prob = 0.3)
sum(d0123)
```

Or we can use the CDF directly:

```{r}
pbinom(3, size = 10, prob = 0.3)
```


