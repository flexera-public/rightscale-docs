---
title: Optima Dashboard
layout: optima_layout
description: Describes how Optima Dashboard page works
---

!!warning*Note*This page is currently under construction - for more Optima dashboard documentation, [click here](https://docs.flexera.com/Optima/Content/helplibrary/dashboards.htm#optimadashboards_2308174151_1009635).

## Overview

The Dashboard page in Optima combines all of the data from all of the billing centers that you have access to in the selected org into one view. If you have the `billing_center_viewer` role at the organization level, this means you are seeing all costs across the organization. If you have the role on one or more billing centers, the dashboard combines the cost from all of those billing centers into one page. 

### Access to Dashboard 

In order to access the Dashboard page, you must have the `billing_center_viewer` role on either the organization or at least one billing center. The data shown in Dashboard is a collection of all of the billing centers to which you have access.

### Shared Dashboards

Optima allows you to share custom dashboards within your organization. For more information, [click here](/optima/Dashboards/shared_dashboards.html)

## Optima Dashboard

The Optima Dashboard provides an overview of your monthly cloud costs across clouds, accounts and services for the selected time period in a bar chart at the top of the page. The remaining charts on the page show data from the selected bar on the top chart (this is denoted with a gray highlight behind the selected bar). 

Hover over any month on the chart to see the breakdown of costs by the selected dimension. Click on any month to change the lower charts on the page to show data for that month. The upper left of the chart shows the costs of the selected month and the prior month.

### Forecast

A forecast of current month spend is provided when "amortized" is selected in the cost type selector. Hovering over the tooltip next to the forecast in the chart key explains how the forecast is calculated, and is shown below:

> The forecast for amortized costs is calculated by using the average daily spend and projecting that amount forward for the remaining days in the month. The average spend is calculated using the last 7 days for which we have full data from the cloud providers.
