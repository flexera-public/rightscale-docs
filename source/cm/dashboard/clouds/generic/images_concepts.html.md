---
title: About Images
descriptions: In order to launch a server in a private cloud, you need RightImages that are designed for use with a private cloud.
---

## Overview

The **Images** index page lists virtual machine images that can be used to launch instances in the cloud.

In order to launch a server in a private cloud, you need RightImages that are designed for use with a private cloud. You can access the appropriate RightImages by contacting RightScale Sales. Please contact your RightScale Sales Account Manager for assistance. If you do not have a RightScale Account Manager, please contact the sales department at [sales@rightscale.com](mailto:sales@rightscale.com).

The default view when looking at the Images Index page is to display the **Machine tab**:

## Machine tab

**Default Fields**

**Name** - Name of the Image. Clicking on the Name hyperlink reveals a show page with additional information about the Image.  
**Resource UID** - Resource Unique IDentifier for the Image. Each resource (or entity) in the Dashboard has a unique ID tied to it. Whether the ID is numeric or alphanumeric varies depending on the cloud infrastructure. The Resource UID is generated and persistent in the Cloud. The value is initially retrieved from the Cloud, set in the database, and retrieved/displayed in many areas of the Dashboard (tied to the specific cloud resource).  
**Ownership** - Cloud account ownership. The image gets associated with the Cloud account ID that created the image. Note that this determines whether you even see the image from the Dashboard or not. This differs depending on the actual cloud infrastructure. For example, for one cloud the Ownership could be based on an alphanumeric account ID, for another a numeric account ID, etc. Note: The account information may or may not be supplied by the cloud. If it is provided, we are able to determine the Ownership. If it is not provided, we can only determine if the image is "public" or "private". If "private", Ownership is definitive and displayed. If "public", there is no definitive way to know if you own it or not.

**Additional Fields**

**CPU Architecture** - The architecture the CPU the Instance Type has. The architecture the CPU Instance Type has. For example, x86 or 64 bit architectures.  
**OS Platform** - The image's operating system. (For example, Linux/Unix or Windows.)  
**Visibility** - The visibility of the Image in the cloud. Examples: private, public.

**Actions**

**Launch** - Launch an instance in the cloud using the selected Image. To launch an image, you will be prompted to supply the following additional information: Name, Instance Type, Security Group and the Datacenter / Zone to run in.

!!info*Note:* In order to launch a server in a private cloud, you need RightImages that are designed for use with a private cloud. The following Linux images for OpenStack and vSphere are available from the following links:

[http://rightscale-openstack.s3-website-us-west-1.amazonaws.com/](http://rightscale-openstack.s3-website-us-west-1.amazonaws.com/)  
[http://rightscale-vsphere.s3-website-us-west-1.amazonaws.com/](http://rightscale-vsphere.s3-website-us-west-1.amazonaws.com/)

Please contact your RightScale Sales Account Manager for assistance with obtaining additional machine images including Windows images. If you do not have a RightScale Account Manager, please contact the sales department at [sales@rightscale.com](mailto:sales@rightscale.com).

## Further Reading

* [Create a New MultiCloud Image](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html#create-a-new-multicloud-image)
* [About MultiCloud Images](/cm/dashboard/design/multicloud_images/multicloud_images.html)
* [Add Server Assistant](/cm/dashboard/design/server_templates/servertemplates_actions.html#add-server-assistant)
