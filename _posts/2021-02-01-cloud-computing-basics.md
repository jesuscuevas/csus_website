---
tags:
    - stat196k
---

- Describe the high level concepts of cloud computing and virtualization
- Login to a remote machine through SSH
- Start and terminate an Amazon Elastic Compute (EC2) instance

Resources:

- 5 minute [video explaining SSH key pairs](https://youtu.be/2HnJFOMewJE)


## cloud computing

At a high level, cloud computing means you pay for what you use as you go, rather than investing a large amount of money up front in physical infrastructure.
For me, the most convincing argument for cloud computing is that it's more efficient, and therefore cheaper.

Virtualization means you have a logical computer, not a physical computer.
An __instance__ is a logical computer that you can login to and use like a normal computer.
You pay the entire time instances run, so turn them off when you're done.


## ssh and key pairs

For our class, the __server__ is a remote machine that you login to, and the __client__ is your local desktop or laptop.
__SSH__ (for secure shell) means to login to a shell on the server from the client.

We will use __key pairs__ rather than passwords to authenticate to our servers.

> A key pair consists of a __public key__ that AWS stores, and a __private key__ file that you store.
> Together, they allow you to connect to your instance securely.
> For Linux AMIs, the private key file allows you to securely SSH into your instance.

Think of your private key as your password.
If someone has your private key, then they can authenticate as you.


## Exercise

#### Prerequisite: Activate your AWS educate account

19 out of 34 of you have already done this.
Find an email from `support@awseducate.com` with subject line "Your AWS Educate Application".
The body starts like this:

> Hi -
> 
> Your educator has invited you to join AWS Educate and access a "Classroom" for your course work.
> A "Classroom" is a hands-on learning environment for you to access AWS services and practice AWS.
> There are no costs or fees to access a Classroom.

If you cannot find it, then let me know, and I'll resend the invite.
Follow the steps and click through the email links to create and activate your account.

-----


1. Login to your [AWS Educate account](https://www.awseducate.com/signin/SiteLogin)
2. Navigate to "My Classrooms" on the top bar, find our class, "Analyzing and Processing Big Data", and click "Go to classroom", which will bring you to Vocareum.
3. Click on the blue "AWS Console" button to navigate to the [AWS Management Console](https://console.aws.amazon.com/console/home?region=us-east-1#)
3. Launch an EC2 instance.
4. Choose "Community AMIs" and search for "stat196k" to find one with a title like "CSUS stat196k v1.0".
    Select that one, which has all the software and settings necessary for our class.
5. Use the default instance type, "t2.micro", then click "Review and Launch".
6. You'll see a warning message: "_Improve your instances' security. Your security group, launch-wizard-2, is open to the world._".
    That's OK here, it just means anyone with valid credentials can login from any IP address.
7. When you launch, AWS will prompt you for a key pair.
    The first time, you'll have to create a key pair, and subsequently you can use these keys.
    Alternatively, you can import your own existing public key from the management console.
8. I suggest you name the key pair the date that you create it, for example, `2020-02-01`.
9. Download the key, and verify that your instance is running.
10. Click on your running instance, and then click "Connect".
11. Follow the commands on the SSH client to login to the running machine using the keys you just created.
    For me on a mac, it looks like the following:
12. `~/Downloads $ ssh -i "2020-01-31.pem" ec2-user@ec2-35-173-178-203.compute-1.amazonaws.com`
13. Once you login, print out the contents of the `README` file in your home directory, and your name.
    Take a screenshot.
14. Go back to the console, and figure out how to terminate your running instance.
    From Instances, take a screenshot showing the "Instance state" as "Terminated", as well as your email.

#### Submit these 2 screenshots on Canvas

The red boxes in the pictures below show what I'm looking for.
Show that you were able to login to the machine, `$ cat README` and `$ echo "your name"`.

![ec2 login success]({% link img/ec2_login_success.png %})

Show that the instance is now terminated.

![ec2 instance termination]({% link img/ec2_instance_termination.png %})
