---
tags:
    - stat128
---

- Identify elements of plots
- Create clear, meaningful statistical graphics 
- Contrast EDA with presentation quality graphics

Announcements:

- Assignments will be more open ended, and you can choose how deep to go.

[pptx slides]({% link files/stat128/fall20/principles_visualization.pptx %})
[annotated PDF slides]()

References:

[Graphics chapter](https://www.stat.berkeley.edu/users/nolan/IntroRPgm/chap-Graphics.html) Intro R programming book
[Data Visualization](https://www.textbook.ds100.org/ch/06/viz_intro.html) UC Berkeley Data 100 class
[Teaching and Learning Data Visualization: Ideas and Assignments](https://arxiv.org/pdf/1503.00781.pdf) by Nolan and Perret

```{r}
library(RColorBrewer)
par(mar=c(3,4,2,2))
display.brewer.all()
```

To make the R plot.

```{r}
inflate = data.frame(rate = c(0.8, 1.1, 1.8, 2.2, 2.4, 2.4, 2.8, 2.9, 3.1, 3.2),
    city = c("Pittsburgh"
    , "Anchorage"
    , "New York"
    , "Los Angeles"
    , "Houston"
    , "Detroit"
    , "Chicago"
    , "Atlanta"
    , "Seattle"
    , "St. Louis"
    )
)

dotchart(inflate$rate, labels = inflate$city
, xlab = "percentage inflation rate"
, main = "2014 annual grocery store inflation by city"
)
NAT_AVG = 2.8
abline(v = NAT_AVG, col = "blue", lty = 3)
text(NAT_AVG, 1.4, "national
average", pos = 2)
```



