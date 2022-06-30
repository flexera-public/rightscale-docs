---
title: About Instances
description: A cloud Instance refers to a Virtual Machine Instance (VMI) that runs within a cloud infrastructure. Conceptually, an instance is simply a dedicated machine in your desired cloud infrastructure that you can configure for your own purposes.
---

## Overview

A cloud **instance** refers to a Virtual Machine Instance (VMI) that runs within a cloud infrastructure. Conceptually, an instance is simply a dedicated machine in your desired cloud infrastructure that you can configure for your own purposes. Two of the more important concepts with respect to instances in the cloud are instance type and state. Both of which can differ from cloud to cloud. An instance type is basically the size of the instance. That is, the amount of compute resources when provisioned such as the amount of CPU, memory, and ephemeral storage. RightScale maps these back to generic terms which are easier to understand across all cloud infrastructures. It's the cloud provider's responsibility to make sure that an instance is provisioned which meets the requirements you specify from the RightScale Dashboard (or API).

See [Instances - Actions](/cm/dashboard/clouds/generic/instances_actions.html) for step-by-step instructions for common operations.

**Default Fields**

* **Name** - Name of the instance.
* **Resource UID** - Resource Unique Identifier. Each resource (or entity) in the Dashboard has a unique ID tied to it. Whether the ID is numeric or alphanumeric varies depending on the cloud infrastructure. The Resource UID is generated and persistent in the Cloud. The value is initially retrieved from the Cloud, set in the database, and retrieved/displayed in many areas of the Dashboard (tied to the specific cloud resource).
* **Attachable IP** - Static, public IP Address which can be assigned to an instance. Attachable IP addresses typically come from a pool offered by the cloud infrastructure, hence assigning or reassigning to a different instance does not have severe lag times normally associated with DNS propagation.
* **State** - The state of an instance. Valid states are: pending, booting, running, operational, terminating, terminated, stopping, stopped, decommissioning.
* **Actions** - The actions you can run against a specific instance. For example, terminate or SSH into an instance.

**Other Fields**

* **OS Platform** (e.g. Linux/Unix, Windows), **Public/Private IP**, **Public/Private DNS**.

**Actions**

* **Launch** - Launch an instance. You will be prompted for the following information: Name, Image, Instance Type, Security Group(s), and Datacenter/Zone.
* **Apply** - You can apply a Filter by Name, Resource UID or Platform.

For operational instances, the following **Actions** also apply:

* **SSH Console** (Linux/Unix) - Open an SSH terminal into the instance using an SSH client. You can use a local installed SSH client when available (See [User Settings - SSH](/cm/dashboard/settings/user/index.html#user-settings---ssh) for more information).
* **RDP** (Windows) - Use Remote Desktop Program (RDP) to access a Windows instance. (IE browser only.)

## Actions

* [Add Instances to a Deployment](/cm/dashboard/clouds/generic/instances_actions.html#add-instances-to-a-deployment)
* [Create a new Instance](/cm/dashboard/clouds/generic/instances_actions.html#create-a-new-instance)
* [Create New Instance with the Instance Provisioner](/cm/dashboard/clouds/generic/instances_actions.html#create-new-instance-with-the-instance-provisioner)

## Further Reading

* [What is inside of a RightImage?](/faq/What_is_inside_of_a_RightImage.html)
