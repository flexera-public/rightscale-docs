---
title: SoftLayer
layout: softlayer_layout_page
description: This page provides an overview of the various SoftLayer features and supported RightScale objects including ServerTemplates, Machine Images, Instance Types, and other resources.
---

[SoftLayer](http://www.softlayer.com/) provides cloud, dedicated, and managed hosting through integrated computing environments, with data centers in Dallas, Houston, San Jose, Seattle, Washington D.C., Toronto, Asia-Pacific (via Singapore, HongKong, Melbourne), and Europe (via Amsterdam, Paris, London, and Milan), and network Points of Presence worldwide.

## RightScale Support for SoftLayer

### Supported Features

Currently, you can manage your SoftLayer assets by stopping and starting your instances.

* Instances (Virtual Server in SoftLayer parlance)
* Images
* Instance Types
* Datacenters / Zones
* Managed SSH
* SSH Keys
* Public and Private VLANs

## Supported RightScale Objects

### Published ServerTemplates

* [Base Server Template for Linux](https://my.rightscale.com/library/server_templates/Base-ServerTemplate-for-Linux-/lineage/46939)
* [Base Server Template for Windows](https://my.rightscale.com/library/server_templates/Base-ServerTemplate-for-Window/lineage/7210)

### Machine Images

RightScale supports launching instances using the stock images supplied by SoftLayer. One can also bundle RightLink agent (RL v6.3.3 or RL v10.1.x) to create their own version of RightImages that can then be used with RightScale Server Templates.

* **Ubuntu**
  * Ubuntu 10.04, 12.04, 14.04

* **CentOS**
  * ​CentOS 5, 6, 7

* **RedHat**
  * RHEL 5, 6, 7

* **Windows**
  * 2008 R2, 2012 R2

### Instance Types

Softlayer does not provide pre-configured typical instance types per se, but instead they offer the ability to select CPU/core count and memory capacity when creating hourly compute instances. Rightscale provides a few pre-created instance types that can be used with your Softlayer account. These instances types will be seen under the **Clouds > Softlayer > Instance Types** menu in the Rightscale dashboard, and their resources are explained in the following table:

| **Label** | **vCPU** | **RAM in GB** | **Local disk in GB** | **Purpose** |
| --------- | -------- | ------------- | -------------------- | ----------- |
| gXSmall | 1 | 1 | 25 | General |
| gSmall | 1 | 2 | 25 | General |
| gMedium | 2 | 4 | 100 | General |
| gLarge | 4 | 12 | 200 | General |
| gXLarge | 8 | 16 | 300 | General |
| mSmall | 2 | 8 | 25 | Memory heavy |
| mMedium | 4 | 16 | 25 | Memory heavy |
| mLarge | 4 | 32 | 100 | Memory heavy |
| mXLarge | 8 | 64 | 200 | Memory heavy |

**Note:** Extra storage can be added to the instance. One can also rebundle images with extra storage.

### Private and Public VLANs

​RightScale supports launching of servers and instances into VLANs configured in the customer account in various datacenters. Servers and instances can be launched in either private-only VLANs (by specifying only the private VLAN at the time of server launch) or with multiple private and public interfaces. Instead of specifying a public and private VLAN, one can also choose to use "cloud-default" as a selection. If "cloud-default" is selected, SoftLayer will launch the instance in a public and private VLAN based on the VLANs configured for the account.

Please see **Clouds->SoftLayer->Instances->New** and the drop-down box for Subnets, on the RightScale Dashboard.

## Known Issues and Limitations

### Enable Private Network Spanning

**Important**

* With SoftLayer accounts, the "Enable Private Network Spanning" setting must be enabled. Please make this change in the SoftLayer portal:
  * Click the private network link where you will see a link called Enable Private Network Spanning. This will allow you to enable your vlan spanning. If this is not enabled, you will see inconsistent behavior depending on what subnet the VM launches with.
  * For more information see SoftLayer's [Cross connects between two or more servers](http://knowledgelayer.softlayer.com/procedure/cross-connects-between-two-or-more-servers).

## Defect Support

To report any bugs related to RightScale SoftLayer support, please raise a support ticket from the Dashboard or email [support@rightscale.com](mailto:support@rightscale.com).
