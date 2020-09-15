---
tags:
    - stat128
---

- create boolean vectors using comparison operators
- select rows by condition
- reorder rows of data frame

We also need to know about dates:

- date class
- format strings
- conversion to dates
- compare dates
- update columns in place


123GO - what's your word of the day?


### Announcements

- These online notes are more thorough, please use them in your homework. 
- HW partially graded

[live notes]({% link files/stat128/fall20/2020-09-14.txt %})


### References

- [Book of R, Section 5.2.3](https://learning.oreilly.com/library/view/the-book-of/9781492017486/xhtml/ch05.xhtml#ch05lev2sec54)
- [Art of R Programming, Chapter 5](https://learning.oreilly.com/library/view/the-art-of/9781593273842/ch05s02.html#extracting_subdata_frames)


## Dates

Let's load the data for our homework.

```{r}
air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")
```

We can extract some columns of interest.
```{r}
d = air[, "Date"]
pm2 = air[, "Daily.Mean.PM2.5.Concentration"]
```

If we try to plot `pm2` as a function of `d`, something bad happens.
```{r}
plot(d, pm2)
Error in plot.window(...) : need finite 'xlim' values
In addition: Warning messages:
1: In xy.coords(x, y, xlabel, ylabel, log) : NAs introduced by coercion
2: In min(x) : no non-missing arguments to min; returning Inf
3: In max(x) : no non-missing arguments to max; returning -Inf
```

Q: Anyone know what's the matter?

A: R doesn't know how to plot `d`.

Why not? These look like dates, which you and I can read.

```{r}
head(d)

[1] "01/22/2020" "01/25/2020" "01/01/2020" "01/04/2020" "01/07/2020"
[6] "01/10/2020"
```

The problem is that we haven't yet told R that they are dates.

```{r}
class(d)
[1] "character"
```

Let's convert them into dates!

```{r}
d2 = as.Date(d)
Error in charToDate(x) :
  character string is not in a standard unambiguous format
```

We need to specify the date format.

```{r}
?as.Date

as.Date(x, format, tryFormats = c("%Y-%m-%d", "%Y/%m/%d"),
```

Q: What do you think this `"%Y-%m-%d"` means in the context of a date?

A: Year-month-day, so dates should look like "2020-08-16".

```{r}
> head(d)
[1] "01/22/2020" "01/25/2020" "01/01/2020" "01/04/2020" "01/07/2020"
[6] "01/10/2020"
```

Q: Does our data look like one of those format strings?

A: Nope. We need to supply our own.

Q: What order does our string use?

A: The first element, `"01/22/2020"` implies month/day/year, so the right format string to use is "%m/%d/%Y".

```{r}
d2 = as.Date(d, format = "%m/%d/%Y")
class(d2)
plot(d2, pm2)
```

That looks more like it!

Q: Did we change the data in d or our original data frame?

A: No

```{r}
class(d)
class(air[, "Date"])
```

Suppose we want to?

```{r}
air[, "Date"] = as.Date(air[, "Date"], format = "%m/%d/%Y")
class(air[, "Date"])
```

## logical comparisons

Logical vectors are vectors where the value is either TRUE or FALSE (or NA, but that's for later).
Comparisons are one way to create logical vectors.

```{r}
x = c(1, 2, 2, 3, 18)
```

Let's check if `x` is equal to 2.

```{r}
x == 2
```

I can assign this value into a new variable, which has class "logical".

```{r}
isx2 = x == 2
class(isx2)
```

Note `=` does variable assignment, which is COMPLETELY different from `==` for equality comparison.

Your turn:
Predict the result of the following.
```{r}
1 < x  # 1
x <= 2   # 2
```

You can use the same idea with dates.
Let's just look at the first ten elements:
```{r}
air[1:10, "Date"]
```

Since we converted them to dates above, we can check:
```{r}
as.Date("2020-01-14") < air[1:10, "Date"]
```

We could save this result as a new column in our data frame.
```{r}
air[, "afterJuly1"] = as.Date("2020-07-01") <= air[, "Date"] 
```


## row selection

We can select subsets of the data that we're interested in.
If `data` is our data frame, and `columns` is a vector of column names, then we select columns as follows:

```{r}
data[, columns]
```

To select a subset of rows, this pattern generalizes to:

```{r}
data[rows, columns]
```

That is, leaving `rows` empty selects all rows.

Suppose I want to select the rows where the value of the `COUNTY` column is `"El Dorado"`.
We can check if this is `TRUE` or `FALSE` for every row:

```{r}
edcounty = air[, "COUNTY"] == "El Dorado"
```

Then we can filter out the rows we like using this logical vector:

```{r}
air2 = air[edcounty, ]
```
