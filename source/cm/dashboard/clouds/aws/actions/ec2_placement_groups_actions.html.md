---
title: EC2 Placement Groups - Actions
description: Common procedures for working with EC2 Placement Groups in RightScale Cloud Management Dashboard.
---

## Create a New Placement Group

EC2 Placement Groups are specific for Cluster Compute Instance Types. Once you create an EC2 Placement Group, you can start adding Cluster Compute Instances into it.

![cm-placement-groups.png](/img/cm-placement-groups.png)

Use the following procedure to create a new Placement Group. You must have 'actor' user role privileges.

* Go to **Clouds** > *AWS Region* > **Placement Groups**. Click the **New** action button.

Provide the following parameters:

* **Name** - The name of the EC2 Placement Group. Once a Placement Group is created, its name cannot be changed.
* **Description** - Description of the EC2 Placement Group. The description can be changed at any time.  

* Click the **Create** button.

## Launch a Cluster Compute Instance

### Overview

Cluster compute instances are launched in a similar way as other EC2 instance types, except for a couple minor differences, which will be explained in context below. Although, you can launch a cluster compute instance directly from an image, it's recommended that you launch them using ServerTemplates for better control and repeatability. This tutorial will focus on the latter use case.

There are two key differences between launching cluster compute instances and other EC2 instance types.

* Cluster Compute Instances require the use of a HVM-based ([Hardware Virtual Machine](http://en.wikipedia.org/wiki/Hardware_virtual_machine)), Amazon EBS-based machine image. (Other EC2 instance types use a PVM-based ([Paravirtual Machine](http://en.wikipedia.org/wiki/Paravirtualization)) machine image.)
* All Cluster Compute Instances that are designed to work together must be placed in the same EC2 Placement Group.

### Prerequisites

* An existing EC2 Placement Group.[Create a New Placement Group](/cm/dashboard/clouds/aws/actions/ec2_placement_groups_actions.html#Create_a_New_Placement_Group)
* 'actor' user role privileges

### Steps

There are two different ways to launch a Cluster Compute Instance:

* Launch Cluster Compute Instances directly from Images
* Launch Cluster Compute Instances using ServerTemplates

#### Launch Cluster Compute Instances Directly from an Image

* Go to **Clouds** > *AWS Region* > **Images**. Use the filter tool to find an HVM-based machine image. For example, you can use an AMI from Amazon (e.g. ami-17f9de52). (*Note*: AWS includes "HVM" in the namespace to help locate a HVM based machine image. You can use the Filter by Name option, and search against "HVM".)

![cm-HVM-AMI.png](/img/cm-HVM-AMI.png)

* Click the **Launch** icon.

Specify the required parameters before launching the instance. HVM machine images do not require Kernel or Ramdisk images. Be sure to select a valid Instance Type (e.g. cc2.8xlarge) and the Placement Group (e.g. dean) into which the instance will be placed. If you do not have one listed, see [Create a New Placement Group](/cm/dashboard/clouds/aws/actions/ec2_placement_groups_actions.html#Create_a_New_Placement_Group).

![cm-new-RightScale-ec2-instances.png](/img/cm-new-RightScale-ec2-instances.png)

* Click the **Launch** button.

Once the instance becomes operational, it will be listed under **Clouds** > *AWS Region* > **Instances** > **Active** tab.

#### Launch Cluster Compute Instances using ServerTemplates

The first step is to create a Deployment that will contain the cluster compute servers.

* Go to **Manage** > **Deployments** > **New**.
* Select the desired EC2 Placement Group into which the Cluster Compute Instances will be placed.

![cm-new-CCI-deployment.png](/img/cm-new-CCI-deployment.png)

* Next, you can create a ServerTemplate that you can use to create Cluster Compute Servers.
* Go to **Design** > **ServerTemplates** > **New** ([Create a new ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_actions.html#create-a-new-servertemplate))

You will add an MCI to this ServerTemplate. You may browse our HVM MCIs in the [Marketplace](http://www.rightscale.com/library/multi_cloud_images/) to import. Or you can create your own HVM MCI and follow the steps below.

#### Create a ServerTemplate and MCI

Be sure to select a valid Cluster Compute Instance Type (e.g. cc2.8xlarge) and a valid HVM-based machine image. Use the image published by RightScale, "RightLink_CentOS_5.4_x64_v5.4.6_HVM_Beta" (only available in AWS US-East) or one from Amazon (Search for "HVM").

* **Name**: clustercompute
* **Description**: Use for launching cluster compute instances
* **MultiCloud Image**: Select "Create a new MultiCloud Image"
* **Name**: cc2 instances
* **Cloud**: AWS US-East
* **Instance Type**: cc2.8xlarge
* **Machine Image**: EC2 CentOS 5.4 HVM AMI

![cm-new-RightScale-servertemplates.png](/img/cm-new-RightScale-servertemplates.png)

* Click **Save**.

Now that you've created a ServerTemplate for launching a Cluster Compute Instance, click the **Add To Deployment** action button when viewing the new ServerTemplate. Select the Deployment that you just created for these Cluster Compute Servers and configure the required parameters. The Server will inherit the correct instance type (e.g. cc2.8xlarge) from the MCI. Since you specified an EC2 Placement Group when you created the Deployment, the Server will also inherit that setting as well.

* Click **Add**.

Repeat these steps to add multiple Cluster Compute Servers to the Deployment.

You can now safely launch the Servers.

!!info*Note:* Amazon recommends launching all Cluster Compute Servers at the same time.

* Go to the Deployment that contains the Cluster Compute Servers and launch them all at once.

!!info*Note:* Before you can launch multiple Servers at the same time, all required Inputs parameters must be specified.

![cm-launch-multiple-servers.png](/img/cm-launch-multiple-servers.png)
