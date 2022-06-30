---
title: Known Limitations for Azure Resource Manager (ARM)
layout: azure_resource_manager_layout_page
description: Known limitations for Azure Resource Manager (ARM) in RightScale
---

## Azure Resource Manager Cloud Limitations
!!warning*Note:*Unlike some public clouds, instances without a public IP still have access to the internet

## Cloud Management Limitations
- RightScale Cloud Management does not currently support moving an Azure Resource Manager (ARM) subscription to a different AD tenant. You would need to delete the cloud account in Cloud Management and re-register.
    - [Delete a Cloud Account from a RightScale Account](/cm/dashboard/settings/account/delete_a_cloud_account_from_a_rightscale_account.html)
    - [Registering your Azure Resource Manager subscription using custom Active Directory Application] (/clouds/azure_resource_manager/getting_started/register_using_ad_application.html)
    - [Registering your Azure Resource Manager subscription using RightScale Service Principal] (/clouds/azure_resource_manager/getting_started/register.html)

!!warning*Warning!* Before you delete a cloud account from RightScale, be sure you fully understand its ramifications. See [What happens when I delete a cloud account from RightScale?](/faq/What_happens_when_I_delete_a_cloud_from_my_RightScale_account.html)

## Security Groups/Security Group Rules
The following limitations currently exist in RightScale with regards to these resources.

1. Security Group Rules created in RightScale are auto­named by the platform (using an encoded string containing the direction, CIDR, protocol, and port range)
1. RightScale does not support all fields for security group rules in Azure Resource Manager. Specifically, RightScale only supports “source” IPs for inbound security group rules, and “destination” IPs for outbound. When a security group rule from ARM is discovered that uses fields unsupported by RightScale, some details will be embedded in the description of the rule for reference.  
1. Non-supported params applied to Security Group Rules (SGR) through ARM dashboard are mapped to SGR description in RightScale.

## Functional Limitations   
1. Number of volumes that can be attached depends on instance type.
1. Subnets that can be selected depends on the instance type.
1. Creating instances in Azure Resource Manager with the same name may cause a conflict error in the cloud.  Duplicate names are allowed but must be launched serially.
1. Relaunch immediately is not supported, use the relaunch after termination option.
1. Resource Group names can be a maximum of 90 characters. VM names can be a maximum of 80 characters.[(Microsoft Limitation)](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)
1. When using custom images (non-gallery), you can only launch VMs from the same Storage Account where the VHD resides. So basically, the VM needs to be in the same Storage Account as the uploaded VHD file.
1. Admin Username cannot contain blank spaces. Some names are restricted [(Microsoft Limitation for Windows machines)](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm).
1. Attaching multiple disks concurrently is not supported. A brief wait(~30 seconds) should be implemented in between volume attachments to allow Azure time to complete each request prior to sending the next.
1. Managed Disk volumes can only be attached to a Managed Instance. That is an instance whose root volume is a managed disk.
1. Managed Disks only support the volume types of `Standard_LRS` and `Premium_LRS`. If you require a GRS volume, you will need to continue using unmanaged disks.
1. Storage account containers with more than 10,000 blobs are not supported. The platform will discover any disks/images/volumes in the "first 10,000" blobs returned by the Azure API, but there is no deterministic way to know which blobs will be in the "first 10,000".
1. RightScale is expected to be able to list the containers and blobs within a Storage Account as part of unmanaged disk discovery. If there is a restriction in place, such as Service Endpoints/Firewall rules, the discovery process for unmanaged disks in that region will be aborted. This may result in inaccurate information for unmanaged disks for the affected region. We recommend adding the [RightScale Owned IP-Networks](/faq/Firewall_Configuration_Ruleset.html) to all Storage Accounts that have firewall rules enabled if you require unmanaged disk discovery in that region.

## Azure Linux Agent
The [Azure Linux Agent](https://github.com/Azure/WALinuxAgent) (/usr/sbin/waagent) has been seen to conflict with RightScripts as it continues provisioning the server after it has been reported back as operational:
* A boot RightScript used to set the server's hostname may be overwritten by the Azure Linux Agent.
* A boot RightScript that checks for swap may see none detected but will later be created by the Azure Linux Agent.
