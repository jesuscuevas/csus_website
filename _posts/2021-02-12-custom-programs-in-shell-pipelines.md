---
tags:
    - stat196k
date: 2021-02-12
---

- write custom scripts that work in shell pipelines


## Announcements

- You do not need to use custom scripts on HW due tomorrow.
- A couple people have asked for extensions on assignment, that's fine.
- HW specific text channels (good suggestion @lKappachino)
- Formatted code works better than screenshots in Discord- use backticks.

123 GO - How do you feel about HW due tomorrow?
For example, "fine", "program works, just need to write", "lost".


## Resources

- [Julia scripting FAQ](https://docs.julialang.org/en/v1/manual/faq/#man-scripting)
- [Julia IO](https://docs.julialang.org/en/v1/base/io-network/)


## Custom steps

When no existing shell program does what you want, then write your own program.

```
gunzip input.txt.gz |
    cut --fields=6-10 |
    ???? |              # <-- complex step, not easy to do in shell
    gzip > output.txt.gz
```

123 GO: What's an example of a complex data processing step that may not be easy to do in the shell?
Open ended question, be creative.


## Pick your language

We call the program a __script__, because it's usually just a single file, aka a script.
The script simply needs to produce `stdout` from `stdin`, and high level programming languages suitable for data science handle this use case.
That's why these languages are sometimes called scripting languages.

Here's an over the top example:

```
$ sqlite3 database.sqlite < selection.sql |
    bash sweet.sh |
    awk able.awk |
    Rscript rad.R |
    python pretty.py |
    julia joy.jl |
    ruby radiant.rb |
    octave maybe.m |
    perl peachy.pl > output.txt
```

In the above pipeline:

- `database.sqlite` is a local SQL database file
- `selection.sql` is a SQL query. The `sqlite3 database.sqlite < selection.sql` means that `sqlite3` takes `selection.sql` as standard input.
- `sweet.sh` is a bash script
- `able.awk` is an Awk script
- `rad.R` is an R script
- `pretty.py` is a Python script
- `joy.jl` is a Julia script
- `radiant.rb` is a Ruby script
- `maybe.m` is an Octave / Matlab script
- `peachy.pl` is a Perl script

They all work together by passing data from `stdin` to `stdout`.

123 GO - How many languages do you need to at least be familiar with to understand the above pipeline?

That's why I call this example "over the top".
These languages have significant overlap with one another, and it's reasonable to stick with one language when possible.


TODO: add hello world examples for R and python.


## Julia basic script

This is a basic example, not following best practices yet.

```
# Example usage:
#
# $ seq 3 | julia hello.jl
# hello 1
# hello 2
# hello 3


function greet(x)
    println("hello " * x)
end


# Process stdin
for line in eachline()
    greet(line)
end
```

Builtin variables in Julia relevant to shell pipelines:

- `stdin` standard input
- `stdout` standard output
- `ARGS` command line arguments

What great variable names!


## Julia script

Allow the user to specify behavior as a command line argument, and add `main()`.
This is closer to best practices.

```
# Example usage:
#
# $ seq 3 | julia hello2.jl bye
# hello 1bye
# hello 2bye
# hello 3bye


function greet(x, after = "")
    println("hello " * x * after)
end


# Process stdin
function main()
    user_after = ARGS[1]
    for line in eachline()
        greet(line, user_after)
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
```


## Exercise

Modify the above Julia program to create a script / command line program that behaves like `seq` when used with one argument:

```bash
$ seq 3
1
2
3
```

Call your file `seq.jl` and verify it behaves as follows (for any positive integer, not just 4):

```bash
$ julia seq.jl 4
1
2
3
4
```

Upload your program to Canvas as `seq.jl.txt`.
