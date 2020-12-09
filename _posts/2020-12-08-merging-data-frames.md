- Merge two data frames that share a common column

[live notes](https://github.com/clarkfitzg/stat128/blob/master/2020-12-09.Rmd)

123 GO – What's your word of the day?

Announcements:

- Submit final project highlight separately from final project on Sunday.

## Merging

Suppose I know which country a person is from, and I want to greet them using a greeting based on the language of their country.
If we had a column representing the greeting for each person, then we could just use `paste`.

```{r}
people = read.csv(text = "name,country
Clark,US
Jen,US
Sara,Mexico
Antonio,Honduras
Alexander,Russia
Sofia,Russia")

country = read.csv(text = "country,language
US,English
Russia,Russian
Mexico,Spanish
Honduras,Spanish")

greeting = read.csv(text = "language,greeting
English,hello
Spanish,hola
Korean,안녕
Russian,Здравствуйте")
```

We can `merge` country and greeting together based on the common column names.
This does a database style join.

```{r}

country_greeting = merge(country, greeting)
people2 = merge(people, country_greeting)

with(people2, paste(greeting, name))
```


