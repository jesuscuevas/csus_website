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


### Context

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
    Tedious and error prone.
- A basic computer will outperform any mathematician when it comes to long calculations.
    We're human, they're machines.
- I'm changing the focus of my courses away from the calculations, and focusing instead on the higher critical thinking skills, for example, mapping a word problem into known random variables.


### How I'm actually doing it

- I'm teaching our STAT 50, a lower division, terminal course in statistics.
- Goal is to use R as a scientific calculator, which is much simpler than learning to program.
- Of course, my ulterior motive is to expose them to data science material to get them excited so they'll take STAT 128 (Statistical Computing) with me.
- Any interpreted language will work the same here: Python, Julia, R
- R works well for statistics classes because it doesn't require external libraries, and the plotting is especially easy.
- Requires minimal expertise from instructor, a good thing.
- Sets students up for best practices
- The price is right, open source software, open educational resources.
- How I'm working R in: when I get to a calculation in my lecture presentation, I run the R code on my computer in front of me, and copy paste to my ipad (Mac feature).
- Note that this example doesn't show the way a professional would actually use R to calculate the standard deviation of these numbers, `sd(c(2,3,5,6))`.

 and it's high time for them to join their extinct cousins, the mathematical tables of logarithms and trigonometric functions.

Abstract:
We're teaching online classes, so students have computers, which makes statistical tables (Z,t,F,binomial,etc.) obsolete.
We should teach our students to use computers for calculation, so that we can focus our teaching efforts on the higher level concepts.
In particular, we should teach programming languages as scientific calculators.
I'll present some concrete examples and strategies for teaching the R language in a lower division statistics course.
You don't need to know R or programming to take this approach.
