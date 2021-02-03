---
tags:
    - stat196k
---

- Describe data locality as the key to speed when processing big data
- Perform experiments to estimate time required to download data
- Download objects from Amazon's Simple Storage Service (S3)

123 GO: How would you spend $100 discretionary cash right now?

## References

- [AWS CLI S3 reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/index.html)


### Data processing cannot go faster than the slowest step.

{% include slide.html %}

Computer network and data transfer performance is commonly measured with two metrics:

- __bandwidth__ measures how many units of data are transferred per second.
- __latency__ is the time between when the client requests the data, and when the client receives the data from the server.

The same ideas apply to accessing data on disk, in memory, and in cache.
According to [Matthew Rocklin in 2015](http://matthewrocklin.com/blog/work/2015/12/29/disk-bandwidth), a physical hard drive can read data at 10-500 MB/sec.

One premise of this class is that the data is so large that it may be difficult to move.
Indeed, for some applications of data movement it might be more efficient to physically mail some hard drives than to send it over the network.


### Minimize data movement so your program will be fast.

{% include slide.html %}

Programs are small relative to data; you can do a lot in 100 lines of code.
Bring the program to the data, not the data to the program.

Our architecture consists of three locations:

- many TB of data stored in S3
- 8 GB of local solid state hard drive (SSD) storage in an EC2 instance
- local client


### AWS S3 (Simple Storage Service) is an example of an object store.

{% include slide.html %}

We have a bucket `stat196k-data-examples`.
The bucket contains objects including `20190204.csv`, a CSV file.
By default, buckets and objects will be private, but I've made them public so we can work with them easily.

> Amazon S3 (delivers) 99.999999999% durability.
> Data is automatically distributed across a minimum of three physical facilities that are geographically separated by at least 10 kilometers within an AWS Region

source: https://aws.amazon.com/what-is-cloud-object-storage/


### Uniform Resource Locators (URLs) identify objects on the web.

{% include slide.html %}

- web page example `https://aws.amazon.com/`
- s3 protocol `s3://stat196k-data-examples/20190204.csv`
- https protocol to access same object `https://stat196k-data-examples.s3.amazonaws.com/20190204.csv`


## History

The commands beginning with `aws s3` have much in common with shell syntax.
Yay synergy! 😀

TODO: save history from demo


## Exercise

Submit your answers to these qeustions along with bash commands and output.

1. SSH to an EC2 instance.
2. Find which files are in the bucket `stat196k-data-examples`.
3. How large are these files?
3. Time how long it takes to download one of the files to your EC2 instance.
    What is a lower bound for the network bandwidth?
3. How many files are in the bucket?
4. Time how long it takes to download one of the files to your EC2 instance.
5. What is a lower bound for the network bandwidth to access data in S3 on this instance?
5. How long does it take to download the same file to your local machine?
5. How much faster is it to access this data from an EC2 instance versus downloading it?
