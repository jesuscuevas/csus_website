---
tags:
    - stat128
---

- Identify side effects in function calls
- Predict behavior of reference objects in simple functions

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-11-18.Rmd)

123 GO – Did the student made review videos improve your understanding?

Announcements:

- Turn in last HW (predicting interest) even if you didn't finish


## side effects

Functions take an input and produce an output.

A __side effect__ in a function call is when the function does something - anything at all - besides return a result.

Which of the following function calls have side effects?

1. `1 + 2`
2. `hist(1:5)`
3. `seq(from = 0, to = 10)`
4. `x = 10`
    Wait... is variable assignment a function call? Yes. Everything in R is a function call. `=`("x", 100)
5. `read.csv("data.csv")`
6. `write.csv(x, "x.csv")`
7. `rnorm(10)`

All of these functions are useful.
Without side effects we could never do anything on a computer.

__Pure__ functions don't have side effects, and they always return the same output for a fixed input.
The functions you study in mathematics courses are pure functions.
Why do we like pure functions?

1. easier to reason about
2. useful when parallel programming


## Motivating question

Consider the following minimal reactive Shiny app:

```{r}
ui <- fluidPage(
  , numericInput("a", label = "some number", value = 1)
  , textOutput("msg")
)

s <- function(input, output) {
  
  output$msg = renderText({
    paste("the value of a is", input$a)
  })
  
  NULL
}

shinyApp(ui = ui, server = s)
```

When we run this app, the user inputs a number `a`, and then R generates a message saying what the current value of a is.


Group activity:

How and why does the function `s` work?

1. What are the arguments to `s`?
1. What does `s` assume about the inputs?
2. What does `s` return?
2. Based on the reactive behavior of the app, what must be happening to the arguments to `s`?
3. Where is `s` called?
3. Where does the program use `s`?
4. Does it make sense to use `s` with `ui` different from the one defined above?


## Reference Semantics

Suppose we have an object `x`.
If a function modifies `x` when it is called, and those changes are visible outside of that particular function call, then `x` has __reference semantics__.
Thus reference semantics are a property of the object, not the function.

Shiny is implemented with reference classes, which have reference semantics, and that's the key to understanding how it all works.
This reference behavior is uncommon, or else at least well hidden, across the rest of the R world.
All the standard objects we work with: vectors, data frames, lists, functions, don't have obvious reference semantics.

We can see reference semantics in action by using environments, and compare the behavior to lists.

```{r}
e = new.env()
e$a = "hello"
e$a 

l = list()
l$a = "hola"

f = function(x){
    x$a = "goodbye"
    x
}

f(l)
l

f(e)
e$a
```

Wait, it gets better :)

```{r}
e2 = f(e)
```

What do you notice when I print these?
`e` has the same memory address as `e2`.

```{r}
identical(e, e2)

e2$b = "assigned to e2"
e$b
```

Any function can potentially have side effects when the argument is a reference object.
