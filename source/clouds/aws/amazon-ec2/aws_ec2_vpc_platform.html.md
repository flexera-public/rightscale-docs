---
title: EC2-VPC Platform
layout: aws_layout_page
description: On 3.11.13, AWS announced Virtual Private Clouds for Everyone. The announcement unveiled AWS's plan to give all accounts access to VPC and calling the old functionality "EC2-Classic."
---

## Background of EC2-VPC Announcement

On 3.11.13, AWS announced [Virtual Private Clouds for Everyone](http://aws.typepad.com/aws/2013/03/amazon-ec2-update-virtual-private-clouds-for-everyone.html). The announcement unveiled AWS's plan to give all accounts access to [VPC](/clouds/aws/amazon-ec2/aws_ec2_vpc_platform.html) and calling the old functionality "EC2-Classic." AWS plans to roll this out region by region. Newly created AWS accounts will launch instances on the "EC2-VPC" platform only. Existing users will experience EC2-VPC by default in new regions that they have not yet used but the regions they are already using remain unchanged.

## Overview of EC2-VPC Platform

In this first phase, new AWS accounts will become "VPC exclusively" (region by region), meaning all resources will be within a Virtual Private Cloud. Each account receives a default VPC and default security group and API calls that create resources without specifying a VPC will use the defaults. This makes the legacy API version and non-VPC API calls work. The default VPC and default security group are configured at the time the account is created and enable a similar experience to accounts on the "EC2-Classic". AWS is intentionally making the transition to "EC2-VPC" seamless in that "EC2-Classic" API interactions work with no change. All of this is compatible and consistent with RightScale's support.

### Amazon Plan

When a user creates a new AWS account, AWS creates a default /16 virtual network (VPC) automatically. This virtual network has a default /20 subnet in each availability zone. This network is attached to the Internet. In RightScale, all of this network configuration occurs behind the scenes and users do not need to configure anything if they choose not to. Their experience will resemble EC2-Classic.

### RightScale Plan

1. RightScale will recognize EC2-VPC platform accounts and recognize default VPC and default security group so they can be displayed as such.
2. The flows for adding a server support default VPC settings to support AWS' effort to make "EC2-VPC" look like "EC2-Classic" as well as more advanced VPC configurations for advanced users.

## Background EC2-Classic VPC Information

Below is some background information about VPC in EC2-Classic that is helpful when transitioning to EC2-VPC.

### VPC characteristics

* VPC is available in all regions
* A single VPC is tied to a single region but can span multiple Availability Zones
* A single subnet spans 1 Availability Zone only
* A subnet is required when launching an EC2 instance in a VPC. A default subnet is automatically created in each Availability Zone in a default VPC.
* You can use all AMIs within a region within a VPC in that same region without having to reregister AMIs
* You can use existing EBS Snapshots within a region within a VPC in that same region
* You can boot an instance with an EBS volume within a VPC. But the instance launched will retain the same IP address when stopped and restarted, which is behaviorally different as compared to the EC2-Classic platform
* You can use reserved instances within a VPC.
  * Customers marked as "VPC Only" can buy Reserved Instances (they only get one choice for a Reserved Instance purchase, which is VPC). It is flagged as a VPC Reserved Instance. The EC2 or VPC designation only specifies where the capacity reservation is held. For everyone else, the price benefit of the Reserved Instance is the same in EC2 and VPC. For example, if you book 10 Reserved Instances in EC2 and you launch 10 instances in VPC, you will get the price reduction on those ten instances. However, since the Reserved Instance is in EC2 and you're launching in VPC, AWS may not have the required amount of capacity for a VPC launch, whereas AWS commits to reserving that capacity for you in EC2.
  * You can also optionally reserve instances in Amazon VPC at the same prices as shown above. [Click here](http://aws.amazon.com/ec2/reserved-instances/) to learn more about Reserved Instances.
  * VPC Reserved Instances cannot be used with regular EC2 instances and vice versa. [Click here](https://forums.aws.amazon.com/message.jspa?messageID=343090) for more information.
  * [Click here](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts-on-demand-reserved-instances.html) for more information on guaranteed capacity with Reserved Instance purchases when using EC2 Reserved Instances in VPC.
 * CC1 instances are not supported, but CG1.4xl and CC2.8xl are in VPC
* [DevPay AMIs](http://aws.amazon.com/devpay/faqs/#Can_my_customers_run_instances_of_my_paid_AMI_in_Amazon_Virtual_Private_Cloud) are available in VPC

### Account defaults

* 5 VPCs per AWS Account per region
* 200 subnets per VPC
* 5 VPC EIPs per AWS account per region
* 1 internet gateway per VPC
* 5 virtual private gateways per AWS account per region

See [Amazon VPC Limits](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Appendix_Limits.html) for the full list.

## EC2-VPC Platform Instance behavior

### Instance Behavior

When a new user launches an instance, just like in EC2-Classic, it is actually launched in the default VPC, even if the user does not specify a VPC or a subnet.

* All existing commands that users use in EC2-Classic will continue to work, except they execute in a VPC.
* All instances launched by the user in a default subnet will automatically receive public IPs, just like EC2-Classic.
  * Users can set a flag on a subnet that says PublicIP=true|false. All instances launched into that subnet will or will not get a public IP. The public IP will be removed when the instance is stopped. The subnet-level flag can be overridden by an instance level flag on ec2run that says PublicIP=true|false.
* All instances launched by the user will be able to access the Internet automatically, just like EC2-Classic.
  * The default VPC is automatically attached to an internet gateway and routes are set appropriately.
* Users can associate multiple EIPs to these instances, including multiple EIPs per interface, if desired.
  * This requires users to first assign multiple private IPs to the interface, then they can associate an EIP to each private IP
  * Users can remove the public IP addresses from these instances during launch or after the instance is running, if desired.
  * Users can designate which subnets should automatically provide public IP addresses to instances during launch (unless a user overrides this setting at launch)
* Instances running with private IPs will only be able to access the internet via a NAT instance in the VPC.
* All EC2 commands will work just like EC2-Classic with no need to specify subnets at launch or specify security groups IDs (security group names are acceptable).

### Changes of Note

1. EIPs behave slightly differently when an instance is stopped (the EIP remains attached in VPC, while it becomes detached in EC2-Classic).
2. VPC security groups cannot reference security groups in other VPCs or in EC2-Classic.

### Exceptions

Instances will work just like EC2-Classic, except for the following cases (if so desired):

* Instances can use egress filtering in security groups
* Instances can specify any protocol in their security groups
* Instances can change security group membership on the fly without needing to be re-launched
* Instances can be assigned multiple IP addresses

Instances can be attached to multiple network interfaces

## EC2-VPC Platform Feature Availability

Standard VPC features will remain available in EC2-VPC platform, including the following:

* Users can attach VPNs to their network if they desire.
  * Users will not need to enter home network routes into route tables when they do VPNs, that can happen automatically, if desired
* Users can create additional subnets if they want and they can launch instances into these subnets, but only if they target their launches into these subnets
* Users can create other VPCs if they want, however, to launch into these other VPCs, they will need to target launches into the subnets in these VPCs
* All instances in this environment will get DNS hostnames, unless the user decides to turn off this feature* All AWS Services including ElastiCache, Beanstalk, OpsWorks, etc. are supported for use in this new environment.

### EC2-VPC and EC2-Classic Behavioral Differences

* Security groups in one VPC **cannot** reference security groups in another VPC or EC2-Classic
* EIPs in EC2-Classic **cannot** be used in EC2-VPC environment
* In EC2-Classic, when you stop an instance, its Elastic IP address is unmapped, and you must remap it when you restart the instance; whereas in VPC if you stop an instance, its Elastic IP address stays mapped.
* In EC2-Classic, instances can talk to each other via private IPs. In EC2-VPC, instances cannot talk to each other over private IPs when in different VPCs.
  * Users will need to start using hostnames to talk to each other, which will resolve to public IPs when called from outside the VPC or to the private IP when called from within the VPC.

## Future Steps

Contact RightScale Support with issues regarding EC2-VPC platform accounts. Consult this page in the interim while AWS rolls EC2-VPC platform to all regions and check back as we will release new documentation in the coming weeks to allow you to get the most out of VPC. Make sure to reference [Enabling Regions for the default VPC feature set](https://forums.aws.amazon.com/ann.jspa?annID=1875) for updated information such as which regions roll out as EC2-VPC.
