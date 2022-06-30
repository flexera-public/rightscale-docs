---
title: Database Manager for MySQL for Chef Server (RightLink 10)
alias: st/rl10/mysql/overview.html
description: The RightLink 10 Database Manager for MySQL for Chef Server ServerTemplate installs and configures a MySQL database server.
---

## Overview

The Database Manager for MySQL for Chef Server (RightLink 10) ServerTemplate installs and configures a MySQL database server. This ServerTemplate provides a high-availability master/slave database configuration that you can use as the backbone for a variety of applications and workloads.
The Database Manager for MySQL Chef Server ServerTemplate creates and attaches cloud based volumes used to store database data. These volumes are periodically backed up based on the volume snapshot features provided by the cloud.

!!info*Note:* This ServerTemplate requires a Chef Server with the required cookbooks (see below under Requirements) uploaded to the Chef Server to work.

!!info*Note:* For a complete list of the Database Manager for MySQL ServerTemplate's features and support, view the detailed description under its Info tab.

## Requirements
* [Chef Server](/st/rl10/chef-server/index.html) or Hosted Chef
* [rs-mysql](https://github.com/rightscale-cookbooks/rs-mysql/blob/v2.0.2/metadata.rb#L13-#L28)
* Instance size should include at least 1gb memory.  

## Software Application Versions

* [MySQL Versions](https://github.com/rightscale-cookbooks/rs-mysql/blob/v2.0.2/README.md#requirements)

## Technical Overview

The Database Manager for MySQL 5 ServerTemplate consists of scripts in all three sections - Boot Sequence, Operational Scripts, and Decommission Sequence.

### Boot Sequence
See [RightLink 10 Linux Base ](/st/rl10/base_linux/overview.html) for details on the default scripts.
* **Chef Client Install** - This script installs and configures the chef client.  
* **MySQL Server Install** -  Installs the MySQL server and tunes the attributes used in the my.cnf based on the available system memory and the server usage type. If the server usage type is 'dedicated', all resources in the system are dedicated to the MySQL server and if the usage type is 'shared', only half of the resources are used for the MySQL server. This 'shared' usage will be used in building a LAMP stack where the same system is used to run both the MySQL server and the PHP application server. This recipe also installs the collectd plugins for MySQL and tags the server as a standalone MySQL server.

### Operational Scripts

* **MySQL Server Install - chef** - See description above in Boot Sequence.
* **MySQL Server Volume - chef** - Creates a new volume from scratch or from an existing backup based on the value provided in the `RESTORE_LINEAGE` Input. If this Input is set, the volume will be restored from a backup matching this lineage otherwise a new volume will be created from scratch. This recipe will also format the volume using the filesystem specified in `DEVICE_FILESYSTEM` Input, mount the volume on the location specified in DEVICE_MOUNT_POINT input, and move the MySQL database directory to the volume.
* **MySQL Server Stripe - chef** - Creates a logical volume composed of volumes that are created from scratch or from an existing backup based on the value provided in `RESTORE_LINEAGE` Input. If this input is set, the volumes will be restored from a backup matching this lineage otherwise volumes comprising the logical volume will be created from scratch. This recipe will create a striped logical volume using LVM on the volumes and format the logical volume using the filesystem specified in `DEVICE_FILESYSTEM` Input. This recipe also mounts the volume on the location specified in DEVICE_MOUNT_POINT Input and moves the MySQL database directory to the logical volume.
* **MySQL Server Master - chef** - This recipe sets up the database to act as the master. It makes sure the database is not read-only by overriding the mysql/tunable/read_only to false and includes the rs-mysql::default recipe which installs MySQL and performs the configuration. The master database specific tags are added to the server and the master is reset.  The master database can be provided with a fully qualified domain name (FQDN) by setting the `DNS_MASTER_FQDN` input. The DNS provider credentials (`DNS_USER_KEY` and `DNS_SECRET_KEY`) must also be set to create/update the DNS records in the DNS provider.  The default DNS provider is DNS Made Easy API 2.0.  
* **MySQL Server Slave - chef** - This recipe modifies the MySQL server to be read-only and includes the rs-mysql::default recipe which installs MySQL, performs configuration, and tags the server as a slave server. It obtains the information about the master database with the help of the find_database_servers helper method provided by the rightscale_tag cookbook and changes the master host of the slave to the latest master available in the deployment. If this script is run after `MySQL Server Volume - chef` or `MySQL Server Stripe - chef` and a backup was restored, this recipe will use information from the backup to assist with catching up with the master MySQL database.
* **MySQL Server Backup - chef** - Takes a backup of all volumes attached to the server (except boot disks if there were any) with the lineage specified in the `BACKUP_LINEAGE` input. During the backup process, the MySQL database will be read-only and the filesystem will be frozen. With the help of a chef exception handler, the filesystem will be unfrozen and the MySQL database will no longer be read-only after the backup even if the backup process fails . This recipe also cleans up the volume snapshots based on the criteria specified in the `BACKUP_KEEP_*` inputs.
* **MySQL Server Schedule - chef** - Adds/removes the crontab entry for taking backups periodically at the minute and hour provided via the `SCHEDULE_MINUTE` and `SCHEDULE_HOUR` inputs.

### Decommission Sequence:

* **MySQL Server Schedule - chef** - If the `DEVICE_DESTROY_ON_DECOMMISSION` Input is set to true, this script moves the MySQL database back to the root volume, drops the database specified by `APPLICATION_DATABASE_NAME` if it is specified, and detaches and deletes the volumes attached to the server. This operation will be skipped if the server is entering the stop state or rebooting.

## Volume Management

The Database Manager for MySQL 5 ServerTemplate contains recipes to manage cloud volumes. These volumes are used by the database for its data storage location. The cloud's snapshot feature is used to do backups and restores. However, if the cloud does not support volumes, backups will not be possible.

The `MySQL Server Volume - chef` script creates a single volume of the size provided by the ‘Device Volume Size’ input, attaches, and formats the volume. The rs-mysql::stripe script creates multiple volumes, attaches them, uses them to create a logical volume, and formats.
The size of the volumes created and attached when using rs-mysql::stripe is determined by the ‘Device Volume Size’ and ‘Device Count’ inputs using this formula: `(total_size.to_f / device_count.to_f).ceil`

## Backup and Restore

Backups are performed using the rs-mysql::backup script.  It signals the cloud to create a snapshot of all volumes attached to the server (with the exception of root disks if applicable) with the lineage specified in the 'Backup Lineage' input. During the backup process, the MySQL database will be read-only and the filesystem will be frozen. Due to the freezing of the database and filesystem, it is recommended that backups are done on 'slave' databases. Once the backup process is complete, regardless of returning a success or failure, the filesystem and database will be unfrozen. The completion of the backup process is is determined by cloud.
Restoring a database, which means restoring volumes, is done using `MySQL Server Volume - chef` or `MySQL Server Stripe - chef` with the `RESTORE_LINEAGE` input set. The optional ‘Restore Timestamp’ input can also be set if there is a specific timestamp that needs to be restored.

## Continuous Backup

The **MySQL Server Schedule - chef** script is used to configure continuous backups at specified times.  Please review the script details above.

## MySQL Tuning Parameters

The most common customization of a MySQL database server is tuning the MySQL parameters to be more optimized for your own database. The Database Manager for MySQL 5.1/5.5 ServerTemplate performs automatic tuning based on available system memory and the server usage type. As you become more familiar with the performance characteristics of your database, you may want to modify some of these parameters accordingly.

**Default MySQL turning parameters:**

[https://github.com/rightscale-cookbooks/rs-mysql/blob/master/libraries/tuning.rb](https://github.com/rightscale-cookbooks/rs-mysql/blob/master/libraries/tuning.rb)

To learn how to override the default settings see [Customize a Chef-Based ServerTemplate](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/04-Developer/ServerTemplate_Development/02-Customize_a_Chef-based_ServerTemplate/index.html).

## Further Reading

* [Database Manager for MySQL 5.1/5.5 - Tutorial](/st/rl10/mysql/tutorial.html)
