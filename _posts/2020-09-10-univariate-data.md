---
tags:
    - stat128
---

- manipulate named vectors
- summarize univariate data using statistics and graphics

Announcements:

- I appreciate Irene asking "What is boilerplate?"
    Please ask when I use words like these without defining them!


## Named vectors

Setup:

I want a named vector with some made up data for us to work with.
The names will be the letters from a to z, which R provides in the variable `letters`.
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
n = 26
x = runif(n)
names(x) = letters
```

After you call `set.seed`, R will produce the same sequence of random numbers.
This means that we can 
Which means, of course, that the numbers aren't random at all. 🤣




`names, sort, head, tail, hist, %in%`


## Summary statistics


Next n students in the queue, take 2 minutes to call the following functions on `x`, and report to the class what they do.
Everyone else: pick one of these and study it, so that you can help your fellow students if they get stuck.

Measures of center:
```{r}
mean(x)
mean(x)
```



standard statistics, range, median, mean, etc.
histograms and bin width

## preview filtering by condition
