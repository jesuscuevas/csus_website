---
tags:
    - stat128
---

- Create and interpret contingency tables
- Create and interpret interaction plots

Announcements:

- Homework is posted.
- Data set is about 400 MB, let me know if your computer starts going super slow.


[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-07.Rmd)


## Categorical Data

What is categorical data?
Categorical data takes on a finite, usually small, set of distinct values.
R represents these as __factors__, but they might show up as character vectors.

```{r}
ed = c("high school", "bachelors", "graduate")
edf = factor(ed)
sex = factor(c("male", "female", "other"))
```

Categorical data can also be ordered.

```{r}
edo = factor(ed, levels = ed, ordered = TRUE)
```


How to make continuous data categorical?
Use `cut` to cut it into pieces.

```{r}
x = seq(from = 1.1, to = 10, length.out = 50)
cx = cut(x, breaks = 1:10)
```



## Contingency tables

Let's load the data for your next homework.
It takes a while!

```{r}
covid = read.csv("~/data/COVID-19_Case_Surveillance_Public_Use_Data.csv")
```

Q: The `age_group` column is an example of what kind of data?
A: conceptually, it should be an ordered factor
We haven't converted it, so it's a character.

```{r}
table(covid$age_group)
class(covid$age_group)
```

We're also interested in whether patients had preexisting serious medical conditions.

```{r}
table(covid$medcond_yn)
```

Let's look at both of these variables together.
Here is an example of a __contingency table__, a table of counts.

```{r}
t1 = table(covid[, c("age_group", "medcond_yn")])
```

The areas in this plot represent relatively how many observations fall into each categoy.

```{r}
plot(t1)
```


## Response and predictors

Many models in statistics and machine learning are based on the idea of using one or more variables to predict a different variable of interest, called the __response__.

Let's look at hospitalization from COVID as a response.

Right now this is a character vector.

```{r}
class(covid$hosp_yn)
```

Q: How are we going to make it a numeric vector?
A: An easy way is to just make it binary.

```{r}
covid$hospital = as.numeric(covid$hosp_yn == "Yes")
```


## Interaction plots

In statistics, an __interaction effect__ is when two or more variables have a non additive effect in the value of some response.

We can look at hospitalizations as a function of age and sex to find out if there are interaction effects between these two variables.
For example, it might be the case that females between 20 and 29 have unusually low rates of hospitalization, and that would provide evidence of an interaction effect.

```{r}
with(covid, 
interaction.plot(age_group, sex, hospital)
)
```

The way to interpret an interaction plot is if each line is a vertical translation of all the other lines, then there is no evidence of an interaction effect.
If the lines have completely different shapes, then that provides evidence of an interaction effect.

This particular plot shows some mild interaction effects.
Take great care in making causal statements.
For example, it might well be the case that sex doesn't have much to do with COVID, rather, sex might be highly correlated with a type of medical condition that does affect vulnerability to COVID.


## Group Activity

Discuss in your groups, and come up with examples of:

1) unordered categorical variable
2) ordered categorical variable
3) two variables that may well have an interaction effect in producing a response
