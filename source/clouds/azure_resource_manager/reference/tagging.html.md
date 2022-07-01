---
title: Azure Resource Manager (ARM) Tag Synchronization
layout: azure_resource_manager_layout_page
description: Details about Tag Synchronization for Azure Resource Manager (ARM)
---

## Tag Synchronization

Tagging with Azure Resource Manager (ARM) in RightScale follows the syntax for [machine tags](../../../cm/rs101/tagging.html#machine-tags-vs--raw-tags-machine-tags): `<namespace>:<key>=<value>`

ARM supports tags as plain strings, these tags are synced with RightScale tags as well.
When a tag is discovered in ARM, it is imported into RightScale with the tag namespace of `azure`. 
In order for a tag in RightScale to be synced to ARM, it similarly must have the namespace `azure`.

## ARM Tag Limits

ARM supports a maximum of 15 tags per resource.

For most ARM Resources, the tag `name` is limited to a maximum of 512 characters, and the tag `value` is limited to 256 characters.
For ARM Storage Accounts, the tag `name` is limited to a maximum of 128 characters, and the tag `value` is limited to 256 characters.

For more information on ARM tagging, see [the ARM documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags).

## Tagging on ARM and RightScale

### Virtual Machines and Instances/Servers

ARM Virtual Machines map to RightScale Instances and Servers.

Adding a tag with the namespace of `azure` to an Instance/Server in RightScale will sync the tag to the relevant Virtual Machine in the ARM Portal.
Adding a tag to the Virtual Machine in ARM will add the tag to the relevant Instance/Server in RightScale with the namespace `azure`.

### Storage Accounts and Placement Groups

ARM Storage Accounts map to RightScale Placement Groups. 

Adding a tag with the namespace of `azure` to a Placement Group in RightScale will sync the tag to the relevant Storage Account in the ARM Portal.
Adding a tag to the Storage Account in ARM will add the tag to the relevant Placement Group in RightScale with the namespace `azure`.

### Resource Groups and Deployments

ARM Resource Groups map to RightScale Deployments.

Adding a tag with the namespace of `azure` to a Deployment in RightScale will sync the tag to the relevant Resource Group in the ARM Portal.
Adding a tag to the Resource Group in ARM will add the tag to the relevant Deployment in RightScale with the namespace `azure`.

For more information on the RightScale Deployment to ARM Resource Group relationship, see the [Azure Resource Groups](./resources.html#azure-resource-groups) section of the [RightScale Azure Resource Manager (ARM) Integration](./resources.html) documentation.