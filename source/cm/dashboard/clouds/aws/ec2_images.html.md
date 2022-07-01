---
title: EC2 Images
layout: cm_layout
description: RightScale provides the ability to launch a variety of different machine images directly within the RightScale Cloud Management Dashboard.
---
## Overview

When a new instance is launched in a cloud, a server is built with a base machine image. As a convenience to our users, we provide the ability to launch a variety of different images directly within the Dashboard. You can launch a working server directly from an image, but we *strongly* recommend using ServerTemplates if you want to create a reproducible setup or make further changes to it once it's launched. Best practices are incorporated within ServerTemplates. See [ServerTemplates](/cm/dashboard/design/server_templates/servertemplates.html).

!!info*Note:* Servers that are launched directly from images cannot be added to Deployments.

As a convenience to our users, we provide the ability to launch a variety of different images directly within the Dashboard. A list of (Machine) Images, Kernel Images, and Ramdisk Images are displayed below.

* **Personal** - Images that you create and register. Only registered images will be listed.
* **Shared** - Images that other have shared with you.
* **RightImages** - RightImages are a CentOS 5 image and a Fedora Core 6 image that are built specifically for Amazon EC2 servers. The latest RightImages are used by all of RightScale's published ServerTemplates.
* **Amazon** - Amazon's machine images (AMI)
* **RHEL** - Red Hat Enterprise Linux images
* **rBuilder** - rBuilder images
* **Others** - Catch all of sorts for any other image types.

With an AMI you can:

* **Launch** - Launch a new EC2 instance using the selected AMI.

## Actions

* [Replicate an Image to Different EC2 Regions](/cm/dashboard/clouds/aws/actions/ec2_images_actions.html#replicate-an-image-to-different-ec2-regions)
* [Create a Custom RightImage (AMI)](/cm/dashboard/clouds/aws/actions/ec2_images_actions.html#create-a-custom-rightimage--ami-)
* [Test a Custom RightImage (AMI)](/cm/dashboard/clouds/aws/actions/ec2_images_actions.html#test-a-custom-rightimage--ami-)
* [Create a New MultiCloud Image](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image)

## Further Reading

* [Sharing Cloud Resources](/cm/pas/sharing_cloud_resources.html)
* [MultiCloud Images](/cm/dashboard/design/multicloud_images/multicloud_images.html)
* [What's inside of a RightImage?](/faq/What_is_inside_of_a_RightImage.html)
