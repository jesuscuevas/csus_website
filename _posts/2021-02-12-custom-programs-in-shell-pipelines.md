---
tags:
    - stat196k
date: 2021-02-12
---

- write custom programs that work in shell pipelines

## Announcements

## Resources

- [Julia IO](https://docs.julialang.org/en/v1/base/io-network/)


## Exercise

Modify the above Julia program to create a command line program that behaves like `seq` when used with one argument:

```bash
$ seq 3
1
2
3
```

Call your program `seq.jl` and verify it behaves as follows (for any integer, not just 4):

```bash
$ julia seq.jl 4
1
2
3
4
```

Upload your program to Canvas as `seq.jl.txt`.
