---
title: How to Enable AWS Enhanced Networking on EC2 Instance
category: general
description: The easiest way to enable this on RightScale is to create a Custom Image (AMI). This article walks you through enabling enhanced networking on an existing image and creating a custom image for use in RightScale.
---

## Overview

AWS provides a feature called [enhanced networking](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html) for instances that results in higher performance (packets per second), lower latency, and lower jitter. This feature must be enabled on the image in order to use it with RightScale.

## Procedure

The easiest way to enable this on RightScale is to create a Custom Image (AMI). The following steps will walk you through enabling enhanced networking on an existing image and creating a custom image for use in RightScale.

1. Check for pre-requisites listed in the [AWS Documentation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html) such as the supported instance types, required setup, etc.
2. Connect to your instance.
3. From the instance, run the following command to update your instance with the newest kernel and kernel modules, including ixgbevf: `sudo yum update`
4. From your local computer, reboot your instance using the Amazon EC2 console or one of the following commands: `reboot-instances` (AWS CLI) or `ec2-reboot-instances` (Amazon EC2 CLI).
5. Connect to your instance again and verify that the `ixgbevf` module is installed and at the minimum recommended version using the `modinfo ixgbevf` command from [Testing Whether Enhanced Networking Is Enabled](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enhanced-networking.html#test-enhanced-networking).
6. After this, you may start creating your Custom AMI.
7. Then you may create a [Multi-Cloud Image] (/cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image) using your new Custom AMI to be used in a ServerTemplate.
8. Be sure to enable the enhanced networking attribute when you register the AMI.
    1. register-image (AWS CLI):<br>
      ```
      $ aws ec2 register-image --sriov-net-support simple ...
      ```
    2. ec2-register (Amazon EC2 CLI):<br>
      ```
      $ ec2-register --sriov simple ...
      ```
