---
title: Google Compute Engine (GCE) Resource Integration
layout: google_layout_page
description: Google Compute Engine (GCE) Resource Integration
---

## RightScale Support for Google

## Resources

The following resources in GCE are supported in RightScale:
* Disks
* Firewall Rules
* Images 
* Instances 
* Machine Types 
* Networks 
* Snapshots 
* Tags 
* Zones

## Feature implementation in RightScale

### Disks

Disks in GCE are called Volumes in RightScale.

### Firewall Rules

Firewall Rules in GCE map to RightScale in a unique way, due to the fact that RightScale has a grouping of rules while GCE does not. 

Read more about this mapping on the [Network Manager for GCE page](/cm/dashboard/manage/networks/network_manager_gce.html)

### Networks

Networks created in RightScale are GCE Networks.

### Tags

GCE Tags on Instances are synchronized with RightScale tags [as described on this page](/cm/rs101/tagging.html#how-rightscale-tags-and-cloud-tags-are-related-gce-instance-tags).

Tags in GCE are also used for a variety of other purposes, such as relating an instance to a firewall rule. For tags used in this way, RightScale provides other constructs that can relate Firewall Rules to Instances (see Firewall Rules above). Tags on other resources are not currently supported natively in RightScale.

### Zones

Zones in GCE are represented as Datacenters in RightScale. When you register GCE in RightScale, only one cloud is created, called "Google", which has multiple datacenters that each correspond to one Zone in GCE.
