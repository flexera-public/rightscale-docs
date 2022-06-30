---
title: Managing CSP Partnerships and Customers in Optima
layout: azure_layout_page
description: This page walks you through the steps to manage your Azure Cloud Solution Provider (CSP) data in RightScale Optima for cost reporting
---

This document is intended for [Microsoft Cloud Solutions Provider (CSP)](https://partnercenter.microsoft.com/en-us/partner/cloud-solution-provider) partners. If you are not part of the Azure CSP program, these instructions are not relevant; instead, see [Azure Enterprise Agreement](/clouds/azure/azure_connect_azure_enterprise_agreement_to_RightScale_for_cost_reporting.html) for connecting your Microsoft EA for billing purposes or [Register an Azure Resource Manager (ARM) account with RightScale](/clouds/azure_resource_manager/getting_started/register.html) for connecting subscriptions for management purposes.

## Overview

Azure CSP subscriptions can be visualized and reported on in Optima like other subscriptions, but there are some important differences in the costs and setup that you need be aware of. 

RightScale integrates with the [Microsoft Partner APIs](https://docs.microsoft.com/en-us/partner-center/develop/partner-center-rest-api-reference) to provide functionality around the CSP program. Each of your customers within the partner portal should have their own [Organization](/cm/dashboard/settings/enterprise/#what-is-an-organization) created in RightScale to contain their information and access controls. Detailed setup information for your customers can be found below.

Since Microsoft does not provide granular cost information for subscriptions that are part of the CSP program, RightScale leverages the [utilization APIs for CSP subscriptions](https://docs.microsoft.com/en-us/partner-center/develop/get-a-customer-s-utilization-record-for-azure) and combines the usage information with the <a nocheck href="https://azure.microsoft.com/en-us/pricing/">Pay-as-you-Go pricing</a> from Azure to generate cost information for CSP subscriptions. Additional information on this method and its implications is located below.

### Limitations

At this time, there are certain limitations within the Optima product as it relates to CSP subscriptions. Other than these limitations, all functions of Optima are equivalent to Azure EA and other public clouds. These limitations are as follows:
* Recommendations are not generated for CSP subscriptions
* Only Azure Pay-As-You-Go pricing in USD is supported
* Azure Reserved Instance purchases are not shown in Optima
* Discounted usage from the use of Reserved Instances is not supported (all costs are generated at the public rate)

## Initial Setup

As a Microsoft CSP, you must first [register your CSP partnership with RightScale](/optima/getting_started/bill_connect/azure_csp.html) so that the platform can offer you the customer management capabilities associated with CSP. Once you have registered your partner information, then you can select which of your customers in CSP you would like to enable in Optima.

[Follow the CSP registration guide](/optima/getting_started/bill_connect/azure_csp.html) to register your partnership with Optima. This step needs to be performed only one time per partnership (not per CSP customer) and should be performed on the RightScale organization that is affiliated with **your company** (not your customer's).

Multiple partnerships can be registered with your organization in RightScale.

!!info*Note*Partner portal API keys are set to expire in 6 months by default. Make sure to set a reminder to rotate the key in Microsoft AND RightScale to ensure service continuity. 

## Enabling your customers in Optima

Once your partnership has been registered, you are ready to enable your customers in Optima. First you must create a RightScale organization for your customer, then you can select which customer tenant to associate with that organization. Once you have taken these steps, **all of the subscriptions** within that customer tenant will be available for cost reporting in the specified RightScale organization. Grant your customers access to the RightScale organization to provide them use of Optima on their subscriptions.

### Create an Organization for the customer

To create an organization for your customer, please email [support@rightscale.com](mailto:support@rightscale.com) with a request to create an organization (or multiple). For each organization, please specify:
1. the initial organization name (you can change this later) 
2. a user in **your** organization that you would like to be granted the initial `enterprise_manager` of the organization 

!!info*Note*When creating the organization, it is important that the initial `enterprise_manager` of the customer organization already has `enterprise_manager` in your organization. This is required to enable the customer tenant on the new organization. The privilege can be removed at a later time.

### Associate a customer tenant to a RightScale organization

Once the customer's RightScale organization has been created, you can associate the tenant from your partner portal with the organization. This action will associate **all of the subscriptions in the customer tenant** with the given RightScale organization in Optima. There will be no indication in the customer organization that their CSP data is connected -- this information is only available in your organization that has the CSP partnership registered.

Multiple customer tenants can be registered to the same RightScale organization, but please note this should only be done if those tenants represent the same "customer".

!!info*Note*If the CSP subscription was transferred into your CSP from another CSP, data will only be available from the transfer date forward.

!!info*Note*The user performing this step must have the `enterprise_manager` role in _both_ your organization as well as the customer organization.

In the Azure Partner Center dashboard, select **Customers** and press the drop-down arrow on the right to expose the `Microsoft ID` -- this is the "CSP Customer Tenant ID".

    ![csp-id](/img/arm-csp-customer-id.png)



#### UI Registration Instructions

To register this customer tenant in the Optima UI, proceed with the following steps:
1. Navigate to the "Settings" menu in Optima and select "Billing Configuration"
2. On the list of bill connections on the left, select the CSP Partnership that the customer belongs to
3. Click on the "Tenants" tab in the main panel
4. Click the "Edit Tenants" button
5. Click the "Add Tenant" button
6. Enter the customer tenant ID from the MS partner portal and use the dropdown to select the RightScale organization to associate their billing data to

    ![tenants list](/img/optima-bill-config-csp-tenants.png)

    ![add tenants](/img/optima-bill-config-csp-add-tenant.png)


Once these steps are complete, please wait up to 24 hours for data to be populated in Optima. All subscriptions will be populated with data from as far back as there is utilization for the subscription.



#### API Registration Instructions

Use the [`Create`](https://reference.rightscale.com/cost_management/#/AzureCSPCustomers/AzureCSPCustomers_create) call on the `AzureCSPCustomers` resource in the [Cost Management API](https://reference.rightscale.com/cost_management/#/index.html) with the customer tenant ID and Organization ID in the body as specified.

Once these steps are complete, please wait up to 24 hours for data to be populated in Optima. All subscriptions will be populated with data from as far back as there is utilization for the subscription.

### Grant customers access to their RightScale organization

Once you have verified that data is being populated in the RightScale organization, you can begin [inviting customer users to the organization](/cm/dashboard/settings/enterprise/#actions-and-procedures-invite-a-user-to-join-an-organization) so that they can see their cost data in Optima.

## Managing customer tenants

Once you have registered your CSP customer tenants with Optima, you can use both the UI and API to manage the configurations. 

### Using the Optima UI

To see which customer tenants you have configured and what organizations they are associated with, navigate to the "Billing Configuration" page in the "Settings" menu in **your** Optima organization. Select your CSP partnership in the list on the left and then click the "Tenants" tab in the main panel.

    ![tenants list](/img/optima-bill-config-csp-tenants.png)

This panel shows all the customer tenants that have been configured and the organizations they are associated with.

To update any information, add new tenants, or remove associations, click the "Edit Tenants" button. In the modal that appears, you can update any information or use the trash can icon to remove a tenant configuration. Clicking the "Update" button will save your changes.

    ![edit tenants](/img/optima-bill-config-csp-edit-tenants.png)

### Using the API

Using the [Cost Management API](https://reference.rightscale.com/cost_management/#/index.html), the [`AzureCSPCustomers`](https://reference.rightscale.com/cost_management/#/AzureCSPCustomers) resource represents each customer tenant that you have registered with an organization in RightScale from your CSP partnership. You can use the [`Index`](https://reference.rightscale.com/cost_management/#/AzureCSPCustomers/AzureCSPCustomers_index) action to get a list of all customer tenants that are registered with RightScale organizations and the [`Get`](https://reference.rightscale.com/cost_management/#/AzureCSPCustomers/AzureCSPCustomers_show) action to get the details for an individual customer tenant.

If you need to remove a customer's subscriptions from a RightScale organization, simply use the [`Delete`](https://reference.rightscale.com/cost_management/#/AzureCSPCustomers/AzureCSPCustomers_delete) operation on the `AzureCSPCustomers` resource in the [Cost Management API](https://reference.rightscale.com/cost_management/#/index.html)

## Generating CSP customer cost data

Once a customer has been configured, RightScale will begin generating cost information for that customer's subscriptions by combining the customer's [subscription utilization records](https://docs.microsoft.com/en-us/partner-center/develop/get-a-customer-s-utilization-record-for-azure) (which contains detailed usage information) with the <a nocheck href="https://azure.microsoft.com/en-us/pricing/">Azure Pay-as-you-Go prices</a> in **USD**. The resulting costs are shown in Optima and can be analyzed like other bill-based costs.

### Historical data generation

RightScale will generate historical data for as much data is available through the utilization records API in Azure.

### Price sheets

At this time only the Pay-As-You-Go prices in USD are supported.

### Billing periods

At this time the cost calculations in Optima use the **calendar month** as the billing period start and end. This has implications on how some of the costs are calculated and how reconciliation with the Azure bill can be done

#### Tiered costs

For some costs in Azure, "tiered" costs apply, where higher usage of a given resource within a given timeframe cause the cost to decrease in a "tiered" fashion. For example, <a nocheck href="https://azure.microsoft.com/en-us/pricing/details/storage/blobs/">storage in Azure</a> uses a tiered pricing model. 

When Optima calculates cost, it also incorporates these tiers, but the usage is calculated using the billing period in effect, which in Optima is currently only **calendar month**. This can cause some differences with the actual prices charged since the tiers in Azure apply to the billing period in effect with Azure.

### Azure Reserved Instances

At this time, Azure RIs are not supported in Optima. Neither the purchase of Azure RIs nor the discounts that they effect will be incorporated into the CSP subscription cost data.

### Reconciliation with Azure bills

In many cases, your staff may want to reconcile the data being provided to your customers via Optima with the bills provided by Azure to your organization. When performing this reconciliation, there are two primary differences that must be taken into account:
1. Optima billing periods are calendar month only, so your staff will need to use daily data from Optima and "cut" the data to whatever period is used by your organization with Microsoft.
2. Optima uses the Pay-as-you-Go pricing to generate cost information, while your bills are generated using CSP pricing.
