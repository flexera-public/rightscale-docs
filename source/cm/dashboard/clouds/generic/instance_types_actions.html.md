---
title: Instance Types - Actions
description: In the RightScale Cloud Management Dashboard you can set your own pricing on Instance Types for Private Clouds.
---

## Set Instance Type Prices

Private Clouds now have the ability to set their own pricing on Instance Types. For example, you can change the associated cost of a large instance type from a dime to .12/hour from the RightScale Dashboard. Use the following procedure to set your own pricing on your Private Cloud.

### Prerequisites

* 'admin' user permissions in the RightScale account to which the private cloud is registered. Any user with 'admin' user permissions can set pricing information for Instance Types in private clouds.

### Steps

* Navigate to **Clouds** > *CloudName* > **Instance Types**. The current Name, Estimated Pricing, Resource UID for the Instance Types, etc. are all displayed.
* Select the **Change Pricing** action button. The current prices are displayed with editable fields.

!!info*Note:* Only the user that connected the cloud can see a "Change Pricing" action button and change the pricing scheme.

* Set or modify the pricing per hour fields as needed. For example, you could set:
 * Small Instance Type to .08/hour
 * Medium to .10/hour
 * Large to .12/hour
* Click the **Save** action button when ready
