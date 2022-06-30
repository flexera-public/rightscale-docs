---
title: EC2 t2.x Instance Type Requirement
category: general
description: The t2.x instance type is only supported in a VPC environment that is why the first error is thrown when used to launch an instance in a EC2-Classic.
---

## Question:

I am getting the following errors when launching an instance using the t2.x types:

t2.micro  
t2.small  
t2.medium

  `400: VPCResourceNotSpecified: The specified instance type can only be used in a VPC. A subnet ID or network interface ID is required to carry out the request.`

  `400: UnsupportedOperation: AMI 'ami-a6386bf4' with an instance-store root device is not supported for the instance type 't2.small'.`

  `400: InvalidParameterCombination: Virtualization type 'hvm' is required for instances of type 't2.small'.`

## Answer:

The t2.x instance type is only supported in a [VPC environment](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Clouds/AWS_Regions/VPCs) that is why the first error is thrown when used to launch an instance in a EC2-Classic. And it can only be used with an HVM type image (Hardware-assisted Virtual Machine). This is an AWS limitation.

An example of an HVM image is the following, usually has HVM in the name

`RightImage\_CentOS\_6.5\_x64\_v13.5\_LTS\_HVM\_EBS`

## Reference:

[http://docs.aws.amazon.com/AWSEC2/la...instances.html](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/t2-instances.html)

<a nocheck href='https://forums.aws.amazon.com/thread.jspa?messageID=553644'>https://forums.aws.amazon.com/thread...ssageID=553644</a>

**Contact Information**

* [support@rightscale.com](mailto:support@rightscale.com)&nbsp;- For questions about this document.
* [docrequests@rightscale.com](mailto:docrequests@rightscale.com)&nbsp;- Report any perceived errors, omissions or suggestions to improve this document.
