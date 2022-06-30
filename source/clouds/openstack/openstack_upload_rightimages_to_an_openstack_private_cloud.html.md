---
title: Upload RightImages to an OpenStack Private Cloud
layout: openstack_layout_page
description: This page outlines the steps for uploading a RightImage to an OpenStack private cloud so that you can create a custom MultiCloud Image (MCI) and use it with a ServerTemplate.
---

## Objective

To upload a RightImage to an OpenStack private cloud so that you can create a custom MultiCloud Image (MCI) and use it with a ServerTemplate.

## Overview

If you are setting up your own private cloud and want to use RightScale's ServerTemplate model for launching servers, you need to use one of RightScale's published RightImages (machine images). The first step of this process is to upload one or more RightImages to your private cloud. Once the RightImage is available in your private cloud, you can create a MCI that references the image in that cloud and then add the MCI to your ServerTemplate(s). This tutorial explains the initial step of uploading a RightImage to your private cloud.

## Steps

### Download OpenStack-related RightImages from RightScale

* Our OpenStack (with Horizon) RightImages can be [found here](http://rightscale-openstack.s3-website-us-west-1.amazonaws.com/).
* For Windows based images, please contact RightScale support ([support@rightscale.com](mailto:support@rightscale.com))

### Upload RightImages to an OpenStack Private Cloud through Horizon

1. Login to your OpenStack Dashboard
2. Navigate to **Images & Snapshots**
3. Click **Create Image**
4. Fill out the necessary information and add your desired image URL in Image Location from our bucket [found here](http://rightscale-openstack.s3-website-us-west-1.amazonaws.com/).
5. When finished, click **Create Image**.

### Upload RightImages Using Command Line Tools

**Note** : When an image is loaded on to an OpenStack cloud, you must specify the correct OS type for the image. If the OS type is not specified, it will default to linux.

If you do not have access to the Horizon dashboard, you can use the *glance* command line tool to upload an image as well by following these steps:

1. Ensure that you have *glance* client installed correctly.
2. Using glance CLI, you can directly upload the image into glance repository from RightScale's image repository:

~~~
# glance image-create --public --copy-from https://rightscale-openstack.s3.amazonaws.com/kvm/centos/5.8/RightImage_CentOS_5.8_x64_v5.8.8.3.qcow2 --name="RightImage_CentOS_6.3 v5.8.8.3" --container-format=ovf --disk-format=qcow2
~~~
