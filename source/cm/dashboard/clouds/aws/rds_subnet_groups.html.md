---
title: RDS Subnet Groups
layout: cm_layout
description: An RDS Subnet Group is a collection of subnets that you can use to designate for your RDS database instance in a VPC.
---
## Overview

An RDS Subnet Group is a collection of subnets that you can use to designate for your RDS database instance in a VPC. The database within your VPC will use the Subnet Group and the preferred Availability Zone to select a subnet and an IP address within that subnet. An Elastic Network Interface will be associated to the database instance with that IP address. Note that each DB Subnet Group should have at least one subnet for every Availability Zone in a given Region.

## Actions

* [Create a New RDS Subnet Group](/cm/dashboard/clouds/aws/actions/rds_subnet_groups_actions.html#create-a-new-rds-subnet-group)

## Further Reading

* [About RDS Instances](/cm/dashboard/clouds/aws/rds_instances.html)
