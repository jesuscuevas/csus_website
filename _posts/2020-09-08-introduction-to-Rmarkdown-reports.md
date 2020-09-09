---
tags:
  - stat128
---

- Create standalone HTML reports from Rmarkdown
- Embed graphics and code into HTML reports
- Change chunk parameters

[Live notes]({% link files/stat128/fall20/2020-09-09.Rmd %})

References:

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

A: Best reason- so people with vision problems can use the internet.
    That's how the web is designed to work.
    The link above does not tell you anything- you have to follow the link to see what they're talking about, and that's a burden for all users.

Q: What do you think that __double underscore__ does to my text?

For example:

- __bold__
- _italics_
- ~~strike through~~
