---
title: RDS Instances - Actions
description: Common procedures for working with RDS Instances in RightScale Cloud Management Dashboard.
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

## View Detailed RDS Information

Once an RDS Instance is launched you can view more detailed information by clicking on the instance in the RDS Instances page. The following table describes each of the RDS Instance fields.

| Field | Description |
| ----- | ----------- |
| Name | The unique name/identifier for the RDS instance. |
| Engine | The version of the MySQL or Oracle engine of the RDS instance. |
| Status | The current operational status of the RDS instance. |
| Endpoint address | The DNS name of a DB instance. The endpoint address includes the RDS instance's name (AWS ID) and EC2 region. (e.g. myrds.chxspydgchoo.us-east-1.rds.amazonaws.com) |
| Endpoint port | The RDS instance's endpoint port. If you leave this field blank (recommended), the default port for MySQL (3306) will be used. |
| Allocated storage in GB | The size of the RDS instance in GB that's allocated for storage. Valid Range: 5-1024GB. (Default: 25) |
| Instance class | The compute and storage classification for the RDS instance. |
| Availability Zone | The availability zone into which the RDS instance will be created and launched. The default is "any", meaning an availability zone is selected at random from the correct region. For billing purposes, you might want to use the same availability zone as the Server instances that will be connecting to it. |
| Multi-AZ | Indicates that the RDS instance will be used in a multiple availability zone configuration. If true (checked) then the Availability Zone must _not_ be selected. If checked, Amazon will create a redundant copy of the instance in a different availability zone however, you will only have access to the main instance and not the copy. |
| License model | The options available are 'bring-your-own-licence' which means it's an existing Oracle Database license, 'license-is-included' means it's a Windows SQL database, and 'general-public-license' means it's a MySQL database. |
| DB name | This is the name for the Oracle System ID (SID) you're connected to. The default is 'oracle'. Note if you are connected to an instance other than Oracle, this field may be left blank. |
| Auto minor version upgrade | If this field was checked when created, Amazon automatically upgraded the instance's version of MySQL. For example, if your instance is using MySQL v5.1.50 and Amazon later supports v5.1.51 for RDS instances, your instance's MySQL engine will automatically be upgraded at that time during one of the maintenance windows. |
| Create at | The date and time the RDS instance was created. |
| Preferred maintenance window | AWS will periodically perform maintenance on your RDS instance. Specify a 4-hour window (GMT timezone) during non peak time that's ideal for maintenance purposes. (Day:HH:MM-Day:HH:MM) If this field is left blank, the default window will be used (sun:05:00-sun:09:00). |
| Preferred backup window | AWS will automatically perform a daily backup your database during your predefined backup window. Specify a 2-hour window (GMT timezone) for backups (HH:MM-HH:MM). If this field is left blank, the default window will be used (03:00-05:00). |
| Backup retention period | AWS performs regular backups of the RDS instance. For typical workloads, you should be able to restore your database to any point in time within your retention period, up to the last five minutes. Specify the desired length of your retention period in number of days. Valid Range: 1-8 (Default: 1) |
| Master username | The username to log into MySQL. |
| Master user password | The password to log into MySQL. |
| RDS Security Group(s) | The name of the RDS security group. Multiple security groups can be associated to an RDS instance. |
| RDS Parameter Group | The RDS Parameter. Only one RDS Parameter can be associated to an RDS instance. |

**Action Buttons**

While viewing the details of a selected RDS instance you can also execute a number of operations on the instance using the following action buttons.

* **Snapshot** - Create a manual snapshot of the RDS Instance at this point in time. (Note: You cannot create a snapshot of a Read Replica.)
* **Restore** - AWS gives you the ability to restore the RDS Instance using to a particular point in time within the specified retention period. For typical workloads, you should be able to restore your database up to the last five minutes.
* **Modify** - Once an RDS Instance is available, you can still modify some of its configuration settings.
* **Reboot** - Reboots the RDS Instance. Performing this action will not change the endpoint address.
* **Launch Read Replica** - If you're viewing a source RDS instance, you can launch a Read Replica RDS instance.
* **Terminate** - Shuts down the RDS Instance. When you terminate an RDS Instance an RDS Snapshot will automatically be created before the instance actually shuts down. (e.g. myrds-final-snapshot-timestamp)

## Modify an RDS Instance

### Overview

Currently, there is no way to modify an RDS instance's configuration settings *without* rebooting it. When a Read Replica instance is launched for the first time it will inherit the remainder of its configuration settings from its source DB instance (e.g. RDS Security Groups, RDS Parameter Groups, etc.). Use the following procedure to modify an RDS Instance's configuration.

### Prerequisites

* AWS Account with RDS support. You must [Sign Up for Amazon RDS](http://aws.amazon.com/rds/) before you can launch RDS instances.
* 'actor' user role privileges
* An 'available' RDS instance (Source or Read Replica)

### Steps

* Select a running RDS instance. If there is a link under the Source instance column, that means it is a Read Replica of the source instance.

![cm-RDS-read-replica.png](/img/cm-RDS-read-replica.png)

* Click the **Modify** action button. The following fields are editable:

The following table lists the configuration settings of an RDS instance can be modified:

| Configuration Setting | Description |
| --------------------- | ----------- |
| Deployments | Specify a Deployment to associate with your RDS Instance, where it will be viewable at the bottom of the Deployment's Servers tab. |
| Allocated storage in GB | Specify a new storage size for the instance that will be allocated for storing data. |
| Master user password | For security purposes, in order to make changes to a Read Replica, you must provide the user password for the Master (Source) RDS instance. |
| Instance Class | If you select a different instance type, the existing instance will be terminated and new RDS instance will be launched. |
| Backup retention period | The number of days for which system snapshots and point in time restore are available. Specified in days. (e.g. 0-3) (Configuration only applies to Source, not Read Replica instances) |
| IOPS | You can specify a minimum of 1,000 IOPS with 100GB up to a maximum of 10,000 IOPS with 1TB of storage for MySQL and Oracle databases at a rate of 1,000 IOPS per 100GB (for example, 1,000 IOPS per 100GB, 2,000 IOPS per 200GB, 3,000 IOPS per 300GB, etc.). If you are using SQL Servers, then the maximum IOPS you can provision is 7,000 IOPS. Note: only specify this value if you are going to use IOPS. Otherwise, leave this blank. |
| Preferred backup window | A two hour window when complete backups of the database will be taken. |
| Preferred maintenance window | AWS will periodically perform maintenance on your RDS Instance. Specify a 4-hour window (GMT timezone) during non peak time that's ideal for maintenance purposes. (Day:HH:MM-Day:HH:MM) If this field is left blank, the default window will be used (sun:05:00-sun:09:00). |
| RDS Security Group(s) | The security group(s) that will be used by the instance. |
| RDS Parameter Group | The parameter group that will be used by the instance. |
| Multi-AZ | If checked, the instance will have a redundant instance in a different availability zone as the source instance. You can only use the multi-availability zone option for sources instances. (Configuration only applies to Source, not Read Replica instances) |
| Engine | The version of MySQL that will be installed on the instance. Note: Read Replicas can only be launched with version 'mysql 5.1.50' and above. |
| Allow major version upgrade | If checked, Amazon will automatically upgrade the instance's major MySQL version. For example, if the instance is using MySQL v5.1.50 and Amazon later supports v5.2.01 for RDS instances, your instance's MySQL engine will automatically be upgraded during one of the maintenance windows. Keep this box unchecked unless you've already tested and verified that your database is compatible with the latest supported version of MySQL. |
| Auto minor version upgrade | If checked, Amazon will automatically upgrade the instance's MySQL version. For example, if the instance is using MySQL v5.1.50 and Amazon later supports v5.1.51 for RDS instances, your instance's MySQL engine will automatically be upgraded during one of the maintenance windows. |
| Apply immediately | Select 'Yes' if you want the changes to take effect immediately. Select 'No' if you want to apply the changes at a later time. |

!!info*Note:* With **Backup retention period** and **Multi-AZ** , configuration only applies to Source (not Read Replica) instances.

When you are satisfied with your changes, click **Modify**. If the changes were set to be applied immediately, the RDS instance will enter a 'modifying' state while the specified changes are applied. If you specified a different instance class, a new RDS instance will be launched. Once all changes have been applied, the instance's state will change to 'available'.

## Launch a Read Replica

### Overview

Read Replicas are a type of RDS instance that is used for taking read-requests off of the source "master" RDS instance. Read Replicas are ideal for read-heavy database applications. Updates to the MySQL database on the source DB Instance will be replicated using MySQL’s native, asynchronous replication.

!!info*Note:* Replication lag can vary significantly. Use the following procedure to launch a Read Replica RDS Instance.

### Prerequisites

* AWS Account with RDS support. You must [Sign Up for Amazon RDS](http://aws.amazon.com/rds/) before you can launch RDS instances.
* 'actor' user role privileges
* An 'available' source RDS instance

### Steps

* Navigate to **Clouds** > *AWS Region* > **RDS Instances**.
* Select a source DB instance for which you want to create a Read Replica.

!!info*Note:* You can only create a Read Replica instance if you have a source DB instance that will serve as the Master-DB.

* Click the **Launch Read Replica** button. This button will only be visible if the source RDS instance is available since a Read Replica will serve as a copy of the source "master" RDS instance for.

![cm-RDS-read-replica.png](/img/cm-RDS-read-replica.png)

* Fill out the following fields appropriately.
* To launch a Read Replica RDS Instance, provide the following information:
  * **Name** - Enter the name of the Read Replica instance that you're going to launch. Note: By default, a name will be automatically generated where the name of the source ("master") RDS instance will be used as a prefix. If you plan to launch more than one Read Replica for the source instance (max=5), you might want to add a number in the name for differentiation purposes.
  * **Instance Class** - Select the instance type that you want to use for launching the new Read Replica RDS instance.
  * **Endpoint Port** - Enter which port will be used by MySQL. By default, if you leave this field blank, port 3306 will be used.
  * **Availability Zone** - Select the availability zone where the instance will be launched. If the 'any' option is selected, Amazon will randomly pick an availability zone for you.
  * **Auto minor version upgrade** - If checked, Amazon will automatically upgrade the instance's MySQL version. For example, if the instance is using MySQL v5.1.50 and Amazon later supports v5.1.51 for RDS instances, your instance's MySQL engine will automatically be upgraded during one of the maintenance windows.
  * **IOPS** - Enter the IOPS for your Read Replica. Note the value of your IOPS depends on the instance in use. Leave blank if you are not using IOPS.

A Read Replica instance will inherit the remainder of its configuration settings from its source DB instance (e.g. RDS Security Groups, RDS Parameter Groups, etc.). To change any of these settings you will first need to launch the instance, wait for it to become 'available' and editable, edit its configurations, and then reboot the instance.

!!info*Tip:* Use the (<u>?</u>) to display a tooltip for additional help on specific fields when available.

* Click the **Launch** action button when ready.

!!info*Note:* Currently, there is no way to save a new RDS Instance's configuration settings *without* launching it.

* Once its status becomes 'available' the RDS Instance will be accessible.

