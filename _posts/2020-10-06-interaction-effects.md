---
tags:
    - stat128
---

- Create and interpret contingency tables
- Create and interpret interaction plots

Announcements:

- Homework is posted.

Hint: It might be useful to think about these COVID illness rates by age after adjusting for the relative sizes of each age group in the country.
You'll need to bring in another data source to do this.


[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-07.Rmd)


## Categorical Data

What is categorical data?

How to make continuous data categorical?


## Contingency tables

bo

## Response and predictors

Many models in statistics and machine learning are based on the idea of using one or more variables to predict a different variable of interest, called the __response__.


## Interaction plots

In statistics, an __interaction effect__ is when two or more variables have a non additive effect in the value of some response.

```{r}

ed = c("high school", "bachelors", "graduate")
edf = factor(ed)
edo = factor(ed, levels = ed, ordered = TRUE)

sex = factor(c("male", "female", "other"))

n = 1000
d = data.frame(ed = sample(edo, n, replace = TRUE)
    , sex = sample(sex, n, replace = TRUE, prob = c(0.49, 0.49, 0.02)))

base_salary = 40e3
d$income_additive = base_salary * (d$edo + d$)

```



## Group Activity
