---
tags:
    - stat196k
---

- implement a streaming algorithm
- create a custom step for a shell pipeline
- test for a distribution


## Resources

- [chi-square test](https://www.itl.nist.gov/div898/handbook/eda/section3/eda35f.htm) National Institute of Standards and Technology (NIST)
- [reservoir sampling](https://en.wikipedia.org/wiki/Reservoir_sampling) Wikipedia


## Background

When we meet a fresh, unfamiliar data set, the first thing to do is some basic Exploratory Data Analysis (EDA).
EDA means to familiarize ourselves with the structure, and make lots and lots of plots to see what's going on.
We need to do this before we go nuts with all our statistics and machine learning toolboxes.
The problem is that EDA with big, remote data sets is clumsy.
The simplest solution to this problem is to download a simple random sample of our data, and work with that.

[Reservoir sampling](https://en.wikipedia.org/wiki/Reservoir_sampling) is one technique for selecting a simple random sample from a data stream.
It's useful when the number of elements in the stream is unknown ahead of time.


## Questions

### 1

1. Why is it better to take a simple random sample, instead of just the first k rows?
1. Suppose we halt reservoir sampling at element m, with m < n, where n is the size of the entire stream.
    Can this be a sample of the entire data?
    Explain.
3. I [read on the internet](https://unix.stackexchange.com/a/108604/456485) that `shuf -n 100 data.txt` uses reservoir sampling.
The following commands each produce 100 lines from `data.txt`.
For each command, will it produce a simple random sample of the lines of the file `data.txt`?
Why or why not?
```
head -n 100 data.txt | shuf         # 1
shuf -n 100 data.txt | head -n 100  # 2
shuf -n 200 data.txt | head -n 100  # 3
shuf -n 100 data.txt | head -n 100  | sort  # 4
```


### 2

Implement reservoir sampling by writing a program in Julia called `shuf.jl` that works like a simple version of `shuf`.
It should accept one positional argument with the number of elements to sample, and default to 100.

Verify that it works for the following cases:

1. `seq 10 | julia shuf.jl` shuffles the integers from 1 to 10.
2. `seq 100 | julia shuf.jl 20` samples 20 random integers without replacement from 1 to 100.
2. `seq 1000 | julia shuf.jl` samples 100 random integers without replacement from 1 to 1000.
2. `seq 1e7 | julia shuf.jl` samples 100 random integers without replacement from 1 to 1000.


### 3 - Testing

TODO: elaborate

Use the chi square test or kolmogorov smirnoff test together with `seq` to check if your implementation of reservoir sampling differs from the uniform distribution on the integers 1 to n.
State the null hypothesis, the p value, and your conclusion.


### 4 - Extra Credit

Math option: Prove that reservoir sampling produces simple random samples.

Programming option:
