---
title: AWS Instance Purchase Options
layout: aws_layout_page
description: Amazon Web Services offers three different ways to purchase EC2 instances - On-Demand Instances, Reserved Instances, and Spot Instances.
---

## Overview

Amazon offers 3 different ways to purchase EC2 instances. The different purchase options are available for all [EC2 Instance Types](/clouds/aws/aws_instance_types.html).

* On-Demand Instances
* Reserved Instances
* Spot Instances

Depending on your technical and financial requirements, one of these options might provide a comparative advantage over the other. There is no difference in terms of the underlying hardware that is being launched. Only the pricing model is different. It's important to properly understand the costs and benefits associated with each option. The table below highlights some of the key differences.

| **Description** | **On-Demand Instances** | **Reserved Instances** | **Spot Instances** |
| --------------- | ----------------------- | ---------------------- | ------------------ |
| Available Instance Types | All | All | All |
| Launch Priority | 2 | 1 | 3 |
| Pricing Model | Fixed Price | Upfront Fee + Reduced Fixed Price | Bidding (Variable Spot Price) |
| Predictable Server Uptime? | Yes | Yes | No |

## On-Demand Instances

The most common instance purchase option follows the On-Demand pricing model. There is a fixed price for a particular instance type. You will be charged at an hourly rate until the instance is terminated.

## Reserved Instances

You also have the option of "reserving" EC2 instances where you pay a one-time payment up-front in order to secure a lower server usage charge when those instances are used. The one-time fee is available for 1 and 3 year terms. Pricing varies depending on size and term length. When you purchase a Reserved Instance, you must specify a particular instance type (e.g. m1.small) and availability zone (e.g. 'us-east-1a'). See [http://aws.amazon.com/ec2/](http://aws.amazon.com/ec2/) for current pricing information. From a technical perspective, EC2 instances are treated the same as on-demand instances inside the Dashboard. The main difference is how Amazon bills your EC2 instance usage. When you purchase Reserved Instances of a particular type in an availability zone and you have existing instances of the same instance type running in that zone, they will automatically be charged at the lower usage rate. Launching an instance is no different in the case of Reserved and On-Demand instances, however the system will apply the lower usage rate based on the number of Reserved Instances in that zone of the same type.

Reserved Instances are an ideal option for businesses that have very predictable and steady usage requirements, and can provide significant cost savings over time. For example, if you know that you will always have at least 4 instances running at a steady rate for the next year, you might consider purchasing 4 Reserved Instances for a 1-year team. Remember, you can always use On-Demand Instances to satisfy any additional resource needs. Another benefit of Reserved Instances is that you have priority over On-Demand and Spot Instance users. If instance capacity ever becomes limited in a particular availability zone, Reserved Instance users have top priority when launching instances. If instance capacity is ever 100% utilized in a particular availability zone, Amazon reserves the right to terminate a Spot Instance so that it can be provisioned in order to satisfy a Reserved Instance launch request.

## Spot Instances

In order to maximize the utilization rates of existing cloud resources, Amazon offers Spot Instances which allow you to bid on unused compute capacity on EC2. You can set a maximum bid price that you're willing to pay for an instance (e.g. $0.055). If the Spot Price for Spot Instances falls below your maximum bid price, a Spot Instance will be launched. A running Spot Instance will be billed at the variable Spot Price, not your bid price. A Spot Instance will continue to run as long as the Spot Price remains below your maximum bid price. However, if either the Spot Price exceeds your maximum bid price or Amazon needs your Spot Instance in order to fulfill an On-Demand or Reserved Instance launch request, your Spot Instance will be terminated. Typically, Amazon will update the Spot Price several times throughout the day. When you make a request to Amazon for a Spot Instance, you must wait until Amazon can fulfill that request. Depending on your maximum bid price and Amazon's excess compute capacity and Spot Price, it may take several days or even weeks before an Instance is actually launched. Therefore, you will not want to launch a Spot Instance if you want to immediately launch a server. The Spot Instance option is useful for running non-critical applications, because the instance could disappear at anytime. You should never use a Spot Instance to launch a server that requires consistent uptime.

When you launch a Spot Instance server inside the Dashboard, the server will remain in the 'bidding' state until additional compute capacity becomes available and the Spot Price falls below your maximum bid price. If a Spot Instance is launched and then later terminated by Amazon, the server will remain in the 'bidding' state. By default, RightScale will persist your Spot Instance request with Amazon so that a new instance will be launched when one becomes available. In order to retract your request for a Spot Instance from Amazon, you must manually terminate the server.

**Note:** You cannot start/stop a Spot Instance. [Click here](http://docs.amazonwebservices.com/AWSEC2/latest/APIReference/index.html?ApiReference-query-StopInstances.html) to see more information on this topic from AWS.

## How do you select a Server's Pricing Type?

Although there are 3 different EC2 instance purchasing options, you can only manually control whether you launch an On-Demand or Spot Instance. Although Reserved Instances are manually purchased from Amazon, it is Amazon, not you, who determines whether your On-Demand instances should be billed at the discounted Reserve Instance price or at the standard On-Demand Instance price. As a user, you can only control whether or not you are launching an On-Demand or Spot Instance.

By default, all servers will be configured to launch On-Demand Instance types unless you overwrite this preference at the server level in the Cloud Management Dashboard. Once a server has been added to a deployment, you can select "Spot" as the instance type under a server's *Info* tab. Click **Edit**. If you want to launch a "Spot" instance type, you will also need to define the Maximum Bid Price. Use the "history" link to view recent changes to the current spot price.

Note: Amazon typically changes the spots randomly throughout the day.

**Note**: Spot Instances do not support start/stop functionality. [Click here](http://docs.amazonwebservices.com/AWSEC2/latest/APIReference/index.html?ApiReference-query-StopInstances.html) for more information.

## Further Reading

* [http://aws.amazon.com/ec2/#pricing](http://aws.amazon.com/ec2/#pricing)
