---
title: Self-Service User Types
description: Overview of the various Self-Service user types and the role mappings to RightScale Cloud Management.
---

## Overview

Self-Service has 4 primary user types that impact what parts of the UI and API are available to a given user. The general descriptions of each user type are:

* **SS Observer** - Users with role `ss_observer` can view the Catalog and running CloudApps, but can not take any action on them (such as launch or terminate).
* **SS End User** - Users with role `ss_end_user` are the primary consumers of Self-Service, they can view the Catalog and CloudApps and can launch and manage CloudApps.
* **SS Designer** - Users with role `ss_designer` can access the Design menu to upload and publish CATs, manage Schedules, and interact with the Cloud Workflow Console.
* **Admin** - Users with role `admin` or `enterprise_manager`can access the Admin menu to configure the Self-Service portal for the account.

Learn more about [RightScale User Roles](/cm/ref/user_roles.html), including how to grant and revoke them from users and/or groups.

## Inviting Self Service Users

### Method 1: Using the Cloud Management Invite flow

* **Step 1:** Login as an Admin or Enterprise Manager and go to **Settings > Account Settings** (or Enterprise Settings). 

* **Step 2:** Under the **Invitations** tab, click the **Invite Users** button and choose the appropriate Self-Service roles. Hit **Send Invitations** when done.

	![selfservice_invite_flow.png](/img/selfservice_invite_flow.png)

Learn more about the detailed [invitation process](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html).

### Method 2: Using the API

* **Step 1:** Use the [API 1.5 Users.create](http://reference.rightscale.com/api1.5/resources/ResourceUsers.html#create) call and set their password as needed.

* **Step 2:** Use [API 1.5 Permissions](http://reference.rightscale.com/api1.5/resources/ResourcePermissions.html) to grant the user appropriate Self-Service roles (`ss_end_user`, `ss_designer`, `ss_observer`).