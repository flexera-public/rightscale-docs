---
title: Connect Azure MCA CSP to Optima for Cost Reporting
layout: optima_azure_layout_page
description: This page walks you through the steps to connect your Azure MCA Cloud Solution Provider (CSP) data to Optima for cost reporting
---

##Overview

Optima uses **bill data** to provide an accurate view of your costs across accounts and services. This data is consumed by the Optima platform and made available for pre-built and ad-hoc analyses. In order to gather the cost information, certain configuration steps must be performed with specific data and credentials being shared with Optima.

To connect the Azure MCA Cloud Solution Provider to Optima, you need to first obtain data fields from Azure, and then enter those data fields into Optima.

##Data Required to Connect Azure MCA to Optima

To successfully connect Azure MCA CSP to Optima, you will need to first register the Azure MCA Partner in Optima, and then register customer(s). To perform these registrations, you must first obtain the following data:

### Azure MCA Partner
Required Data  						  | Data Field Name
------------------------------------  | -----------------------------
Application ID 						  | `application_id`
Application Directory ID  			  | `application_directory_id`
Application Secret Key 				  | `application_secret`
Billing Account ID            		  | `billing_account_id`
Microsoft Partner Network ID (MPN ID) | `mpn_id`

### Customer
Required Data   | Data Field Name
-------------   | -------------
Azure Tenant ID | `customer_tenant_id`

## Obtaining Required Data

To obtain the required application data fields from Azure, perform the following steps:
1.	Open the Microsoft Partner Center: https://partner.microsoft.com/en-us/pcv/apiintegration/appmanagement
2.	In the top right corner, click the gear icon then select Azure AD profile.
3.	Under Account Settings, select App management.
4.	Select your desired Web App, and locate and copy the following information:

Data Field  						  | Location
------------------------------------  | -----------------------------
Application ID 						  | Listed under the new native app in the <b>App ID</b> field.
Application Directory ID  			  | Listed in the <b>Account ID</b> field.
Application Secret Key 				  | Listed below, as a key.<br><br><i>NOTE: The application secret keys are like passwords with longer expiry. We recommend saving this in a secure location for future use.</i>

###Application Data Fields and Assigning Application Permissions

To assign application permissions in Azure, perform the following steps.

1.	Open your [Microsoft Azure MCA portal](https://portal.azure.com/#blade/Microsoft_Azure_CostManagement/Menu/access)

!!warning*NOTE*If this link does not work, you may want to check with your cloud administrator that you have a Microsoft Partner Agreement in place.

2.	Click <b>+ Add</b>. The <b>Add Permission</b> panel opens.
3.	In the <b>Select</b> box, enter the name of your application from before.
4.	Select the name of your application, and in the <b>Role</b> box select <b>Billing account reader</b>.
5.	Click <b>Save</b>.

###Billing Account ID

To obtain the <b>Billing Account ID</b> from Azure, perform the following steps.

!!warning*IMPORTANT NOTES*This information is hard to find. You need to make sure that you are logged in to Azure as an admin to the partner account. If you are using the old Azure UI, you may need to switch to the new Azure UI.<br><br>There are two cost management views: one in Azure Services and one in the Tools section. Make sure that you are in the Tools section.

1.	Open the following [Microsoft Azure URL](https://portal.azure.com/#home)

2.	In the <b>Cost Management</b> panel, navigate to <b>Go to billing account</b>.

3.	Click <b>Settings > Properties</b>. On this page, the <b>Billing Account ID</b> can be found in the <b>Billing Account Name</b> field. The <b>Billing Account ID</b> is the first part of the <b>Billing Account Name</b> (everything before the first semicolon).

#### Example

If the full <b>Billing Account Name</b> is `1bc3aca-5016-4db0-a6bc-1111fccdf72b:5efda3d-936b-4534-99cf-46b0d0a1211e_2018-09-30`, then the <b>Billing Account ID</b> is `1bc3aca-5016-4db0-a6bc-1111fccdf72b`.

!!warning*NOTE*If the Billing Account Name field is empty, the Microsoft Partner Agreement may still need to be signed.

### MPN ID

To obtain the MPN ID from Azure, perform the following steps.

1.	Open this [Microsoft Azure URL](https://partner.microsoft.com/en-us/pcv/accountsettings/partnerprofile)

2.	Copy the <b>MPN ID</b> from the right side of the page.

### Customer Tenant ID

To obtain the Customer Tenant ID from Azure, perform the following steps.

1.	Open this [Microsoft Azure URL](https://partner.microsoft.com/commerce/customers/list)
2.	Navigate to the desired customer and then to the <b>Account</b> section for the customer.
3.	Locate and copy the ID in the <b>Customer account info > Microsoft ID</b> field; this is the needed <b>Customer Tenant ID</b>.

## Connecting Azure MCA Cloud Solution Provider in Optima

To connect Azure MCA Cloud Solution Provider in Optima, perform the following steps.

1.	Open Optima.
2.	Open the Settings view and click <b>ADD A CLOUD BILL</b> in the upper right corner.
3.	Choose Microsoft Azure.
4.	Choose MCA Partner (under the Microsoft Customer Agreement heading).
5.	On this view, enter the following information, which you obtained in Obtaining the Required Data Fields from Azure:
 * Application ID
 * Directory ID
 * Application Secret Key
 * Billing Account ID
 * Microsoft Partner Network ID
 * Insert Azure Tenant ID(s)
6.	Click <b>CONTINUE</b> to connect.
