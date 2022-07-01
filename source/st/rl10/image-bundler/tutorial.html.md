---
title: Image Bundler For RightLink 10 - Tutorial
description: Use this tutorial to create images in your cloud.
---

## Objective

To create private images based on public/official cloud images that will not be removed or deregistered by the cloud provider

## Prerequisites

* You must log in under a RightScale account with "actor" and "library" user roles in order to complete the tutorial.
* You must have an supported cloud registered with RightScale
* We strongly recommend that you set up credentials for password values and any other sensitive data included as inputs.

## Overview

This tutorial describes the steps for launching one Chef server in the cloud, using the [Image Bundler For RightLink 10](http://www.rightscale.com/library/server_templates/Image-Bundler-For-RightLink-10/lineage/58435) ServerTemplate.


## Steps

### Add a Server

Follow these steps to add the image builder to the deployment.

1. Go to the MultiCloud Marketplace (**Design** > **MultiCloud Marketplace** > **ServerTemplates**) and import the most recently published revision of the [Image Bundler For RightLink 10](http://www.rightscale.com/library/server_templates/Image-Bundler-For-RightLink-10/lineage/58435) ServerTemplate into the RightScale account.
2. From the imported ServerTemplate's show page, click the **Add Server** button.
3. Select the cloud for which you will configure a server.
4. Select the deployment into which the new server will be placed.
5. Next, the Add Server Assistant wizard will walk you through the remaining steps that are required to create a server based on the selected cloud.
  * **Server Name** - Provide a nickname for your new server (e.g., ImageBundler - AWS - CentOs).
  * Select the appropriate cloud-specific resources that are required in order to launch a server into the chosen cloud. The required cloud resources may differ depending on the type of cloud infrastructure.
6. Click **Confirm**, review the server's configuration and click **Finish** to create the server.

### Configure Inputs

The next step is to define the properties of the packer build and configuration parameter by entering values for inputs. As a best practice, you should define required inputs for the servers at the deployment level. For a detailed explanation of how inputs are defined and used in RightScripts, see [Inheritance of Inputs](/cm/rs101/inheritance_of_inputs.html).

To enter inputs, open the deployment's **Inputs** tab, click **Edit**, and use the following settings to configure input values. We recommend that you set up credentials for password values and any other sensitive data as shown in the examples.

#### Image Bundler Inputs
The CLOUD Category provides inputs to select which cloud specific parameters.

| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|CLOUD| Select the supported target cloud for your image | text: ec2 |
|DATACENTER|The Datacenter or Availability Zone to create the image in.|text: us-east-1|
|IMAGE_NAME|The name of the image to be created.  Image name must not already exist. |text: my-image|
|INSTANCE_TYPE|The instance type used to create the image.  |text: m3.medium|
|PLATFORM|The Platform of the target image.  Either Linux or Windows|text: linux|
|SOURCE_IMAGE|The source image id of the image being copied.  Leave blank for Azure RM.|text: ami-abc123|

The AWS Category provides inputs specific to images created in AWS.

| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|AWS_ACCESS_KEY|The AWS Access Key Id|cred:AWS_ACCESS_KEY_ID|
|AWS_SECRET_KEY|The AWS Secret Access Key |cred:AWS_SECRET_ACCESS_KEY|
|AWS_SUBNET_ID|The Subnet id used with the VPC. Leave blank for default.||
|AWS_VPC_ID|The VPC ID of the VPC to use  Leave blank for default ||

The Google Compute Category provides inputs specific to images created in GCE.

| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|GOOGLE_ACCOUNT|The Google Service Account json file |cred:GOOGLE_SERVICE_ACCOUNT_FILE|
|GOOGLE_NETWORK|The Network name to use when building the image.  Leave blank for default ||
|GOOGLE_SUBNETWORK|The Subnet name used with the Network being used. Leave blank for default.||

The Azure RM category provides inputs specific to images created on Azure.  Carefully read the [Packer Documentation](https://www.packer.io/) to gather the
credentials needed below.

| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|AZURERM_CLIENT_ID|The Active Directory service principal associated with your builder.|cred:AZURERM_CLIENT_ID |
|AZURERM_CLIENT_SECRET|The password or secret for your service principal.|cred:AZURERM_CLIENT_SECRET|
|AZURERM_IMAGE_OFFER|Offer for your base image.CLI example azure vm image list-offers -l westus -p Canonical|text: UbuntuServer|
|AZURERM_IMAGE_PUBLISHER|PublisherName for your base image. CLI example azure vm image list-publishers -l westus|text:Canonical|
|AZURERM_IMAGE_SKU|SKU for your base image. CLI example azure vm image list-skus -l westus -p Canonical -o UbuntuServer|text:14.04.5|
|AZURERM_RESOURCE_GROUP|Resource group under which the final artifact will be stored.|text:myresourcegroup|
|AZURERM_SPN_OBJECT_ID|Storage account under which the final artifact will be stored.|cred:AZURERM_SPN_OBJECT_ID|
|AZURERM_STORAGE_ACCOUNT| [Storage Accounts](/clouds/azure_resource_manager/reference/resources.html#storage-accounts) under which the final artifact will be stored.|text:mystorageaccount|
|AZURERM_SUBSCRIPTION_ID|Subscription under which the build will be performed. The service principal specified in client_id must have full access to this subscription.|cred:AZURERM_SUBSCRIPTION_ID|
|AZURERM_TENANT_ID|Azure tenant id|cred:AZURERM_TENANT_ID|

The MISC Category provides inputs to install RightLink on the Image.

| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|IMAGE_PASSWORD|The Windows Administrator password when building windows images.  The password must abide to the Windows Password requirements |cred: WINDOWS_ADMIN_PASSWORD|
|SSH_USERNAME|The username packer will use to ssh into the new image to run scripts. This is the username provided by the cloud provider or linux distribution.  For example, on CentOS distro the username is 'centos', and ubuntu it's 'ubuntu' |text: centos|
|CUSTOM_SCRIPT_URL|Public URL to custom script to modify image.  This script will run in the provision section of the packer build, after the image is built.|text: https://s3.awsamazon.com/mybucket/myscript.sh|

The RIGHTLINK Category provides inputs to install RightLink on the Image.

| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|RIGHTLINK_VERSION|The version of RightLink 10 to install on image.  Leave blank to NOT add RightLink to image. Enter 10 to get the latest version or RightLink 10, or provide the explicit version, i.e 10.6.0 |text: 10.6.0|

The RIGHTSCALE Category provides inputs manage boot time RightScripts.

| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|MANAGED_LOGIN|To enable or disable managed login. Default is 'enable'. |text: enable|

### Launch the Server

1. Go to the deployment's **Servers** tab and launch the image builder. When you view the input confirmation page, there should not be any required inputs with missing values. If there are any required inputs that are missing values (highlighted in red) at the input confirmation page, cancel the launch and add values for those inputs at the deployment level before launching the server again. Refer to the instructions in [Launch a Server](/cm/dashboard/manage/deployments/deployments_actions.html#launch-a-server) if you are not familiar with this process.


### Create or Update your MultiCloud Image (MCI).
Now that you have your new Image created you before you can use it you need to create a new or Update an existing (MCI). Refer to the [Create a new MultiCloud Image]( /cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image) document for these details.

## More Details
###Bundling RightLink 10
RightLink 10 on Linux can be installed at [boot time](/rl10/reference/rl10_install_at_boot.html) and doesn't need to be bundled into the image, but it can be if it's desired.  Windows however can not install RightLink during boot and it must be [added to the image](/rl10/reference/rl10_install_windows.html).  You can use the RIGHTLINK_VERSION input to tell packer to include RightLink on the image.

### Networks, Subnets and Security Groups
Packer use the default network, subnet unless specific network and subnets are supplied as Inputs for those clouds.

!!info*Note:* Packer doesn't create the security group or allow you to specify it in the configuration file.  Instead Google uses the default security group for the network being used.  Add inbound TCP ports 22 and 5986 to the default security group for the network being used.

### Azure Resource Manager and Storage Accounts
When custom images are created in Azure they are placed in [Storage Accounts](/clouds/azure_resource_manager/reference/resources.html#storage-accounts).  When launching a server using custom images they must be launched in the same storage accounts the image is in.  When Launching a server in RightScale select the Storage Account created for the custom images in the Placement Group download list.

## Further Reading
* [Packer](http://packer.io)
* [Packer EC2](https://www.packer.io/docs/builders/amazon.html)
* [Packer Google](https://www.packer.io/docs/builders/googlecompute.html)
* [Packer Azure Resource Manager](https://www.packer.io/docs/builders/azure/arm)
* [RightScale Azure RM Integration](/clouds/azure_resource_manager/reference/resources.html#storage-accounts)
