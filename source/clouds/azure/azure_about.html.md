---
title: Microsoft Azure (Classic)
layout: azure_layout_page
description: Microsoft Azure is an open and flexible cloud platform that enables you to quickly build, deploy and manage applications across a global network of Microsoft-managed datacenters.
---

## Azure Resource Manager (ARM) vs Azure Service Manager (Classic)

Azure Resource Manager is the replacement for Azure Service Manager (Classic). The architecture, APIs, and features available for Azure classic are different than Azure and more limited and the two models are not compatible. **Microsoft documentation “recommends that you use Resource Manager for all new resources. If possible, Microsoft recommends that you redeploy existing resources through Resource Manager.”**

While classic deployments are still supported in Azure, the Azure classic portal is <a nocheck href="https://azure.microsoft.com/en-us/updates/azure-portal-updates-for-classic-portal-users/">no longer supported</a> as of January 2018 and [most Azure services are only supported under Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-deployment-model#understand-support-for-the-models).

You can continue to manage Azure classic deployments in RightScale, but you must register your Azure subscriptions separately for classic and ARM support.  Learn about [RightScale support for Azure Resource Manager](/clouds/azure_resource_manager/).

## Supported Azure Classic Services

RightScale supports the following Azure Classic features

* Virtual Machines
* Disks
* Networks

## Known Issues and Limitations

* If you try to terminate multiple servers in one action using the bulk select and terminate option, it may result in one of the servers becoming stranded in the decommissioning state. In such cases, you must manually delete the stranded server(s) to terminate it.
* Command line based stop requests will result in an "allocated" stop. This type of stopped state is not supported by RightScale. If a CLI based stop is executed on a server that server will stay in the "Operational" state in RightScale as opposed to transitioning to the stopped state as expected.

## Contact Information

### Microsoft Azure

* **Corporate website:**  <a nocheck href="https://azure.microsoft.com/en-us/">https://azure.microsoft.com/en-us/</a>

### RightScale

* **Sales** - For information about your account specifics, contact your account manager _or_ email [sales@rightscale.com](mailto:sales@rightscale.com)
* **Support** - Report any bugs related to RightScale, please raise a support ticket from the Dashboard or email [support@rightscale.com](mailto:support@rightscale.com).
