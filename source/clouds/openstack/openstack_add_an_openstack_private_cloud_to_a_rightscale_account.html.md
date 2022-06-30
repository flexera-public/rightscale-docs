---
title: Add an OpenStack Private Cloud to a RightScale Account
layout: openstack_layout_page
description: This page outlines the steps for adding your OpenStack cloud to RightScale so that you can use the RightScale Cloud Management Dashboard to manage your cloud resources.
---

## Objective

Add your OpenStack cloud with RightScale so that you can use the Cloud Management (CM) Dashboard to manage your cloud resources.

## Prerequisites

* (Recommended) A set of non-admin cloud credentials (username, password, tenantID)
* The OpenStack cloud you wish to add must already be [registered](openstack_register_an_openstack_private_cloud_with_rightscale.html) with a RightScale account.
* A Rightscale account with Admin Role priviledges
* [Cloud Token](openstack_register_an_openstack_private_cloud_with_rightscale.html) received from the cloud administrator.
* This tutorial uses the Horizon dashboard.

## Steps

### Connect to Cloud

1. After logging into the CM Dashboard, go to **Settings > Account Settings > Clouds**. Click **Connect to a Cloud**.
2. Next, click **Connect to a Private Cloud**.

### Enter Cloud Token

Next, you will have to enter your [Cloud Token](openstack_register_an_openstack_private_cloud_with_rightscale.html).

### Enter Credentials

Next, enter values for the following fields:

* **Username** : The OpenStack username used to log in to the Horizon dashboard (recommended to be the username for a non-Admin OpenStack user).
* **Password:** The related password.
* **Tenant ID** : find the tenant ID by logging into the Horizon dashboard. Retrieve this value when logged in as admin by navigating to **Access & Security > Identity > Download OpenStack RC File**. Open the downloaded RC File and find the value under `OS_TENANT_ID`.

### Check the cloud status

On the same Clouds tab or on the Cloud Credentials widget in the Overview tab, you may check the status of your cloud.

* **Cloud Controller** - Displays the status of your cloud.
* **Cloud Account** - Displays the status of your cloud credentials.

Both of these items must be valid and active (green) in order to successfully launch cloud server.

## Next Steps

Allow RightScale several minutes to populate your account with the appropriate images before launching servers. In the RightScale Dashboard, navigate to **Clouds > OpenStack > Images** where RightScale queries every few minutes for the images.

To upload RightScale RightImages to your OpenStack cloud, see [Upload RightImages to a Private Cloud](openstack_upload_rightimages_to_an_openstack_private_cloud.html).
