---
title: Create and Use Bootable Volumes
layout: openstack_layout_page
description: RightScale provides tools that help you leverage OpenStack's ability to boot instances from an existing volume.
---

RightScale provides tools that help you leverage OpenStack's ability to boot instances from an existing volume. With RightScale, you can both create volumes from images as well as specify volumes to boot from.

## Creating a bootable volume from an existing image

In order to boot from a volume, you must first have a volume that has bootable content in it. Generally, these volumes are created by specifying an image from which to create the volume from. The following steps describe how this can be done in RightScale.

1. Navigate to **Clouds** > \<Your Openstack Cloud\> > **Volumes** > **New**
2. Select the image you would like to use from the image dropdown.
3. Fill in the other fields appropriately and submit

!!warning*Note*Volume size must be large enough to accommodate the image being used to create it.

## Launching a server or instance using a bootable volume

Currently, RightScale support booting from a volume by using special content in the userdata of your instance. Note that in the future this will be replaced by functionality built-in to the UI and API. In order to boot from a volume using the userdata content, perform the following steps:

1. First, locate the bootable volume you want to use and record its resource_uid by navigating to the Volumes section in your OpenStack cloud. The volume ID should look something like `1725333c-50bb-4f27-aabc-703c6f67c2db`
2. Add a Server/Array/Instance as usual
3. When configuring your server or instance object, make sure to select the image that was used to create the bootable volume. This will correctly allow RightScale to detect the OS platform.
4. On the Details screen, expand the `Advanced Options` selection and add the following to the `User data` field: `VolumeUUID=<volume_resource_uid>` using the volume ID from step 1
5. Launch your VM
