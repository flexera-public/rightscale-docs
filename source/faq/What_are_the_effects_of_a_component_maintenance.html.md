---
title: What are the effects of a component maintenance?
category: general
description: During a "component" maintenance, the RightScale Dashboard has a maintenance window when accessing the MultiCloud Marketplace or "Settings" menu.
---

## Background

During a "component" maintenance, the RightScale Dashboard has a maintenance window when accessing the MultiCloud Marketplace or "Settings" menu.

## Answer

The RightScale planned maintenance for "component" is typically between 60 and 90 minutes. Please see the estimated downtime for each incident provided in the maintenance window notification emails sent7 days in advance. Also, notifications are displayed in the Dashboard prior to the event.

The main disruption of a component maintenance is the that the gateway and library are down which will interrupt communication with clouds and configuration of cloud-based resources.

**NOTE**: Look in the RightScale email notice for the date and time of the maintenance which varies depending on your environment. If you are unsure of which environment you are in, please contact [support@rightscale.com](mailto:support@rightscale.com).

### Effects

Any action that requires the cloud endpoint will fail, but anything related to configuring RightScale's assets will continue to work uninterrupted (as long as it doesn't require a change in existing resources in the cloud). Also, any cloud resource discovery will be on hold during the maintenance. Requests will queue up for your information during the maintenance window and subsequently timeout before the maintenance window goes away, resulting in failed requests.

The following will not function during the component maintenance:

* You will **not** be able to complete cloud operations such as launch/terminate
* You will **not** be able to access the MultiCloud Marketplace to import components such as ServerTemplates, RightScriptsor MultiCloud Images
* You will **not** be able to access any RightScale Settings found under the "Settings" link in the navigation bar such as Passwords, Account Groups, Information, Plan settings, Preferences, or SSH settings

The following will continue to work during a component maintenance:

* Your instances and cloud services will all continue to function normally
* You can access and modify any assets that you have already imported into your account
* Alerts will continue to function properly
* Scheduled scripts and recipes will run on instances
* Automation between instances will continue to function properly
* Cloud Workfloworchestration will continue to function properly

If you have any questions, please feel free to contact support via the Dashboard or by emailing [support@rightscale.com](mailto:support@rightscale.com). Support staff will be available and monitoring requests during and after planned maintenance windows in case there are any issues that might affect you.

### See also

This is a FAQ for "component" maintenance. For "regular" planned maintenance, see [What are the effects of a regular planned maintenance?](http://support.rightscale.com/06-FAQs/FAQ_0104_-_What_are_the_effects_of_RightScale_Planned_Maintenance%3F/index.html)
