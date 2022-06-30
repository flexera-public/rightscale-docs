---
title: RightLink 10 Windows Base
alias: st/rl10/base_windows/overview.html
description: The RightLink 10 Base ServerTemplate for Windows contains the minimum set of scripts and alerts for optimized server management through the RightScale platform.
---

## Overview

The Base ServerTemplate for Windows contains the minimum set of scripts and alerts for optimized server management through the RightScale platform such as:

* Scripts for setting up monitoring and generation of real-time graphs in the Dashboard
* Creation of alert specifications for automation
* Best practices alerts that are pre-configured under the Alerts tab

It is strongly recommended that you begin custom ServerTemplate development by cloning the Base ServerTemplate and then modify it to meet your needs.

For details about RightLink 10, please visit the [RightLink 10 documentation section](/rl10).

## Minimum Scripts for Best Practices

Since the Base ServerTemplate contains the minimum set of scripts that are required for optimal server management within the RightScale management platform, it is recommended that these scripts are not deleted from a ServerTemplate unless you are an advanced user and are aware of the ramifications.

The minimum set of scripts in the Base ServerTemplate are found in most ServerTemplates published by RightScale and perform the following setup operations:

### Boot Sequence
* **[RL10 Windows Wait for EIP](http://www.rightscale.com/library/right_scripts/RL10-Windows-Wait-For-EIP/lineage/55959)** -  On AWS, if an elastic IP address is specified this script will wait until all API Hosts are reporting the expected IP address for the server, which is recorded in the user-data.
* **[RL10 Windows Setup Automatic Upgrade](http://www.rightscale.com/library/right_scripts/RL10-Windows-Setup-Automatic-U/lineage/55962)** - Creates a scheduled job that performs a daily check to see if an upgrade to RightLink is available and upgrades if there is.
* **[RL10 Windows Enable Monitoring](http://www.rightscale.com/library/right_scripts/RL10-Windows-Enable-Monitoring/lineage/55963)** - Enable built-in RightLink system monitoring. This works with RightScale TSS (Time Series Storage), a backend system for aggregating and displaying monitoring data.
### Operational scripts
* **[RL10 Windows Upgrade](http://www.rightscale.com/library/right_scripts/RL10-Windows-Upgrade/lineage/55960)** - Check whether a RightLink upgrade is available and perform the upgrade.
* **[RL10 Windows Setup Automatic Upgrade](http://www.rightscale.com/library/right_scripts/RL10-Windows-Setup-Automatic-U/lineage/55962)** - Creates a scheduled job that performs a daily check to see if an upgrade to RightLink is available and upgrades if there is.
### Decommission Sequence
* **[RL10 Windows Shutdown Reason](http://www.rightscale.com/library/right_scripts/RL10-Windows-Shutdown-Reason/lineage/55961)** -  Print out the reason for shutdown. We pull the reason RightScale thinks the instance is going down and put it in rs_decom_reason. Note that this variable will only be populated if we issue a stop/terminate/reboot from either the RightScale dashboard or the API. It will be empty if we shutdown or rebooted at the command line, or if a shutdown/reboot was issued on the cloud provider's console. Note we can't tell if a terminate was issued on a cloud provider's console, as we just know the system is going down. rs_decom_reason possible values are:

  * stop = instance is being stopped/shutdown but disk persists
  * terminate = instance is being destroyed/deleted
  * reboot = instance is being rebooted


!!warning*Important* As a general best practice, any new scripts that you add to the ServerTemplate should be added to the bottom of the existing boot script list.
