---
title: RDS Security Groups - Actions
description: Common procedures for working with RDS Security Groups in the RightScale Cloud Management Dashboard.
---

## Create a New RDS Security Group

### Overview

Use the following procedure to create a new RDS database security group. Once you create an RDS Security Group, you can add a CIDR IP or standard EC2 Security group to it.

### Steps

* Navigate to: **Clouds** > *AWS Region* > **RDS Security Groups**
* Click **New Security Group**.
* Specify the following parameters:
  * **Group name** - Provide a name for the security group. It must begin with a letter; must contain only ASCII letters, digits, and hyphens; and must not end with a hyphen or contain two consecutive hyphens.
  * **Group description** - Brief description about the security group. (Required)
  * **VPC** - The Virtual Private Cloud you would like to associate to this group.

### Post Tutorial Steps

* Increasing security for your RDS Security Group (adding CIDR IP and/or EC2 Security Groups)

## Allowing Additional Access to Your RDS Database

### Overview

Once you create an RDS Security Group, you can add a CIDR IP *or* standard EC2 Security group to it. **You cannot add both.**

* You can add IP ranges in CIDR block format if the application using your database is running on the Internet.
* Add standard EC2 security groups if the application using the database is running on EC2 instances.
Use the following procedure to grant authorization to your RDS database by altering your RDS Security Group and allowing (ingress) access based on *either* IP or EC2 Security Group.

### Prerequisites

* Already created RDS Security Group
* Already created EC2 Security Group (if specifying an EC2 Security Group to your RDS DB Security Group)

### Steps

* Navigate to **Clouds** > *AWS Region* > **RDS Security Groups**
* Select the Security group you want to add to

!!info*Note:* You can not add both a CIDR IP and EC2 Security Group; only one or the other.

* Select the **Add CIDR IP** action button
  * Specify the CIDR IP in the following format: 1.2.3.4/## (example. 10.0.60.0/24)
* Select the **Add EC2 Group** action button
  * Specify the *owner* of the existing EC2 Security Group
  * Specify the *name* of the existing EC2 Security Group
  * *Tip*: You can get the AWS Owner ID and Security Group name here: **Clouds** > *AWS Region* > **Security Groups**
* Select the **Add** action button to save your changes.

## Revoking Ingress Access to Your Database

### Overview

Use the following procedure to revoke previously granted ingress access to your RDS database.

### Prerequisites

* Existing RDS Security Group
* Existing authorized ingress access (either CIDR IP or EC2 Security Group)

### Steps

* Navigate to the existing RDS Security Group: **Clouds** > *AWS Region* > **RDS Security Group**.
* Select the Security Group name
* Select the **revoke** action link from either
  * Ec2 security group
  * IP ranges

## Delete a RDS Security Group

### Overview

Use the following procedure to remove a RDS r3Security Group

### Steps

There are two ways to remove an existing RDS Security group:

1. Navigate to **Clouds** > *AWS Region* > **RDS Security Group** and select the corresponding **delete** action icon.
2. When viewing a selected RDS Security Group (see above navigation), select the **Delete** action button.
