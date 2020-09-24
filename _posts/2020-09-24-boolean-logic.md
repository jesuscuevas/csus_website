---
tags:
    - stat128
---

- Reason about vectorized boolean computations
- Explain difference between `TRUE` and `T`.

Announcements:

- You should be proud of yourselves for the last HW.
- New programmer specific office hours after class today, all are welcome.


## boolean logic

Boolean logic is a way for us to combine simple true and false values into more complex expressions.
Most have probably seen this in other classes that involve logic.
Boolean logic is extremely powerful, because everything a computer does boils down to operations on bits of 1's and 0's.

The simplest thing we can do with `TRUE` and `FALSE` values in R is negate them using `!`.

```{r}
!TRUE
!FALSE
```



The basic rules involve combining TRUE and FALSE with "and" represented by `&`, and "or", represented by `|`.
Here's everything you can possibly do:

Test intuition:

```{r}
TRUE & TRUE     # TRUE
TRUE & FALSE    # FALSE
FALSE & TRUE    # FALSE
FALSE & FALSE   # FALSE

TRUE | TRUE     # TRUE
TRUE | FALSE    # TRUE
FALSE | TRUE    # TRUE
FALSE | FALSE   # FALSE
```

In summary:
- `A & B` returns TRUE when A and B are both TRUE, and FALSE otherwise.
- `A | B` returns TRUE if any of A or B are TRUE, and FALSE otherwise.

TODO: Binary, unary operator, difference from function call.


## Difference between `TRUE` and `T`



## Sequences of AND's and OR's



## Group activity

`xor(x, y)` returns `TRUE` if exactly one of `x` and `y` is `TRUE`.
As a group, use only `!, |, &` to implement a function `xor2` with this behavior.


## homework hints

I gave you this function in your homework template to represent a 

```{r}
even = function(x)
{
    win = (x %% 2 == 0) & (x != 0)
    ifelse(win, 1, -1)
}
```

`ifelse` is like a ternary operator.
