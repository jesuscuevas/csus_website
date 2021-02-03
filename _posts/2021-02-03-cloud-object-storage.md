---
tags:
    - stat196k
---

- Describe data locality as the key to speed when processing big data
- Perform experiments to estimate time required to download data
- Download objects from Amazon's Simple Storage Service (S3)

From https://aws.amazon.com/what-is-cloud-object-storage/

> Amazon S3 (delivers) 99.999999999% durability.
> Data is automatically distributed across a minimum of three physical facilities that are geographically separated by at least 10 kilometers within an AWS Region

One premise of this class is that the data is so large that it may be difficult to move.
Indeed, for some applications of data movement it might be more efficient to physically mail some hard drives than to send it over the network.

Computer network and data transfer performance is commonly measured with two metrics:

- __bandwidth__ measures how many units of data are transferred per second.
- __latency__ is the time between when the client can hear back from a server.


## Exercise

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
