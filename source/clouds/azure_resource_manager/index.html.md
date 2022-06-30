---
title: Microsoft Azure Resource Manager
layout: azure_resource_manager_layout_page
description: Microsoft Azure Resource Manager is an open and flexible cloud platform that enables you to quickly build, deploy and manage applications across a global network of Microsoft-managed datacenters.
---

## Overview
RightScale allows you to discover, provision, take action, and create policies across a wide variety of Azure Resource Manager (ARM) cloud services including compute, storage, network, database, middleware, and application services.

Many cloud services are supported out-of-the-box in RightScale while others leverage a plugin. Plugins describe the API of a service provider for the RightScale platform, including defining the parameters which must be specified to interact with the service, the structure of resources in the service, and how RightScale can create and interact with those resources. RightScale continually creates new plugins for cloud services which are shared in a [public repository on GitHub](https://github.com/rightscale/rightscale-plugins). RightScale partners or customers can [create their own plugins](/ss/reference/cat/v20161221/ss_plugins.html).  

There are four approaches that you can leverage to manage cloud services in RightScale:

* Native integration - no plugin is required
* Out-of-the-box plugin - plugin is provided by RightScale. ([GitHub repo](https://github.com/rightscale/rightscale-plugins))
* Custom plugin - [create a plugin](/ss/reference/cat/v20161221/ss_plugins.html) for other cloud services
* http/https - use the [http/https function in Cloud Application Templates](/ss/reference/rcl/v2/ss_RCL_functions.html#http-https-functions) 


## Azure Resource Manager (ARM) vs Azure Service Management (Classic)
Azure Resource Manager is the replacement for Azure Service Manager (Classic). The architecture, APIs, and features available for Azure classic are different than Azure and more limited and the two models are not compatible. Microsoft documentation “recommends that you use Resource Manager for all new resources. If possible, Microsoft recommends that you redeploy existing resources through Resource Manager.”

While classic deployments are still supported in Azure, the Azure classic portal is <a nocheck href="https://azure.microsoft.com/en-us/updates/azure-portal-updates-for-classic-portal-users/">no longer supported</a> as of January 2018 and [most Azure services are only supported under Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-deployment-model#understand-support-for-the-models).

You can continue to manage Azure classic deployments in RightScale, but you must register your Azure subscriptions separately for classic and ARM support. 

## Supported Azure Resource Manager (ARM) Services

Below is a list of services supported for Azure. Other services can be supported through [custom plugins](/ss/reference/cat/v20161221/ss_plugins.html) or the [http/https function in Cloud Application Templates](/ss/reference/rcl/v2/ss_RCL_functions.html#http-https-functions).

| **Azure Services** | **How Supported** | **Link to Plugin** |
| ----------- | ----------- | --------------------- |
| Virtual Machines | Native and Plugin | [Azure Compute](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_compute) |
| Scale Sets | Plugin | [Azure Compute](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_compute) |
| AKS | Plugin | [Azure Container Services](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_containerservices) |
| Managed/Unmanaged Disks | Native |  |
| Blob Storage | Native |  |
| Storage | Plugin | [Azure Storage](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_storage) |
| Networks | Native and Plugin | [Azure Networking Interface](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_networking) |
| Load Balancer | Plugin | [Azure Load Balancer](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_networking) |
| SQL Database | Plugin | [Azure SQL Database](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_sql) |
| Azure Database for MySQL | Plugin | [Azure Database for MySQL](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_mysql) |
| Azure Database for PostgreSQL | Plugin | [Azure PostgreSQL](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_pgsql) |
| Azure Cosmos DB | Plugin | [Azure Cosmos DB](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_cosmosdb) |
| Redis Cache | Plugin | [Azure Redis Cache](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_cache) |
| ARM Templates | Plugin | [Azure ARM Templates](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_template) |
| Azure Key Vault | Plugin | [Azure Key Vault](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_key_vault) |
| Service Diagnostics | Plugin | [Azure Service Diagnostic Settings](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_diagnostic_settings) |
| Azure Resources | Plugin | [Azure Resources](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_resources) |
| Any other Azure services | Custom plugin or http/https support | &nbsp; |

## Contact Information

### Microsoft Azure

* **Corporate website:**  <a nocheck href="https://azure.microsoft.com/en-us/">https://azure.microsoft.com/en-us/</a>

### RightScale

* **Sales** - For information about your account specifics, contact your account manager _or_ email [sales@rightscale.com](mailto:sales@rightscale.com)
* **Support** - Report any bugs related to RightScale, please raise a support ticket from the Dashboard or email [support@rightscale.com](mailto:support@rightscale.com).
