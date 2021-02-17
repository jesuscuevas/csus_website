---
tags:
    - stat196k
---

- implement a streaming algorithm
- test distributional assumptions

## Announcements


## Resources

- [chi-square test](https://www.itl.nist.gov/div898/handbook/eda/section3/eda35f.htm) National Institute of Standards and Technology (NIST)


## Background

Making our own version of `shuf`.

Idea: come up with a reservoir sampling scheme that doesn't take longer than a fixed amount of time, meaning it stops once a certain amount of time has passed.

1. Suppose we halt reservoir sampling at item m, with m < n, where n is the size of the entire stream.
    Can this be a sample of the entire data?
    Explain.

2. Test your implementation of the algorithm on the uniform distribution on the positive integers.
Use the Kolmogorov-Smirnov test or the Chi squared test to see how close your distribution is to the expected.
Plot some QQ plots to verify that the distribution looks as you expect.

Idea: This could be a good lead in to parallel programming.
Simulations are the easiest things to parallelize.
    
3. Which of these will produce a simple random sample?

```
head data.txt | reservoir_sample
reservoir_sample data.txt | head
```

Test your classmate's code and verify that it works in the following cases:

1. input data with 0 lines
2. input data with 5 lines
2. input data with 20 lines
1. input file specified and empty (stdin)

1. If your input data has fewer than the number of samples, then write an informative message to standard error.

Harder:

1. Generalize your program through a function that works on any iterable data in Julia, rather than only `stdin`.
4. Wikipedia claims simple reservoir sampling is slow.
Is it?
Check by implementing another algorithm and comparing speeds.
5. Make sure your program works for arbitrarily large input.
    Hint: you need to handle more points than this:
```
julia> typemax(Int)
9223372036854775807
```
How long must your program run before something like this matters?




