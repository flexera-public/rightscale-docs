---
title: About Security Groups
description: Security Groups are essentially firewalls for instances in the Cloud. It defines which ports are opened in the cloud infrastructure's firewall to allow incoming connections to your instance.
---

## Overview

**Security Groups** are essentially firewalls for instances in the Cloud. It defines which ports are opened in the cloud infrastructure's firewall to allow incoming connections to your instance. (All Security Group rules are ingress.) When you launch an instance in the cloud, you must assign a Security Group (or Security Groups) to it.

**Fields**

* **Name** - Name of the Security Group. The name will be used in various drop down menus when selecting the Security Group. For example, when launching a new instance.
* **Created by** - RightScale user that created the Security Group. For example, [john.doe@example.com](mailto:john.doe@example.com) or "- unknown -" if the user could not be determined.
* **Resource UID** - Resource Unique IDentifier for the Security Group. Each resource (or entity) in the Dashboard has a unique ID tied to it. Whether the ID is numeric or alphanumeric varies depending on the cloud infrastructure. The Resource UID is generated and persistent in the Cloud. The value is initially retrieved from the Cloud, set in the database, and retrieved/displayed in many areas of the Dashboard (tied to the specific cloud resource).

**Actions**

!!info*Note:* Only accounts with the 'security_manager' user role are permitted to create new Security Groups, or delete existing ones.

* **New** - Create a new Security Group.
* **Delete** - Delete an existing Security Group.

!!warning*Important!* If you are on a UCP account, you will need to create security groups within the Network Manager. For more information, see [Networks](/cm/dashboard/manage/networks/networks.html).

## Actions

See [Security Groups - Actions](/cm/dashboard/clouds/generic/security_groups_actions.html) for step-by-step instructions on common security group operations.
