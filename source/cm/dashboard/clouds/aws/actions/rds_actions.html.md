---
title: AWS RDS - Actions
description: Common procedures for working with the AWS RDS in the RightScale Cloud Management Dashboard.
---

## Create a New RDS Instance

### Overview

Use the following procedure to create a new RDS instance using the RDS Browser in the CM dashboard.

### Prerequisites

* AWS Account with RDS support. You must [Sign Up for Amazon RDS](http://aws.amazon.com/rds/) before you can launch RDS instances.
* 'actor' user role privileges

### Steps

* Go to **Clouds** > *AWS region* > **RDS** or **Clouds** > *AWS region* > **RDS Instances**.
* Click **New Instance**.

    ![cm-new-RDS-instance-details.png](/img/cm-new-RDS-instance-details.png)

* Enter the information for your new RDS instance:
  * **DB Instance Identifier** - The user-defined name that will identify the database Instance. This unique key will be stored as a lower-case string.
  * **Instance Class** - Defines the available compute power and memory for the instance.
  * **Availability Zone** - An availability zone is an isolated set of compute resources. If Multiple Zones are selected, the DB Instance will have a standby in an additional zone.
  * **Subnet Group** - A collection of subnets in a VPC. DB subnet groups must have a subnet in each availability zone in the region.
  * **Additional Options**
      * **Automatically apply minor engine version upgrades** - If enabled, the RDS instance will automatically receive and apply minor database upgrades.
      * **Use Provisioned IOPs** - If enabled, the RDS instance will support a minimum number of I/O operations per second. Provisioned IOPS have to be 1,000 or greater and the IOPS to Allocated Size ratio must be 10 to 1. Thus, the smallest ratio you can have is 1,000 IOPS for 100GB of Allocated Size. And the largest is 10,000 IOPS for 1000GB (or 1024GB) of Allocated Size.
  * **DB Security Group(s)** - One or more DB security groups that control IP and port access to the database instance.
  * **Engine Versions** - The database engine and version that the RDS instance will use.
  * **License Model** - License for the selected database engine. Some engines may have only one license available.
  * **Allocated Storage** - The amount of storage, in gigabytes that will be initially allocated to the database instance. The allocated size must be between 5 and 1024GB.
  * **Database Name** - An identifier for the database. The exact value that is used depends on the database engine. For Oracle, this is the value of the ORACLE_SID.
  * **Master Username** - The username for the database.
  * **Master Password** - The password for the database.
  * **Database Port** - The port used to communicate with the database.
  * **DB Option Group** - A set of options for the selected database engine. If no compatible option groups are available, a default option group will be created when the DB instance is launched.
  * **DB Parameter Group** - A set of key-value pairs associated with the database. If you do not have a custom parameter group, the default settings will be used.
* If you would like to make changes to how you would like your RDS Instance backed up, click **Backup and Maintenance**.

    ![cm-new-RDS-instance-backup-and-maintenance.png](/img/cm-new-RDS-instance-backup-and-maintenance.png)

  * **Backup Window**
    * **Enable Automatic Backup** - If selected, automatic backups will be made for your DB instance. Automated backups are only supported for the InnoDB storage engine.
      * **Backup Retention Period** - If selected, automatic backups will be made for your DB instance. Automated backups are only supported for the InnoDB storage engine.
      * **Configure a specific window** - Select this box to indicate a specific window in which backups will be made.
      * **Start Time** - The beginning of the window in which automated backups will be created.
      * **Duration of Window** - The number of hours from the start time in which system maintenance will occur.
  * **Maintenance Window**
    * **Configure a specific window** - Select this box to indicate a specific window in which maintenance will be made.
      * **Start Time** - The beginning of the window in which automated backups will be created.
      * **End Time** - The ending of the window in which automated backups will be created.

* Click **Create**.

## Take an RDS Database Snapshot

### Overview

Taking an RDS Database Snapshot creates a backup of your DB instance. A snapshot can be used to restore your database instance. You can have snapshots automated when you create an instance or you can create the snapshots manually. The steps below explain how to manually create a snapshot.

### Prerequisites

* AWS Account with RDS support. You must [Sign Up for Amazon RDS](http://aws.amazon.com/rds/) before you can launch RDS instances.
* 'actor' user role privileges

### Steps

* Go to **Clouds** > *AWS Region* > **RDS** or **Clouds** > *AWS region* > **RDS Instances**.
* Click on an RDS instance Nickname.
* From the **Details** tab, click **Take DB Snapshot**.

!!info*Note:* The RDS instance Details tab will only be accessible if the RDS instance is in an 'available' state. Other ongoing actions may prevent the RDS instance from being fully accessible, so it may be necessary to wait until those actions have completed before proceeding.

![cm-RDS-beta-snapshot.png](/img/cm-RDS-beta-snapshot.png)

* Enter the name of the snapshot:

![cm-take-DB-snapshot.png](/img/cm-take-DB-snapshot.png)

* Click **Take Snapshot**. You will be redirected to the **Snapshots** tab. The status of the snapshot will list as "creating." You will not be able to perform actions on the snapshot or RDS instance until the snapshot becomes "available." It should take several minutes for a snapshot to create. Once available, you can click on the snapshot and perform various tasks such as restore, delete, or view the events of a snapshot.
