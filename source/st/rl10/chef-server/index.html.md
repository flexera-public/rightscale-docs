---
title: Chef Server for Linux (RightLink 10)
alias: st/rl10/chef-server/overview.html
description: The RightLink 10 Chef Server for Linux ServerTemplate Linux contains the minimum set of scripts and alerts for optimized server management through the RightScale platform.
---

## Overview

The Chef Server for Linux ServerTemplate Linux contains the minimum set of scripts and alerts for optimized server management through the RightScale platform such as:

* Install and setup a chef server
* Creation of alert specifications for automation.
* Best practices alerts that are pre-configured under the Alerts tab.

You can customize the Chef Server install by cloning the ServerTemplate and making your modifications.

## Minimum Scripts for Best Practices

Since the Chef Server for Linux ServerTemplate contains the minimum set of script that are required for optimal server management within the RightScale management platform, it’s recommended that these scripts are not deleted from a ServerTemplate unless you are an advanced user and are aware of the ramifications.

The minimum set of scripts in the Chef Server for Linux ServerTemplate are found in most ServerTemplates published by RightScale and perform the following setup operations.

### Boot Sequence
See [RightLink 10 Linux Base ](/st/rl10/base_linux/index.html) for details on the default scripts.
* **RL10 Chef Server** - This script installs a stand-alone Chef Server.

### Operational scripts
* **RL10 Chef Server Backup** - Performs a backup to cloud storage of the chef server cookbooks, database and config.
* **RL10 Chef Server Restore** - Performs a restore of the backup.
* **RL10 Chef Server Schedule** - Schedules the backups.

!!warning*Important* As a general best practice, any new scripts that you add to the ServerTemplate should be added to the bottom of the existing boot script list.

### Chef Server Inputs
| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|CHEF_SERVER_ADDONS| A comma separated list of chef server add-ons | text: manager,reporting |
|CHEF_SERVER_FQDN|The FQDN of the chef server.|text: chef-server.example.com|
|CHEF_SERVER_VERSION|The version of chef server to install|text: 12.0.8|
|CHEF_NOTIFICATON_EMAIL|The email address the chef server will use for notifications and alerts.|text: name@example.com|
|LOG_LEVEL|The log level for the chef server install.|text: info|
|SMTP_RELAYHOST|The SMTP Relay host|text:email.relay.com|
|SMTP_SASL_USER_NAME|The username for the mail relay host|cred: SMTP_SASL_USER_NAME|
|SMTP_SASL_PASSWORD|The password for the mail relay host|cred: SMTP_SASL_PASSWORD|
|BACKUP_LINEAGE|The name of the backup|text: chef-server|
|STORAGE_ACCOUNT_ENDPOINT|The cloud storage endpoint|text: https://some.end.point.com/path/|
|STORAGE_ACCOUNT_ID|The Cloud provider Username or key|ccred:AWS_ACCESS_KEY_ID|
|STORAGE_ACCOUNT_PROVIDER|The cloud provider|text:aws|
|STORAGE_ACCOUNT_SECRET|The Cloud provider password or secret|cred:AWS_SECRET_ACCESS_KEY|
|SCHEDULE_ENABLE|Enable or disable the schedule backup|text: true|
|SCHEDULE_HOUR|The backup schedule hour based on the crontab hr|text: 6|
|SCHEDULE_MINUTE|The backup schedule minute base on the crontab min. |text: 30|
