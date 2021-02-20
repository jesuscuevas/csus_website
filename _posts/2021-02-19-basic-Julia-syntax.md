---
tags:
    - stat196k
---

- use basic syntax in Julia programming language

next week: stats

The goal today is to expose you to just those parts of Julia that you need to implement reservoir sampling for the [most recent homework]({% link _posts/2021-02-17-homework-sampling-stream.md %}).


## Announcements

- Iterative grading implemented
- See [video describing how to access Canvas feedback](https://youtu.be/iuZy0pckWlE)
- Travis wins speed challenge with a time of 1:20! 👏
- I played around with some different instances, and wasn't able to get past the network bottleneck of around 3:30 for [previous homework]({% link _posts/2021-02-05-homework-streaming-large-text-file.md %}).

123 GO - who is one person you admire?

Mistake in last lecture: The way I inferred a network bottleneck from looking at `top` cannot be exactly right.

If you have an explanation, I would love to hear it.

These things are still true:

- The network can be a bottleneck.
- Measure to see what the bottleneck is.

When I run the histogram pipeline on c4.xlarge with 4 vCPU's it takes 3:30.
Here's `top`:

```
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 4049 ec2-user  20   0   44948   1236   1128 S  78.1  0.0   0:07.47 unpigz
 4052 ec2-user  20   0  129340   8380   2060 R  60.8  0.1   0:05.94 sort
 4050 ec2-user  20   0  114648    760    700 S  49.2  0.0   0:04.74 cut
 4051 ec2-user  20   0  123636   1016    912 S  18.9  0.0   0:01.77 sed
 4055 ec2-user  20   0 1255408 383336  11236 S  15.9  5.0   0:04.80 aws
 2694 rngd      20   0  397100   4672   3832 S   0.3  0.1   0:24.59 rngd
```

When I run a simpler pipeline that simply counts lines (`aws s3 cp ... - | unpigz | wc -l`) on c4.xlarge it takes 1:30.
Here's `top`:

```
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 3829 ec2-user  20   0   44948   1320   1216 S 166.1  0.0   0:49.86 unpigz
 3832 ec2-user  20   0 1262060 398784  11188 S  55.5  5.2   0:18.67 aws
 3830 ec2-user  20   0  114644    724    660 R  17.9  0.0   0:05.39 wc
 2694 rngd      20   0  397100   4672   3832 S   0.7  0.1   0:24.15 rngd
 3852 ec2-user  20   0  171020   4484   3780 R   0.3  0.1   0:00.03 top
    1 root      20   0  191044   5388   3980 S   0.0  0.1   0:01.56 systemd
```


## Resources

Julia's official website has tons of [resources to help you learn](https://julialang.org/learning/).
Find one that works for you and follow along with it, since we won't be spending too much time exclusively on Julia in class.
Share the ones you find helpful on Discord.


## Content

Ask questions!

- Good: clarify conceptual differences between languages.
- Harder: really specific syntax or which function to use.

Modules organize objects in namespaces.
Use `import X` to use namespace lookups in module `X`.

```julia
import Random
Random.shuffle(1:5)
```


`using X` makes exported objects from the module `X` globally available.

```julia
using Random

shuffle(1:5)
```

Why `import` rather than `using`?

- Avoid name collisions if both modules export same name.
- Let's you be more clear and specific - tells you what's happening.

`?` enters the help menu to access builtin documentation.

`rand(x)` selects a random element from `x`.

```julia
rand([10, 20, 30])
rand(1:10)
```

When there are too versions of a function, `f(x)` and `f!(x)`, the convention is that `f!(x)` mutates `x`, meaning it modifies `x` in place.

```julia
x = [10, 20, 30]
shuffle(x)

shuffle!(x)
```


Mutation is an example of a side effect.
123 GO - Do side effects make it easier or more difficult to understand code?

Answer- more difficult, particularly for parallel programming.

Arrays are the basic container in Julia.

```julia
x = [10, 20, 30]

typeof(x)
```


We can select and assign elements in arrays based on indexes.

Julia uses 1 based indexing.

```julia
x[2]

# update
x[2] = 200
```


`1:n` represents a sequence of integers from `1` to `n`.

```julia
y = 1:10
```


When used inside brackets `[`, `end` represents the last element of an array.

```julia
x[length(x)]


x[end]

x[2:end]

x[1:end]

# syntactic sugar
x[end-1]

x[length(x) - 1]

x[-1]

x[end-2]
```


`end` closes the end of syntactic blocks, like `if` statements.

```
if 1 < 2
    println("sweet")
else
    println("uh oh")
end
```


Simple functions return the value of the last expression.

```
function foo(x)
    y = x + 1
    y * 2       # <-- last expression
end

foo(10)

function foo2(x)
    println("starting")
    y = x + 1
    return y * 2
    println("all done")
end

```

Office hours

```julia

function set_first_to_100!(x)
    x[1] = 100
end

x = [10, 20, 30]

set_first_to_100!(x)

```




## Exercise

See Canvas quiz
