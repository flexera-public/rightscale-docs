---
title: AWS Quick Start
layout: aws_layout_page
description: This page outlines quick start instructions for managing basic Amazon Web Services (AWS) assets in the RightScale Cloud Management Dashboard.
---

## Objective

To provide you with quick start instructions for managing basic Amazon Web Services (AWS) assets in the RightScale Cloud Management Dashboard.

* **Add AWS** - Register AWS with the RightScale Dashboard
* **Import** - Import a base ServerTemplate from the MultiCloud Marketplace
* **Launch** - Launch a Server

## Add AWS

First you will need to register your AWS cloud account with RightScale so that you can use the RightScale Cloud Management Dashboard to manage your AWS cloud resources.

**Note**: If you have never signed up for an AWS account, you will need to carry out that one-time pre-requisite step. To do so, please visit [https://aws.amazon.com/](https://aws.amazon.com/).

**Prerequisite**:  In order to register an AWS cloud account with RightScale, you must be an 'admin' user of the RightScale account.

### Add AWS Account Credentials

Use the following steps to add access to the AWS public cloud so that you can launch instances in EC2.

1. Navigate to **Settings > Account Settings > Clouds**. Click **Connect to a Cloud**. Then click Amazon Web Services and click the (+) icon next to Add AWS Cloud.
2. Next, you will need to provide the following AWS Credentials. You can find your credentials when you are logged into your AWS account. 

**Note** If you are using IAM, be sure to use the security credentials associated with the 'RightScale' user. [Connect to RightScale using IAM](/faq/How_do_I_use_Amazon_IAM_with_RightScale.html)
  * AWS Account Number
  * AWS Access Key ID
  * AWS Secret Access Key
3. Enter the information and click **Continue**.
4. Next, RightScale will query AWS for all of the cloud resources that currently exist for your AWS Account Number (if available). You will then be prompted to create a couple AWS resources that are prerequisites in order to launch an EC2 instance (EC2 SSH Key and EC2 Security Group). It is recommended that you keep the default names for these cloud resources and click **Continue** to create each cloud resource.
5. After the default resources have been created you should have valid AWS cloud credentials associated with your RightScale account.

### (Optional) Add x.509 Certificates

If you plan to bundle instances to create Amazon Machine Images (AMIs) using the RightScale Cloud Management Dashboard, you will also need to upload your AWS Account's x.509 Key and Certificate using the following steps.

1. Click one of the edit (pencil) icons under the Action column for one of the AWS Regions.
2. Expand the "Show Advanced" section and enter your key and certificate information.

3. Copy and paste your x509 Certificate and Key values. Click **Continue**.

## Import a ServerTemplate

Although many ServerTemplates from the Multi-Cloud Marketplace work in AWS, for this tutorial please use the "LAMP All-In One Trial with MySQL 5.5". That ServerTemplate is the "blueprint" for the Server you will launch in the next and final step. Log into the Dashboard and follow the steps below.

1. Go to **Design > MultiCloud Marketplace > ServerTemplates**
2. Find and select the appropriate ServerTemplate.Browse by categories, perform a keyword search, or use the filter options to find the correct ServerTemplate.
3. Click **Import**.

Once imported, the ServerTemplate and associated RightScripts are considered part of your "local" collection.

## Launch Server

Add and launch the Server that is based on the ServerTemplate you just imported. Click the "Add Server" action button. This will start the Add Server Assistant.

### New Server

1. Select an AWS region from the Cloud drop-down menu (e.g. AWS AP-Singapore... AWS US West)
2. Select " **Default**" from the Deployment drop-down menu (_Tip_: Alternatively, you could of course select an existing Deployment name. Deployments are simply containers to organize your cloud assets. See [Create a New Deployment](/cm/dashboard/manage/deployments/deployments_actions.html#create-a-new-deployment) in the *Dashboard Users Guide* for more information.)
3.  Click " **Continue**"

### Server Details

The Server Details dialog is split into two windows: **Hardware** on the left, and **Networking** on the right. Provide the following information for each:

1. **Hardware** - Leave the default values. (Server Name, MultiCloud Image, Instance Type and Pricing.)
2. **Network**
  - Select a SSH Key. If you have none, click the New button. Provide an SSH Key Name (e.g. LAMP SSH Test)
  - Select the "default" Security Group. All other Network settings you can leave at their default settings.
3. Click the " **Confirm**" action button when ready.

### Confirm

The **Confirm** tab provides a detailed summary of the server you're about to create in the cloud. If you are satisfied with your selections, click **Finish** to create the server.

### Launch

After confirming your server creation, you are automatically placed in the correct deployment, viewing the server you just created.

1. Click the **Launch** action button
2. *Note*: With more complicated server setups you would have the opportunity to set Inputs (server variables). Your server is already configured for you however, so you can simply click the **Launch** action button one last time.
3. The server is launched and you should see a message in the blue banner near the top of the Dashboard similar to:

Launched server LAMP All-In-One Trial

**Congratulations!** You just launched your first server in AWS using the RightScale Dashboard... in 3 easy steps! In approximately 5-10 minutes your server state should progress from "pending" to "operational". Don't forget to terminate your server when finished using it to avoid any unneccessary charges.
