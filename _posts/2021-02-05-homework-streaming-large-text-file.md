---
tags:
    - stat196k
date: 2021-02-05
---

- use streaming computations to process a text file larger than memory

## Announcements

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

Briefly explain a single row.
What is the CAMEO event gode, what event does this correspond to, and what is the Goldstein score? 


### 2 - histogram
