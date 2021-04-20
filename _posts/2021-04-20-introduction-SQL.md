---
tags:
    - stat196k
---

- Write SQL queries to select subsets of columns and rows

## Announcements


## Resources


If there's one technology / language you MUST be familiar with as a data scientist, it's SQL, Structured Query Language. 
Fortunately, SQL is easier to learn than general programming languages, and we can cover the basics in an hour.

1. GUI dashboard tools: Tableau, BI (business intelligence), etc.
    These are useful for quick visuals, and if you don't want to code.
    Many of them generate SQL.
2. SQL: Database is already set up, so you can write queries to your heart's content.
3. Underlying storage: Requires the most knowledge.

AWS Athena

Steps

1. Create a bucket in S3. `stat196k-firstlastname`
2. Navigate to [Amazon Athena](https://console.aws.amazon.com/athena/home?force&region=us-east-1#query)
3. [Connect Data Source](https://console.aws.amazon.com/athena/datasources/create/home)

This works:

```
CREATE EXTERNAL TABLE IF NOT EXISTS covid.pfizer (
  `jurisdiction` string,
  `week_of_allocations` string,
  `_1st_dose_allocations` int,
  `_2nd_dose_allocations` int 
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = ',',
  'field.delim' = ','
) LOCATION 's3://covid19-lake/cdc-pfizer-vaccine-distribution/csv/'
TBLPROPERTIES ('has_encrypted_data'='false');
```

The CloudFormation executes, but I can't query anything as a student.
I'm pretty sure the problem is that the data is stored in US east 2 (Ohio), but our student accounts can only use data in US east 1 (Virginia).
This is a real shame.

My workaround is to copy the files that look interesting into US east 1.

What makes them interesting?
I want to use SQL, AWS Athena.
The data should be big enough to motivate these tools.
We need to do at least 1 join.
Hmmm... What about having the students find a data set to join in?

[COVIDcast](https://delphi.cmu.edu/covidcast/) looks pretty cool.
135 million rows, that's something!

COVID signals:
https://cmu-delphi.github.io/delphi-epidata/api/covidcast_signals.html

TODO: Get the cloudformation to work based on data in MY bucket.
