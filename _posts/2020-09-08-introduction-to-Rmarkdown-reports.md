---
tags:
  - stat128
---

- Create standalone HTML reports from Rmarkdown
- Embed graphics and code into HTML reports
- Change chunk parameters

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-09-09.Rmd)

References:

- [markdown documentation](https://daringfireball.net/projects/markdown/)
- [Rmarkdown documentation](https://rmarkdown.rstudio.com/)


## Motivation

We want to make beautiful reports.

Q: Why not just copy and paste the results from R into a Word document?

A: Reproducibility is the biggest challenge.
Nobody can tell what you did afterwards.


## Markdown

Why don't we just write HTML?

Q: Show of hands, who has experience editing HTML?

A: You don't really want to do it by hand.
But I'd rather edit HTML by hand than use MS Word. 😜

We need a source document format that is easy to write, and can be easily converted to most other kinds of documents, such as HTML, PDF, Word, etc.
That's markdown.

Markdown is __way__ easier to edit by hand than HTML.

[Wikipedia definition](https://en.wikipedia.org/wiki/Markdown): 

> Markdown is a lightweight markup language with plain-text-formatting syntax
> ...
> Its key design goal is readability – that the language be readable as-is, without looking like it has been marked up with tags or formatting instructions

For example, to create that link above, I write:

```
[--- anchor text ----](--------- URL ------------------------)
[Wikipedia definition](https://en.wikipedia.org/wiki/Markdown): 
```

Use descriptive anchor text.

Q: Why? What's wrong with "according to [this](https://en.wikipedia.org/wiki/Markdown) ..."?

A: Using "this" as anchor text does not tell you anything- you have to follow the link to see what they're talking about, and that's a burden for all users.

Best reason- so people with impaired vision can use the internet.
Here's what a user with a screen reader sees:

![screen reader bad links]({% link img/badlinks.jpg %})

Image source: <https://www.jimthatcher.com/webcourse4.htm>

Q: What do you think that __double underscore__ does to my text?

For example:

- __bold__
- _italics_
- ~~strike through~~

Of course, Markdown is intentially simple, so you do give up some features that you have in richer languages.
That's a feature, not a bug. 🐛
The simplicity helps you focus more on the content, less on the formatting.


## Rmarkdown

Rmarkdown is a variation on markdown that adds some R specific features.
Rstudio recognizes files that end with `.Rmd` as Rmarkdown files.


## Your turn

Take 5 minutes right now to create a new Rmd document, and try to run it.
Do the following:

- Define `x` as 100 samples from a Uniform(0, 1) distribution.
- Plot a histogram of `x`.
- Calculate the mean of `x`, and use it inside a sentence.

Help each other, and use the "call for help" feature.
Breakout rooms, go!


## Code Chunks

A __chunk__ is simply a logical block of code that should be grouped together.


## Chunk Options

There are several options to suppress and change output from the R chunks.
In general, I want to see your code for grading, so I'll ask you to use `echo = TRUE`.

`{r warning = FALSE}`
sqrt(-1)


## Inline R

```{r}
x = 100
```

We can inline R expressions by using backticks prefaced with r, like so.
For example, the value of `x` plus one is `r x+1`.
This eliminates the possibility of copy paste errors, a good thing!


## Pretty tables

Use `kable` from `knitr` to print nicely formatted tables, for example:

```{r}
library(knitr)
kable(head(cars))
```


## Mathematics

You can write LaTeX and knitr does the right thing.
Surround your LaTeX with $$, for example:
```
$$
\bar{x} = \sum_{i = 1}^n X_i
$$
```

## How `knitr` Works

The `knitr` package in R uses [pandoc](https://pandoc.org/) under the hood to convert to the target document format.

```
Rmd -> md -> pandoc -> output
```
