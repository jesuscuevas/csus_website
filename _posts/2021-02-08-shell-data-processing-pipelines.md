---
tags:
    - stat196k
---

- describe how a filter program processes standard input (`stdin`) into standard output (`stdout`)
- interactively develop data processing pipelines using standard shell commands
- create minimal working examples to check programs


## Announcements

- The Canvas wiki looks great!
    Let me know if you want more pages.
- Don't look at Discord and think, "everyone gets it except for me." 😢
    Instead, think, "Wow, there's so much cool stuff here for me to learn!" 😁
- Beginner focused office hours after class today.


## Resources

- Software Carpentry [Pipes and Filters Lesson](https://swcarpentry.github.io/shell-novice/04-pipefilter/index.html)
- Wikipedia [Software Filters](https://en.wikipedia.org/wiki/Filter_(software))
- [Bash Redirection](https://www.gnu.org/software/bash/manual/html_node/Redirections.html)


## Filter programs process standard input into standard output

![filter program]({% link img/lecture_sketch_placeholder.jpeg %})

123 GO - Can filters produce more data to `stdout` than comes in through `stdin`?


## Join two or more filters together into a pipeline

![pipeline]({% link img/lecture_sketch_placeholder.jpeg %})

The UNIX philosophy is to take many small, specialized programs and join them together in useful ways.

123 GO - Below we have 10 commands.
How many different pipelines with 5 commands can we potentially create?


## Commands

Command |   Mnemonic    |   Example
------- |   --------    |   -----------
`cut`   |           |
`head`  |   head        |   `$ head README` prints out the first few lines in the file README
`grep`   |           |
`gzip`  |   zip?        |   `$ gzip README` compresses the file `README`, saves it in the file `README.gz`, and deletes `README`
`gunzip`  |   unzip        |   `$ gunzip README.gz` decompresses the file `README.gz`, saves it in the file `README`, and deletes `README.gz`
`sed`   |           |
`sort`   |           |
`tail`   |           |
`time`  |   time        |   `$ time cp a.txt b.txt` prints out the time required to run the command `cp a.txt b.txt`
`uniq`   |           |


## Redirection

Command |   Mnemonic    |   Example
------- |   --------    |   -----------
`>`     |   overwrite   |   After you run `$ echo "hello" > world.txt`, the file `world.txt` will contain the single line `hello`.
`>>`    |   append      |   `$ echo "hello" >> world.txt` appends the line `hello` to whatever was already in `world.txt`.
`|`     |   pipe        |   `$ echo "bac" | fold --width=1 | sort` produces the sorted output lines `a`, `b`, `c`


## A principled approach to building shell pipelines

Shell pipelines 
These principles can also apply to 

### 1. Define goal

Start with a precise, explicit goal, expressed as a minimal working example.
It often helps to write down in prose what you are trying to do.

Here's an example:

```
echo "D,bill
R,George
D,Barack
R,Donald
D,Joe" > presidents.csv
```

Our goal is to count up all the names that start with each letter.
We want to produce a table of counts like this:

```
     2 b
     1 d
     1 g
     1 j
```


### 2. Take one step at a time

Just do one thing that gets you closer to goal, and check that it does what you expected on your minimal working example before trying another step.
If there are many possible steps, then pick the one that will simplify the data and the next task, as much as possible.

```
$ cut --delimiter=, --fields=2 presidents.csv
bill
George
Barack
Donald
Joe
```


### 3. Write clear, explicit code

Use verbose options and clear formatting.
Unfortunately, options are not always __portable__, which means the same command might not work on two different versions of the shell.

```
cut --delimiter=, --fields=2 presidents.csv |
    cut --characters=1 |
    tr [:upper:] [:lower:] |
    sort |
    uniq --count
```

The pipelines above and below are exactly equivalent, except for the way they are written.
Which one is easier to explain and maintain?

```
cut -d, -f2 presidents.csv | cut -c1 | tr [:upper:] [:lower:] | sort | uniq -c
```


### 4. Save your work

When you do get a step that works, save it into a script file.
It can also be useful to record commands you try that don't work, as well as your thought process.
For example, here are some [experiments I did to explore the capabilities of aws streaming](https://github.com/clarkfitzg/stat196K/blob/main/s3_wildcard_copy.sh).


### 5. Iterate

Once you have something that minimally does what you want, try to run it on the full data set.
You'll most likely have problems, and then you'll need to identify and fix them.
Update your original minimal working example to include the problematic data.


## Exercise

1. Use `grep` to find all the rows in `presidents.csv` beginning with `D`.
2. Write a simple pipeline with `gzip` followed by `gunzip`.
    This is called a "round trip", with data first being compressed, and then uncompressed.
    Can pipes handle binary data, in addition to text?
3. Use `sed` to transform `presidents.csv` into the following output:

```
DEM,bill
REP,George
DEM,Barack
REP,Donald
DEM,Joe
```
