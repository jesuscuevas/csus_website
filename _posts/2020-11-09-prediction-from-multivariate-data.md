---
tags:
    - stat128
---

- Describe the purpose of record identifiers, and why they should be excluded from models
- Identify patterns in text

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-11-09.Rmd)

123 GO – What’s your word of the day

Announcements:

- No class on Wednesday, Nov. 11th - Veteran's Day
- Final project proposal due Thursday


## Computed columns

In the last homework, we did something similar to the following:

```{r}
n = 100
x = sort(2.5 * runif(n))
y = x^2 - 2*x + 7 + rnorm(n, sd = 0.1)

fit1 = lm(y ~ x + I(x^2))

plot(x, y)
lines(x, predict(fit1))
```

`x^2` was computed from `x`.
In general, we often have __multivariate data__, with many columns in a data frame.
We can predict one numeric response using multiple columns.

```{r}
d = data.frame(y, x, xsquared = x^2)

fit2 = lm(y ~ ., data = d)

plot(x, y)
lines(x, predict(fit1), col = "blue", lwd = 2)
```

The formula `y ~ .` says model `y` as a linear function of every other column in the data frame.
`fit1` and `fit2` produce the same object

Here's some real multivariate data :)


## City Debt Data

You wanted something finance- here you go!
The next homework will be focused on this.

The [California DebtWatch](https://data.debtwatch.treasurer.ca.gov/Raw-Data/CDA-ALL-Raw/x7jp-pweb) contains the following information:

> The principal amounts, sale dates, interest rates, terms, purposes, ratings, costs of issuance, financing team participants, issuance documents, and annual reporting (if applicable), among 67 other data points required under California Government Code section 8855, of the various types of debt issued by all state and local government agencies in California.

I LOVE these open government data sets in raw form.

- true transparency in government operations
- they're great for statistics classes 😎

Suppose you're comparing credit cards, student loans, auto loans, home loans.

Q: What's the most important characteristic of any debt?
What makes you pick one option over another?

A: Interest rate!


## Group Activity

3rd person alphabetically in group to share.
Two questions:

1. Which columns do you think will be important for predicting interest rate, and why?
2. Which columns will not be important, or should be excluded from predicting interest rate?

Look at

1. [column descriptions](https://www.treasurer.ca.gov/cdiac/debtdata/database_text.asp)
2. [raw data](https://data.debtwatch.treasurer.ca.gov/Raw-Data/CDA-ALL-Raw/x7jp-pweb) see bottom of page


## Record Identifiers

Record / row identifiers uniquely identify a record in a database.
They're also called "keys".
Usually, they're a computer generated number or short character string.

Q: Consider all the courses at CSUS listed in a course catalog.
What is the record identifier for this class?

A: "STAT 128" 


Q: What's a record identifier for an individual person in the United States?

A: Social security number, which is used, for example, to check your credit history.


Q: What's the row identifier in the above data set?

A: CDIAC (California Debt and Investment Advisory Commission) Number

> The CDIAC Number is a unique sequential number that, along with the issuance year (the year in which the issuance was entered into the CDIAC database), identifies the issuance. This number is assigned by CDIAC’s system at the time the issuance is added to the database. The numbering sequence is reset to “0001” at the beginning of each calendar year.


Q: What's the purpose of a record identifier?

A: If you're interested in a particular record, you can quickly look it up.
There is another person in California who shares my first and last name and my birthday, but he has a different middle name.
In 2006 he got a speeding ticket, and it showed up on MY driving record.


Q: Should we use record identifiers for data analysis, say building models?

A: NO!
They can be a proxy for another variable, often date.
Unlike dates, keys can be anything for any reason, as long as they're unique.

Suppose you want to build a model to predict whether something happened before or after a certain date.
If you use an integer record identifier as a predictor, then it's like predicting the date from the date, which is silly.


## Identifying patterns in text

Statistics needs numbers to work, but sometimes all you have is a bunch of text.
There are many ways to compute numbers from text.
Perhaps the simplest way to is to check for the existence of a particular pattern, and output 1 if we find a match, and 0 otherwise.
That's what `grepl` does.

For example, suppose we want to find which of the following elements of a character vector contain the string "lease".

```{r}
debt_type = c("Conduit revenue bond"
    , "Special assessment bond"
    , "Certificates of participation/leases"
    , "Tax allocation Bond"
)

grepl("lease", debt_type)
```

Case sensitivity matters.

```{r}
grepl("bond", debt_type, ignore.case = FALSE)  # Default

grepl("bond", debt_type, ignore.case = TRUE)
```

We can use this to create new logical columns from text columns, and use these logical columns for further analysis.


From [Wikipedia's entry on GREP](https://en.wikipedia.org/wiki/Grep):

> grep is a command-line utility for searching plain-text data sets for lines that match a regular expression. Its name comes from the ed command g/re/p (globally search for a regular expression and print matching lines), which has the same effect.[3][4] grep was originally developed for the Unix operating system, but later available for all Unix-like systems and some others such as OS-9.[5]

Original use- data science!

> Thompson wrote the first version in PDP-11 assembly language to help Lee E. McMahon analyze the text of the Federalist Papers to determine authorship of the individual papers.[7]
