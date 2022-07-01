---
title: Bill Adjustments
layout: optima_layout
description: Optima allows you to apply adjustments to your bill via our bill adjustments API.
---

## Overview

Flexera allows for flexible bill adjustments based on customizable rules, for Optima has the ability define adjustments by a variety of dimensions. <b>Different markup/markdowns can be assigned to:</b>
* Vendor
* Billing center
* Region
* Service
* Resource type
* Line item type

### Viewing Applied Bill Adjustments

There are various ways to see applied bill adjustments in Optima.

#### Adjustments Interface

To view adjustments, you must (1) have bill adjustments in place and (2) have the `enterprise_manager` role. For assistance with your bill adjustments, or to apply new adjustments, please contact your account management team or cost optimization service representative.

![bill_adjust_ui.gif](/img/bill_adjust_ui.gif)


#### Tabular View

To view applied bill adjustments in tabular view:

1. After logging into Optima, navigate to the <b>Billing</b> tab
2. Click on the <b>Tabular View</b> tab
3. To select your <b>Adjustment</b> dimension, click on the `+` next to the <b>Group by:</b> header. Available <b>Adjustment</b> dimensions include:
 * Adjustment Cost Multiplier
 * Adjustment Rule Name
 * Adjustment Rule Label
 * Adjustment Usage Multiplier

![bill_adjustment_overview.png](/img/bill_adjustment_overview.png)

<br>
!!warning*Note*To view adjustments by billing center, select the billing center you wish to view adjustments within follow the same instructions above. 

### Editing Existing Adjustments

Existing bill adjustments can be edited within the Optima UI via the Adjustments interface, by percentage. To edit adjustments, you must have the `enterprise_manager` role.

![bill_adjust_edit.png](/img/bill_adjust_edit.png)

### Bill Adjustment Visibility

Adjustment dimensions are typically only visible to users with the `enterprise_manager` role.

But these dimensions could also be made visible to _all_ users of the org, if that is preferred.

### Sample Use Cases

#### Currency Conversion

#### Markup/Markdown

#### Line Item Elimination 

You can effectively remove costs such as fees or taxes by adding an adjustment that negates the cost.
For example:
```
"Cost Elimination" Adjustment:

    Rules:
    1. // Refunds
       IF line_item_type == "Refund"
       THEN cost_multiplier = -100%        
```
Equivalent JSON:
```json
{
  "dated_adjustment_lists": [
    {
      "effective_at": "2020-01",
      "adjustment_list": [
        {
          "name": "Cost Elimination",
          "rules": [
            {
              "condition": {
                "type": "dimension_equals",
                "dimension": "line_item_type",
                "value": "Refund"
              },
              "cost_multiplier": -1,
              "label": "Refunds"
            }
          ]
        }
      ]
    }
  ]
}
```
!!warning*Note*Any subsequent adjustments should probably "build on" this Cost Elimination adjustment, to prevent markups from being applied to these removed costs.

#### Pricing Adjustment

<br>
!!danger*To discuss bill adjustments, configure bill adjustments, or set bill adjustment visibility preferences, please contact your Cost Optimization Service representative*

