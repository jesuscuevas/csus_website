---
tags:
    - stat196k
---

- use basic syntax in Julia programming language

The goal today is to expose you to just those parts of Julia that you need to implement reservoir sampling for the [most recent homework]({% link _posts/2021-02-17-homework-sampling-stream.md %}).


## Announcements

- Iterative grading implemented
- See [video describing how to access Canvas feedback](https://youtu.be/iuZy0pckWlE)
- I played around with some different instances, and wasn't able to get past the network bottleneck of around 3:30 for [previous homework]({% link _posts/2021-02-05-homework-streaming-large-text-file.md }).

123 GO - who is one person you admire?

Error: How I thought pipelines get bottlenecks cannot be exactly right.

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

When I run a simpler pipeline (`wc -l`) on c4.xlarge it takes 1:30.
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

When I run the histogram pipeline on c4.4xlarge which has 16 vCPUs it takes 2:59.
Here's `top`:


```
   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
  4970 ec2-user  20   0   44948   1228   1124 S 103.3  0.0   1:37.66 unpigz
  4973 ec2-user  20   0  133436   8324   2004 R  67.3  0.0   1:02.99 sort
  4971 ec2-user  20   0  114648    728    664 S  52.0  0.0   0:49.05 cut
  4976 ec2-user  20   0 1262828 423832  11136 S  22.7  1.4   0:22.60 aws
  4972 ec2-user  20   0  123636    960    860 S  17.0  0.0   0:16.39 sed
  4075 rngd      20   0  169760   4580   3740 S   0.7  0.0   0:06.40 rngd
  4977 ec2-user  20   0  171036   4360   3796 R   0.3  0.0   0:00.15 top
```

Observe that `unpigz` is using slightly higher CPU (103%) vs. the c4.xlarge (78%).



## Resources

Julia's official website has tons of [resources to help you learn](https://julialang.org/learning/).
Find one that works for you and follow along with it, since we won't be spending too much time exclusively on Julia in class.
Share the ones you find helpful on Discord.


## Content

Ask questions!

- Good: clarify conceptual differences between languages.
- Harder: 

Modules organize objects in namespaces.
Use `import X` to use namespace lookups in module `X`.

`using X` makes exported objects from the module `X` globally available.

`?` enters the help menu to access builtin documentation.

`rand(x)` selects a random element from `x`.

When there are too versions of a function, `f(x)` and `f!(x)`, the convention is that `f!(x)` mutates `x`, meaning it modifies `x` in place.

Mutation is an example of a side effect.
123 GO - Do side effects make it easier or more difficult to understand code?

Arrays are the basic container in Julia.

We can select and assign elements in arrays based on indexes.

`1:n` represents a sequence of integers from `1` to `n`.

When used inside brackets `[`, `end` represents the last element of an array.

`end` closes the end of syntactic blocks, like `if` statements.

Simple functions return the value of the last expression.


## Exercise

See Canvas quiz
