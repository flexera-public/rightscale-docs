---
title: Register an Azure Resource Manager (ARM) account with RightScale
layout: azure_resource_manager_layout_page
description: Describes the process for registering an Azure Resource Manager (ARM) account with the RightScale platform.
---

!!warning** This registration method does not support personal accounts (gmail.com, live.com, hotmail.com) with ARM. You must authenticate with a corporate email, connected with your Azure AD Tenant. To use a personal account, [connect to Azure Resource Manager using your own Active Directory Application](register_using_ad_application.html).

## Overview

This page walks you through the steps to connect your Azure Resource Manager account with RightScale for management purposes using a RightScale-owned Service Principal. This approach is simple and puts the responsibility for key rotation with RightScale, but it also limits the control that you have on the privileges granted to the Service Principal. An alternative method to connecting for management purposes is to [connect to Azure Resource Manager using your own Active Directory Application](register_using_ad_application.html).

If you are part of the Azure CSP program and wish to connect your partner data to Optima for cost reporting purposes, see [Connect Azure CSP to Optima for Cost Reporting](/clouds/azure_resource_manager/getting_started/managing_csp_partnerships_and_customers.html).

If you wish to connect your Azure Enterprise Agreement to Optima for cost reporting purposes, see [Connect Azure Enterprise Agreement to Optima for Cost Reporting](/clouds/azure/azure_connect_azure_enterprise_agreement_to_RightScale_for_cost_reporting.html).

## Prerequisites

1. You must have a Azure Resource Manager subscription to register with RightScale
2. You must be `admin` or `enterprise_manager` on the RightScale account
3. For the initial creation of the "RightScale" Service Principal, the Azure AD user being used to register with RightScale must be a __Member__ of the Active Directory Tenant containing the subscription (not a __Guest__) and have the rights to create Enterprise Applications. [By default, __Members__ of the tenant have this ability, but that right can be revoked.](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-how-applications-are-added#who-has-permission-to-add-applications-to-my-azure-ad-instance)
4. The Azure AD user being used to register the Subscription with RightScale must have the __Owner__ role on the Subscription. If you temporarily add permissions to a user to complete registration, you may revoke those permissions after the subscription is registered, as RightScale will only use the "RightScale" Service Principal for authentication.

!!info** Alternatively, you can create [connect to Azure Resource Manager using your own Active Directory Application](register_using_ad_application.html).

## Steps

### Connect to the Cloud

1. After logging into the Dashboard, go to **Settings** > **Account Settings** > **Clouds.** Click **Connect to a Cloud.**

2. Next, click the (+) icon next to Microsoft Azure Resource Manager.

    ![arm-connect-to-public-clouds.png](/img/arm-connect-to-public-clouds.png)

3. You will be taken to Microsoft Azure to complete the oauth authorization process. Click on **Accept** when prompted to give RightScale access.

    ![arm-rightscale-needs-permission-to-access-your-azure-service.png](/img/arm-rightscale-needs-permission-to-access-your-azure-service.png)
4. Select the target subscription from a list of available Azure Subscriptions to register.

    ![arm_Connect_RightScale_with_your_Azure_Active_Directory.jpg](/img/arm_Connect_RightScale_with_your_Azure_Active_Directory.jpg)
5. Next, you should see a `successfully registered with clouds` notification on the top bar.

    ![arm-successfully-registered-with-clouds.png](/img/arm-successfully-registered-with-clouds.png)

!!info*Note* If the Azure account that you use to authenticate belongs to multiple AD tenants, select the tenant ID that contains the subscription you would like to register first.
!!info*Note* If there are no subscriptions available we will present the following error:
![arm_multiple_tenants_no_subscription_available.jpg](/img/arm_multiple_tenants_no_subscription_available.jpg)

### Check the Cloud Status

On the same **Clouds** tab or on the **Cloud Credentials** widget in the **Overview** tab, you may check the status of your cloud. Both of these items must be valid and active (green) in order to successfully launch cloud servers:
On the Dashboard, go to  **Settings** > **Account Settings** > **Clouds**.  You should be able to view all the Azure Resource Manager Regions

  ![arm-view-all-arm-regions.png](/img/arm-view-all-arm-regions.png)

Once your cloud credentials have been verified, you will see that the Microsoft Azure Resource Manager cloud is enabled under the Clouds tab. You will now see all of your Microsoft Azure Resource Manager resources under the Clouds menu (Clouds _>_ AzureRM). You may need to refresh the tab to view your newly added Azure Resource Manager cloud.

### Adding Newly Supported Regions

As RightScale adds support for additional ARM Regions, complete the steps below to view them in RightScale for your ARM subscriptions that have been previously registered.
!!info*Note*You can only add regions using the same already-registered subscription.
1. Complete the standard [ARM registration steps](/clouds/azure_resource_manager/getting_started/register.html#connect-microsoft-azure-resource-manager-to-your-rightscale-account-connect-to-the-cloud)

## The RightScale-Azure Integration

RightScale uses the Azure "Service Principal" approach to getting permissions to operate on your subscription, which is the recommended best practice as published by Microsoft.

In short, the RightScale "web application" is added to Azure Active Directory (AD) associated with the registered subscription. Then the RightScale application service principal (which shows up as a "user") is granted the "Contributor" role to the subscriptions within that AD. The service principal is then used by RightScale to authenticate and make requests on your behalf. RightScale **does not** store any user credentials for this access in the platform. You can read more about this approach on [the Microsoft Azure docs](https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-application-objects).

The registration process above performs the following tasks:
1. Adds the RightScale web application to the Azure AD (if it is not already added)
2. Adds the "RightScale" application service principal ("user") to the specified subscription with the "Contributor" role
3. Informs RightScale which subscription to use for this RightScale account

Each of the above steps is explained in more detail below.

### Add the RightScale web app to Azure AD

In order for the "RightScale" service principal to be granted permissions on a subscription, the RightScale web application must first be added to Azure AD. Today, there is no way to add this application directly via the Azure Portal -- note that there **is** a RightScale application listed in the marketplace, but that application is used for SSO, not for cloud management integration.

The only way to add this today is to go through the cloud registration process through RightScale as specified above.

The ARM user performing this step must be a member of the Active Directory Tenant containing the subscription (not a guest).

**After registration, the only permission that the "RightScale" Service Principal will have on the Azure AD tenant is "Sign-in and read user profile".**

  ![arm-ad-application-arm-portal.png](/img/arm-ad-application-arm-portal.png)

### Grant RightScale permission to a subscription

In order for RightScale to be able to manage cloud resources, it must have permissions granted on the Subscriptions in Azure. The RightScale cloud registration process will automatically add the "RightScale" service principal to the specified subscription with the **Contributor** role -- this is the required role for RightScale to have in order to perform cloud management on Azure.

While this permission can be manually granted in AD, the RightScale cloud registration steps must still be followed in order to associate the RightScale account with the correct subscription.

The user performing this action must have the **Owner** role on the Subscription.

**After registration, the "RightScale" Service Principal will have Contributor access on the Subscription.**

!!info*Note*Removing the "RightScale" service principal's access from the subscription using the Azure Portal will prevent RightScale from acting on this subscription. The behavior in RightScale at this point will be undefined -- it will not be able to modify or read any information from the subscription.

  ![arm-subscription-users2.png](/img/arm-subscription-users2.png)


### Grant RightScale read access to a subscription

In order to provide RightScale read access to a subscription, you need to first follow the steps under [Connect Microsoft Azure Resource Manager to your RightScale Account](/clouds/azure_resource_manager/getting_started/register.html#connect-microsoft-azure-resource-manager-to-your-rightscale-account).

Once the AzureRM subscription has successfully been registered to the RightScale account, you can then restrict its access by following these steps:
1. Go to the "Subscriptions" blade in the AzureRM Portal.
1. Select the Subscription you would like to modify access for.
1. Go to "Access Control (IAM)"
1. Find the "RightScale" user and remove it.
1. Re-add the "RightScale" user by selecting "Add", choose "Reader" for the role, and find the "RightScale" application user in the directory.
1. Save your changes.

!!info*Note*Changing the "RightScale" service principal's access to "Reader" will still allow RightScale to discover resources. Although actions will still be available from RightScale, they will fail if you try to use them.
