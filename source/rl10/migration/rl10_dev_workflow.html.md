---
title: Development Workflow for ServerTemplates and RightScripts
alias: [rl/migration/rl10_dev_workflow.html, rl10/migration/rl10_dev_workflow.html]
description: Recommended workflow in developing and maintaining ServerTemplates and RightScripts with RightLink 10.
---

This document entails the recommended workflow in developing and maintaining ServerTemplates and RightScripts. The tool to use is [`right_st`](https://github.com/rightscale/right_st).

## Overview

[`right_st`](https://github.com/rightscale/right_st) allows the ability to maintain ServerTemplates and RightScripts using a version control system of your choice and push updates to the RightScale platform. The README file provides instructions on how to [install](https://github.com/rightscale/right_st/blob/master/README.md#installation) and [configure](https://github.com/rightscale/right_st/blob/master/README.md#configuration) it.

## Initial Download of ServerTemplate

The following command will access the HEAD revision of the "Prod Application Server" ServerTemplate and do the following in your current working directory:
* create a YAML representation of the ServerTemplate (in this case Prod_Application_Server.yml)
* download the RightScripts as files
* create an 'attachments' directory where it will place all files that are attached to RightScripts

```bash
right_st st download "Prod Application Server"
```

An example of the files created from this command would be:

```bash
Prod_Application_Server.yml
PHP_DB_connection_configure.sh
WEB_Application_code_checkout.sh
LB_Apache_reverse_proxy_configure.sh
LB_Application_to_HAProxy_disconnect.sh
LB_Application_to_HAProxy_connect.sh
WEB_Apache_base_install.sh
WEB_PHP_install.sh
WEB_Apache_http-only_vhost.sh
WEB_Apache_re_start.sh
SYS_Timezone_set.sh
SYS_Monitoring_install.sh
SYS_Monitoring_Apache_add.sh
attachments/collectd-5.6.1.tar.bz2
```

An example of the ServerTemplate YAML file:

```yaml
Name: Prod Application_Server
Description: Application server
Inputs:
  APACHE_MPM: text:prefork
RightScripts:
  Boot:
  - SYS_Timezone_set.sh
  - SYS_Monitoring_install.sh
  - WEB_Apache_base_install.sh
  - WEB_PHP_install.sh
  - LB_Apache_reverse_proxy_configure.sh
  - WEB_Apache_http-only_vhost.sh
  - WEB_Application_code_checkout.sh
  - PHP_DB_connection_configure.sh
  - WEB_Apache_re_start.sh
  - SYS_Monitoring_Apache_add.sh
  - LB_Application_to_HAProxy_connect.sh
  Decommission:
  - LB_Application_to_HAProxy_disconnect.sh
  Operational:
  - LB_Application_to_HAProxy_connect.sh
  - LB_Application_to_HAProxy_disconnect.sh
  - WEB_Apache_re_start.sh
MultiCloudImages:
- Name: Ubuntu_14.04_x64
Alerts:
- Name: rs instance terminated
  Description: Raise an alert if the instance has been terminated abnormally, i.e.
    not through the RightScale interface or by an elasticity daemon resizing server
    arrays.
  Clause: If RS/server.state == terminated for 1 minutes Then escalate critical
- Name: rs instance stranded
  Description: Raise an alert if the instance enters the stranded state.
  Clause: If RS/server-failure.state == stranded for 1 minutes Then escalate warning
- Name: rs instance not responding
  Description: Raise an alert if the instance fails to send monitoring information
    for 5 minutes.
  Clause: If cpu-0/cpu-idle.value == NaN for 5 minutes Then escalate critical
- Name: rs cpu busy
  Description: Raise an alert if the idle time is too low.
  Clause: If cpu-0/cpu-idle.value < 15 for 3 minutes Then escalate warning
- Name: rs cpu overloaded
  Description: Raise an alert when the cpu idle time is too low.
  Clause: If cpu-0/cpu-idle.value < 3 for 5 minutes Then escalate critical
- Name: rs cpu I/O wait
  Description: Raise an alert if disk io is too high.
  Clause: If cpu-0/cpu-wait.value > 40 for 15 minutes Then escalate warning
- Name: rs memory low
  Description: Raise an alert if free memory is too low.
  Clause: If memory/memory-free.value < 1000000 for 1 minutes Then escalate critical
- Name: rs out of memory
  Description: Raise an alert when the server is out of free memory.
  Clause: If memory/memory-free.value == 0 for 1 minutes Then escalate critical
```

In addition to downloading the RightScripts, it will automatically add [RightScript YAML metadata comments](/cm/dashboard/design/rightscripts/rightscripts_metadata_comments.html) to each one if it does not already exist.

This set of files is the representation of a ServerTemplate and is what should be used with your version control workflow.

## Testing and Making Changes

As changes are made to the RightScripts and ServerTemplate YAML file, and committed using your version control workflow, testing will need to be done with the RightScale dashboard. [`right_st`](https://github.com/rightscale/right_st) has an upload action that accepts a flag to add a prefix string to the ServerTemplate and each RightScript for development testing:
```bash
right_st st upload --prefix="DEV-TESTING" Prod_Application_Server.yml
```
After the command has completed, there will be a ServerTemplate in your account called "Dev-Testing_Prod Application Server"

As more changes are made during testing, the same command can be used to push the changes to the ServerTemplate.

Once testing is completed with the "Dev-Testing_Prod Application Server" ServerTemplate, the following command should be executed to delete it from RightScale:
```bash
right_st st delete --prefix="DEV-TESTING" Prod_Application_Server.yml
```

## Final Update to ServerTemplate

After testing and development has completed, the following command will update the HEAD revision of the 'Prod Application Server' ServerTemplate:
```bash
right_st st upload Prod_Application_Server.yml
```
Once uploaded to RightScale, the dashboard should be used to commit the ServerTemplate, creating a new revision.
