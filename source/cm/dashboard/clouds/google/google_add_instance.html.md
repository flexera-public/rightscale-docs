---
title: Add and Launch a New GCE Instance
description: Use this procedure to add and launch a new GCE Instance using the RightScale Instance Provisioner.
---

## Overview

Use the Instance Provisioner to create a new Instance in GCE Cloud and launch it.

## Steps

The Instance Provisioner walks you through the following steps to creating a new GCE Instance:

* Selecting an image
* Specifying hardware and networking details
* Confirming launch settings
* Launching the Instance

Use the following procedure to create a new Instance in GCE using the Instance Provisioner.

1. Navigate to **Clouds** > **Google** > **Instances** > **New**. The Image screen of the Instance Provisioner displays.
2. In the left-hand pane, select the machine image you want to use for your Instance. You can use the filter controls to help you locate the images that are of interest to you. The information displayed in the right-hand pane provides specific details on the selected image. Once you have chosen an appropriate image, click **Details** to move to the next screen. Note that you can also use the 'breadcrumbs' at the top of the screen to navigate through the various steps of the Instance Provisioner.
3. The Details screen provides the following fields and controls for configuring the hardware and storage settings for your Instance.

    | Field/Control | Description |
    | ------------- | ----------- |
    | Instance Name | A user-defined name for the instance. Use this text field to enter a name for your Instance. |
    | Deployment | The RightScale deployment into which the Instance will be launched. Use the drop-down list to select an existing deployment. |
    | Instance Type | A cloud-specific descriptor identifying a combination of CPU, storage, memory, and networking capacity. Use the drop-down list to select an appropriate type. |
    | Root Volume Size (GB) | The size (in gigabytes) of the volume that contains the root filesystem of the instance. |
    | Additional Local SSD Scratch Disks | A local SSD scratch disk that provides 375GB of storage for the Instance and is deleted when the Instance is terminated. Use the drop-down to specify the number of scratch disks you want. |
    | Local SSD Interface | The type of SSD to be created. NVMe requires using an NVMe-compatible image. Use the drop-down to select the SSD interface type. |
    | User Data | (Optional) Allows for configuration of the Instance during launch. |
    | Preemptibility | A preemptible virtual machine costs much less, but only lasts 24 hours. It can be terminated sooner by the cloud provider due to system demand. |
    | Auto-Assign Public IP | If enabled, the Instance will request a public IP from the GCE IP address pool at launch time. Ephemeral external IP addresses are assigned to an Instance until it is restarted or terminated. |
    | IP Forwarding Enabled | If enabled, the Instance will act like a NAT Instance when the source or destination is not itself. |
    | Datacenter | A location within a GCE cloud region, meant to isolate a failure from reaching other zones. |
    | Security Groups | Provides a set of firewall rules that control access to the Instance. Select one or more Security Groups for each Instance. You can also click the **New** button to create a new Security Group. |  

4. Enter or select appropriate values for the settings on the Details screen, then click **Confirm**.
5. Review your settings for the Instance you want to launch. If you need to change anything, you can use the 'breadcrumbs' at the top of the screen or the buttons in the lower left-hand portion of the screen to navigate back to make modifications. Click **Launch** to initiate launching the Instance.
