---
title: Optima billing data configuration
layout: optima_layout
description: Describes how to configure cloud billing data for ingestion into Optima for cost allocation and analysis
---

## Overview

Optima ingests billing data provided by major cloud providers and [custom bills](common_bill_ingestion.html), allowing you to allocate costs, identify waste, and performed detailed analysis of your cloud spend. This page describes how to add and update billing configuration data using the Optima UI and API.

In addition to the steps on this page, there are [cloud-specific instructions for configuring bill data from each of the cloud providers](../getting_started/bill_connect) which must be completed.

## Using the Optima UI

### Navigation

From any screen in Optima, select the "Settings" option in the left-hand navigation bar, and then the "Billing Configuration" tab.

![optima-bill-config-topnav.png](/img/optima-bill-config-topnav.png)

!!info*Note*This option is only available for users that have the `enterprise_manager` role

### Adding new billing data

To add new bill data to Optima:
1. Select the "Add a cloud bill" button in the upper-right corner of the billing configuration page
2. Select the cloud that you would like to connect to Optima. Note that each cloud requires different configuration information, detailed in the links below
3. Click the Continue button
4. Optima performs initial validation of the configuration data and will provide a success or failure message
5. If successful, billing data can be expected to be available within 24 hours
6. If unsuccessful, please check all configuration information and try again, or contact support

For details on the cloud-specific billing configuration information, see [the articles listed here](../getting_started/bill_connect)

### Viewing information about bill configurations

Once in the billing configuration page, all connected bills are listed on the left. Selecting any bill will provide details about the configuration information in the Info pane on the right. For Azure CSP connections, the "Tenants" tab [shows the CSP tenants that are currently configured](TBD).

For each cloud, non-sensitive configuration information is made available. Sensitive key material is not available via the Optima UI.

Note that the `Last updated on` date reflects the last change of **configuration information** for this bill, not the last bill that was processed.

### Updating billing data configuration

In the case of credential rotation or other changes in the cloud environment, the configuration of each bill can be updated. Each cloud allows most configuration data to be updated except for the account ID (or equivalent).

To update bill data configurations:
1. Select the bill that needs to be updated
2. Click the blue "Edit" button in the lower-right corner of the bill information panel
3. Change the configuration data as needed
4. Click the Update button
5. Optima performs initial validation of the configuration data and will provide a success or failure message
6. If successful, the new configuration is saved
7. If unsuccessful, please check all configuration information and try again, or contact support. The current configuration will not be updated.

For details on the cloud-specific billing configuration information, see [the articles listed here](../getting_started/bill_connect)

### Removing billing data

Bill data configurations can be removed from Optima to prevent data from being updated for a given account. Once removed, any rules, dashboards, or other features relying on that data will no longer contain updated information for that account.

To remove a set of bill data from Optima:
1. Select the bill to remove
2. Click the red "Delete" button in the lower-left of the bill information panel
3. Confirm bill deletion by clicking "Remove Configuration"

## Using the Optima API

The [Optima API for bill connects](https://reference.rightscale.com/optima_front/) provides full control of bill data configuration and can be used to automate connections or credential rotation using a REST-compliant interface.

The `BillConnects` resource provides a list of all bill data configurations (except for Azure CSP) while cloud-specific resources are used for creating, updating, and removing bill data configurations.

!!info*Note*For Azure CSP partners, please see the [CSP Partnership Guide](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html#setup-registering-your-csp-partnership).

### Adding new billing data

To add new billing data, use the cloud-specific path for bill connects with the `POST` method. Each cloud requires different payloads in the `POST`, the details of which can be found [in the articles listed here](../getting_started/bill_connect). The specific API resources/paths for each cloud are as follows:

* **AWS** - [AWSBillConnects](https://reference.rightscale.com/optima_front/#/AWSBillConnects/AWSBillConnects_createIAMUser)
* **Google** - [GoogleBillConnects](https://reference.rightscale.com/optima_front/#/GoogleBillConnects/GoogleBillConnects_create)
* **Microsoft Azure (Enterprise Agreement)** - [AzureEABillConnects](https://reference.rightscale.com/optima_front/#/AzureEABillConnects/AzureEABillConnects_create)
* **Microsoft Cloud Solution Provider (CSP) Partner** - see the [CSP Partnership Guide](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html#setup-registering-your-csp-partnership).

If the API returns a success code, the the configuration has been saved and bill data can be expected to be available within 24 hours.

### Update billing data configuration

To update the credential or other configuration for an existing bill data connection, locate the ID of the bill connect resource through the API or UI and make a `PATCH` call to that href. Each cloud requires different payloads in the `PATCH`, the details of which can be found [in the articles listed here](../getting_started/bill_connect). The specific API resources/paths for each cloud are as follows:

* **AWS** - [AWSBillConnects](https://reference.rightscale.com/optima_front/#/AWSBillConnects/AWSBillConnects_updateIAMUser)
* **Google** - [GoogleBillConnects](https://reference.rightscale.com/optima_front/#/GoogleBillConnects/GoogleBillConnects_update)
* **Microsoft Azure (Enterprise Agreement)** - [AzureEABillConnects](https://reference.rightscale.com/optima_front/#/AzureEABillConnects/AzureEABillConnects_update)
* **Microsoft Cloud Solution Provider (CSP) Partner** - see the [CSP Partnership Guide](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html#setup-registering-your-csp-partnership).

If the API returns a success code, the the configuration has been saved.

### Removing billing data

Bill data configurations can be removed from Optima to prevent data from being updated for a given account. Once removed, any rules, dashboards, or other features relying on that data will no longer contain updated information for that account.

To remove bill data configurations from Optima, locate the ID of the bill connect resource through the API or UI and make a `DELETE` call to that href. Each cloud requires different payloads in the `DELETE` call, the details of which can be found [in the articles listed here](../getting_started/bill_connect). The specific API resources/paths for each cloud are as follows:

* **AWS** - [AWSBillConnects](https://reference.rightscale.com/optima_front/#/AWSBillConnects/AWSBillConnects_delete)
* **Google** - [GoogleBillConnects](https://reference.rightscale.com/optima_front/#/GoogleBillConnects/GoogleBillConnects_delete)
* **Microsoft Azure (Enterprise Agreement)** - [AzureEABillConnects](https://reference.rightscale.com/optima_front/#/AzureEABillConnects/AzureEABillConnects_delete)
* **Microsoft Cloud Solution Provider (CSP) Partner** - see the [CSP Partnership Guide](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html#setup-registering-your-csp-partnership).
