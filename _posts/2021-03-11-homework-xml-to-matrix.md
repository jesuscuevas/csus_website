---
tags:
    - stat196k
---

- apply natural language processing (NLP) techniques to convert unstructured text to a numeric matrix
- extract interesting data from XML documents


## Announcements

- Excellent work coming up with questions about the IRS 990 data 👍
- The latest course EC2 image has all the software necessary to do this assignment


## Data

The IRS tax returns for the year 2019 are available via S3.

```bash
aws s3 cp s3://stat196k-data-examples/2019irs990.zip ./ --no-sign-request
```

This will download a 2.8 GB zip file containing around a half million IRS 990 forms for 2019.
When you unzip it, the directory will be 16 GB on disk.
This means you'll need to use an EC2 instance with at least 22 GB of hard drive available.
These files are not the same as the ones provided by AWS; I removed the schema to make them easier to process.
For the curious, [this shell script creates the zip file](https://github.com/clarkfitzg/stat196K/blob/main/irs990.sh).


## Assignment

Use NLP to convert the text descriptions of each nonprofit into the rows of one big document term matrix.
The resulting matrix will have one row for every 990 form that has a description, and one column for every word in the lexicon.
In the next assignment we will use this matrix to cluster the nonprofits based on their descriptions.

Your program should do the following:

1. Extract the organization name, one or more text elements that describe the nonprofit, and another element that can be used as a proxy for size, such as revenue, number of employees, etc.
2. Process the text descriptions using a similar process as [described in class]({% link _posts/2021-03-08-introduction-natural-language-processing.md %}).
3. Create and save the term document matrix.

Run your program, and report the following:

1. How many of the returns were you able to process?
2. Show one explicit example of how you processed the text.
    What was the input and output?
2. What are the dimensions of your term document matrix?
2. How long did your program take to run? (It should be less than half an hour, but no problem if it takes longer, either.)
3. Which part of the program took the longest?
