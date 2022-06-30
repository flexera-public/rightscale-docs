---
title: Chargeback and Showback Reporting
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

## Overview

RightScale Optima can be used to perform chargeback and showback reporting on all clouds supported by RightScale, including private clouds. You can also use [markups and markdowns](/ca/ca_cloud_markups_markdowns.html) to adjust the costs shown from the standard public cloud pricing levels before reporting.

This document will show you how to:

1. Structure your accounts
2. Set up private cloud prices
3. Allocate costs with tagging
4. Apply markups or discounts to the standard public cloud prices
5. Export the adjusted costs for reporting.

## Structuring your Accounts for Chargeback and Showback

In order to ensure you can chargeback or showback costs accurately, [create separate RightScale accounts](/cm/administrators_guide/user_and_account_management.html) for each department or business unit you want to report costs to.

The below diagram shows a typical RightScale enterprise account setup. There is a master account, and three child accounts for different development teams. Each of the child accounts has access to its own cloud accounts, using its own cloud credentials. The RightScale child accounts are tagged with their department and their location.

![ca-chargeback-diagram.png](/img/ca-chargeback-diagram.png)

## Setting Private Cloud Instance Prices

To report on private cloud costs in Optima, the private cloud needs to be connected to RightScale, and the private cloud instance types need to have prices assigned. See [Register a Private Cloud with RightScale](/cm/dashboard/settings/account/register_a_private_cloud_with_rightscale.html) for information on connecting your private cloud in Cloud Management.

Once the private cloud is registered, Optima will use the prices set in Cloud Management to calculate the cost of all private cloud instances. To set the costs for each instance type on your private cloud, follow the instructions at [Set Instance Type Prices](/cm/dashboard/clouds/generic/instance_types_actions.html#set-instance-type-prices).

Public clouds connected to RightScale will show costs based on the publicly available prices. To apply any custom discounts or markups, see the [Adjusting Costs with Markups and Markdowns](/ca/ca_chargeback_and_showback_reporting.html#adjusting-costs-with-markups-and-markdowns) section.

## Allocating Costs with Tagging

Once all of your cloud accounts are connected to RightScale accounts and you have set up prices for private clouds, you can allocate costs to individual departments or business units.

In order to allocate all cloud costs (compute, storage, network and other services) you will use the Optima Dashboard. On the [Dashboard](/ca/ca_user_interface_dashboard.html), all costs are grouped by account. These accounts can be grouped further by [using Account tags](/ca/using_account_tags.html). All account tags will be shown in the CSV export from the Dashboard, along with the costs of each product and product category.

The Instant [Analyzer](/ca/ca_analyzing_costs.html) provides more granular filtering and reporting of compute costs. Here you can use [instance and deployment tags](/cm/rs101/tagging.html) to drill down and view instance costs within a single RightScale account.

## Exporting the Adjusted Costs

From the Optima Dashboard, click **Export to CSV**. This will download a CSV of all the data on the page, along with any account tags applied to the accounts you have access to, to help with further analysis in a spreadsheet.

If you also need to export more detailed instance costs, go to the Instant Analyzer, click **Full instance details** at the top, and then **Export to CSV**. The CSV will contain all of the columns on the page, as well as tag columns for all tags used in your Instant Analyzer filters.
