---
title: Instances and Servers
layout: cm_layout
alias: cm/dashboard/manage/instances_and_servers/instances_and_servers.html
description: The Instances and Servers page in the RightScale Cloud Management Dashboard provides an overview of all instances in your account, whether they are associated with servers, server arrays or stand-alone.
---
## Overview

The Instances and Servers page provides an overview of all instances in your account, whether they are associated with servers, server arrays or stand-alone. Specifically:

* For each running **server** , the instances provisioned in the cloud are shown (there can be multiple instances while relaunching) and the ‘next instance’ used when relaunching the server is shown. For each inactive server only the ‘next instance’ is shown.
* For each **server array** all the provisioned instances are shown and the ‘next instance’ used for the next launch is shown
* All **stand-alone instances** are also shown.

The Instances and Servers page looks similar to the following:

![cm-instances-servers-manage.png](/img/cm-instances-servers-manage.png)

The Instances and Servers page presents a tabular view of the instances in your account. By default, this view displays instances and servers whether they are active or inactive. However, you can customize your view using the controls described below.

!!info*Note:* The result set displayed in the Instances and Servers page is limited to the most recently updated 1000 compute objects (instances, servers, and server arrays). If you only have instances (no servers or arrays), then the 1000 most recently updated instances are retrieved. Otherwise, the result set displayed on the page is a combination of the most recently updated instances, servers (running or not), and arrays (running or not). In addition, the contents of the result set depend on any filtering you may have selected. For example, if you choose to filter by Running Instances then any instances that are not running will be excluded from the result set. Similarly, if you filter by Next Servers or Next Arrays then any server or array instances that are running would be excluded from the result set.

## Filters

In addition to the **Active** and **Inactive** tabs, there are several filters available for you to further fine tune the results displayed in the table.

**Free text filter** - you can enter any string of characters (multiple words will be considered one string). All visible columns will be matched against your filter, including tags that are collapsed. For columns that contain icons, the tooltip value will be filtered upon.

**Item type drop-down filter**
* **Running Instances** - All instances are shown, save those in a stopped state. This includes current server instances and server array instances.
* **Next Servers** - All servers have a 'next' state, which contains configuration values used for future instances when the server is launched or relaunched. Active and current server instances are not shown.
* **Next Arrays** - All autoscaling server arrays which contain configuration values used for instances launched by the server array. Instances launched by server arrays are not shown.
* **Everything** - All instances, servers (next and current instances), and server arrays will be shown.

## Show/Hide Columns

The column layout of the table view in the Instances and Servers page can be tailored to your needs using the **Show/Hide Columns** button. Clicking the button presents a context menu from which you can select or deselect the columns that you want to have displayed in the table. You can also re-set your column selections by clicking **Restore default columns**.

![cm-show-hide-cols-instances.png](/img/cm-show-hide-cols-instances.png)

The following table provides descriptions of the available column headings.

| Name | Name of the instance, server, server instance, array, or array instance |
| ---- | ----------------------------------------------------------------------- |
| Type | Displays an icon indicating the resource type (Ar=array, AI=array instance, In=instance, S=server, SI=server instance), |
| Resource ID | A unique identifier for the resource |
| Deployment | Indicates the RightScale deployment(s) a resource belongs to (if any). Clicking the hyperlink takes you to the Deployments > Servers tab. |
| Container | Displays the container for the selected server. Clicking the hyperlink takes you to the Info tab for the selected item. |
| ServerTemplate | The ServerTemplate from which the resource originated from. Clicking the hyperlink takes you to the Info tab for the ServerTemplate of the selected item. |
| MCI | The RightScale MultiCloud Image associated with the resource. Clicking the hyperlink takes you to the Info tab for the MCI. |
| Image | The machine image associated with the instance. |
| Cloud | The Cloud the resource is associated with (ex: AWS US-Oregon, Azure West US, Google, etc) |
| SSH Key | The unique identifier for the security component used by some cloud providers to secure client connections to servers in the cloud over SSH or Remote Desktop Protocol (RDP). Clicking the hyperlink takes you to the SSH Key Info page for the selected item. |
| Security Groups | The name(s) of the Security Group(s) associated with the resource. A Security Group is a collection of access rules governing which server IP addresses and network protocols and ports a server can access. Clicking the hyperlink takes you to the Security Groups tab in Network Manager. |
| CPU | Displays an icon indicating the current state of the CPU, such as pending, booting, operational, etc. |
| State | Displays the current server state. (e.g., pending, booting, operational, terminated, etc.) |
| Instance Type | The Instance Type associated with the resource. Each Cloud has varying levels of compute capability. RightScale uses 'Instance Types' to categorize and normalize these offerings. |
| Public IP | Denotes the Public IP Address associated with the resource |
| Private IP | Denotes the Private IP Address associated with the resource |
| Elastic IPs | Identifies any Elastic IP Addresses associated with the resource. Elastic IPs are typically used on frontend servers in the AWS cloud. |
| Public DNS | The Public DNS name associated with the resource |
| Private DNS | The Private DNS name associated with the resource |
| Networks | Displays the network(s) an operational server is associated with. Clicking the hyperlink takes to the Manage Networks view. |
| Subnets | The subnet(s) (or logically visible subdivision of the IP Network) the resource resides in. Clicking the hyperlink takes you to the Subnets tab for the Network the selected item is associated with. |
| Datacenter | The regional datacenter (also referred to as a zone) in which the resource resides. Clicking the hyperlink takes you to the Info page for the Datacenter the item is associated with. |
| Tags | The descriptive metadata (defined by RightScale or the user) associated with the resource. |
| Runtime | Indicates the runtime duration in minutes. |
| Operations | Displays icons indicating valid operations for the selected resource, such as Terminate, Launch, etc. |
| SSH/RDP | Displays buttons that can be clicked to launch either an SSH session for Linux servers or a Remote Desktop Connection (RDP) for Windows servers allowing root level console access to the server. |

## Actions

The **Actions** drop-down provides you with a number of commands that can be executed on items in the table depending on the context of your selection. Each of these actions is described in the following sections.

* [Instances and Servers Actions](/cm/dashboard/manage/instances_and_servers/instances_and_servers_actions.html)

## New Instance

You can use the **New Instance** drop-down to create a new Instance, new Server, or new Server Array in a selected Cloud. Opening the drop-down exposes menu selections for the available cloud providers and sub-menus for compute regions as depicted below.

![cm-msa-new-instance-drop-down.png](/img/cm-msa-new-instance-drop-down.png)

Choosing a cloud provider and compute region from the drop-down displays the modal dialog shown below.

![cm-msa-new-instance-modal.png](/img/cm-msa-new-instance-modal.png)

From this dialog you can elect to create an Instance, a Server, or an Array.

* Clicking **Create Instance** will take you to the Instance Provisioner as described in [Create New Instance with the Instance Provisioner](/cm/dashboard/clouds/generic/instances_actions.html#create-a-new-instance-using-the-instance-provisioner).
* Selecting an existing deployment and clicking **Create Server** will take you to the Add Server Assistant as described in [Add Server Assistant](/cm/dashboard/design/server_templates/servertemplates_actions.html#add-server-assistant).
* Selecting an existing deployment and clicking **Create Array** will take you to the Add Server Array Assistant as described in [Add Server Array Assistant](/cm/dashboard/manage/arrays/arrays_actions.html#add-server-array-assistant).

## Concepts

* [Instances and Servers Concepts](/cm/dashboard/manage/instances_and_servers/instances_and_servers_concepts.html)

## Related FAQs

* [What is HAProxy and how does it work?](/faq/What_is_HAProxy_and_how_does_it_work.html)
* [How can I use OpenVPN with RightScale?](/faq/How_can_I_use_OpenVPN_with_RightScale.html)
* [FAQ 190 - What is the difference between the Launch option and Save and Launch option?](http://support.rightscale.com/06-FAQs/FAQ_190_-_What_is_the_difference_between_the_Launch_option_and_Save_and_Launch_option%3F/index.html)
