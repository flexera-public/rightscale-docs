---
title: Optima Controls
layout: optima_layout
description: Describes the common controls across Optima
---

## Overview

In Optima, there are many controls that are common across different pages -- this page describes the common controls that you will find in many pages throughout Optima.

## Common controls

### Organization selector

!!info*Note*If you have access to only one organization, this control will not be visible (this is very common)

### Left-hand navigation

The left-hand navigation provides one-click access to the top-level capabilities within Optima. Access to individual pages within the navigation are sometimes gated by certain roles or access to certain datasets.

The left-hand navigation menu can be collapsed/expanded using the "handle" control at the top-left of the screen.

### Product selector

!!info*Note*This control may be hidden if you have access only to Optima capabilities

The product selector allows you to quickly navigate to other parts of the RightScale product, including Self-Service, Cloud Management, and Governance.

### User configuration

The user menu allows you to configure your user properties (including changing your password), get quick access to support and documentation, and logout of the platform.

### Give feedback

In the lower-left of Optima is an option to Give Feedback to the Optima team. This is a **hugely beneficial capability** for you and the Optima team - please use it freely to report issues, share ideas, ask questions, or just say hi.

### Date selector

Many of the Optima pages contain a date selector which changes the time range to which the data on the current page applies. Click on the date selector to open the picker. Some pages allow the granularity of data to be selected between "Monthly", "Quarterly", and "Biannually". Other pages only support "Month" granularity but allow you to pick the time range from which to show data. A convenient list of common selections is provided on the right and can be set with a single click.

Once the data selector has been set, its configuration is saved as you navigate across other pages.

### Cost type selector

Many pages offer the choice to view different cost types based on your use case. These options currently focus on amortizing one-time costs and on showing the AWS Reserved Instance blended costs. On any page with the cost type option, your selection will be reflected in the cost data on that page. On any page that doesn't have the option, the costs shown are **blended, non-amortized**.

#### Cost amortization

Amortizing costs is defined as taking one-time costs and "spreading" the cost out over the lifetime of the purchase. If such a cost were shown "non-amortized", then the full cost of that item is attributed to the time of the purchase. If a cost were "amortized", then the cost would be divided into all of the hours of the duration of the cost and shown in each hour.

The simplest example of such a cost would be an up-front purchase of a Reserved Instance. Let's assume we purchase a 1-yr Reserved Instance from AWS on January 5, 2018 at 3:00pm and it cost us $15,000. Here is how that purchase will be shown under both scenarios:

- **non-amortized** - the full $15,000 shows in cost data on Jan 5, 2018
- **amortized** - the full cost is divided by number of hours in the lifespan of the item (there are 8,760 hours in a year) and the result is attributed to each hour in the lifespan. In this case, we would see a $1.71 charge on every single hour between Jan 5 2018 3:00pm and Jan 5, 2019 2:00pm.

#### Cost blending

!!info*Note*Cost blending only applies to AWS costs

Cost blending is a cost reporting approach that is used by AWS that spreads the discounts from Reserved Instances over all applicable instances. In Optima, you can choose whether to see costs that are blended or unblended.

To learn more about cost blending in AWS, [see their documentation](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/con-bill-blended-rates.html#Blended_CB).

### Dimension selector

On pages with a dimension selector, it is used to break down the costs on the given page. In some pages there is only the option to choose from while other pages allow multiple dimensions to be selected. The selected dimension is used to break down the costs in some graphs on the page.


