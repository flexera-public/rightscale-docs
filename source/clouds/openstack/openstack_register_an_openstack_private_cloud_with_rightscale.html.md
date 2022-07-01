---
title: Register an OpenStack Private Cloud with RightScale
layout: openstack_layout_page
description: This page outlines the steps for registering an OpenStack Private Cloud with the RightScale Cloud Management Platform.
---

## Objective

Register your OpenStack cloud with RightScale to manage your cloud resources.

## Prerequisites

* A completed OpenStack installation.
* Registration requires a RightScale user with 'Admin Role' privileges to the RightScale account.
* A set of OpenStack user credentials.
* Update the **keystone.conf** file with the cloud's public endpoint. *Note*: You will use the same URL later in this procedure as the "Registration URL" when you register the cloud with RightScale.

~~~
..
# The base endpoint URLs for keystone that are advertised to clients
# (NOTE: this does NOT affect how keystone listens for connections)
public_endpoint = <<http://198.101.133.81:5000/v2.0/tokens>>
# admin_endpoint = http://localhost:%(admin_port)s/
~~~

## Steps

### Register Cloud

Once you have installed and set up your OpenStack cloud, you need to register the cloud itself with RightScale so that it can be accessed through the RightScale platform.

* Go to **Settings** > **Account Settings** > **Administered Clouds** tab.

**NOTE:** If you do not see this tab, your RightScale account is not enabled for adding a private cloud. If you would like to enable this feature, contact your account manager or [sales@rightscale.com](mailto:sales@rightscale.com).

![openstack-clouds-adminclouds.png](/img/openstack-clouds-adminclouds.png)

* Under "Register Your Private Cloud," select **OpenStack** from the dropdown menu.
* Click **Register Cloud**

### Enter Credentials

Next, provide your OpenStack credentials as listed below.

![openstack-clouds-regcloud.png](/img/openstack-clouds-regcloud.png)

* **OpenStack Releases** - Select Juno, Kilo, or Liberty from the drop down menu depending on your version of OpenStack.
* **Name** - Provide a name for your private cloud. Since the name of the cloud will appear in the Dashboard under the Clouds menu, it's recommended that you use a short name.
* **Description** - Provide a brief description about your private cloud. You might want to include a reference link or contact information.
* **Registration URL** - This is the URL to reach your keystone catalog from the public internet or your wstunnel client (e.g. http://198.101.133.81:5000/v2.0/tokens). Retrieve this value when logged in as admin by navigating to **Access & Security** > **Identity**.
* **Username** - The user name used to access the Horizon dashboard. For Liberty and beyond, if your user is not part of the default domain, username should be of the form `domain_id\username`
* **Password** - The password used to access the Horizon dashboard.
* **Region** - Region name setup during OpenStack cloud installation. If you are unsure about the name, use "keystone catalog" command from the shell prompt on your cloud controller node to determine the region name.
* **Tenant ID** - Find the tenant ID by logging into the Horizon dashboard. Retrieve this value by navigating to **Access & Security** > **Identity** > **Dowload OpenStack RC File**. Open the downloaded RC File and find the value under OS_TENANT_ID.
* **Use Private Tunnel** - Enable this option if you are using a wstunnel or a VPN tunnel for connectivity between the RightScale platform and your OpenStack cloud.
* **Tunnel Token** - If you are using wstunnel, enter the wstunnel token configured on the wstunnel client. If you are a VPN-only user, please contact RightScale to obtain a token.

Click **Request Registration** to submit your private cloud information for verification purposes. Upon successful registration, you will see the following message: "Cloud Registration succeeded. Cloud is now registered within RightScale."

## Next Steps

Since you registered your private cloud with RightScale, you will see the private cloud's Cloud Token, which you can provide to other users so that they can add your private cloud to their RightScale account and use your cloud's resources. See [Add an OpenStack Cloud to a RightScale Account](openstack_add_an_openstack_private_cloud_to_a_rightscale_account.html).
