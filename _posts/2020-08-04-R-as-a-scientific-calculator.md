These are notes to prepare a talk for the September 2020 Math Council Colloquium (MC^2): Comp Methods/Programming for math majors

Comparison:

Feature                                     | Paper Tables  |   Calculators     |   Programming
-------                                     | ------------  |   -----------     |   --------------------------------
free                                        |   Yes         |   No              |   Yes
can use to communicate on in class exams    |   No          |   No              |   Yes    
provides answers to arbitrary precision     |   No          |   Sometimes       |   Yes
evaluates solutions at any point            |   No          |   No              |   Yes
saves result                                |   No          |   No              |   Yes
Setup for further growth with technology    |   No          |   No              |   Yes
used by professionals                       |   No          |   No              |   Yes


### Prior work

- Deb Nolan and Duncan Temple Lang have been strongly advocating for more computing in the statistics curricula since at least 2010.
- Other prior work: [Mosaic](http://mosaic-web.org/) Pruim, Kaplan, Horton provide useful material for teachers.


### Problems with tables

- If we're teaching online, the last bastion of defense of the paper table is gone.
    Good riddance!
- Why teach obsolete technologies?
    Statistics isn't "history of math"
- Some topics are even obsolete for terminal courses.
    For example, an approximation, if the only purpose of the approximation is to get to a known table so you can evaluate something.
- But students can't have a computer on the test...
    Teaching online post COVID, every student has a computer for every test.
- Even good students aren't that good at using a hand calculator.
    Rounding to 2 or 3 decimal places quickly loses all your precision.


### Switching focus

- Why make students evaluate something like `pbinom(7, size = 15, prob = 0.4)`?
    It's tedious and error prone.
    Everyone makes mistakes.
- A basic computer will outperform any mathematician when it comes to long calculations.
    We're human, they're machines.
- I'm changing the focus of my courses away from the calculations, and focusing instead on the higher critical thinking skills, for example, mapping a word problem into known random variables.
- We often have only one semester to teach statistics.
    Learning how to correctly evaluate expressions is important, but learning the higher level concepts is more important.


### How I'm actually doing it

- "But we're not programmers!" The power of yet.
- I'm teaching our STAT 50, a lower division, terminal course in statistics.
- Goal is to use R as a scientific calculator
- Of course, my ulterior motive is to expose them to data science material to get them excited so they'll take STAT 128 (Statistical Computing)
- Any interpreted language will work the same here: Python, Julia, R
- R works well for statistics classes because it doesn't require external libraries, and the plotting is especially easy.
- Requires minimal expertise from instructor, a good thing.
- Sets students up for best practices
- The price is right, open source software, open educational resources.
- How I'm working R in: when I get to a calculation in my lecture presentation, I run the R code on my computer in front of me, and copy paste to my ipad (Mac feature).
- Note that this example doesn't show the way a professional would actually use R to calculate the standard deviation of these numbers, `sd(c(2,3,5,6))`.

If you are dying to teach these methods on a paper exam, then there are still a couple options.
I like providing facts like "suppose Z ~ N(0, 1), then P(Z < 2) = 0.977".
The reason I like this is because I don't care how long it takes students to look facts like these up, and I do not want to assess them on it.

consider providing R output for functions, for example:
```{r}
> pnorm(0.2)
[1] 0.5792597
```



## Title: Goodbye Z Tables, Hello R – Using the R language as a scientific calculator for statistics classes

## Abstract:

The ability to use a computer as a scientific calculator is a powerful asset for statistics students at all levels, for many reasons.
The content of this talk is as follows.
First, I argue that in 2020, more than ever, it's time to stop teaching statistical tables such as the Z table.
Second, I describe how incorporating functionality from the R language into a lower division statistics course has shifted the focus from rote calculation to more conceptual understanding.
Finally, I present some concrete strategies and examples for teaching R as a scientific calculator, which is much simpler than learning to program.
You do not need to know R or programming to follow this approach.


Students should learn to use computers as scientific calculators.

 have served their time, and it's time to retire them alongside their cousins, the logarithmic and trigonometric tables.

so that we can shift the emphasis of our courses from rote calculation to higher level skills, such as identifying probability distributions in word problems. 
It's 2020, and students have access to computers.


Instead of tables, statistics students should learn to use computers as scientific calculators.
In lower division courses, the emphasis will shift 



Many college students will take only one course in statistics.
As instructors, 

What should they be able to do when they get out?

When we're teaching, we should ask ourselves, is this the best way to teach?
 and we need to keep this in mind as we choose which content we'll 
How 


We 

Our course content should reflect 


We should teach robust methods for numeric calculation in our statistics classes.
The switch 

Students have computers, so we should teach them 
