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

Programmers distinguish __pure__ functions from functions with side effects.


## mutability


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

How and why does the function `s` work?

1. What are the arguments?
1. What does `s` assume about the inputs?
2. What does `s` return?
3. Where does the program use `s`?
