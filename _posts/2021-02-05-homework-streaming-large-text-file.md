---
tags:
    - stat196k
date: 2021-02-05
---

- use streaming computations to process a text file larger than memory

## Announcements

- The question "How much longer does X take than Y" is most interesting when answered in relative terms.
- "shell first steps" homework solutions posted

## Resources

- blog post [streaming with S3](https://loige.co/aws-command-line-s3-content-from-stdin-or-to-stdout/)

## Brian Kernighan Explains Shell Pipelines

Watch until 10:50.

<iframe width="560" height="315" src="https://www.youtube.com/embed/tc4ROCJYbm0?start=331" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Background

The [GDELT Project](https://www.gdeltproject.org/) is the Global Database of Events, Language, and Tone.
It describes itself as:

> A Global Database of Society
> Supported by Google Jigsaw, the GDELT Project monitors the world's broadcast, print, and web news from nearly every corner of every country in over 100 languages and identifies the people, locations, organizations, themes, sources, emotions, counts, quotes, images and events driving our global society every second of every day, creating a free open platform for computing on the entire world.

The events from 2018 are available in a single file at the S3 URI `s3://stat196k-data-examples/2018.csv.gz`.
This file is 3.8 GB, compressed.
Here are the [column definitions](https://stat196k-data-examples.s3.amazonaws.com/GDELT_2.0_Events_Column_Labels_Header_Row_Sep2016.csv).

### Goldstein Score

> Each CAMEO event code is assigned a numeric score from -10 to +10, capturing the theoretical potential impact that type of event will have on the stability of a country.
> This is known as the Goldstein Scale.
> This field specifies the Goldstein score for each event type.
> NOTE: this score is based on the type of event, not the specifics of the actual event record being recorded‚ thus two riots, one with 10 people and one with 10,000, will both receive the same Goldstein score.
> This can be aggregated to various levels of time resolution to yield an approximation of the stability of a location over time.

I believe this is the [CAMEO event code mapping](http://eventdata.parusanalytics.com/cameo.dir/CAMEO.SCALE.txt) to goldstein scores.


## Assignment

Turn in your answers to the following questions in a neatly organized report.


## Questions

### 1 - subset

Download a small subset of the data (100 rows is plenty) to your personal computer, and examine it using any software you like.

Briefly describe this subset of the data.
How many columns are there?
Do they seem to match the column definitions?
What character delimits the records?

Pick out a couple rows that look interesting to you, and explain them briefly.
What is the CAMEO event code, what event does this correspond to, and what is the Goldstein score?
Are the URL's to the news articles still live, and do they match the CAMEO event code?
Does the Goldstein score appear to be doing what it was designed to do?


### 2 - histogram

Create and plot a histogram of the Goldstein scores for all of 2018, using the integers as bin endpoints.
It's possible to do this in less than 10 minutes using a single shell pipeline on a t2 micro instance with 1 vCPU, 1 GiB memory, and 8 GiB storage.
How long does your program take to run?
Explain in detail what each command in the pipeline does and how they work together.

You'll probably want to download the summary statistics (around 20 numbers) to your personal computer to plot the histogram.


### 3 - performance

Print and interpret the output of `top` while your program is running.
What are the bottlenecks?

Run and time your program on an EC2 instance with more vCPU's and a faster network and look at `top` once more.
Is it faster?
Are you benefitting from pipeline parallelism?
What's the bottleneck now?


### 4 - Extra Credit Challenge

Starting with the same 3.8 GB file on S3, calculate the summary statistics necessary for the histogram as fast as possible, using the shell or any other programming language.
Hint: use a fast enough machine, and look into software like [GNU parallel](https://www.gnu.org/software/parallel/) and [pigz](http://zlib.net/pigz/)
The student with the fastest program gets extra credit.
