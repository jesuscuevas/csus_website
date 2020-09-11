---
tags:
    - stat128
---

- manipulate named vectors
- summarize univariate data using statistics and graphics

Announcements:

- I appreciate Irene asking "What is boilerplate?"
    Please ask when I use words like these without defining them!

[Live notes]({% link files/stat128/fall20/2020-09-11.txt %})


## Named vectors

A vector is an ordered sequence of data values.
A named vector has names for every element.

Setup:

I want a named vector with some made up data for us to work with.
Recall `runif` creates random data from a Uniform(0, 1) distribution.
That's `r` for random, `unif` for uniform.
The names will be the letters from a to z, which R provides in the variable `letters`.
There are 26 letters in the English alphabet, so I need 26 random data points.
Let's verify there are 26 letters:

```{r}
length(letters)
```

Q: Which is the best way to create this data, and why?

```{r}
x = runif(26)

# OR

x = runif(length(letters))
```

It might not be obvious, but `x = runif(length(letters))` is much better, because it can easily adapt to new situations without requiring us to change it.
For example, if we were using a non English alphabet that has a different number of letters, then `x = runif(length(letters))` will still work.
Another reason this choice is better is it prevents a whole class of possible typos and errors.


```{r}
set.seed(128)
x = runif(length(letters))
names(x) = letters
```

After you call `set.seed`, R will produce the same sequence of random numbers.
This should let us all have the same set of numbers, which implies that the numbers aren't random at all. 🤣


## Helpful functions for homework

Demo all of these, ask students to describe what they do.

`names, sort, head, tail, hist, %in%, x["a"]`

Try some predictions:

```{r}
"a" %in% letters
"b" %in% letters
"abcd" %in% letters
```


## Summary statistics


Next n students in the queue, take 2 minutes to call the following functions on `x`, and report to the class what they do.
Everyone else: pick one of these and study it, so that you can help your fellow students if they get stuck.

Measures of center:
```{r}
mean(x)
median(x)
mean(x, trim = 0.05)
```

Measures of spread:
```{r}
sd(x)
quantile(x)
range(x)
summary(x)
```

Let's see which measures of center are robust to outliers!
We'll create a data set `y` that's just like `x`, but has an outlier.
```{r}
y = c(x, 10)
```


## Exponent notation

Print out data, introduce exponent notation.
```
0.03956565 = 3.956565e-02 = 3.956565 * 10^-2
```

Watch out for numbers very close to 0!


## 1d graphics

These should look familiar from stats courses:

```{r}

x = rnorm(100)
par(mfrow = c(1, 3))
hist(x, main = "histogram")
boxplot(x, main = "boxplot")
d = density(x)
plot(d, main = "kernel density estimate")

```

More exotic are the kernel density estimators:

```{r}
```

Plot all three together:

```{r}
d = density(x)

plot(d)
```


The idea of density estimators is to infer the probability density function (PDF) that generated the data, assuming that the data are independent and identically distributed (IID) observations from a particular distribution.


## preview filtering by condition

Compare with trimmed means.
