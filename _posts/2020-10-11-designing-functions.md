---
tags:
    - stat128
---

- Evaluate code using `source`
- Plan and implement functions
- Document functions

Announcements:

- Good job on the COVID assignment.
    Everyone in the world is talking about COVID, but how many have actually looked at the raw case level data firsthand?
    That's over 4 million rows, more than anyone said they have dealt with before.

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-12.Rmd)


## `source`

R by itself comes with a bunch of functionality.
A strength of R is the large ecosystem of 3rd party code in packages, for example, ggplot2.
I don't need to write all the code that makes ggplot2 work, I just load it up and I can start using it.

Q: How do we load packages?
A: `library(ggplot2)`, for example

We're going to work with this roulette simulator again.
I already wrote all the code, and it works fine.
I don't want to reimplement all the functions, I just want to use them.
We need something like `library`, but I haven't gone to the (minimal) trouble of creating a package yet.
I want something a little lighter weight- that's `source`.

I'll start a new R terminal and verify that I haven't yet defined any variables.
You can think of `ls` as "list variables".

```{r}
ls()
```

I've made [`roulette.R` publicly available](https://raw.githubusercontent.com/clarkfitzg/stat128/master/roulette.R).

Q: What is this file?
A: It's an R __script__, a single file containing valid R expressions.
Think of it as simply a big code chunk.
Instead of saving it in an Rmarkdown document with extension `.Rmd`, I've saved it as a plain text file with extension `.R`.

`source` will evaluate all the expressions in the file, just like I had typed them in the console.

Q: Do you think you need to be careful with a function like `source`?
A: Yes, particularly from a URL!
This can run arbitrary code on your computer, which people can use to do bad things.
It's the same as installing unknown software from the internet- you better trust it.
You can trust me. 😜

```{r}
source("https://raw.githubusercontent.com/clarkfitzg/stat128/master/roulette.R")
```

If I download the file locally then I can pass in the local file path to `source`.

```{r}
source("~/projects/stat128/roulette.R")
```

Now that I've ran all the code in the file, I see the functions that were defined in `roulette.R`.

```{r}
ls()
# [1] "column1"         "doublebet"       "even"            "high"
# [5] "play"            "simple_strategy" "single"
```


## DRY

Q: Has anyone heard the acronym "DRY" in the context of programming?
It means "Do not Repeat Yourself".
`source` is one way to not repeate yourself.
Functions are another way.


## Motivation

For the next homework, we're going deeper into typical outcomes when you gamble by doing many simulations.

```{r}
set.seed(1380)

NTIMES = 10000L
NPLAYERS = 500L
d = play(simple_strategy(even), nplayers = 500L, ntimes = NTIMES)
```

I would like to know the mean and standard deviation of winnings at every time point `time`.
For the simple strategies, we can evaluate these analytically, and treat these as a function of `time`.
For example, for bets that pay 1:1, like evens, we can do:

```{r}
mean_theory = function(time){
    pwin = 18 / 37
    m1 = -1 * (1 - pwin) + 1 * pwin
    time * m1
}

sd_theory = function(time){
    pwin = 18 / 37
    mx2 = (-1)^2 * (1 - pwin) + 1^2 * pwin
    v1 = mx2 - mean_theory(1)^2
    v = time * v1
    sqrt(v)
}



#' Compute summary statistics for a particular time
#'
#' @param ds data frame containing columns for winnings at a particular time
summary_at_time = function(ds)
{
    time = ds$time[1]
    w = ds$winnings
    data.frame(time, sample_mean = mean(w), sample_sd = sd(w))
}

ds = split(d, d$time)
dq = lapply(ds, summary_at_time)
dtheory = do.call(rbind, dq)


dtheory$pop_mean = mean_theory(dtheory$time)
dtheory$pop_sd = sd_theory(dtheory$time)

dtheory$lower = with(dtheory, sample_mean - 2 * sample_sd)
dtheory$upper = with(dtheory, sample_mean + 2 * sample_sd)


NEXAMPLES = 30L
example_lines = d[d$player <= NEXAMPLES, ]

library(ggplot2)

sample_color = "red"
pop_color = "blue"
conf_line = 2

g = ggplot(data = dtheory) +
    geom_line(mapping = aes(x = time, y = sample_mean), color = sample_color) + 
    geom_line(mapping = aes(x = time, y = pop_mean), color = pop_color) +
    geom_line(mapping = aes(x = time, y = lower), linetype = conf_line) + 
    geom_line(mapping = aes(x = time, y = upper), linetype = conf_line) +
    geom_line(data = example_lines, mapping = aes(x = time, y = winnings, group = player), alpha = 0.1, size = 0.3)
    

print(g)
```

## Group Activity - Planning computations

We want to make the plot above.
How are we going to make it?


## Designing functions

Here are some general steps to follow when writing a function.
Order doesn't matter much, as long as you wait until the end to implement it.

1. Decompose large problems into smaller problems.
2. Decide what the inputs and outputs should be.
3. Create the function __signature__, the name of the function and all the inputs.
4. Have a test case ready, so you can check for correctness.
    TDD- Test driven development.
5. Implement the function.
