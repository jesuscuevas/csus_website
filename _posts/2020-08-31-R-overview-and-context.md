---
tags:
    - stat128
---

- Describe use cases for R at a high level: interactivity, visualization, data analysis, and statistical modeling
- Describe difference between R and RStudio


## R is a high level language

Ocean drawing - GUI's in the air, languages underwater.

Highest are the GUI's
(Graphical User Interface):

Q: What GUI's do you know for data analysis?

1. JMP
2. Tableau
1. Excel

Q: Show of hands, who has any experience programming?

Q: Name some computer languages.

Computer languages From high to low, a rough characterization:

1. SQL  `SELECT name FROM students WHERE major = "mathematics"`
1. R, Python, Julia
2. Java, C++
3. C
4. Assembly / Machine code

Einstein quote: "The idea should be as simple as possible, but no simpler."
The same principal applies to languages.
To be most productive, you usually want to program in the highest level language you can, because it requires orders of magnitude less code.


### Computer programs are just text files.

Usually programs use a specific file extension.
For example, we might use `hw1.R` or `hw1.Rmd`.

Q: Why is programming intimidating?

Your program must be perfect to run.
Every single piece of syntax in the right place.


### Integrated development environments (IDE's) help you write code.

Programming languages are often associated with one or more IDE's, integrated development environment.

Q: Can we think of some examples?

- Java has Eclipse
- Python has Pycharm
- R has Rstudio


### Rstudio is the most common IDE for R.

Rstudio works great.
I don't usually use it, but I think it's the best tool for this class because it makes producing beautiful reports easy.

Q: Who uses a general purpose text editor?

There's also general purpose text editors, like Sublime, emacs, and vim.
If you program in many languages, it's worth developing your skills using a text editor.

If you have problems with your editor, it will be harder for us to help you.


### Language wars will waste your time.

"There are two kinds of programming languages- those that people complain about, and those that nobody use."

People develop strong emotional attachments to their languages.
There's a lot of snobbiness out there.
Flame wars.
Let's try not to add to it.


### R was made for statisticians, by statisticians.

R's whole design philosophy comes from this.

Q: What does this mean?

R is designed for:

- processing data
- statistical analysis
- interactivity, meaning you don't need much code to do standard statistical analysis.
     For example, `lm(y ~ ., data)` does multivariate linear regression.
- visualization

R may behave quite differently than other more rigid languages, and we can talk about this in office hours.


### Lets open up Rstudio and play.

I invite you to follow along online.
