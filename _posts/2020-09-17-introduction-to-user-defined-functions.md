---
tags:
    - stat128
---

- Implement a function given a description of what it should do
- Describe R's formula syntax, `y ~ x`
- Select rows of a data frame by index

123GO - what's your dream job?

Announcements:

- The standards for homework grading are high, to help you grow.
- I'll provide an example of a submission that would earn a full score.

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-09-18.Rmd)


## Defining Functions

Functions are the heart of R.
Everything in R is a function.
To really use R, we need to define our own functions.

Q: What's the mathematical definition of a function?

A: Maps an input to exactly one output. `input ---> output`

Last homework we found the data point that was closest to the mean.
Let's implement this in a general function, `closest_to_mean`.

Q: 123GO - What's a simple example we can test to verify the behavior of our function?
We need an input and output.

A: There are many ways. Here's one: `closest_to_mean(c(10, 11, 12))` should output `11`.

Let's write a placeholder for the function.

```{r}
#' Return the data point in `x` closest to the mean of `x`.
#'
closest_to_mean = function(x)
{
}
```

The empty braces `{}` after `function(x)` mean that this function doesn't do anything yet.
It's like a skeleton or outline, ready for implementation.
We can attempt to use it, and verify it doesn't do anything:

```{r}
> closest_to_mean(precip)
NULL
```

`NULL` means nothing, and we'll talk about it in detail in a future lecture.

In the last homework, we did this calculation for `precip`, and we can implement our function based on this code:

```{r}
diff_from_mean = abs(precip - mean(precip))
closest_index = which.min(diff_from_mean)
precip[closest_index]
```

The code above is written with `precip` as the input.
We need to change it so that `x` is the input, and stick it in the __body__ of the function, the part between the braces `{}`.

```{r}
#' Return the data point in `x` closest to the mean of `x`.
#'
closest_to_mean = function(x)   # <--- function name, arguments
{                               # <--- begin body
    diff_from_mean = abs(x - mean(x))
    closest_index = which.min(diff_from_mean)
    x[closest_index]            # <--- last line of body is the return value
}
```

Finally, we verify that our function does what we expected.

```{r}
> closest_to_mean(precip)
Cleveland
       35

> closest_to_mean(c(10, 11, 12))
[1] 11
```

🤑 Sweeeet. 


## Model Formulas

R uses `~` (tilde, pronounced "till-duh") to specify statistical models.
The most basic way to specify a model is `y ~ x`, which you can think of as saying "model y as a function of x".

The R documentation goes into more detail.

```{r}
?formula
```

> The models fit by, e.g., the ‘lm’ and ‘glm’ functions are specified in a compact symbolic form.
> The ‘~’ operator is basic in the formation of such models.
> An expression of the form ‘y ~ model’ is interpreted as a specification that the response ‘y’ is modelled by a linear predictor specified symbolically by ‘model’.

Many functions accept model formula, for example, `boxplot`.
Let's load our data for the homework and see.

```{r}
air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")
```

Suppose we want to see comparative boxplots of `DAILY_AQI_VALUE`, split into groups by `COUNTY`.

```{r}
boxplot(DAILY_AQI_VALUE ~ COUNTY, data = air)
```

We see a boxplot for each county, all on the same y axis scale, so that we can easily compare them.
Think about the formula `DAILY_AQI_VALUE ~ COUNTY` as saying, "model `DAILY_AQI_VALUE` as a function of `COUNTY`".

Q: How can we group all the counties besides Sacramento together and do a boxplot?

A: We need a new column saying whether each row belongs to a Sacramento county or not.

```{r}
air[, "Sac"] = air[, "COUNTY"] == "Sacramento"
boxplot(DAILY_AQI_VALUE ~ Sac, data = air)
```

## Selecting Rows by Index

I'd like to reorder `air` so that the smallest values of `DAILY_AQI_VALUE` show up first.
How do we do this?

Subsetting `x` with integers allows us to permute `x`, and we can use this idea to reorder our data frames.
Here's an example of randomly permuting letters.

```{r}
> rand_index = sample(length(letters))
>
> rand_index
 [1] 14  6 19  2  4 16  3 10 18 13 15  8 23 11  1 12  5 26 21  7 24 25 20  9 17
[26] 22
> letters[rand_index]
 [1] "n" "f" "s" "b" "d" "p" "c" "j" "r" "m" "o" "h" "w" "k" "a" "l" "e" "z" "u"
[20] "g" "x" "y" "t" "i" "q" "v"
```

`rand_index` is a random permutation of the integers 1 to 26.
`letters[rand_index]` selects the elements of `letters` corresponding to `rand_index`.
14 comes first in `rand_index`, so the 14th letter `n` shows up first.
6 comes next in `rand_index`, so the 6th letter `f` shows up next, and so on.

Recall general data subsetting has this form.

```{r}
data[rows, columns]
```

We need a vector of integers that shows the sorted order of `DAILY_AQI_VALUE`.
`order` will give us this.

```{r}
aqi_order = order(air[, "DAILY_AQI_VALUE"])
head(aqi_order)
```

This means element 1065 is the smallest value in `DAILY_AQI_VALUE`, followed by element 582, and so on.
Let's sort the data using `aqi_order` and save the result.

```{r}
air2 = air[aqi_order, ]

# 123GO - What do you think, same or different?
dim(air)
dim(air2)
```

Let's plot them and see what happened.

```{r}
plot(air[, "DAILY_AQI_VALUE"], type = "l")  # "l" for line plot
```

```{r}
plot(air2[, "DAILY_AQI_VALUE"], type = "l")
```
