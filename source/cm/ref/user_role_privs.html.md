---
title: User Role Privileges
layout: cm_layout
description: Below is a breakdown of RightScale user privileges based on user roles. 
---

## Overview

Below is a breakdown of user privileges based on user roles. The ability to "manage" a section includes the ability to create/edit/delete the object/resource. To check and see which user role privileges you have across all RightScale accounts to which you have access, go to **Settings** > **User** > **Info**. To learn more about our Role Based Access control (RBAC), see [User Roles](/cm/ref/user_roles.html).

## Managing RightScale Accounts

| Action | Required User Roles |
| ------ | ------------------- |
| View RightScale Account | observer |
| Edit User Preferences - SSH, Timezone, Password (1) | observer |
| View estimated cloud billing information (5) | ca_user |
| Send RightScale Account Invitations | admin |
| Manage User Roles | admin |
| Manage Cloud Credentials | admin |
| Register a Private Cloud | admin |
| Add a Public/Private Cloud | admin |
| Accept Account Group Invitations | admin |
| Enable/Disable "Instance Available" Email Notifications | admin |
| Customer Usage Reports (2) | admin |
| Enable Cloud Services (e.g. SQS) | admin |
| Log into RightScale API (3) | admin, observer, actor, designer, library, server_login, publisher, enterprise_manager |

## Managing Server Instances

| Action | Required User Roles |
| ------ | ------------------- |
| Manage Deployments | actor |
| Manage Server Arrays | actor |
| Manage Servers | actor |
| Manually run boot, operational, or decommission scripts | actor |
| Bundle an Instance | actor |
| Tag Servers | actor |
| View Initial Password (Windows) | actor |
| Log into servers (SSH or RDP) | server_login |
| Log into servers as 'root' user (Linux only) | server_supervisor |

## Managing the Cloud (e.g. AWS, Azure, Google, OpenStack, etc.)

| Action | Required User Roles |
| ------ | ------------------- |
| Launch and terminate instances | actor |
| Queues (SQS) | actor |
| S3 | actor |
| Cloudfront | actor |
| Personal Images | actor |
| EC2 Security Groups | security_manager |
| Create/Use EC2 SSH Keys | actor |
| View Private Key Material of SSH Keys (4) | admin |
| Elastic/Remappable IPs | actor |
| Volumes | actor |
| Snapshots | actor |
| Elastic Load Balancing (AWS) | actor |
| Purchase Reserved Instances (AWS) | admin |
| RDS (AWS) | actor |
| VPC (AWS) | actor |
| Share Cloud Resources | actor |
| View Cloud Billing Information (5) | ca_user |
| Infrastructure Audit Reports | admin, security_manager |

## Managing RightScale Components

| Action | Required User Roles |
| ------ | ------------------- |
| View Library | designer |
| Import from the Library | library |
| View Account Library | designer |
| ServerTemplates | designer |
| RightScripts | designer |
| MultiCloud Images (MCI) | designer |
| Cookbooks | designer |
| Repositories | designer |
| Manage Software Repositories | designer |
| Create/Edit/Lock/Delete a Macro | designer |
| Run a Macro (6) | actor, designer |
| Clone a Macro | designer |
| Alert (Specifications) | designer |
| Alert Escalations | designer |
| Create/Edit Credentials  | actor |
| View Credential's "hidden" value (7) | admin, credential_viewer |
| Publish to the Library | publisher |
| Manage Your Publications | publisher |
| Share RightScale Components (via Account Groups) | publisher |
| Send Account Group Invitations | publisher |
| Accept Account Group Invitations | admin |

## Managing the Organization

| Action | Required User Roles |
| ------ | ------------------- |
| Access to all accounts within the Organization | enterprise_manager |
| Grant account access | enterprise_manager |
| Control User Roles across the Enterprise | enterprise_manager |
| Grant 'enterprise_manager' privileges to another user | enterprise_manager |
| Manage Account Group memberships within the Enterprise | enterprise_manager |
| Set cost quotas for RightScale accounts | enterprise_manager |
| Download Usage Report for the Enterprise | enterprise_manager |
| Limited access inside the Dashboard | enterprise_manager |

## RightScale Optima

| Action | Required User Roles |
| ------ | ------------------- |
| View and analyze historic cost and usage information (5) | ca_user |
| Read-only access to View Billing Centers within the Org | billing_center_viewer |
| Full access to View/Add/Edit/Delete Billing Centers within the Org | billing_center_admin |
| Create new RightScale child accounts | enterprise_manager |
| Connect to new clouds (e.g. AWS) | admin, enterprise_manager |
| Manage other user permissions | admin |
| Manage account markups and markdowns | admin |
## RightScale Self Service

| Action | Required User Roles |
| ------ | ------------------- |
| View Catalog, Manage CloudApps incl. launch, terminate | ss_end_user |
| View Catalog and running CloudApps (view only; no action) | ss_observer |
| View the Design menu, manage schedules, interact with Cloud workflow console | ss_designer |
| UI Customizations, CloudApps permissions | admin, enterprise_manager |

## RightScale Policy Management

| Page | Action | Required User Roles |
| -------- | -------- | ----------- |
Catalog | View Catalog | `policy_publisher`, `policy_designer`, `policy_manager` |
 | Publish to Catalog | `policy_publisher` |
 | Un-publish from Catalog | `policy_publisher` |
 | Delete policy template | `policy_designer` |
 | Apply a policy |  `policy_designer`, `policy_manager` | 
Dashboard | View dashboard | `policy_designer`, `policy_manager`, `policy_viewer`  | 
Applied Policies | View applied policies | `policy_designer`, `policy_manager`, `policy_viewer` | 
 | Update a policy | `policy_designer`, `policy_manager` | 
 | Terminate a policy | `policy_designer`, `policy_manager` | 
 | Apply a similar policy | `policy_designer`, `policy_manager`  | 
Incidents | View Incidents | `policy_designer`, `policy_manager`, `policy_viewer`
Templates | View Templates | `policy_designer`, `policy_manager` |
 | Upload a custom policy template | `policy_designer` | 
 | Apply a policy template | `policy_designer` | 
 | Delete a custom policy template | `policy_designer` | 
 | Publish a policy template | `policy_publisher` |

## Notes

1. User preferences are defined on a per-user basis and are used across all RightScale accounts.
2. Only RightScale accounts that have been properly enabled to view the ServerTemplates Usage Report will see this item in the Dashboard. (Reports > Usage Estimate)
3. Any user can log in to the RightScale API. However, once you log in, your user role privileges will take effect.
4. Only the owner (identified by email) who created the SSH Key and 'admin' users can view/edit the private key material of an SSH Key.
5. If you run a macro that creates/clones design objects you must have the 'designer' role.
