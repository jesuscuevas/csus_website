---
tags:
    - stat196k
---

- use basic syntax in Julia programming language

The goal today is to expose you to just those parts of Julia that you need to implement reservoir sampling for the [most recent homework]({% link _posts/2021-02-17-homework-sampling-stream.md %}).


## Announcements

- Iterative grading implemented
- See [video describing how to access Canvas feedback](https://youtu.be/iuZy0pckWlE)

123 GO - who is one person you admire?


## Resources

Julia's official website has tons of [resources to help you learn](https://julialang.org/learning/).
Find one that works for you and follow along with it, since we won't be spending too much time exclusively on Julia in class.
Share the ones you find helpful on Discord.


## Content

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
