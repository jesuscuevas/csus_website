---
tags:
    - stat128
---

- Extract patterns from strings

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-11-13.Rmd)

123 GO – What’s on your radio today?

Announcements:

- STAT 196K is live, see Canvas announcement
- I look forward to seeing your final projects
- dashboards (Shiny) starting Monday

Good question / comment on Discord, Aaron:

> @professor fitz For the homework, should we be focusing on predicting the interest rates for NIC and TIC interest types? There are some observations with an interest type of "O" with their interest set to values that aren't just numbers, for example "Fixed @ 3.92%, no TIC/NIC" or "A1 4.68% A2 adj LIBOR plus 2.05%." Are we expected to parse out the percentages from these values, or can we filter these out and just focus on the interest types of NIC/TIC?

Resources:

- The package `stringr` is popular for what we're doing here, and you're welcome to look into it and use it.


## Cities data

```{r}
citydebt = read.csv("~/Downloads/Cities.csv")
```

Suppose I want to find all the columns that have `"date"` in the name.
There's a lot of columns.

```{r}
colnames(citydebt)
```

We can use our new friend `grep`.

```{r}
grep("date", colnames(citydebt), ignore.case = TRUE, value = TRUE)
```


## Finding the year in text

How can I extract the year from these columns?
Let's list all the unique ways we could do it:

TODO: paste these in chat

```{r}
id = c("2005-1585", "2002-1342", "2020-0115", "2020-0169")
date_s = c("09/28/2005 12:00:00 AM", "07/16/2002 12:00:00 AM", "02/06/2020 12:00:00 AM")
```

1. Select first four characters of `id`.
2. Select the digits between the start of the string and `-` in `id`.
2. Delete everything in `id` starting with `-`.
3. Parse `date_s` into a date/time object, and then extract the year.
4. Find the four digit integer in `date_s`.

After all of them, you must convert the string to integer.

123 go: which is most robust?

First four characters:
```{r}
substring(id, 1, 4)
```

## Regular expressions are an art

Select the digits between the start of the string and `-` in `id`.

```{r}
m = regexpr("^[0-9]+-", id)
ydash = regmatches(id, m)
gsub("-", "", ydash)
```

Explanation:
- `^` matches the start of the string.
- `[0-9]` are ... the digits 0 through 9!
- `+` means one or more match of the previous character(s).
- `[0-9]+` means as many digits as possible.
- `-` is a literal `"-"`.

The pattern `"^[0-9]+-"` is called a __regular expression__.
Regular expressions are a domain specific language- a language to extract patterns in character strings.
They are very general and powerful, but there's a saying about them:

> You have a problem, and you say, "I know, I'll use regular expressions!"
> Now you have two problems.

This is a general purpose cliche, because you can substitute "regular expression" with any other technology :)

Here are my suggestions for regular expressions:

1. Avoid them when possible.
    This means don't try to use them for structured data, like the timestamps above.
1. First write down test cases describing exactly what you do and do not want to match.
1. Keep them as simple as possible.
2. Don't worry about performance unless it becomes intolerably slow.

Alternatively:

```{r}
gsub("(^[0-9]+)(-*)", "\\1 \\2", id)
```



## Converting text to calendar date and time

We've used dates before.
More generally, we can also have a date and time, aka timestamp.

```{r}
sd2 = as.POSIXct(date_s, format = "%m/%d/%Y %H:%M:%OS %p")
format(sd2, "%Y")
```


