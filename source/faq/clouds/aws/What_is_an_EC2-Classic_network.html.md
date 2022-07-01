---
title: What is an EC2-Classic network?
category: aws
description: Since the inception of EC2-VPC, all new AWS accounts are automatically on the EC2-VPC platform so you do not have the choice to launch instances into EC2-Classic if you are a new customer.
---

## Background Information

AWS has two platforms for launching EC2 instances: EC2-Classic and EC2-VPC. This FAQ describes EC2-Classic. Not all accounts support EC2-Classic so this information may not apply to you. See the Answer section for details.

## Answer

AWS introduced a new EC2 platform called EC2-VPC. Since the inception of EC2-VPC, all new AWS accounts are automatically on the EC2-VPC platform so you do not have the choice to launch instances into EC2-Classic if you are a new customer. You can find out what platforms are supported in your account by going to the AWS dashboard and checking the **Account Attributes**.

EC2-Classic is the original release of Amazon EC2. With this platform, instances run in a single, flat network that is shared with other customers. With EC2-VPC, instances run in a virtual private cloud (VPC) that is logically isolated to only one AWS account.

The following are some of the key attributes that comprise an EC2-Classic network:

* Public IP address - Your instance receives a public IP address
* Private IP - Your instance receives a private IP address from the EC2-Classic, default VPC range each time it's started.
* Multiple IP addresses - You can assign a single IP address to your instance.
* Elastic IP address - An EIP is disassociated from your instance when you stop it.
* DNS hostnames - DNS hostnames are enabled by default.
* Security group - A security group can reference security groups that belong to other AWS accounts. You can create up to 500 security groups in each region.
* Security group association - You can assign an unlimited number of security groups to an instance when you launch it.
* Security group rules - You can add rules for inbound traffic only and can add up to 100 rules to a security group.
* Tenancy - Your instance runs on shared hardware.
