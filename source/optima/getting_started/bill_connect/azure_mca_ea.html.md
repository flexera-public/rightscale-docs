---
title: Connect Azure MCA EA to Optima for Cost Reporting
layout: optima_azure_layout_page
description: This page walks you through the steps to connect your Azure MCA Enterprise Agreement (EA) data to Optima for cost reporting
---

##Overview

Optima uses **Azure bill data** to provide an accurate view of your costs across accounts and services. This data is consumed by the Optima platform and made available for pre-built and ad-hoc analyses. In order to gather the cost information, certain configuration steps must be performed, sharing specific information and credentials with Optima.

To connect your Azure MCA Enterprise Agreement (EA) to Optima, you need to first obtain data fields from your Azure portal, and then enter those data fields into Optima.

## Data Required to Connect Azure MCA to Optima

To successfully connect Azure MCA EA to Optima, you will need to register the Azure Enterprise in Optima. To perform this registration, you must provide the following data. Continue to the next sections for instructions on obtaining the below information.

### Azure Enterprise
Required Data  						  | Data Field Name
------------------------------------  | -----------------------------
Application ID 						  | `application_id`
Application Directory ID  			  | `application_directory_id`
Application Secret Key 				  | `application_secret`
Billing Account ID            		  | `billing_account_id`

## Confirmation of Azure Migration Status

The purpose of this section is to confirm the Azure Modern Commerce migration status of your Azure enrollment. In order to be fully migrated to the Azure Modern Commerce experience, you must have accepted the Microsoft Customer Agreement (MCA) and had your "Microsoft Azure" subscriptions migrated to the new "Azure plan" subscription type.

Note: The confirmation procedure must be done by someone with the "Global Administrator" role on the Azure EA account. If you're unable to confirm any of the points below, please check with Microsoft on the status of your EA account's migration to Modern Commerce.

### Confirm Acceptance of Microsoft Customer Agreement

First, we will confirm that your organization has accepted the MCA.

1. Log in to portal.azure.com under your Azure EA account
1. On the left-hand portal menu, navigate to "Home"
1. On the "Home" page, under the "Tools" section, click "Cost Management"
1. On the "Cost Management" page, select "Go to billing account"
1. Next, select "Properties" near the bottom of the left-hand menu. If the value of "Type" shown is "Microsoft Customer Agreement", you have accepted the MCA.
1. Lastly, note down the portion of the "ID" field before the first ':' character as your **"Billing Account ID"**
Example: If the full Billing Account Name is `1bc3aca-5016-4db0-a6bc-1111fccdf72b:5efda3d-936b-4534-99cf-46b0d0a1211e_2018-09-30`, then the Billing Account ID would be `1bc3aca-5016-4db0-a6bc-1111fccdf72b`.

### Confirm Azure Plan and Billing Scopes

Next, we will confirm that you have at least one subscription with the "Azure Plan" subscription type and that you have a Billing Account billing scope available.

1. In the left-hand menu of the last screen above, select "Azure subscriptions"
1. Confirm that you have at least one subscription whose value for "Plan" is "Microsoft Azure Plan"
1. Next, in the left-hand menu click "Billing scopes"
1. Confirm that you have at least one scope whose value for "Billing scope type" is "Billing account"
1. If you could confirm both Steps 2 and 4 above, you have an Azure plan and a Modern Commerce billing account has been provisioned

## Create App Registration in Azure Active Directory

In this step, you will create an App Registration in AAD to serve as the Service Principal for Optima to call in to Azure to retrieve your organization's Modern Commerce billing data.

1. Log in to portal.azure.com under your Azure EA account
1. On the left-hand portal menu, navigate to "Azure Active Directory"
1. On the "Azure Active Directory" page, in the left-hand menu, navigate to "App registrations"
1. Click the "+ New registration" button
1. Enter a name (e.g. "Optima Billing Integration"), ensure "Single tenant" is selected, then click "Register"
1. Beside the "Application (client) ID", click the "Copy to clipboard" button and record it as your **"Application ID"**
1. Beside the "Directory (tenant) ID", click the "Copy to clipboard" button and record it as your **"Directory ID"**
1. In the left-hand menu, navigate to "Certificates & secrets"
1. Near the bottom of the page, click the "+ New client secret" button
1. Enter a name for the secret (e.g. OptimaBillingSecret) and select your preferred expiration time (Note: If you enter 1 or 2 years, after that time your secret will expire and will need to be updated in Optima to continue importing billing data)
1. Click "Add"
1. Beside the newly-created secret's "Value" field, click the "Copy to clipboard" button and record it as **"Application Secret"**. (Also, for your records, note down the "Expires" date so you know when you will need to create a new secret and update your Optima Bill Connect.)

## Add Modern Commerce Billing Access to your App Registration

The last required configuration step on the Azure side is to add the "Billing account reader" role to the app registration created previously, so that it has access to read billing data on your organization's Modern Commerce billing account.

1. Log in to portal.azure.com under your Azure EA account
1. Navigate to the following link: [Azure Cost Management - Access Control](https://portal.azure.com/#blade/Microsoft_Azure_CostManagement/Menu/access)
1. Click "+ Add"
1. In the "Role" dropdown, select "Billing account reader". If you do not see this role, you may be on a scope other than the billing account, or you may not have the required access to view the billing account scope.
1. In the "Select" textbox, enter the name of your App registration you created in Step 2 (e.g. "Optima Billing Integration")
1. You should see your App Registration appear below. Select it and click "Save". You will see your app registration appear under the "Billing Account reader" section, indicating that you have assigned the App registration the "Billing account reader" role.

You now have everything you need to create your Azure MCA Enterprise Bill Connect in Optima. Please continue on to the final step to create your Optima Bill Connect.

## Create Azure MCA Enterprise Bill Connect in Optima

In this step, you will be adding a new Cloud Bill in Optima for your Azure MCA Enterprise billing information. You'll also keep your original Azure EA Cloud Bill if you previously configured one prior to migrating to Azure Modern Commerce. This is needed for Optima to pull your billing data from before and after you were migrated to Modern Commerce billing in Azure.

**_Note: You will need the "enterprise_manager" role on your Org in Optima to add a Bill Connect._**

1. Log in to Optima under the Org where you want your Azure MCA billing data to be imported
1. In the left-hand menu, select "Settings"
1. Make sure you're on the "Billing Configuration" tab and select "Add a Cloud Bill" in the upper right
1. In the pop-up dialog, select "Microsoft Azure"
1. In the new dialog, select "MCA Enterprise" under Microsoft Customer Agreement, then "Continue"
1. Enter the four pieces of information you noted down in the previous steps in the corresponding inputs.
1. Click "Continue". If all is well, you will see a success message.

Your new Azure Modern Commerce/MCA billing data will show in Optima's UI once it has been imported and processed by our system (usually within 24 hours). In addition, your new billing data will flow into Optima under a different "Cloud Vendor" name ("Microsoft Azure (Modern Commerce)" instead of "Microsoft Azure").
