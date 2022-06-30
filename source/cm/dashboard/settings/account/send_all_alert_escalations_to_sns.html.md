---
title: Send All Alert Escalations to SNS
layout: cm_layout
description: Steps for exporting all RightScale alerts on your account to a specified SNS Topic.
---

!!warning*Warning*This feature has been **deprecated** and is no longer available.

## Objective

Export all RightScale alerts on your account to a specified SNS Topic.

## Prerequisites

* Requires 'admin' user role privileges to configure this feature.
* An Amazon Web Services account with valid AWS Credentials. See [Sign-up for Amazon Web Services (AWS)](http://support.rightscale.com/03-Tutorials/01-RightScale/3._Upgrade_Your_Account/1.5_Sign-up_for_AWS/index.html).
* Must have SNS set up with your AWS account.

## Overview

Export all alert escalations to an SNS Topic so you can log them in the ticketing service of your choice.

!!info*Note:* Although this is an AWS feature, it is able to work with multiple clouds and will report through AWS SNS.

## Steps

1. Navigate to **Settings** > **Account**  **Settings** > **Preferences**.
  ![cm-preferences-sns.png](/img/cm-preferences-sns.png)
2. Specify an SNS TopicARN and your SNS Cloud Region.<br>
  ![cm-edit-sns.png](/img/cm-edit-sns.png)
  * **SNS TopicARN:** the unique ARN (Amazon Resource Name) assigned by AWS after creating a topic, consisting of the service name, region and AWS ID.
  * **SNS Cloud Region:** select the region where your SNS is utilized.
3. Click **Save**.

## See also

* [https://aws.amazon.com/sns/](https://aws.amazon.com/sns/)
* [http://docs.amazonwebservices.com/sn...I\_Publish.html](http://docs.amazonwebservices.com/sns/latest/api/API_Publish.html)
