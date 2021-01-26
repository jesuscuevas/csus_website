---
tags:
    - stat196k
---

- Navigate 


## Resources

- [Software Carpentry Unix Shell Lesson](https://swcarpentry.github.io/shell-novice/)
- notes from a [previous lecture on shell](https://github.com/clarkfitzg/sta141c-winter19/blob/master/lecture/01-31-bash1.md#shell)


## Motivation

Reasons to use the shell:

1. The shell can interact with remote machines.
    GUI's aren't always available; the shell is.
    For us, the shell will be the __only__ way to interact with our machines.
    By using it locally, we get relevant experience.
2. The shell is more efficient and precise than GUI's.
    For example, suppose you have 100 `.csv` files and 100 `.txt` files sitting in one directory, and you want to put the `.csv` files in one directory, and the `.txt` files in another.
    This is trivial with the shell.
3. We can easily automate commands in the shell by saving the commands in a file.
4. The shell is stable.
    For example, [`ls` has been listing directories since 1971](https://linuxgazette.net/issue48/fischer.html).
    Learn these tools, and they'll serve you for your whole career.
3. Many programs have only a shell interface, for example, `aws s3`.
4. The shell can compose programs with `|`, the pipe.
    This idea makes the shell a powerful tool for processing raw text data, and we'll practice this technique in this class.
5. The shell has much in common with other programs, particularly those with roots in UNIX.
    When you use them all, there is a synergistic effect in your efficiency.
    For example, what is the function to list objects in an environment in R?
    `ls()`, from the UNIX `ls`.
    There's also `rm`, `head`, `grep`, ... the list goes on :)


## Time Productivity Curve


## Command Summary


Command |   Mnemonic    |   Example
------- |   --------    |   -----------
`cd`    |   change directory    |   `cd class` sets current working directory to `class`
`mkdir` |   make directory    |   `mkdir class` creates a new directory called `class` inside the current working directory


## Correspondence between shell and file explorer windows


## Exercise

Open up a shell and perform the following tasks.
Turn in the commands you used, together with output.

1) Create a new directory `stat196k_exercise1` in your home directory.
2) Change your working directory to `stat196k_exercise1`.
3) Check the absolute pathname of the current working directory.
4) Create two files `data1.csv` containing just a single `1`, and `data2.csv` containing just a single `2`.
5) Verify the contents of these two files.
5) Create a directory called `data`.
6) Move all the `.csv` files into the directory `data` using a single command.
7) Copy the `.csv` files back from `data` into `stat196k_exercise1`. 
7) Verify using a single command that you have two copies of `data1.csv`, one in `stat196k_exercise1` and one in `stat196k_exercise1/data`.
