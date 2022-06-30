---
title: What is the difference between terminating and stopping an EC2 instance?
category: aws
description: This article describes the difference between terminating and stopping an EC2 instance.
---

## Background Information

Amazon supports the ability to terminate or stop a running instance. The ability to stop a running instance is only supported by instances that were launched with an EBS-based AMI. There are distinct differences between stopping and terminating an instance. It's important to properly understand the implications of each action.

**Note**: You cannot start/stop a Spot Instance.  [Click here](http://docs.amazonwebservices.com/AWSEC2/latest/APIReference/index.html?ApiReference-query-StopInstances.html) to see more information on this topic from AWS.

Manage AWS more efficiently with RightScale. [Try it now](https://www.rightscale.com/free-trial?sd=Free&t=supportal).

* * *

## Answer

### Terminate Instance

When you terminate an EC2 instance, the instance will be shutdown and the virtual machine that was provisioned for you will be permanently taken away and you will no longer be charged for instance usage. Any data that was stored locally on the instance will be lost. Any attached EBS volumes will be detached and deleted. However, if you attach an EBS Snapshot to an instance at boot time, the default option in the Dashboard is to delete the attached EBS volume upon termination.

### Stop Instance

When you stop an EC2 instance, the instance will be shutdown and the virtual machine that was provisioned for you will be permanently taken away and you will no longer be charged for instance usage. The key difference between stopping and terminating an instance is that the attached bootable EBS volume will not be deleted. The data on your EBS volume will remain after stopping while all information on the local (ephemeral) hard drive will be lost as usual. The volume will continue to persist in its availability zone.  Standard charges for EBS volumes will apply. Therefore, you should only stop an instance if you plan to start it again within a reasonable timeframe.  Otherwise, you might want to terminate an instance instead of stopping it for cost saving purposes.

The ability to stop an instance is only supported on instances that were launched using an EBS-based AMI where the root device data is stored on an attached EBS volume as an EBS boot partition instead of being stored on the local instance itself. As a result, one of the key advantages of starting a stopped instance is that it should theoretically have a faster boot time. When you start a stopped instance the EBS volume is simply attached to the newly provisioned instance.  Although, the AWS-id of the new virtual machine will be the same, it will have new IP Addresses, DNS Names, etc. You shouldn't think of starting a stopped instance as simply restarting the same virtual machine that you just stopped as it will most likely be a completely different virtual machine that will be provisioned to you.


For more information about what really happens during each server/instance state, please see [Server States](http://support.rightscale.com/12-Guides/Lifecycle_Management/05_-_Server_Management/Server_States).


**Warning!** - When stopping an instance, keep in mind that it must be started again through RightScale in order to operate correctly.  If the instance is started outside of RightScale, we will not be able to generate the required user data so that the instance will be able to properly communicate with RightScale via the RightLink agent.
