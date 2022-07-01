---
title: RDS Subnet Groups - Actions
description: Common procedures for working with RDS Subnet Groups in the RightScale Cloud Management Dashboard.
---

## Create a New RDS Subnet Group

## Overview

When you create a database instance inside an Amazon VPC, you will need to define a DB Subnet Group. Then your database will use that Subnet group and the preferred Availability Zone to select a subnet and an IP address within that subnet. Note that each database Subnet Group should have at least one subnet for every Availability Zone in a given Amazon Region. Use the following procedure to create a new RDS database subnet group for your AWS VPC.

### Steps

* Navigate to: **Clouds** > *AWS Region* > **RDS Subnet Groups**
* Click **New**.
* Specify the following parameters:
  * **Group name** - Provide a name for the security group. It must begin with a letter; must contain only ASCII letters, digits, and hyphens; and must not end with a hyphen or contain two consecutive hyphens.
  * **Group description** - Brief description about the security group. (Required)
  * **VPC** - The Virtual Private Cloud you would like to associate to this group.
