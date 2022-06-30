---
title: Azure Quick Start
layout: azure_layout_page
description: This page provides you with quick start instructions for managing basic Microsoft Azure assets in the RightScale Cloud Management Dashboard.
---

## Objective

To provide you with quick start instructions for managing basic Microsoft Azure assets in the RightScale Dashboard.

* **Add** - Register Azure with the RightScale Dashboard
* **Import** - Import a base ServerTemplate from the MultiCloud Marketplace
* **Launch** - Launch a Server

## Add Azure

First you will need to register your Microsoft Azure cloud account with RightScale so that you can use the RightScale Dashboard to manage your Azure cloud resources.

**Note**: If you have never signed up for an Azure account, you will need to carry out that one-time pre-requisite step. To do so, please see [Sign up for Microsoft Azure](http://support.rightscale.com/09-Clouds/Microsoft_Azure/Tutorials/Sign_up_for_Microsoft_Azure/index.html) tutorial, then return and carry out the three steps in this tutorial.

**Prerequisite**: In order to add Microsoft Azure, you must be an 'admin' user of the RightScale account.

### Connect to a Cloud

 1. After logging into the Dashboard, go to **Settings** > **Account Settings** > **Clouds**. Click **Connect to a Cloud.**
 2. Next, click the (+) icon next to Microsoft Azure.

**NOTE**: Azure is a cloud with several regions which you can view by clicking the arrow next to its name in the "Connect to Public Clouds" box. For every region, you must register individually using the same Azure credentials. Only 5 regions can be added to a RightScale account. RightScale requires a virtual network for each region. By default Microsoft Azure subscriptions have a maximum of 5 virtual networks they can create. This means that only up to 5 regions can be added to RightScale by default. Please contact Microsoft to request more virtual networks in your subscription if needed.

### Upload Publish Profile

**NOTE** : Make sure you are signed up for [‘Virtual Machines & Virtual Networks’](http://support.rightscale.com/09-Clouds/Microsoft_Azure/Tutorials/Sign_up_for_Microsoft_Azure/index.html).

Next, upload your publish profile file.;

### Select a Subscription ID

Select a Subscription ID from the drop-down list. This lists all your Subscription IDs found at [https://account.windowsazure.com/Subscriptions](https://account.windowsazure.com/Subscriptions) when logged in. Click on the ‘Subscriptions’ link at the top of your Microsoft Azure portal.

**NOTE**: Azure does not currently support specifying the public IP space. They dynamically assign public IPs.

Click **Continue**.

You are going to be registering a Microsoft Azure subscription where you will specify a virtual network and subnet where virtual machines launched via RightScale will be provisioned. If virtual networks already exist within this Microsoft Azure subscription you will be given the option to select a virtual network on the next page. If no virtual networks exist within this Microsoft Azure subscription, RightScale will create one on your behalf. When creating a subnet within that virtual network, we will use the private IP range specified in the Subnet Prefix field on the next page.

### No Existing Virtual Network

**Subnet Prefix:** Specify a Private IP address range in CIDR format for the subnet that will be created on your behalf in Azure.

### Existing Virtual Network

If you have an existing virtual network, you must go back into the Azure portal and make sure there’s a subnet within the virtual network with same name as the virtual network itself.

* Navigate to Preview.
* Choose Networks on the left panel which will take you to Virtual Networks.
* Click on the name of your virtual network.
* Click Configure.

Add a subnet with the same name as the virtual network.

Once you have an existing virtual network and subnet, you will see the following screen:

Select your virtual network and subnet and click **Continue**.

Once your cloud credentials have been verified, you will see that the Microsoft Azure cloud is enabled under the Clouds tab. You will now see all of your Microsoft Azure resources under the Clouds menu (Clouds _>_ Microsoft Azure). You may need to refresh the tab to view your newly added Azure cloud.

### Check the cloud status

On the same Clouds tab or on the Cloud Credentials widget in the Overview tab, you may check the status of your cloud. Both of these items must be valid and active (green) in order to successfully launch cloud servers:

**NOTE** : RightScale could take several hours to discover the instance types before you can launch a server after initially adding a cloud.

## Import ServerTemplate

Import a ServerTemplate. Although many ServerTemplates from the Multi-Cloud Marketplace work in Azure, for this tutorial please use the "Base ServerTemplate for Windows". That ServerTemplate is the "blueprint" for the Server you will launch in the next and final step. Log into the Dashboard and follow the steps below.

1. Go to **Design** > **MultiCloud Marketplace** > **ServerTemplates**
2. Find and select the appropriate ServerTemplate. Browse by categories, perform a keyword search, or use the filter options to find the correct ServerTemplate.
3. Click **Import**.  

Once imported, the ServerTemplate and associated RightScripts are considered part of your "local" collection.

**Note** : If you have problems finding the ServerTemplate, here is an example full URL (below). You can click on that URL and import the ServerTemplate instead of the steps above. [http://www.rightscale.com/library/server\_templates/Base-ServerTemplate-for-Window/lineage/7210](http://www.rightscale.com/library/server_templates/Base-ServerTemplate-for-Window/lineage/7210)

## Launch Server

Add and launch the Server that is based on the ServerTemplate you just imported. Click the "Add Server" action button. This will start the Add Server Assistant.

### New Server

* Select "Azure" from the Cloud drop-down menu
* Select " **Default**" from the Deployment drop-down menu (_Tip_: Alternatively, you could of course select an existing Deployment name. Deployments are simply containers to organize your cloud assets. See [Create a New Deployment](/cm/dashboard/manage/deployments/deployments_actions.html#create-a-new-deployment) in the _Dashboard Users Guide_ for more information.)
* Click " **Continue**"

### Server Details

The Server Details dialog is split into two windows: **Hardware** on the left, and **Networking** on the right. Provide the following information for each:

* **Hardware** - Leave the default values for Server Name, MultiCloud Image and Instance Type.
* Click the " **Confirm**" action button when ready

### Confirm

The **Confirm** tab provides a detailed summary of the server you're about to create in the cloud. If you are satisfied with your selections, click **Finish** to create the server.

### Launch

After confirming your server creation, you are automatically placed in the correct deployment, viewing the server you just created.

* Click the " **Launch**" action button
* _Note_: With more complicated server setups you would have the opportunity to set Inputs (server variables). Your server is already configured for you however, so you can simply click the " **Launch**" action button one last time.
* The server is launched and you should see a message in the blue banner near the top of the Dashboard similar to:

Launched server Base ServerTemplate for Windows

Congratulations! You just launched your first server in Microsoft Azure using the RightScale Dashboard... in 3 easy steps! In approximately 15 minutes your server state should progress from "pending" to "operational". Don't forget to terminate your server when finished using it to avoid any unnecessary charges.
