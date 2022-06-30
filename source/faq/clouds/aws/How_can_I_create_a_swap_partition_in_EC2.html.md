---
title: How can I create a swap partition in EC2?
category: aws
description: The default swap partitions in Amazon EC2 are defined by the instance type used. Only m1.small and c1.medium instance types provide a swap partition by default.
---

## Background Information

How do you know what instances have a swap partition and what instances do not? How can I create a swap partition of my EC2 instance?

* * *

## Answer

The default swap partitions in Amazon EC2 are defined by the instance type used. Only m1.small and c1.medium instance types provide a swap partition by default.

### Adding a swap partition

For all other instance types, a swap partition can be created using LVM and the ephemeral storage provided with the instance.&nbsp; RightScale provides the following RightScript for adding a swap partition:

* [SYS Add Swap Partition](http://www.rightscale.com/library/right_scripts/SYS-Add-swap-partition-11H1/lineage/6516) (Available to Paid RightScale Accounts only)

Before you run the "SYS Add Swap Partition"&nbsp;RightScript, you must first execute the " [SYS lvm install](http://www.rightscale.com/library/right_scripts/SYS-Lvm-install-11H1/lineage/6512)" RightScript.&nbsp; If those scripts are not available in the current RightScale account, you will need to import them from the MultiCloud Marketplace.&nbsp; Please note that this method is rarely practiced now and creating a swap file instead is best practice.

### Adding a swap file

RightScale OSS provides the following RightScript for adding a swap file to your instance:

* [SYS Swap Setup](http://www.rightscale.com/library/right_scripts/SYS-Swap-Setup/lineage/60618) (Available to all RightScale accounts)

### See also

* [Creating dynamic swap space](http://www.debian-administration.org/articles/550)
