---
title: RightImages
layout: cm_layout
description: A RightImage is a base machine image, published by RightScale, that can be used to launch instances in cloud infrastructures.
---

## What is a RightImage?

A **RightImage** ™ is a base machine image, published by RightScale, that can be used to launch instances in cloud infrastructures. RightImages are unique from other cloud-based machine images because they are specifically designed for optimum communication with the RightScale platform.

RightImages are designed to not only give you exactly what you need to build a stable server instance in the cloud, but also give you the control and flexibility to customize each server depending on your application's requirements using the ServerTemplate model for launching servers. Although you can launch a functional instance in the cloud using any of our RightImages, they are designed to be used in the context of a ServerTemplate. Each of RightScale's published ServerTemplates was tested and published with one or more RightImages.

Each RightImage contains a base install of an operating system (e.g. CentOS 6.5, Ubuntu 12.04, Windows 2012, etc.), cloud-specific tools, standard networking, and Internet tools. Our latest RightImages (v5) also contain our RightLink agent which allows the instance to be more efficiently managed by the RightScale platform.

RightImages include:

* Clean base image that has never been booted
* Image that automatically uses our build script
* Built-in support for RightScale™ features and service
* Core tools and utilities that make it easy to install additional software

## Which RightImage Should You Use?

In order to successfully launch a server, you must select the appropriate image type based upon the instance's system architecture. Each RightImage will denote the system architecture in its name.

* 32-bit: i386 (e.g. RightImage Ubuntu_10.4\_ **i386** \_v5.5)
* 64-bit: x64 (e.g. RightImage Ubuntu_10.4\_ **x64** \_v5.5)

### AWS

AWS offers both 32-bit and 64-bit EC2 instance types.

* 64-bit images: Supports all instance types except 'micro'.

## Where do RightImages Exist?

RightImages are cloud resources that exist at the cloud infrastructure level. RightScale periodically publishes new RightImages to the different public cloud infrastructures that are supported to make them available for use in those clouds/regions. In order to launch an instance using a particular RightImage, the machine image must exist within that cloud/region. As a convenience to our users, when RightScale creates and publishes a new suite of RightImages, each image is replicated (copied) across all clouds/regions. In some cases where a RightImage requires a specific kernel version or has other image dependencies that have been deprecated by the cloud provider, RightScale is not able to make that particular RightImage available in those clouds/regions. For example, when Amazon introduces a new AWS Region, sometimes older kernels are not made available in that region so RightScale cannot publish some of its older RightImages.

If you are building your own custom RightScale-enabled images, you need to make the image available in each of the clouds where you intend to use it to launch instances.

## How are RightImages Selected and Used?

If you're launching servers through the RightScale platform (Dashboard or API), a MultiCloud Image (MCI) will select the appropriate RightImage based on the selected cloud/region. For example, let's say you want to create a PHP Application Server in EC2 using the latest published RightImage for Ubuntu 10.04 (e.g. RightImage_Ubuntu_10.04_i386_v5.6). When you add a Server to a Deployment, you must first select the desired cloud/region for your server. Based on that selection (e.g. AWS US-East), the appropriate RightImage in that cloud/region is selected.

To learn more, see [MultiCloud Images](/cm/dashboard/design/multicloud_images/index.html).

### Default Image Selection

Each ServerTemplate is published with one or more MCIs. By default, each ServerTemplate is published with a default MCI preselected. For ServerTemplates published by RightScale, the default MCI and instance size for AWS is often a 32-bit RightImage where the chosen instance type is an 'm1.small'.

## See also

- [What's inside of a RightImage?](/faq/What_is_inside_of_a_RightImage.html)
