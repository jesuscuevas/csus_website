---
tags:
    - stat128
---

- Write functions containing `if` and `else` statements

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-10-19.Rmd)

Announcements:

- Midterm next week
- This week's homework will be to create a midterm review video, details TBA

Plan:

- `if` statements
- Group reflect activity on data science panel

123 GO - Word summarizing impression of Friday's data science panel

## Conditional statements

```{r}
# if(CONDITION){
#   DO SOMETHING
# }
```

```{r}
x = 2
if(x < 10){
  # Beginning of a block - 123 GO - how many lines of code INSIDE this block?
  print("x is less than 10!")  # line 1
  y = 100       # line 2
}

```

Define __block__

## else

```{r}
x = 2

# Predict: Will we see "something else" printed out? 123 GO yes, no, idk
if(x < 10){
  print("x is less than 10!")
  y = 100
} else {
  print("something else!")
}

```

```{r}
x = 20

# Predict: Will we see "something else" printed out? 123 GO yes, no, idk
if(x < 10){
  print("x is less than 10!")
  y = 100
} else {
  print("something else!")
}

```

```{r}
x = 20

# Predict: Will we see "something else" printed out? 123 GO yes, no, idk
if(x < 10){
  print("x is less than 10!")
  y = 100
} else if (x < 100){
  # x < 100
  print("10 <= x < 100")
} else {
  print("something else!")
}

```

## Nesting

```{r}
x = 20

if(x < 10){
  print("x is less than 10!") # no
  y = 100
} else if (x < 100){
  # x < 100
  print("10 <= x < 100") # yes
  if (x %% 2 == 0){
    print("x is even") # yes
    if (90 < x){ # This `if` is nested three deep
      print("x is greater than 90") # no
    }
  }
} else {
  print("something else!") # no
}
```

Moral: Deeply nested code can be difficult to read, so avoid when possible.

`ifelse` is a function that does everything all at once.
Specific purpose- select elementwise from 2 vectors.
Use `ifelse` if you have a long vector of TRUE and FALSE.

In contrast, `if` and `else` are used for control flow.
In the case of `if(CONDITION)`, `CONDITION` should have length 1, and should be TRUE or FALSE.
Otherwise, it's probably a mistake.


```{r}
a = c(TRUE, FALSE) # ambiguous
if(a){
  print("hello!")
}

ifelse(a, "This element TRUE", "This element FALSE")
```

## Assignment

```{r}
x = 20

if(x < 10){
  y = TRUE
} else {
  y = FALSE
}

# Equivalently

y = if(x < 10){
  TRUE
} else {
  FALSE
}

# 123 GO - what will the value of y?
y
```

## Group activity

15 minutes to reflect and talk with your group about Friday's data science panel.
Use the following questions as a starting place:

1. What were your takeaways?
2. Did it give you any ideas?
3. We have some flexibility later in this class- what would you like to see?

Two people with names appearing last in each group will share- pick one of the questions above, or just general thoughts are fine.

- Impress people with beautiful graphics
- Blog post for your project / showcase work, outside projects
- Looking for problem solving ability
- Propensity to learn
- Defining the actual problem!
- Job opportunities in different fields- wide breadth of opportunities
- Remote work possible
- Encouraging to see people from diverse backgrounds making their way in the field
- +1 Could learn SQL, Python
