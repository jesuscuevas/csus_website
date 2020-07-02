---
layout: single
title: Introduction to Julia's Debugger
date: 2020-06-19 08:34
comments: false
categories: julia, debugging, software
---

This post demonstrates [Julia's Debugger](https://github.com/JuliaDebug/Debugger.jl) through some simple examples.

## Introduction

Learning how to use a debugger was an important milestone in my growth as a programmer.
I thought I was doing fine without it, but I just didn't know what I was missing.
A debugger allows you to stop a program in the middle of execution and interact directly with the software that you've written.
Debuggers validate your mental model of the program you've written, and your model of the language itself.
Duncan Temple Lang once remarked, "before you learn anything in a new programming language, you should learn the debugger."
I'm taking his advice.

What follows is a brief, self contained, introduction to Julia's debugger.
You may also enjoy Norm Matloff's [general resources on debugging](http://heather.cs.ucdavis.edu/~matloff/debug.html).


## Stepping Through a Program

We start by loading Debugger and defining a simple function, `f`.
```julia
using Debugger

f = function(x, y = 2)
    z = 3
    x + y + z
end
```

We can enter the debugger by prefacing a function call with the aptly named macro `@enter`.
```julia
@enter f(1)
```

The debugger displays the following output.
```julia
In #1(x, y) at REPL[1]:1
 1  f = function(x, y = 2)
 2      z = 3
>3      x + y + z
 4  en

About to run: (+)(1, 2, 3)
1|debug>
```

This means that the current program state is paused inside the call `f(1)`.
The `>` symbol in front of line 3 means the debugger is ready to run line 3: `x + y + z`.
The prompt has changed to `1|debug>`, since we are in the debugger, not the Julia REPL.

From the debug prompt, we can enter any valid Debugger commands.
Type `?` followed by enter to see the possible commands.

```julia
1|debug> ?
  Debugger commands
  ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡

  Below, square brackets denote optional arguments.

  Misc:
  - o: open the current line in an editor
  - q: quit the debugger, returning nothing
  ... (and many more)
```

Let's start by looking at the variables in our current frame.
These are the local variables inside the function.
We expect to see `x, y, z` bound to `1, 2, 3`.
```julia
1|debug> fr
[1] #1(x, y) at REPL[1]:1
  | x::Int64 = 1
  | y::Int64 = 2
  | z::Int64 = 3
```

Indeed they are.
To evaluate any Julia expression, we type `` ` `` (a backtick) and Debugger gives us a Julia prompt.
We can call functions on the local variables _based on their current state in the function execution_.
```julia
1|julia> 2*x
2
```

We can also manipulate the state of the computation.
Suppose we would like to see what happens in the rest of the function if `x = 2.0`.
```julia
1|julia> x = 2.0
2.0
```

Type Ctrl+C to exit the Julia prompt and return to the debug prompt.
```julia
1|julia> ^C

1|debug>
```

Inspecting the variables in our current frame shows the new value for `x`.
```julia
1|debug> fr
[1] #1(x, y) at REPL[1]:1
  | x::Float64 = 2.0
  | y::Int64 = 2
  | z::Int64 = 3
```

`n` steps to the next line in the function body, which is the implicit `return` statement.
The call returns `2.0 + 2 + 3 = 7.0`.
```julia
1|debug> n
In #1(x, y) at REPL[1]:1
 1  f = function(x, y = 2)
 2      z = 3
>3      x + y + z
 4  en

About to run: return 7.0
```

`c` continues execution until a breakpoint is hit.
We didn't add any breakpoints, and we're already at the `return` statement anyways, so the call returns and we exit the debugger, returning to the main Julia REPL.
```julia
1|debug> c
7.0

julia>
```

That's it for the basic introduction.
The next example contains an actual bug.


## Stopping on Error

It's often useful to stop and enter the debugger when an error occurs, so we can examine the state of the program under the exact conditions that produced the error.
We do this with Debugger by calling `break_on(:error)`, then `@run` in front of the expression that produces the error.
Hopefully, this investigation will lead us to the root cause.

The following code calculates and prints `2*3 + 4`, but it contains two bugs.

```julia
axpy1 = function(a, x, y)
    ax + y
end

f1 = function()
    a = 2
    x = 3
    y = 4
    println("If a = $a, x = $x, y = $y, then ax + y = $(axpy1(x, y, a))")
end
```

When we call `f1()`, we see the following error message:
```julia
julia> f1()
ERROR: UndefVarError: ax not defined
Stacktrace:
 [1] (::var"#5#6")(::Int64, ::Int64, ::Int64) at ./REPL[45]:2
 [2] (::var"#9#10")() at ./REPL[48]:5
 [3] top-level scope at REPL[49]:1
```

We don't need debugging to fix this error.
This error message tells us exactly what the problem is: we never defined the variable `ax`.
Our program is simple, and the stack trace only contains three frames, so if we have the correct mental model of how the language works, then we can reason through it to fix the error.

Debugging becomes truly useful when the problem is __not__ obvious.
The error message may be uninformative, the program may be complex, and the stack trace may contain more frames than you can fit in your head.
If you hit an error, and you don't know what's wrong, then run the same code through the debugger, as follows.
```julia
julia> break_on(:error)

julia> @run f1()
Breaking for error:
ERROR: UndefVarError: ax not defined
Stacktrace:
 [1] (::var"#11#12")(::Int64, ::Int64, ::Int64) at REPL[52]:2
 [2] (::var"#13#14")() at REPL[53]:5

In #11(a, x, y) at REPL[52]:1
 1  axpy1 = function(a, x, y)
>2      ax + y
 3  en

About to run: (+)(Main.ax, 2)
1|debug>
```

We are now in the debugger prompt, _inside the call to `axpy1()`,_ so we can enter any of the debugger commands.
The error message said variable `ax` is not present.
What variables are present?
Let's see.
```julia
1|debug> fr
[1] #11(a, x, y) at REPL[52]:1
  | a::Int64 = 3
  | x::Int64 = 4
  | y::Int64 = 2
```

We have `a`, `x`, and `y`, but no `ax`.
Ah, of course: we should have written `a*x` instead of `ax`.
Let's fix this bug:
```julia
axpy2 = function(a, x, y)
    a*x + y
end

f2 = function()
    a = 2
    x = 3
    y = 4
    println("If a = $a, x = $x, y = $y, then ax + y = $(axpy2(x, y, a))")
end
```

<!--
Julia allows [juxtaposed expressions like `10x`](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/#man-numeric-literal-coefficients-1), but no sane programming language can know that `ax` should actually mean `a*x`, even if the mathematical notation was perfectly clear to the human reader.
-->

We call it as follows:
```julia
julia> f2()
If a = 2, x = 3, y = 4, then ax + y = 14
```

That's not right.
`2 * 3 + 4 = 10`, not `14`.
This is an altogether more troubling class of bug: one that executes perfectly fine, but produces the wrong answer. 😭
`break_on(:error)` doesn't help us here, because there is no error to break on.
Let's use another debugging technique, breakpoints, to find what went wrong.


## Setting Breakpoints

Breakpoints tell the debugger to stop executing code, and instead drop you into an interactive debugger prompt so that you can look around.

One simple way to add a breakpoint is to add the macro `@bp` to the line of the source code where you want to stop and examine the state.
Let's add `@bp` inside of the `axpy` function, which makes this equivalent to debugging when the `axpy` function is called.
In practice, you might add `@bp` deep in a loop in a conditional branch, so it only enters the debugger in the one case you're interested in.
```julia
axpy3 = function(a, x, y)
    @bp
    a*x + y
end

f3 = function()
    a = 2
    x = 3
    y = 4
    println("If a = $a, x = $x, y = $y, then ax + y = $(axpy3(x, y, a))")
end
```

If we run this code normally, then it behaves as before.
In particular, leaving `@bp` in the code does not cause Julia to enter the debugger.
```julia
julia> f3()
If a = 2, x = 3, y = 4, then ax + y = 14
```

To stop at the break point and enter the debugger, we need to preface the code with `@run`.
```julia
julia> @run f3()
Hit breakpoint:
In #23(a, x, y) at REPL[62]:1
 1  axpy3 = function(a, x, y)
●2      @bp
>3      a*x + y
 4  en

About to run: (*)(3, 4)
1|debug>
```

We hit the breakpoint that we added inside the definition of `axpy3`, so we're now back in the debugger.
`●2` indicates the breakpoint we hit on the second line, and `>3` indicates the next line to run.
Let's look at the variables in our current frame, the call to `axpy3`.
```julia
1|debug> fr
[1] #23(a, x, y) at REPL[62]:1
  | a::Int64 = 3
  | x::Int64 = 4
  | y::Int64 = 2
```

Fine, `a`, `x`, and `y` are all defined and nothing looks too terribly wrong.
Debugger allows us to step __up__ the [call stack](https://en.wikipedia.org/wiki/Call_stack), into the parent frame of the call to `axpy3()` where we encountered the breakpoint.
The command is `up`.
```julia
1|debug> up
In #25() at REPL[63]:1
 1  f3 = function()
 2      a = 2
 3      x = 3
 4      y = 4
>5      println("If a = $a, x = $x, y = $y, then ax + y = $(axpy3(x, y, a))")
 6  en

About to run: (var"#23#24"())(3, 4, 2)
2|debug>
```

We are inside the call to `f3()`, which called `axpy3()`.
In addition, the prompt changed to `2|debug>`, indicating that we are on frame 2.
Let's probe the state of the evaluation.
```julia
2|debug> fr
[2] #25() at REPL[63]:1
  | a::Int64 = 2
  | x::Int64 = 3
  | y::Int64 = 4
```

In this frame, we still have the same variables `a`, `x`, and `y`, but because of [Julia's lexical scoping rules](https://docs.julialang.org/en/v1/manual/variables-and-scoping/) _they're not the same as the `a`, `x`, and `y` in frame 1_.
Press `` ` `` (literal backtick) to enter the Julia REPL where can evaluate our `axpy3` function in the frame where it appeared to have a problem:
```julia
2|julia>

2|julia> axpy3(a, x, y)
10
```

`2 * 3 + 4 = 10`, so our `axpy3` function works just fine.
The bug lies in `f3`, where we call `axpy3(x, y, a)` with the arguments in the wrong order.
Type `^C` followed by `q` to get back to the main Julia REPL.

Maybe it wasn't the best idea to bury our call to `axpy3` inside this string interpolation.
Let's fix the bug.
```julia
axpy4 = function(a, x, y)
    a*x + y
end

f4 = function()
    a = 2
    x = 3
    y = 4
    z = axpy4(a, x, y)
    println("If a = $a, x = $x, y = $y, then ax + y = $z")
end
```

Does it work?
```julia
julia> f4()
If a = 2, x = 3, y = 4, then ax + y = 10
```

Problem solved.


## An __Actual__ Bug

I get lots of practice using debuggers, because I write lots of bugs.
I wrote the following buggy program to solve [Project Euler number 18](https://projecteuler.net/problem=18).

```julia
maxsum = function(datafile = "18example.txt")
    oldmax = [0]
    for line in eachline(datafile)
        weights = parse.(Int, split(line))
        newmax = similar(weights)
        for (i, wi) in enumerate(weights)
            largest_parent = if i == 1
                    # The left side of the triangle
                    oldmax[i]
                elseif i == length(weights)
                    # The right side of the triangle
                    oldmax[i-1]
                else
                    # The middle of the triangle
                    maximum(oldmax[(i-1):i])
                end
            newmax[i] = largest_parent + wi
        end
    end
    maximum(newmax)
end
```

If you'd like to follow along, create a file called `18example.txt` with the following contents:
```
3
7 4
2 4 6
8 5 9 3
```

`maxsum` produces an error when I try to use it.

```julia
julia> maxsum()
ERROR: BoundsError: attempt to access 1-element Array{Int64,1} at index [1:2]
Stacktrace:
 [1] throw_boundserror(::Array{Int64,1}, ::Tuple{UnitRange{Int64}}) at ./abstractarray.jl:542
 [2] checkbounds at ./abstractarray.jl:507 [inlined]
 [3] getindex at ./array.jl:817 [inlined]
 [4] (::var"#1#2")(::String) at ./REPL[26]:16
 [5] (::var"#1#2")() at ./REPL[26]:2
 [6] top-level scope at REPL[27]:1
```

I didn't immediately notice the error, so I pulled out the debugger and went straight to the help menu to remind myself of the syntax.

```julia
julia> using Debugger

julia> break_on(:error)

julia> @run maxsum()
Breaking for error:
ERROR: BoundsError: attempt to access 1-element Array{Int64,1} at index [1:2]
Stacktrace:
 [1] throw_boundserror(::Array{Int64,1}, ::Tuple{UnitRange{Int64}}) at abstractarray.jl:542
 [2] checkbounds(::Array{Int64,1}, ::Tuple{UnitRange{Int64}}) at abstractarray.jl:507
 [3] getindex(::Array{Int64,1}, ::UnitRange{Int64}) at array.jl:817
 [4] (::var"#3#4")(::String) at /Users/clark/projects/summer20euler/clark/18.jl:19
 [5] (::var"#3#4")() at /Users/clark/projects/summer20euler/clark/18.jl:5

In throw_boundserror(A, I) at abstractarray.jl:542
>542  throw_boundserror(A, I) = (@_noinline_meta; throw(BoundsError(A, I)))

About to run: (throw)(BoundsError([0], (1:2,)))
1|debug> ?
  Debugger commands
  ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
 ...
```

The first couple frames didn't look familiar, so I crawled up the stack.

```julia
1|debug> up
In checkbounds(A, I) at abstractarray.jl:505
 505  function checkbounds(A::AbstractArray, I...)
 506      @_inline_meta
>507      checkbounds(Bool, A, I...) || throw_boundserror(A, I)
 508      nothing
 509  end

About to run: (Base.throw_boundserror)([0], (1:2,))
2|debug> up
...
3|debug> up
In #3(datafile) at /Users/clark/projects/summer20euler/clark/18.jl:4
 15                  # The right side of the triangle
 16                  oldmax[i-1]
 17              else
 18                  # The middle of the triangle
>19                  maximum(oldmax[(i-1):i])
 20              end
 21          newmax[i] = largest_parent + wi
 22      end
 23  end
```

Aha, this looks like the code I wrote!
It looks like the error came from this indexing: `oldmax[(i-1):i]`.
Let's see if `i` and `oldmax` match my expectations.

```julia
About to run: (getindex)([0], 1:2)
4|debug> fr
[4] #3(datafile) at /Users/clark/projects/summer20euler/clark/18.jl:4
  | datafile::String = "18example.txt"
  | oldmax::Array{Int64,1} = [0]
  | ::Int64 = 2
  | line::String = "2 4 6"
  | weights::Array{Int64,1} = [2, 4, 6]
  | newmax::Array{Int64,1} = [2, 0, 0]
  | i::Int64 = 2
  | wi::Int64 = 4
  | largest_parent::Int64 = 0
4|debug> q
julia>
```

Nope, I expected the `oldmax` array to grow by one element with every iteration.
It doesn't grow, because I forgot to update with the line `oldmax = newmax`.
That's an easy fix.

For this problem, I could have stared at it until I saw the error.
Depending on how fresh my brain is, the "stare 'em down" approach for a problem like this that could take less than a minute or more than an hour.
It's also easy to convince yourself that code is correct when you stare at it for too long.
After all, you have a clear idea what it should do.
The problem is almost always that you didn't communicate that idea clearly enough to the computer.


## Conclusion

This post highlighted only a couple of Debugger's rich set of capabilities.
You can add a breakpoint when a function is called, when a particular method is called, when a condition is satisfied, or to an arbitrary line in a file.
You can toggle breakpoints on and off, and generally control entire sequence of breakpoints.
We didn't even talk about watching expressions, editing code on the fly, or more sophisticated stepping.

Debuggers are one of those peripheral skills that take a little time and effort to learn, so it's easy to put it off.
Don't.
You and I both write buggy programs.
Debuggers save time by allowing you to quickly pinpoint problems.
They also strengthen your mental model, for any language, by allowing you to constantly test, explore, and verify what you believe to be true.

Some bugs are truly difficult to uncover, even with debuggers.
For example, a system might have many interacting parts, and it's hard to isolate where the issue is.
A helpful strategy in that case is to spend time hunting for it, and then walk away and clear your head.
Go for a walk, get some fresh air, and sit back down a couple hours later, or the next day.
Many times I've hunted fruitlessly for hours, and then sat back down with a clear head and immediately found the bug.
