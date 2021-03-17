---
tags:
    - stat196k
---

- apply natural language processing (NLP) techniques to convert unstructured text to a numeric matrix
- extract interesting data from XML documents


## Announcements

- Excellent work coming up with questions about the IRS 990 data 👍
- The latest course EC2 image has all the software necessary to do this assignment

123 GO - What's your ideal pet?

## Data

It's best to start developing your approach using just one or two files.
Here's the [IRS 990 for the Free software Foundation]({% link assets/201932259349302043_public.xml %}), which we [covered in class]({% link _posts/2021-03-05-framing-statistical-questions.md %}).
The IRS tax returns for the entire year 2019 are available via S3.

```bash
aws s3 cp s3://stat196k-data-examples/2019irs990.zip ./ --no-sign-request
```

This will download a 2.8 GB zip file containing around a half million IRS 990 forms for 2019.
When you unzip it, the directory will be 16 GB on disk.
This means you'll want to use an EC2 instance with at least about 30 GB of hard drive available, just to be safe.
If you want to be more efficient, you can access the files as you need them, without unzipping everything.
These files are not the same as the ones [provided by AWS](https://registry.opendata.aws/irs990/); I removed the schema to make them easier to process.
For the curious, [this shell script creates the zip file](https://github.com/clarkfitzg/stat196K/blob/main/irs990.sh).
If you wanted to process more than the 2019 forms, then you could modify this script.


## Assignment

Use NLP to convert the text descriptions of each nonprofit into the rows of one big document term matrix.
The resulting matrix will have one row for every 990 form for which you can find a suitable text description, and one column for every word in the lexicon.
In the next assignment we will use this matrix to cluster the nonprofits based on their descriptions.

### Script

Write a Julia\* script to process the data, including the following steps:

1. Extract from the 2019 IRS 990 data the organization name, one or more text elements that describe the purpose of the organization (description), and one or more elements that can be used as a proxy for size, such as revenue or number of employees.
2. Process the text descriptions that describe each organization using a similar process as [described in class]({% link _posts/2021-03-08-introduction-natural-language-processing.md %}).
3. Create and save the term document matrix for the processed text descriptions.

\* _If you want to use another language then you may, but you're on your own for support._


### Questions

1. How many of the returns were you able to process?
2. Show and interpret one explicit example of what you extracted from one tax return, including the text description before and after processing.
2. What are the dimensions of your term document matrix?
2. How long did your program take to run? (Less than 30 minutes is easily attainable, but no problem if it takes longer, either.)
3. Which parts of the program took the longest time to run?


### Submission

Turn in a __single__ PDF file or text document answering these questions and include the text of your script either at the end of the document, or in the body, Jupyter Notebook style.
I only want to look at one document, which is different than previous assignments.

For resubmissions, leave a comment in the submission comments box saying what you changed.


### Extra Credit

Worth 1 point, but so much glory.

Implement an approach to "unsplit" the concatenated words that we saw in the description field, for example:

> THE GNU PROJECT DOES COLLABORATIVE DEVELOPMENT AND DISTRIBUTION OF ANOPERATING SYSTEM (OS) THAT RESPECTS USERS' FREEDOM.
> GNU SOFTWARE ISLICENSED FREELY SO THAT USERS CAN RUN, SHARE, STUDY AND MODIFY ITHOWEVER IS BEST FOR THEM.
> THE GNU SYSTEM IS USED MOST POPULARLY WITHTHE KERNEL LINUX, FORMING THE GNU/LINUX OS USED ON MILLIONS OFCOMPUTERS WORLDWIDE, INCLUDING THE MAJORITY OF WEB AND EMAIL SERVERS. 
> THE FSF SUPPORTS GNU WITH RESOURCES FOR COORDINATION, PLANNING,SOFTWARE DEVELOPMENT INFRASTRUCTURE, WEB AND DOWNLOAD HOSTING,COPYRIGHT STEWARDSHIP, PROGRAMMING WORK, AND PUBLIC PROMOTION. 

This contains obvious errors:

- `ANOPERATING` should be `AN OPERATING`
- `ISLICENSED` should be `IS LICENSED` 
- `ITHOWEVER` should be `IT HOWEVER` 
- `WITHTHE` should be `WITH THE`
- and so on.
