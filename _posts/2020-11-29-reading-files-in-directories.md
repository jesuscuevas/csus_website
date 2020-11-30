---
tags:
    - stat128
---

- Read, write, rename, and move files in directories

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-11-30.Rmd)

123 GO – 

Announcements:


## File and directory structure

On the right hand side of the Rstudio pane there is a file browser.
Directories (folders) contain files.
123 GO: Give an example of a kind of file.

We're often interested in a handful of files:

- `.Rmd` files, R markdown documents
- `.html` files, reports generated from R markdown
- `.R` files, R scripts
- `.csv` files, containing tabular data

Much of data analysis is simply reading, writing, and organizing files.
Some people call this __utility scripting__.
It saves you the trouble of doing the same thing over and over again.
For example, resize every image in a directory.

Computers do repetition better than people do.
Anyone got any fun examples of doing the same thing over and over manually?


## Working directory

Like many computer languages, R maintains a __current working directory__.
Let's see where we are.

```{r}
getwd()
```

get `wd`, for working directory.
I can list the files here:

```{r}
list.files()
```

If we want to go into my `~/projects/stat128` directory I can set `wd`

```{r}
setwd("~/projects/stat128")
```

123 go:
I changed the directory.
If I now list the files, will they be the same, or different than what we had above?

Ans: In general they're different.

```{r}
list.files()
```


## Making new directories.

Here's some data to play around with.

```{r}
d = read.csv(text = "language,word
en,hello
en,goodbye
sp,hola
sp,adios
kor,안녕")
```

Here I created a data frame by simply writing out a single string containing a CSV file, and then read it into R.
For nearly anything other than simple examples, you'll call `read.csv` on a file or a file like object.

Let's make a new directory called `languages`, split this data apart, and create a new file for each language.


```{r}
dir.create("languages")
```

We see this new directory appear in our file browser.


## Relative directories

I'd like to save all the english words in a file called `en.csv` within the new languages directory.

```{r}
e = d[d$language == "en", ]
```

What happens if I just save the file here?

```{r}
e_file = paste0(e[1, "language"], ".csv")
write.csv(e, e_file)
```

It ends up in the same directory as languages.
It's not inside the languages directory where I want it.
I can specify a __file path__ relative to my current working directory.
A file path is the precise location of a particular file.

```{r}
e_file2 = file.path("languages", e_file)
```

123 GO: What benefits do file paths give us?
Ans: For one, they allow us to have files with the same names.
Think about every "hw1.pdf" you've had in college :)


## Writing the files

Now I'll just proceed to do all of them...

```{r}
e = d[d$language == "en", ]
k = d[d$language == "kor", ]
s = d[d$language == "sp", ]
...
```

What's wrong with this?
DRY.
Don't repeat yourself.
Anytime you're writing code and you see the same thing 5+ times in a row, figure out a better way.

So what's the solution here?
We can use the split, apply strategy to save these files.

I'll copy and paste what I had above, and then abstract it into a function.
You can't see this process too many times!

```{r}
save_one_file = function(x)
{
    xfile = paste0(x[1, "language"], ".csv")
    xfile2 = file.path("languages", xfile)
    write.csv(x, xfile2, row.names = FALSE)
}
```

Now we split and apply.

```{r}
l = split(d, d$language)
lapply(l, save_one_file)
```

We can check that our answers showed up where we wanted them:

```{r}
list.files("languages")
```


## Reading the files in

Here's a common task: read all the files in from a particular directory:

```{r}
file_names = list.files("languages", full.names = TRUE)

langs = lapply(file_names, read.csv)

d2 = do.call(rbind, langs)
```


## Cleaning up

When we're done, we'll just delete the languages directory and everything in it.

```{r}
unlink("languages", recursive = TRUE)
```

BOOM!
There's nothing left.

```{r}
list.files()
```

Think `unlink` with `recursive = TRUE` is dangerous?
You betcha!
With great power comes great responsibility.
None of that recycling bin garbage for us, we're programmers.
