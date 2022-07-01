---
title: RightScale Organization
layout: cm_layout
alias: cm/dashboard/settings/enterprise/enterprise.html
description: RightScale organization enables larger companies to manage all of the RightScale accounts under the same umbrella.
---

## What is an Organization

In RightScale, the **Organization** (*formerly known as an Enterprise*) concept was introduced in early 2017 with the release of [Governance module](/gov/). An **Organization** is a container for users, permissions, RightScale accounts, cloud accounts, and allows customers to monitor the cloud related activity across all RightScale accounts.  All RightScale accounts belong to an organization. 

The RightScale organization allows you to:

* Aggregates RightScale and cloud accounts
* Manage Bill data from public cloud providers
* Manage security and access controls
* Implement managed SSH login
* Leverage audit trails for governance and compliance
* Chargeback and showback via Billing Centers

A typical RightScale organization:

    ![organization_example.png](/img/organization_example.png)

!!info*Note:* Master account is the very first account that gets created automatically when you join RightScale. It does not have any other specific significance but it's important to note that Master account can not be moved between RightScale organizations.

### Organization Access

The user with `enterprise_manager` role is responsible for managing all the above mentioned features and has complete control of the organization and all its accounts. The organization must have at least one `enterprise_manager` user. Enterprise Managers access organization settings in Cloud Management under **Settings** > **Organization**. They will also have access to the Governance module for IAM.

Read more about our [Governance module](/gov/) to learn more about how to manage users, groups, and roles.

!!info*Note:* You must be very careful when granting another person `enterprise_manager` role because they will have the ability to change your permissions, including removing you from the organization.

## How to setup your organization

It is really important to plan out your RightScale organizational structure before configuring your cloud setup. The following is a set of best practices recommended by RightScale based on various real world scenarios that we see. *Please don't hesitate to discuss this with our support or sales team.*

### General approach

**The general approach is to create a RightScale organization for every business entity that will be using RightScale**. In most cases, this means that each Organization maps to one *Company*. No *RightScale organization* should contain data or accounts from multiple companies. 

A payer account and all its linked *cloud accounts* should be connected to same RightScale organization.

### Scenario: Single payer account

This is the most basic scenario for a customer with payer accounts from any of the public cloud providers (AWS, Azure or Google). It gives you complete control and visibility, including creating **Billing Centers** for chargeback and showback, in the same organization.

![enterprise_single_org_single_bill_v3.png](/img/enterprise_single_org_single_bill_v3.png?s=200)

### Scenario: Multiple payer accounts

This scenario applies to large company that has multiple business units (or departments), with separate payer accounts. In this scenario, we recommend having a single RightScale Organization that contains all these payer accounts to ensure not only central management but also ability to do chargeback and showback via Billing Centers. 

![enterprise_multi_organization_multi_bill_v3.png](/img/enterprise_multi_organization_multi_bill_v3.png)

!!info*Note:* If you have a use case to connect separate payer accounts in separate RightScale organizations, you can choose to do so but please note that it creates minor management overhead (e.g.: SSO) and you will not be able to create Billing Centers across multiple organizations. 

### Scenario: Resellers (partners)

For cases where a reseller (MSP, SP etc) is managing or reselling RightScale to their clients, each client should have their own *RightScale organization*. Doing so creates a minor management overhead (e.g.: SSO), but ensures that the platform will behave as expected in most cases. 

![enterprise_msp_v3.png](/img/enterprise_msp_v3.png)

!!info*Note:* A future roadmap capability will provide features that will allow large enterprises and MSP's to manage multiple RightScale organizations seamlessly.

## Setting up an Organization

Please contact our sales team at [sales@rightscale.com](mailto:sales@rightscale.com) or by phone at **(866) 787-2253**. 

## Actions and Procedures

### Connect cloud billing accounts

[Learn about the data sources for Optima, how to connect bills for other clouds, and how to connect usage data.](/ca/ca_getting_started.html)

### Create a new Account

1. **RightScale API**: Our v1.5 API offers a [Child Accounts API](/api/api_1.5_examples/childaccounts.html) controller which can be used to create a new account within your Organization. General examples of API 1.5 use can be found in the [API 1.5 Examples Guide](/api/api_1.5_examples/index.html).
2. **Cloud Management**: You can create accounts from within Cloud Management by accessing **Settings** > **Organization** > **Account**. 
3. Contact your **Account Manager** or our **Sales team** at [sales@rightscale.com](mailto:sales@rightscale.com) or by phone at **(866) 787-2253**

### Invite a User to Join an Organization

Follow the instructions to [Invite users to RightScale](/cm/dashboard/settings/account/invite_users_to_a_rightscale_account.html)

### Manage IP Whitelists for the Organization

You can manage IP whitelists by adding, modifying, or deleting Dashboard and API IP access rules that have been created on Rightscale accounts. All account holders of an organization have the ability to create a range of IP Whitelists. This feature is beneficial if account administrators would like to enable access to RightScale through a company's IP address, essentially blocking traffic from any other IP address. For more information, see [Add an IP Whitelist Range](/cm/dashboard/settings/account/add_an_ip_whitelist_range.html).

To be able to properly manage this feature, Enterprise account managers can modify, add, or delete an IP Whitelist range that has been set from accounts of the Organization. The instructions below explain how to use this feature.

#### Prerequisites

* Requires `admin` and `enterprise_manager` user role privileges Enterprise Edition account to configure this feature. Contact your account manager or [sales@rightscale.com](mailto:sales@rightscale.com) for more details.

#### Steps

* Go to **Settings** > **Organization** > **IP**  **Whitelists**

![cm-enterprise-ip-white-list.png](/img/cm-enterprise-ip-white-list.png)

**Add a New Rule**

* To add a new IP Range, click on **New Rule**  

![cm-enterprise-whitelist-new-rule.png](/img/cm-enterprise-whitelist-new-rule.png)

* Enter in the following details:
  * **IP Range (CIDR)**: Specify the IP Range in CIDR notation to control the range of IP addresses that will be allowed access for your account. 0.0.0.0/0 (default) allows access to any IP address whereas 0.0.0.0/32 denies access to all IP addresses. If you enter a range that does not include your own IP address, you may be denied access to your account.
  * **Description (Optional)**: This is a user-defined description to help describe the purpose of the IP Range.
  * **Accounts**: A collection of one or more accounts to which the IP Whitelist will apply. Users with IP addresses outside of the whitelist range will not be able to access these accounts.

!!info*Note:* When you add an IP Whitelist Range, it will be viewable from the Access Controls tab (Settings > Account Settings > Access Controls).

**Edit an IP Whitelist Range**

When accont memebers of the Organization add an IP Whitelist Range from the **Settings** > **Account Settings** > **Access Controls** , the range will be viewable from the Enterprise IP Whitelists section. If you would like to modify this range, select the IP Whitelist Range and click **Edit** in the **Selected Item** window.  

![cm-enterprise-ip-whitelist-edit.png](/img/cm-enterprise-ip-whitelist-edit.png)

You will have the ability to modify the **IP Range (CIDR)**, **Description** , and the **Accounts** of the selected range.

**Delete an IP Whitelist Range**

Additionally, if you would like to remove this range, you can do this by selected the IP Whitelist Range, clicking **Actions**, and then **Delete**.  

![cm-enterprise-ip-whitelist-delete.png](/img/cm-enterprise-ip-whitelist-delete.png)

Once you delete an IP Whitelist Range, it will be removed from the Access Controls tab (**Settings** > **Account Settings** > **Access Controls**) of the account user that has access to view the tab.

### Update Organization name

Ensure the name of your organization is meaningful to your users. You need to have `enterprise_manager` role in order to perform this action.

#### Steps

1. Select any account in the Organization that you wish to update from the account selector.
  ![gov_find_enterprise.png](/img/gov_find_enterprise.png)
  

2. Under **Settings**, select **Organization**
  ![gov_enterprise_settings.png](/img/gov_enterprise_settings.png)
  

3. At the top, click anywhere on the **existing name** above the dotted line
  ![gov_update_org_name.png](/img/gov_update_org_name.png)
  

4. Enter new name and click OK to save
  ![gov_update_org_name_save.png](/img/gov_update_org_name_save.png)
  

5. The new name will now be displayed
  ![gov_update_org_name_display.png](/img/gov_update_org_name_display.png)

## Further Reading

* [Why am I getting a warning that cookbooks could not be found?](/faq/Why_am_I_getting_a_warning_that_cookbooks_could_not_be_found.html)
* [Using Account Tags](/ca/using_account_tags.html)