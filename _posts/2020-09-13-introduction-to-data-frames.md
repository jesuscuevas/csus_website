---
tags:
    - stat128
---

- describe high level idea of data frames
- load CSV file on local file system
- select columns by name
- interpret interactive results of `class, dim, head, tail, unique, table`

123GO - On a scale of 1 (easy) to 10 (hard), how difficult did you find the last homework?

Announcements:

- I expected to see more chatter on the Canvas discussions and Discord.
    Ask more questions, because we can and should help each other.
    Don't sit there stuck for hours.
- Remember to note in the assignment if you work with someone else.
    That's what professors do, and people in open source software do.
    Explaining ideas to another is a wonderful way to learn.
- To get the benefit from this course, you do need to do your own work, and completely understand it.

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-09-14.Rmd)

[homework air quality data]({% link files/stat128/fall20/ad_viz_plotval_data.csv %})


## data frames

Let's see what R has to say about data frames.

```{r}
?data.frame
```

According to the official documentation, data frames are:

> tightly coupled collections of variables ... used as the fundamental data structure by most of R's modeling software.
>
> ... a matrix-like structure whose columns may be of differing types (numeric, logical, factor and character and so on).

Sounds important.

Think of a data frame as a spreadsheet or table, where each row is an observation.

Let's check out `airquality`, a data frame included with R, just like `precip`.
Air quality should be on your mind if you're local.

Here are the functions I reach for first when loading a new data set.

```{r}
class
dim
head
summary
```

## select columns

Type `airq` and then tab for "tab completion".

Q: What happened?
The name of the object matching the first couple letters showed up.

Q: Why use it?
Faster and more accurate.

`airquality` has a column for "Month".
Let's extract this individual column from the data frame and work with it.
One way that works well for interactive use is `$`.

```{r}
m = airquality$Month
class(m)
```

The form is `container$element` to extract the element from the container.

We can also use tab completion for `Month`, as in `airquality$M` then press tab.

Q: Which months are represented in the data?
If only we knew the unique months...

```{r}
unique(m)
```

How many from each month?

```{r}
table(m)
```


## load external files


Here is the easiest way to load the data:

```{r}
air = read.csv("http://webpages.csus.edu/fitzgerald/files/stat128/fall20/ad_viz_plotval_data.csv")
```

Q: What happened?
Was the file local or remote?

R visited a public URL, downloaded a data set, and loaded it into my R session.
Cool!


## your turn

Everyone: Download the data file for this week's homework.
It consists of air quality measurements around Sacramento for the last year.

Look at the output of the following functions:

```{r}
class
dim
head
summary
```

I'd like to know which sites are represented in this data set.
Try to figure it out.
I'll be standing by to help with voice or chat.

```{r}
table(air$Site.Name)
```
