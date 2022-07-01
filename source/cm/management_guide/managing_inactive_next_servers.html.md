---
title: Managing Inactive (Next) Servers
layout: cm_layout
description: An "inactive" RightScale Server is one that is not currently launched. Perhaps it has never been launched or the previous incarnation was terminated or stopped. Learn about supported modifications and actions you can perform on inactive Servers in the RightScale Cloud Management Dashboard.
---
## Overview

An "inactive" server is a definition of a server that has not been launched. Perhaps the server has never been launched or the previous incarnation of that server was terminated or stopped. Current (active) servers also have the notion of an inactive server, which can be accessed in the history timeline bar under the "Next" server option.

If a server has not been launched you can change all of its configurations because a corresponding virtual instance does not exist. However, if a server is operational and has a virtual instance that's running in the cloud, you are fairly limited in what you can change because a virtual instance has already been launched and configured. See [Managing Active (Current) Servers](/cm/management_guide/managing_active_current_servers.html).

The majority of a server's configuration settings can be edited under its Info tab. Remember, most of a server's configuration settings are inherited from either its ServerTemplate or Deployment. However, you do have the flexibility to overwrite any of the settings listed below at the server level. Although the ability to modify a server's configuration at the server level is allowed to give you more design flexibility it should only be used under unique circumstances. If you are following best practices, a server's configuration should always inherit its settings from either the ServerTemplate or Deployment in order to promote consistency and repeatability. You should only update a server's configuration at the server level for development and testing purposes.

## Supported Modifications

You can perform any of these modifications/actions on an inactive server. A server's configuration can be modified under its Info tab. Click Edit. See details below.

* Change the ServerTemplate and/or Revision
* MultiCloud Image
* VPC Subnet\* (if applicable)
* SSH Key
* Security Groups
* Instance Type (e.g. small, large, etc.)
* Images - Cloud Machine (e.g. AMI, RightImage<sup>TM </sup>), Kernel, Ramdisk
* Availability Zone\*
* Assign/Switch Elastic IPs\*
* EC2 User Data\*
* Pricing Type\* (On-demand, Spot)
* Your Max Bid Price\* (Spot Instances only)
* Define Input Parameters
* Add Scripts (RightScripts or Chef Recipes)
* Attach snapshot
* Attach volume
* Attach blank volume

\* EC2 only

## Supported Actions

* Move a Server
* Clone a Server
* Launch a Server
* Modify and Copy Inputs

## See also

* [Managing Active (Current) Servers](/cm/management_guide/managing_active_current_servers.html)
* [Server History Timeline](/cm/management_guide/server_history_timeline.html)
