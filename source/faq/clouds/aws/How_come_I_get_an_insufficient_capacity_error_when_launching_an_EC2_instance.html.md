---
title: Why do I receive an "Insufficient capacity" error when launching an EC2 instance?
category: aws
description: The reason you receive this error is because the availability zone (into which you are attempting to launch an instance) is out of capacity.
---

## Background Information

You try to launch an instance in EC2, but you receive an "InsufficientInstanceCapacity: Insufficient capacity" error message and are unable to successfully launch a server.

* * *

## Answer

The reason you receive this error is because the availability zone (into which you are attempting to launch an instance) is out of capacity.  For example, if you attempt to launch an 'm1.xlarge' instance in the 'us-east-1a' availability zone, but there are no more 'm1.xlarge' instances available for provisioning, you will receive an "insufficient capacity" error message.

It's important to note that availability zones are not common across all accounts. i.e. The 'us-east-1a' availability zone for my account may be a different actual zone than the 'us-east-1a' availability zone for your account.

When you receive this type of error, you have several different options:

1. Simply wait for that instance type to become available.
2. Launch a different instance size.
3. Launch an instance in a different availability zone and migrate back at a later time, if necessary.  This provides a temporary solution until you can replace it at a later time with one in the desired availability zone. However, you will be charged cross-zone data transfer costs.
4. Launch an instance in the -Any- availability zone
5. Purchase a reserved instance (for that instance type) in the desired availability zone. This will also prevent you from receiving this error in the future.
