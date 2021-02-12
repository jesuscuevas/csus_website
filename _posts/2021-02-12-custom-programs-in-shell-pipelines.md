---
tags:
    - stat196k
date: 2021-02-12
---

- write custom programs that work in shell pipelines

## Announcements

- A couple people have asked for extensions on assignment, that's fine.


## Resources

- [Julia scripting FAQ](https://docs.julialang.org/en/v1/manual/faq/#man-scripting)
- [Julia IO](https://docs.julialang.org/en/v1/base/io-network/)


## When no existing shell program does what you want, then write your own script.

![]({% link img/lecture_sketch_placeholder.jpeg %})


## The script simply needs to produce `stdout` from `stdin`.

```
$ bash sweet.sh | R rad.R | python pretty.py | julia joy.jl
```


## Julia script hello world

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
function main()
    for line in eachline()
        greet(line)
    end
end
```

Builtin variables in Julia relevant to shell pipelines:

- `stdin` standard input
- `stdout` standard output
- `ARGS` command line arguments

What great names!


## Julia script hello world 2

Allow the user to specify behavior as a command line argument

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
```


## Exercise

Modify the above Julia program to create a script / command line program that behaves like `seq` when used with one argument:

```bash
$ seq 3
1
2
3
```

Call your file `seq.jl` and verify it behaves as follows (for any integer, not just 4):

```bash
$ julia seq.jl 4
1
2
3
4
```

Upload your program to Canvas as `seq.jl.txt`.
