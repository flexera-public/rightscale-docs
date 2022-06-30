---
title: What is the maximum number of instances that I can have running at one time on EC2?
category: aws
description: Before you can have more than 20 running instances running at the same time in one EC2 region, you must first get approval directly from Amazon.
---

## Background Information

Is there a limit to how many instances that you can have running at any given time on EC2? For example, you might have received a "This account has exceeded the maximum number of allowed instances" error message.

* * *

#### Answer

By default, when you create an EC2 account with Amazon, your account is limited to a maximum of 20 instances per EC2 region with two default High I/O Instances (hi1.4xlarge) (not availability zone). Before you can have more than 20 running instances running at the same time in one EC2 region, you must first get approval directly from Amazon. You must specify which EC2 region you would like to increase your limit. Limit increases apply to that region only.

* This includes instances launched from a server array. Your array will start new instances until you reach your limit of total instances allowed.
* Only running instances count against your limit.

You can request an increase to your limit from Amazon here: [http://aws.amazon.com/contact-us/ec2-request/](http://aws.amazon.com/contact-us/ec2-request/)
