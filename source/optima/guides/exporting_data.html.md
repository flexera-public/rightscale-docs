---
title: Exporting data from Optima
layout: optima_layout
description: Describes data from Optima can be exported in various formats
---

## Overview

This page describes how to export data from Optima. Depending on your level of permission and what data you want exported, there are various options available.

## Monthly CSV reports

Monthly CSV reports are available for any user with organization-wide access to Optima -- reports are not yet available on a per-billing center level basis. For users with sufficient privileges, simply navigate to the top-level Billing page for the organization and select `Monthly Reports`. The page lists all available monthly reports along with the date at which they were most recently generated.

By default, Optima ensures that the current and prior month CSV reports are updated on a regular basis. Prior months can be re-generated on-demand by [contacting support](mailto:support@rightscale.com).

The CSV reports provide a "resource-level view" of the information - each row in the report corresponds to a unique resource and the cost for the resource is the total cost for the month. Note that some resources in cloud bills do not have a resource ID -- such resources have a `null` value for resource ID and are grouped together in the monthly report.

The CSV reports also provide some data points that are not available elsewhere, including resource IDs and Azure Resource Group information.

The "billing_center" field contains a top-down list of the billing center hierarchy that the cost is allocated to. Each level in the hierarchy is separated by a "pipe" `|` character.

## Tabular view exports

When using **Tabular View** to browse and interact with your cost information, the `Export` button on the upper-right hand side of the table will allow you to export the current content in the table to either CSV or to Excel. When using this method, the current group selections **and** filters apply to the data exported.

!!info*Tip*If you consume data in non-US formatted currencies, the Excel export provides a better experience.