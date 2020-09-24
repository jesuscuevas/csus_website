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

Side note:
`|` and `&` are examples of __binary operators__.
Other binary operations include addition `+`, and multiplication, `*`.
You can think of them as functions that take two arguments, and are usually called without parentheses in the syntax of a language as `x OP y`, rather than `OP(x, y)`.
Logical negation using `!` operates on a single argument, so it's a __unary operator__.


## Difference between `TRUE` and `T`

When I teach, I try to always use `TRUE`, rather than `T`, even though the latter is shorter and easier to type.

```{r}
?Reserved
```



## Sequences of AND's and OR's

What will this return?

```{r}
TRUE | TRUE & FALSE
```

I don't know, I can never remember.
It depends on whether R evaluates `|` or `&` first.

If R evaluates `|` first, then it will be:
```{r}
(TRUE | TRUE) & FALSE  # becomes TRUE & FALSE, which is FALSE
```

If R evaluates `&` first, then it will be:
```{r}
TRUE | (TRUE & FALSE)  # becomes TRUE | FALSE, which is TRUE
```

Let's see what actually happens:

```{r}
> TRUE | TRUE & FALSE
[1] TRUE
```

The expression evaluates to `TRUE`, which means that R evaluates `&` before `|`.
Let's take a look at all the rules for operator precedence:

```{r}
?Syntax

     The following unary and binary operators are defined.  They are
     listed in precedence groups, from highest to lowest.

       ‘:: :::’           access variables in a namespace
       ‘$ @’              component / slot extraction
       ‘[ [[’             indexing
       ‘^’                exponentiation (right to left)
       ‘- +’              unary minus and plus
       ‘:’                sequence operator
       ‘%any%’            special operators (including ‘%%’ and ‘%/%’)
       ‘* /’              multiply, divide
       ‘+ -’              (binary) add, subtract
       ‘< > <= >= == !=’  ordering and comparison
       ‘!’                negation
       ‘&  &&’            and
       ‘| ||’             or
       ‘~’                as in formulae
       ‘-> ->>’           rightwards assignment
       ‘<- <<-’           assignment (right to left)
       ‘=’                assignment (right to left)
       ‘?’                help (unary and binary)
```

Indeed, `&` appears ahead of `|`, so it has higher precedence.

It's better to write your code in a way that you can tell at a glance what's happening, rather than relying on expert knowledge of operator precedence.
Clear style works in any language.

It's fine if you combine many conditions only using `&`, because this selects the indexes for which all the conditions are true.
For example:

```{r}
x = 1:10
(x < 5) & (1 <= x) & (x != 3) & (sqrt(x) < 29)
```

Similarly, you can combine many conditions using `|`, because this selects the indexes for which any condition is true.

```{r}
x = 1:10
(x < 5) | (9.5 <= x) | (x == 7) | (sqrt(x) < 1.6)
```

Best practices:

- Use parentheses to clarify.
    That's what we did with `(TRUE | TRUE) & FALSE`.
- Combine several conditions with exactly one of `|` and `&`.
    If you do this, operator precedence doesn't matter.
- Don't mix `&` and `|` in long logical expressions.


## Group activity

`xor(x, y)` returns `TRUE` if exactly one of `x` and `y` is `TRUE`.
As a group, use only `!, |, &` to implement a function `xor2` with this behavior.


## homework hints

I gave you this function in your homework template to illustrate some patterns you can use.

```{r}
even = function(x)
{
    win = (x %% 2 == 0) & (x != 0)
    ifelse(win, 1, -1)
}
```

`%%` is read as "mod", for modular arithmetic, and `x %% 2` means to take the remainder after you divide by 2.
If you want to check for even numbers, you can just check if the remainder is 0 after division by 2.

```{r}
iseven = function(x) (x %% 2) == 0
iseven(1:10)
```

`ifelse` is vectorized, operating elementwise.
