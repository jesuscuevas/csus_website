---
tags:
  - stat128
---

- Define the following terms, and identify them in an R expression:
    - assignment
    - variable name
    - function call
    - argument 
- Look up builtin documentation
- Search for error messages

[Live notes]({% link files/stat128/fall20/2020-09-04.Rmd %})


### Assignment 

```{r}
?`=`
```

Assign `x` to 3

```{r}
x = 3
x <- 3 # Does same thing
```

`x` is the __variable name__, and `3` is the __value__.

Print it out, see the current value.

```{r}
x
```

What's that `[1]` doing in front of our 3?
Here's a hint:
```{r}
1:50
```

`x` is defined, so we can use it in calculations.
Q: make a prediction, what's the result below?
```{r}
x = 3
x + 4
```

We see x in our global environment, assigned to the value 3.
Q: below we assign `x` to a different value, 5.
Make a prediction, what will the line below produce?
```{r}
x = 5
x + 4
```

We can change `x`, and use the new value.

Q: How do we assign the `x + 4` to the variable `y`?
```{r}
y = x + 4
```

In general, we can put as many computations as we need to on the right.
```{r}
y = 5*(x-5) + 4 + x^2 - 2.2
```

### Function calls

Functions are the heart of R. 
Next week, we'll start defining our own functions.
__Function calls__ typically look something like this:
```{r}
sqrt(4)
```
Q: Guess what this does?

`sqrt` is the function, and `4.2` is the __argument__.
A function can accept 0, 1, or many arguments.

### Documentation

To learn exactly what `sqrt` does, we need to look at the documentation.
```{r}
?sqrt
```
Demo documentation.

### Errors

Suppose we write something incorrect:
Q: Make a prediction, what will happen?
```{r}
sqrt(four)
```

This happens because `four` is a name, not a __literal__ like `4`.
Suppose you have no idea what this error message means.
The obvious solution is to Google it.

Q: How do you Google it?
The whole error message, or modify it?
How to modify it?
Take out part specific to your problem.
Google this: "Error: object not found"

Here's the [first Stack Overflow post](https://stackoverflow.com/questions/27886839/what-does-error-object-myvariable-not-found-mean) Google found for me.
The answer goes into great detail about all the possible ways you could produce this error.

### packages

"There's an app for that"
External, user contributed packages make R great.
CRAN has tons, for every application you can imagine.
Explain package GUI.







