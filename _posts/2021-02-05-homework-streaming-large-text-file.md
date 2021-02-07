---
tags:
    - stat196k
date: 2021-02-05
---

- calculate summary statistics from a data stream
- use pipelines to process a file larger than memory


## Announcements

- The question "How much longer does X take than Y" is usually most useful when answered in relative terms.
    For example, if the transfer took 1.9 seconds, and now it takes 79.2 seconds, then say that the second way is 79.2/1.9 = 42 times slower than the first.
- Check for comments / feedback on skills assignments.
- will post skills assignment solutions next week.

123 GO - what was the last kind of physical exercise you did?

## Resources

- blog post [streaming with S3](https://loige.co/aws-command-line-s3-content-from-stdin-or-to-stdout/)


## Background

The [GDELT Project](https://www.gdeltproject.org/) is the Global Database of Events, Language, and Tone.
It describes itself as:

> A Global Database of Society.
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

Turn in two files:

- A PDF or HTML document containing your answers to the following questions in a neatly organized report.
- A file with extension `.sh.txt` showing all the code necessary to reproduce your work.
    The `.sh` is for shell script, and this is normally the only extension you need.
    The `.txt` allows Canvas to render it as plain text in the web browser, so I can grade it.

I suggest you use markdown through something like pandoc, Rmarkdown, or Jupyter notebooks to create your report.
The [markdown source for the assignment](https://raw.githubusercontent.com/clarkfitzg/csus_website/master/_posts/2021-02-05-homework-streaming-large-text-file.md) is on Github, so you can copy and paste from there.
MS Word and other GUI programs should work fine too.


## Questions

### 1 - subset

_5 pts_

Download a small subset of the data (100 rows is plenty) to your personal computer, and examine it using any software you like.
Briefly describe this subset of the data by picking out a couple rows that look interesting to you.

1. How many columns are there?
1. Do the data values in each column seem to match the column definitions?
1. What character delimits the records?
1. What is the CAMEO event code, what event does this correspond to, and what is the Goldstein score?
1. Are the URL's to the news articles still live, and do they match the CAMEO event code?
1. Does the Goldstein score appear to be doing what it was designed to do?


### 2 - histogram

_10 pts_

Create a histogram of the Goldstein scores for all of 2018, using the integers as bin endpoints for the histogram.
It's possible to do this in less than 10 minutes using a single shell pipeline on a t2 micro instance with 1 vCPU, 1 GiB memory, and 8 GiB storage.

1. How long does your program take to run?
1. Explain in detail what each command in the pipeline does and how they work together.
1. Plot and interpret the histogram.
    You'll probably want to download the summary statistics (around 20 numbers) to your personal computer to plot the histogram.
    Do you notice anything strange?
1. Exactly how many events (rows) are in this data?


### 3 - performance

_5 pts_

Print and interpret the output of `top` while your program is running.

1. What are the bottlenecks?
1. Run and time your program on an EC2 instance with more vCPU's and a faster network and show the results of `top` once more.
    Is the program faster on the more expensive instance?
1. Are you benefitting from pipeline parallelism?
1. What's the bottleneck now?
1. Compare and comment on the financial cost of using a more expensive instance versus the t2.micro.
    Is it worth it?

__Remember to terminate these more expensive machines immediately after you use them!__
Otherwise, you may quickly run through your $50 credit and have to spend your own money.
[AWS Services Supported](https://s3.amazonaws.com/awseducate-starter-account-services/AWS_Educate_Starter_Accounts_and_AWS_Services.pdf) says that our Educate accounts can only use these kinds of instances: "t2.small", "t2.micro", "t2.nano", "m4.large", "c4.large", "c5.large", "m5.large", "t2.medium", "m4.xlarge", "c4.xlarge", "c5.xlarge", "t2.2xlarge", "m5.2xlarge", "t2.large", "t2.xlarge", "m5.xlarge".

### 4 - Extra Credit Challenge

_0 pts, optional_

Starting with the same 3.8 GB file on S3, calculate the summary statistics necessary for the histogram as fast as possible.
You can use the shell or any other programming language together with any EC2 instance available through your AWS Educate account.
Hint: look into software like [GNU parallel](https://www.gnu.org/software/parallel/) and [pigz](http://zlib.net/pigz/).
Turn in any extra code you write.
The student with the fastest program gets a minimal amount of extra credit and a maximal amount of glory.


## Brian Kernighan Explains Shell Pipelines

Watch until 10:50.

<iframe width="560" height="315" src="https://www.youtube.com/embed/tc4ROCJYbm0?start=331" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
