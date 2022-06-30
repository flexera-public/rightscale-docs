---
title: Add and Launch a New OpenStack Instance
description: Use this procedure to add and launch a new OpenStack Instance using the RightScale Instance Provisioner.
---

## Overview

Use the Instance Provisioner to create a new Instance in OpenStack Cloud and launch it.

## Steps

The Instance Provisioner walks you through the following steps to creating a new OpenStack Instance:

* Selecting an image
* Specifying hardware and networking details
* Confirming launch settings
* Launching the Instance

Use the following procedure to create a new Instance in OpenStack using the Instance Provisioner.

1. Navigate to **Clouds** > **OpenStack** > **Instances** > **New**. The Image screen of the Instance Provisioner displays.
2. In the left-hand pane, select the machine image you want to use for your Instance. You can use the filter controls to help you locate the images that are of interest to you. The information displayed in the right-hand pane provides specific details on the selected image. Once you have chosen an appropriate image, click **Details** to move to the next screen. Note that you can also use the 'breadcrumbs' at the top of the screen to navigate through the various steps of the Instance Provisioner.
3. The Details screen provides the following fields and controls for configuring the hardware and storage settings for your Instance.

    | Field/Control | Description |
    | ------------- | ----------- |
    | Instance Name | A user-defined name for the instance. Use this text field to enter a name for your Instance. |
    | Deployment | The RightScale deployment into which the Instance will be launched. Use the drop-down list to select an existing deployment. |
    | Boot to New Volume | If enabled, the instance will boot into volume storage, otherwise the instance will launch into local storage. |
    | Delete Volume on Storage | If selected, the associated volume will be deleted when the instance is terminated. |
    | Root Volume Size | The size of the boot volume in gigabytes. Must be a size supported by the instance. |
    | Instance Type | A cloud-specific descriptor identifying a combination of CPU, storage, memory, and networking capacity. Use the drop-down list to select an appropriate type. |
    | User Data | (Optional) Allows for configuration of the Instance during launch. |
    | SSH Key | Provides secure console login to your instance. Use the drop-down to select a previously created SSH key, or you can click the **New** button to create a new key. |
    | Security Groups | Provides a set of firewall rules that control access to the Instance. Select one or more Security Groups for each Instance. You can also click the **New** button to create a new Security Group. |
    | Datacenter | A location within an OpenStack region, meant to isolate a failure from reaching other zones. |
    | Subnet | Covers a range of IP addresses that reside within a network. Use the drop-down to select a subnet. |

4. Enter or select appropriate values for the settings on the Details screen, then click **Confirm**.
5. Review your settings for the Instance you want to launch. If you need to change anything, you can use the 'breadcrumbs' at the top of the screen or the buttons in the lower left-hand portion of the screen to navigate back to make modifications. Click **Launch** to initiate launching the Instance.
