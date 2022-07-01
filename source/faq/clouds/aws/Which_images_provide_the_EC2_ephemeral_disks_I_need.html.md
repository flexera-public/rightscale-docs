---
title: Which images provide the EC2 ephemeral disks I need?
category: aws
description: AWS EC2 provides a variety of instance types with a wide range of different block device setups for instance storage and swap disks.
---

## Background Information

AWS EC2 provides a variety of instance types with a wide range of different block device setups for instance storage and swap disks.

## Answer

To know which Instance Types have Ephemeral Storage and how many, please see this [LINK](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html)

For Example, [m3.xlarge](http://aws.amazon.com/ec2/instance-types/) Instance Type has both ephemeral SSD drives attached to (`/dev/sdb` and `/dev/sdc`) respectively. Please note that Instance Store backed images are different from 'EBS-backed' images which determine the attachment of the ephemeral disks by the block device mapping in the image registration.


## Latest RightLink 10

With the introduction of Rightlink 10, default AWS images can easily be used seamlessly with very minimal configuration in RightScale. Users are able to select the Instance Type they desire with the Instance Store they need and then wrap that using RightLink 10.
