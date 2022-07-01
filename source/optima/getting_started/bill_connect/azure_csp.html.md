---
title: Connect Azure CSP to Optima for Cost Reporting
layout: optima_azure_layout_page
description: This page walks you through the steps to connect your Azure Cloud Solution Provider (CSP) data to Optima for cost reporting
alias: clouds/azure_resource_manager/azure_connect_azure_csp_for_cost_reporting.html
---

## Background

Optima uses **bill data** to provide an accurate view of your costs across accounts and services. This data is consumed by the Optima platform and made available for pre-built and ad-hoc analyses. In order to gather the cost information, certain configuration steps must be performed with specific data and credentials being shared with Optima.

If your organization is a Microsoft Azure Cloud Solution Provider (CSP), Optima can generate cost information for your customer subscriptions that they can leverage in the platform. For details on how cost information is generated, including limitations, [see the CSP partner guide](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html).

This page describes how to connect your Azure CSP partnership to Optima, which is the first requisite step to generating and showing back your customer cost information.

For instructions on using Optima to add or update billing information, see [the billing information guide](index.html).
For instructions on connecting your cloud accounts to the platform for management purposes, see the [cloud account management guide](/ca/ca_getting_started.html#connecting-clouds)

If you have any questions and would like live assistance, please join us on our chat channel on [chat.rightscale.com](http://chat.rightscale.com) or email us at [support@rightscale.com](mailto:support@rightscale.com).

## Overview

This page walks you through the steps to connect your Azure CSP partner data to RightScale for cost reporting purposes. If you are not part of the Azure CSP program, these instructions are not relevant; instead, see [Azure Enterprise Agreement](azure_ea.html) for connecting your Microsoft EA.

In order for Optima to generate cost information for your customers, you must provide your CSP Partner information. This information allows the Optima platform to call the Microsoft Azure CSP Partner API on your behalf in order to get information about your CSP customers and their detailed subscription usage information.

The following steps must be completed in order for RightScale to provide insight on your Azure EA bill:
1. [Locate your Microsoft Partner Network ID (MPN ID)](#locate-your-microsoft-partner-network-id--mpn-id-)
2. [Create the CSP Web App](#create-the-csp-web-app)
3. [Generate a key for the Web App](#generate-a-key-for-the-web-app)

Each of the steps above is explained in detail on this page.

## Locate your Microsoft Partner Network ID (MPN ID)

Use the Microsoft Azure Partner Center or other means to obtain your MPN ID, which you will need in future steps.

To find your MPN ID in the Partner Center navigate to the [Partner Profile page](https://partner.microsoft.com/en-us/pcv/accountsettings/partnerprofile) and the MPN ID is listed on the right side of the page.

    ![partner-id](/img/arm-csp-partnerid.png)

## Locate your default domain

Use the Microsoft Azure Partner Center or other means to obtain your partner domain, which you will need in future steps.

To find your domain in the Partner Center, navigate to the [Organization Profile page](https://partner.microsoft.com/en-us/pcv/accountsettings/organizationprofile) and the `Default domain` is displayed.

    ![domain](/img/arm-csp-domain.png)

## Create the CSP Web App

!!warning*Note*The user performing these steps must be a `Global Admin` on the CSP Tenant

1. Log in to the Microsoft Azure Partner Center and navigate to the Dashboard. [Azure Partner Center](https://partnercenter.microsoft.com/en-us/pcv/apiintegration/appmanagement)

2. Click on the **Settings** icon in the upper-right and select **Partner Settings**.

2. Click on **App Management** on the left.

3. The RightScale CSP integration uses the **Web App** on this page. Azure limits each partner tenant to only one web app. If needed, **Register** a Web App (if you already have one that is active, this is not needed).

4. Note the **Application ID**, which will be required in following steps.

    ![partner-portal](/img/arm-csp-partner-portal.png)

## Generate a Key for the Web App

1. Navigate to the Azure Resource Manager portal using the same login and ensure you are in the CSP tenant. [Azure Portal](https://portal.azure.com)

2. Go to the **Azure Active Directory** and select ["App Registrations" blade](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ApplicationsListBlade)

3. Find the Web App in the list matching the partner center web app by Application ID (step 4 above) and select it.

    ![appreg](/img/arm-csp-appregistrations.png)

4. Select **Keys** under **API Access**

5. Add a new key by filling out the **Key Description**, select **Never expires**, and then hit **Save**. Note: if you would prefer to set an expiration date, that is acceptable as well, but please note that **you** are responsible for ensuring that a new key is generated and provided to RightScale before the key expires. Failure to do so will result in incorrect data for your customers.

6. Copy the key **Value** and save it for submittal to RightScale.

    ![key](/img/arm-csp-key.png)


## Submit the information

Follow the [billing configuration guide](/optima/guides/billing_configuration.html) to submit the above information to Optima

## Next steps

Once your partner information has been provided to Optima, you are now ready to [configure your CSP customers](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html).
