---
title: Connect Azure Enterprise Agreement to Optima for Cost Reporting
layout: optima_azure_layout_page
description: This page walks you through the steps to connect your Azure Enterprise Agreement to Optima for cost reporting purposes.
alias: clouds/azure/azure_connect_azure_enterprise_agreement_to_RightScale_for_cost_reporting.html
---

## Background

Optima uses **bill data** to provide an accurate view of your costs across accounts and services. This data is consumed by the Optima platform and made available for pre-built and ad-hoc analyses. In order to gather the cost information, certain configuration steps must be performed with specific data and credentials being shared with Optima.

This page describes the configuration and input information needed to connect **Azure with Enterprise Agreement** billing data to Optima.

For instructions on using Optima to add or update billing information, see [the billing information guide](index.html).
For instructions on connecting your cloud accounts to the platform for management purposes, see the [cloud account management guide](/ca/ca_getting_started.html#connecting-clouds)

If you have any questions and would like live assistance, please join us on our chat channel on [chat.rightscale.com](http://chat.rightscale.com) or email us at [support@rightscale.com](mailto:support@rightscale.com).

## Overview

This page walks you through the steps to connect your Azure Enterprise Agreement to RightScale for cost reporting purposes. If you are part of the Azure CSP program and wish to connect your partner data to RightScale for cost reporting purposes, see [Connect Azure CSP to RightScale for Cost Reporting](azure_csp.html).

Please note the **user** who creates the API Key needs to have the `Enterprise Enrollment Admin` role assigned to their user **before** creating the key.

The following steps must be completed in order for RightScale to provide insight on your Azure EA bill:
1. [Locate your Enterprise Agreement enrollment number](#locate-your-enterprise-agreement-enrollment-number)
2. [Generate an API key](#generate-an-api-key)

Each of the steps above is explained in detail on this page.

## Locate your Enterprise Agreement enrollment number

1. Start by opening a new tab and navigating to [ea.azure.com](http://ea.azure.com) and logging in.

2. The enrollment number can be found at the top right-hand side of the page, or by clicking on the **Manage** menu on the left.

    ![azure-enrollment-detail.jpg](/img/azure-enrollment-detail.jpg)

## Generate an API key

1. From the Azure EA portal and click on **Reports** from the left-hand menu. Then select "Download Usage" at the top left of the page. Then select "API Access Key" from the sub menu:

    ![azure-api-key.jpg](/img/azure-api-key.jpg)

2. Click on the Key icon to generate the API key. Note that this key is quite long, make sure you have selected the entire key, not just the visible part of the key in the Azure EA portal.

## Submit the information

Follow the [billing configuration guide](/optima/guides/billing_configuration.html) to submit the above information to Optima
