---
title: Discovery and Inventory of Cloud Resources In RightScale
description: The RightScale Cloud Management Platform easily handles the discovery and inventory of existing resources in public or private clouds.
---

## Overview

RightScale easily handles the discovery and inventory of existing resources in public or private clouds.

This document summarizes how to:

1. Connect to clouds
2. Review your existing cloud resources
3. Enable additional management functions

## Connect to Clouds

It is easy to connect to public and private clouds or vSphere environments:

* [Add a public cloud to a RightScale account](/cm/dashboard/settings/account/add_a_cloud_account_to_a_rightscale_account.html).
* [Register a private cloud](/cm/dashboard/settings/account/register_a_private_cloud_with_rightscale.html)
* [Use RightScale Cloud Appliance for vSphere to connect and manage your vSphere environments](/rcav/v3.0/rcav_download_deploy_configure.html)

## Review Your Existing Cloud Resources

To see your existing cloud resources in Cloud Management, navigate to **Manage** > **Instances and Servers**. Here you can see all of your existing cloud resources, including those that were just discovered and those that have been launched through RightScale.

You can customize the display in a number of ways:

* Use the **Filter Within The Table** field to find instances on particular cloud providers or in particular regions or datacenters.
* Sort columns by ascending or descending order. Columns are customizable by the **Show/Hide Column** button.  

![cm-instances-servers-filter.png](/img/cm-instances-servers-filter.png)

[Learn more about the Instances and Servers page](/cm/dashboard/manage/instances_and_servers/instances_and_servers.html).

## Enable Additional Management Functions

Once you have connected clouds and discovered running instances, you can organize your resources and also perform basic management tasks.  For example, once an instance has been discovered, you can click on the actions bar to do things including:

* Add tag(s)
* Remove tag(s)
* Add to a Deployment
* Reboot
* Terminate

You can also access Audit Trails for each instance.

![cm-audit-trails.png](/img/cm-audit-trails.png)

To perform additional management such as monitoring, alerting, running operations scripts, managed SSH you will need to install the lightweight RightLink agent.

**RightScale RightLink™** helps you manage workloads already running in the cloud without relaunching, re-architecting or disrupting running applications.

The RightLink agent runs on each server, connects to the RightScale platform, and facilities two-way communication - the agent can report status or local state changes to the RightScale platform, and the RightScale platform can provide data to the agent as well as send it commands.

To install RightScale RightLink, please review the following [page.](/rl10/getting_started.html)
