---
title: Grant a RightScale Account Access to your vSphere Cloud
alias: rcav/guides/rcav_grant_account.html
description: Procedure for granting a RightScale Account access to your vSphere Cloud.
---

## Objective

To grant another RightScale account access to your registered vSphere cloud so that users within that other RightScale account will be able to launch and manage instances (VMs) in your vSphere environment.

## Prerequisites

* Registered vSphere (cloud) environment. See [Register a vSphere Cloud with RightScale](rcav_register_vsphere_cloud.html).
* Log in access to the RightScale Cloud Appliance for vSphere (RCA-V) interface.

## Steps

1. Log in to the RCA-V interface that is connected to the vSphere environment to which you're going to grant access. Enter the RCA-V's IP address of the instance in a browser window. Use the IP address from the previous step. (e.g. 10.100.100.90)
  * **Username**: rightscale
  * **Password**: vscale2013@@ (default)
  **Note**: The person who initially set up the RCA-V should have changed the default password. Please contact that person directly if you need to retrieve the password.

        ![RCA-V RCA Login](/img/rcav-RCA-login.png)

2. Go to **Cloud Configuration > Tenants**.
3. Click **Add Tenant**.

        ![RCA-V Tenant](/img/rcav-tenant.png)
    * **Tenant Name** - Provide a name for the tenant and click Continue. (e.g. Development)
    * ![RAC-V Save Icon](/img/rcav-icon-save.png) Save the Tenant Name.
    * **Tenant Password** - Create a password for the tenant.
    * **Add Zone** - Select and add one or more zones to associate with the tenant. Remember, you can create multiple tenants which leverage resources in the same zones (i.e. datacenter:cluster combination). Since multiple RightScale accounts have access to essentially the same pool of VMs, you may want users to see other active VMs that were launched from outside of their account. Use the "See Unowned VMs" checkbox to specify whether or not users will also see other VMs.

4. Click **Save**.
5. In order to grant another RightScale account access to your vSphere cloud environment, you must give the following information to a user (within that RightScale account) that has 'admin' user permissions. (Note: Only 'admin' users can add cloud credentials to a RightScale account.)
  * **Cloud Token** - In the RightScale Cloud Management Dashboard go to **Settings > Account Settings > Administered Clouds**.

        ![RCA-V vShere Cloud Token](/img/rcav-vsphere-cloud-token.png)
  * **Tenant Name and Tenant Password** - Provide the login information for the user profile that the RightScale platform uses to make authenticated API requests to the vSphere cloud environment. Typically, this user does not have 'admin' access in the vSphere cloud. Use the same user that was used to configure the RCA-V in the [Tenants](rcav_download_deploy_configure.html#tenants) step of the [Download, Deploy, and Configure the RightScale Cloud Appliance for vSphere (RCA-V)](rcav_download_deploy_configure.html) document. A tenant may only be associated with a single RightScale account.
