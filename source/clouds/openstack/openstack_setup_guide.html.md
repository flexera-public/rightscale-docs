---
title: Setup Guide
layout: openstack_layout_page
description: The purpose of this guide is to provide end-to-end setup procedures for using an OpenStack cloud with the RightScale Cloud Management Platform.
---

## Let's Get Started!

The purpose of this guide is to provide end-to-end setup procedures for using an OpenStack cloud with RightScale. It provides information about both the OpenStack-specific requirements and components, and the configuration and setup requirements within RightScale. Before working through the procedures described below it is recommended that you read through the [Overview of OpenStack](openstack_about.html) to get familiar with the supported features and capabilities of OpenStack.

This guide covers the following steps for OpenStack cloud setup:

1. [Review OpenStack Configuration Prerequisites](openstack_config_prereqs.html) - Describes the prerequisites for configuring OpenStack to work with RightScale, including information about requirements for RightScale with OpenStack Juno, Kilo and Liberty, including supported features in the dashboard, account selection, API endpoints, firewall settings, uploading images, and known issues.

2. [Register an OpenStack Private Cloud with RightScale](openstack_register_an_openstack_private_cloud_with_rightscale.html) - Describes the process for registering your OpenStack private cloud with RightScale, including prerequisites, cloud registration steps, credential information and entry steps, and private cloud token instructions.

3. [Add an OpenStack Private Cloud to a RightScale Account](openstack_add_an_openstack_private_cloud_to_a_rightscale_account.html) - Describes the process for adding an OpenStack private cloud to a RightScale account, including prerequisites and steps for connecting to a cloud, entering a cloud token, entering credentials, obtaining a Tenant ID, and Checking the cloud status.

4. [Upload RightImages to an OpenStack Private Cloud](openstack_upload_rightimages_to_an_openstack_private_cloud.html) - Describes the process for uploading RighImages to an OpenStack private cloud, including downloading RightImages from RightScale, uploading RightImages to an OpenStack private cloud, and uploading RightImages using command line tools.

5. [Create a MultiCloud Image](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Design/MultiCloud_Images/Actions/Create_a_MultiCloud_Image/index.html) - Once you create a RightLink-enabled Image with RightScale, you must create a MultiCloud Image that points to that image. Then tag the MCI so RightScale recognizes it as an image with RightLink installed.

6. [Add a MultiCloud Image to a ServerTemplate](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Design/ServerTemplates/Actions/Add_a_MultiCloud_Image_to_a_ServerTemplate/index.html) - Once you create an MCI, you can use it in your ServerTemplates.

7. [**Optional**] [Create and Use Bootable Volumes](openstack_boot_volume_guide.html) - Describes the process for creating a bootable volume and launching a server or instance using a bootable volume.

After completing the steps in this guide, you can begin launching servers in the RightScale Cloud Management (CM) Dashboard using your OpenStack cloud.
