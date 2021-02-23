---
tags:
    - stat196k
date: 2021-02-05
---

- outcome 1

## Announcements

- 

## Resources

- [Pearson's chi-squared test](https://en.wikipedia.org/wiki/Pearson%27s_chi-squared_test) Wikipedia
- Julia HypothesisTests [Pearson chi-squared test](https://juliastats.org/HypothesisTests.jl/latest/parametric/#Pearson-chi-squared-test-1)

## Background

Pearson's chi-squared test applies to data from a multinomial distribution, which we can understand as a distribution that gives probability `p_i` to each of `k` different outcomes.
In [our homework]({% link _posts/2021-02-17-homework-sampling-stream.md %}) we are writing a program to generate data from a uniform distribution.
What does the multinomial distribution have to do with the uniform?

It's possible to model any continuous distribution using a multinomial distribution by putting data into bins, just like in a histogram.
A natural way to do this is to split the distribution into `k` distinct bins defined by the quantiles / percentiles.
For example, let's sample n = 200 data points uniformly from the integers between 1 and 1 million and put them into 10 evenly spaced bins.
The 0th percentile is 1, and the 10th percentile is 100,000.
About 10% of our data, or 20 points, should land between 1 and 100,00.
Similarly, there should be around 20 numbers between 100,001 and 200,000, and so on, up to 900,001 to 1 million.

How many bins you should use is subjective.
The standard rule of thumb is to have at least 5 or 10 expected counts 

## Implementing

