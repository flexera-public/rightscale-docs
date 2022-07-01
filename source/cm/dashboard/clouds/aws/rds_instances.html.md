---
title: RDS Instances
layout: cm_layout
description: Amazon Relational Database Service (Amazon RDS) is a web service that that allows you to quickly create a relational database instance in the cloud.
---

## Overview

Amazon Relational Database Service (Amazon RDS) is a web service that that allows you to quickly create a relational database instance in the cloud. Amazon RDS manages the database instance on your behalf by performing backups, handling failover, and maintaining the database software.

For read-heavy applications, you can launch Read Replicas which are RDS instances that serve as copies of the source "master" database for handling read-requests. You can attach up to five (5) Read Replicas to a source DB instance.

The Instances page lists the existing RDS Instances in the selected AWS region. Clicking on an existing RDS Instance displays the details for that instance.

**Fields**

* **Name** - unique name/identifier for the RDS instance.
* **Engine** - The version of the MySQL or Oracle engine of the RDS Instance.
* **RDS Subnet Group** - The group of RDS Subnets for the VPC.
* **Availability Zone** - The availability zone into which the RDS Instance will be created and launched.
* **Multi-AZ** - Indicates that the RDS Instance will be used in a multiple availability zone configuration.
* **Instance class** - If you selected a different instance type, the existing instance will be terminated and new RDS instance will be launched.
* **Storage** - storage size in GBs for the instance that will be allocated for storing data.
* **Source instance** - If the instance is a Read Replica, it will list the name of the source DB instance.
* **Status** - The status of the RDS Instance (creating, modifying, available, rebooting, deleting). An RDS Instance will only be accessible when its status is 'available'.

**Action Buttons**

* **New Instance** - Create a new RDS instance.

## Actions

* [Create a New RDS Instance](/cm/dashboard/clouds/aws/actions/rds_actions.html#create-a-new-rds-instance)
* [View Detailed RDS Information](/cm/dashboard/clouds/aws/actions/rds_instances_actions.html#view-detailed-rds-information)
* [Launch a Read Replica](/cm/dashboard/clouds/aws/actions/rds_instances_actions.html#launch-a-read-replica)
* [Migrate from RDS to ServerTemplates](/cm/dashboard/clouds/aws/actions/rds_instances_actions.html#migrate-from-rds-to-servertemplates)
* [Modify an RDS Instance](/cm/dashboard/clouds/aws/actions/rds_instances_actions.html#modify-an-rds-instance)
