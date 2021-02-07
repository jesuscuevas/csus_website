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
- Don't look at Discord and think "everyone gets it except for me" 😢
    We're all starting from different places, and the goal is for us all to grow.
- Beginner focused office hours after class today.


## Resources

- Software Carpentry [Pipes and Filters Lesson](https://swcarpentry.github.io/shell-novice/04-pipefilter/index.html)
- Wikipedia [Software Filters](https://en.wikipedia.org/wiki/Filter_(software))
- [Bash Redirection](https://www.gnu.org/software/bash/manual/html_node/Redirections.html)


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
For example:

It often helps to write down in prose what you are trying to do.

### 2. Take one step at a time

### 3. Write clear, explicit code

Use verbose options and clear formatting.
Writing 

### 3. Save your work

### 3. Iterate

Once you have something that minimally does what you want, try to run it on the full data set.
You'll most likely have problems, and then you'll need to identify and fix them.
Update your original minimal working example to include the problematic data.


## Exercise
