---
title: Automated Optimization
layout: optima_layout
description: Optima allows you to optimize cloud cost with a variety of automated optimization capabilities. These features identify savings opportunities, as well as help you set up automated actions to realize potential savings and prevent future waste.
---

## Overview

Optima allows you to optimize cloud cost with a variety of automated optimization capabilities. These features identify savings opportunities, as well as help you set up automated actions to realize potential savings and prevent future waste.


## Instance Rightsizing

Cloud providers charge you for all active Compute Instances, regardless of whether you are using the full Central Processing Unit (CPU) and memory capacity. Each underutilized instance may be costing you 50-75% in wasted cost. The Instance Rightsizing feature assesses utilization metrics to identify any instances that could be downsized, and with your approval, will take the action of switching over to a smaller instance size.

### Configure the Instance Rightsizing Policy

1. From the <b>Policies</b> screen, select the appropriate policy and click <b>Apply</b>.
2. Select the options to configure the policy. Our policy catalog includes solutions for both downsizing and upsizing across multiple cloud vendors.

### Define the Scope of the Instances to Include

Determine which resources to evaluate for underutilization.

* To define scope using <b>Select Accounts</b>: Specify the list of accounts to evaluate. For example, you may wish to limit the rightsizing to non-production accounts or to any subset of accounts.
* To define scope using <b>Tag filtering</b>: Limit the scope within the selected accounts by specifying tags. For example, if your production and non-production resources are mixed in your cloud accounts, you can leverage this tag-based filtering functionality to limit the rightsize action based on an environment tag. Instances can also be tagged with a rightsize-related tag key to mark whether they have been selected as suitable for rightsizing.

### Define the Thresholds for Rightsizing

Having defined a scope, you’ll need to set percent thresholds to allow for downsize or upsize depending on which policy you have selected. You can assess both memory and CPU metrics to determine suitability, and you are able to set separate thresholds for both average and maximum utilization.

Maximum utilization will be affected directly by any spikes in CPU or memory usage. For example, CPU usage can spike during recurring weekly scans or nightly backups. In some cases these types of activities are not materially impacted if the CPU size is lower. If you are concerned about provisioning capacity to accommodate these short-lived spikes, set a high maximum free memory percent. If you are not concerned by slowed performance during periodic activity spikes, reduce the maximum percent threshold.

Depending on whether memory capacity is more critical to your applications than CPU or vice versa, you will need to set different CPU and memory thresholds.

For the majority of compute instances, a single downsize will reduce the instance’s capacity by half. Accordingly, in standard downsize cases you should select a number below 50 for the average percent to allow for downsize. For example, if you set the threshold to 40 percent, the utilization would still remain under 80 percent once downsizing has occurred.

How far you set this number below 50 will define a more or less conservative capacity buffer in the event that future usage patterns depart from the historical trend. To disregard any of the four thresholds for downsize, enter a value of -1. A blank field will be recorded as a value of 0.

For upsizing, you will configure thresholds according to the same logic to determine when to give an instance higher capacity by upsizing.

### Define the Instance Rightsizing Actions to Take

To define the Instance Rightsizing actions to take, perform the following actions:

* <b>Configure users to be notified</b>: Specify the list of recipients who should receive notifications about rightsizing. Add as many recipients as you like to the <b>Email addresses of the recipients you wish to notify</b> field. They do not need to be registered as Optima users.
* <b>Configure automated actions for the policy</b>: Specify whether you want the recipients to receive an emailed report of downsize recommendations with no automated action, or send the report as well as taking automated action to downsize instances that meet the previously defined criteria.

### Configure the General Instance Rightsizing Policy Options

To configure the general Instance Rightsizing Policy options:

Set the following standard policy configuration options when the Instance Rightsizing Policy is applied.

* <b>Frequency for policy to run</b>: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* <b>Fully automated vs approval required</b>: Specify at the time it is applied whether the policy will take action after user approval versus automatically without user intervention. For details, see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

### Customize the Instance Rightsizing Policy

Policy designers can customize the Instance Rightsizing Policy definition in several ways:

* <b>Change the observation period:</b> By default, this policy calculates utilization over a 30-day period. To calculate over a different period of time, you can update the policy template. More information on this is available in the readme.
* <b>Change the script to draw monitoring data for rightsizing from different monitoring tools:</b> Samples are provided for tools including Cloudwatch (AWS), Stackdriver (GCE), LogAnalytics (Azure), and Datadog in the public GitHub repository.
* <b>Adjust the logic that generates the recommendations to incorporate a risk profile defined by percentiles.</b>
* <b>Customize the mapping for larger and smaller instance sizes:</b> This optimization action works on a default set of standard larger and smaller instance size mappings. These can be modified in cases where users wish to take specialized factors into account, such as storage drivers, network drivers, 32/64 bit architecture, or non-standard instance mappings. The files containing predefined instance mappings for each cloud vendor can be accessed via the links below:
  * [AWS Instance Size Relationship Mapping](https://github.com/flexera/policy_templates/blob/master/data/aws/instance_types.json)
  * [Azure Instance Size Relationship Mapping](https://github.com/flexera/policy_templates/blob/master/data/azure/instance_types.json)
  * [Google Instance Size Relationship Mapping](https://github.com/flexera/policy_templates/blob/master/data/google/instance_types.json)

Instructions for modifying the relationships, such as including cross-family recommendations, are available in the [readme](https://github.com/flexera/policy_templates/tree/master/cost/downsize_instance).

### Review Actions Taken by the Instance Rightsizing Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the <b>Skip Action Approvals</b> option.

Any instances that meet the conditions specified will be stopped, size changed, and restarted. The default instance mappings do not include moves between instance families that would imply major infrastructure (such as network), operating system, or cloud image changes. If the user configures a custom mapping between families, the policy action could result in image or driver incompatibilities that could cause loss of service.

To generate recommendations and automate same-sizing moves to less expensive sub-regions, apply the [Cheaper Region Policy](https://github.com/flexera/policy_templates/tree/master/cost/cheaper_regions).

### Notify Users on How to Use the Instance Rightsizing Policy

Once the Instance Rightsizing Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the <b>Policy Schedule</b> field. Users can also access this information in the <b>Applied Policies</b> section of the <b>Policies</b> menu.

The <b>Incidents</b> section shows any triggered recommendations.

If <b>Skip Action Approvals</b> has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to <b>Approve</b> or <b>Deny</b> the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Cloud PaaS Services Rightsizing

Just like Compute Instances, Platform as a Service (PaaS) such as Amazon RDS database instances, Azure SQL database instances, and Google Cloud SQL database instances may be larger and more expensive than usage patterns indicate is necessary. We assess utilization metrics to identify any database instances that could be downsized.

### Configure the Cloud PaaS Services Rightsizing Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Cloud PaaS Services Instances to Include

Determine which resources to evaluate for underutilization.

* To define scope using Select Accounts: Specify the list of accounts to evaluate. For example, you may wish to limit the rightsizing to non-production accounts or to any subset of accounts.
* To define scope using Tag filtering: Limit the scope within the selected accounts by specifying tags. For example, if your production and non-production resources are mixed in your cloud accounts, you can leverage this tag-based filtering functionality to limit the rightsize action based on an environment tag. Database instances can also be tagged with a rightsize-related tag key to mark whether they have been selected as suitable for rightsizing.

### Define the Cloud PaaS Services Threshold for Downsizing

Having defined a scope, you’ll need to set percent thresholds to allow for downsize. You can assess both memory and CPU metrics to determine suitability, and you are able to set separate thresholds for both average and maximum utilization.

Maximum utilization will be affected directly by any spikes in CPU or memory usage. For example, CPU usage can spike during occasional processes such as backups. In some cases these types of activities are not materially impacted if the CPU size is lower. If you are concerned about provisioning capacity to accommodate these short-lived spikes, set a high maximum free memory percent. If you are not concerned by slowed performance during periodic activity spikes, reduce the maximum percent threshold.

Depending on whether memory capacity is more critical to your applications than CPU or vice versa, you will need to set different CPU and memory thresholds.

For the majority of database instances, a single downsize will reduce the instance’s capacity by half. Accordingly, in standard downsize cases you should select a number below 50 for the average percent to allow for downsize. For example, if you set the threshold to 40 percent, the utilization would still remain under 80 percent once downsizing has occurred.

How far you set this number below 50 will define a more or less conservative capacity buffer in the event that future usage patterns depart from the historical trend. To disregard any of the four thresholds for downsize, enter a value of -1. A blank field will be recorded as a value of 0.

### Define the Cloud PaaS Services Rightsizing Actions to Take

To define the Cloud PaaS Services Rightsizing actions to take, erform the following actions:

* Configure users to be notified: Specify the list of recipients who should receive notifications about rightsizing. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.
* Configure automated actions for the policy: Specify whether you want the recipients to receive an emailed report of downsize recommendations with no automated action, or send the report as well as taking automated action to downsize instances that meet the previously defined criteria.

### Configure the General Cloud PaaS Services Rightsizing Policy Options

Set the following standard policy configuration options when the Cloud PaaS Services Rightsizing Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time it is applied whether the policy will take action after user approval versus automatically without user intervention. For details, see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

### Customize the Cloud PaaS Services Rightsizing Policy

Policy designers can customize the Cloud PaaS Services Rightsizing Policy definition in several ways:

* Change the observation period. By default, this policy calculates utilization over a 30-day period. To calculate over a different period of time, you can update the policy template. More information on this is available in the [readme](https://github.com/flexera/policy_templates/tree/master/cost/downsize_instance).
* Change the script to draw monitoring data for rightsizing from different monitoring tools. Samples are provided for tools including Cloudwatch (AWS), Stackdriver (GCE), LogAnalytics (Azure), and Datadog in the public GitHub repository.
* Customize the mapping for larger and smaller instance sizes. This optimization action works on a default set of standard larger and smaller instance size mappings. These can be modified in cases where users wish to take specialized factors into account, such as storage drivers, network drivers, 32/64 bit architecture, or non-standard instance mappings. The files containing predefined instance mappings for each cloud vendor can be accessed in our GitHub repository.

Instructions for modifying the relationships, such as including cross-family recommendations, are available in the [readme](https://github.com/flexera/policy_templates/tree/master/cost/downsize_instance) linked in the policy details.

### Review Actions Taken by the Cloud PaaS Services Rightsizing Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the Skip Action Approvals option.

Any database instances that meet the conditions specified will be stopped, size changed, and restarted. The default database instance mappings do not include moves that would imply major infrastructure (such as network) changes, such as moves between instance families. If the user configures a nonstandard custom mapping, the policy action could result in incompatibilities that could cause loss of service.

### Notify Users on How to Use the Cloud PaaS Services Rightsizing Policy

Once the Cloud PaaS Services Rightsizing Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Idle Compute Instance Termination

Compute Instances that were provisioned for a past initiative may remain active, incurring cost even when utilization metrics indicate they are not in use. Identifying these and automatically terminating them can generate significant cost savings.

### Configure the Idle Compute Instance Termination Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of Idle Compute Instances to Include

Determine which resources to evaluate for the Idle Compute Instances Policy.

* To define scope using Select Accounts: Specify the list of accounts to evaluate. For example, you may wish to limit the termination to non-production accounts or to any subset of accounts.
* To define scope using Tag filtering: Limit the scope within the selected accounts by specifying tags for items to exclude. For example, if your production and non-production resources are mixed in your cloud accounts, you can leverage this tag-based filtering functionality to limit the action based on an environment tag.

### Define the Idle Compute Instance Threshold for Termination

Having defined a scope, you will need to set percent utilization thresholds to allow for termination. You can assess both memory and CPU metrics to determine suitability.

### Define the Idle Compute Instance Termination Actions to Take

To define the Idle Compute Instance Termination actions to take, perform the following action:

* Configure users to be notified: Specify the list of recipients who should receive notifications about termination. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.

### Configure the General Idle Compute Instance Termination Policy Options

Set the following standard policy configuration options when the Idle Compute Instance Termination Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time it is applied whether the policy will take action after user approval versus automatically without user intervention. For details, see the Skip Action Approvals documentation.

### Customize the Idle Compute Instance Termination Policy

Policy designers can customize the Idle Compute Instance Termination Policy definition in several ways.

* Change the observation period. By default, this policy calculates utilization over a 30-day period. To calculate over a different period of time, you can update the policy template.
* Change the script to draw monitoring data for rightsizing from different monitoring tools. Samples are provided for tools including Cloudwatch (AWS), Stackdriver (GCE), LogAnalytics (Azure), and Datadog in the public GitHub repository.

### Review Actions Taken by the Idle Compute Instance Termination Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the Skip approval option.

Any instances that meets the conditions specified will be Terminated.

### Notify Users on How to Use the Idle Compute Instance Termination Policy
Once the Idle Compute Instance Termination Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Unused Storage Deletion

When Compute Instances are terminated, it is fairly common to see that the associated storage resources are not deleted at the same time, whether through the forgetfulness of a human performing manual terminations or an incomplete automated deletion process. Some storage volume types incur cost whether or not they are utilized.

### Configure the Unused Storage Deletion Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Unused Storage Deletion Resources to Include

Determine which resources to evaluate for the Unused Storage Deletion Policy.

* To define scope using Select Accounts: Specify the list of accounts to evaluate. For example, you may wish to limit the deletion of storage to non-production accounts or to any subset of accounts.
* To define scope using Tag filtering: Limit the scope within the selected accounts by specifying tags to exclude. For example, if your production and non-production resources are mixed in your cloud accounts, you can leverage this tag-based filtering functionality to limit the deletion based on an environment tag.

### Define the Unused Storage Time Period Thresholds for Deletion

Specify the number of days the volume should be unattached before deletion.

### Define the Unused Storage Deletion Actions to Take

To define the Unused Storage Deletion actions to take, perform the following actions:

* Configure users to be notified: Specify the list of recipients who should receive notifications of storage deletion. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.
* Configure automated actions for the policy: Specify whether you want the recipients to receive an emailed report of deletion recommendations with no automated action, or send the report as well as taking automated action to delete the storage volumes that meet the criteria defined above.
* Configure whether to take a snapshot: Check the box if you want the policy to automatically take a final snapshot before deleting.

### Configure the General Unused Storage Deletion Policy Options

Set the following standard policy configuration options when the Unused Storage Deletion Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time it is applied whether the policy will take action after user approval versus automatically without user intervention. For details, see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

### Customize the Unused Storage Deletion Policy

Policy designers can customize the Unused Storage Deletion Policy definition as they choose.

### Review Actions Taken by the Unused Storage Deletion Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the Skip approval option.

Any storage that meets the conditions specified will be:
* Snapshotted (if the option was selected)
* Deleted (if the Email and Delete option was selected)

If the volume is not able to be deleted for any reason, such as the volume being locked, the volume will be tagged to indicate the CloudException error that was received. If the issue causing the delete failure is removed, the next run of the policy will delete the volume.

!!warning*Note*The unattached volumes report will reflect the updated set of unattached volumes on the subsequent run.

### Notify Users on How to Use the Unused Storage Deletion Policy

Once the Unused Storage Deletion Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Old Snapshot Deletion

Snapshots that sit around for too long outlive their usefulness for backup. Relying on manual deletions often means that old snapshots incur unnecessary cost until someone remembers to check on them. Our Old Snapshot solution sends alerts when snapshots outlive a given timeframe and can also delete them, either automatically or upon approval.

### Configure the Old Snapshot Deletion Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Old Snapshots to Include

Determine which resources to evaluate for the Old Snapshot Deletion Policy.

* To define scope using Select Accounts: Specify the list of accounts to evaluate. For example, you may wish to limit the deletion of storage to non-production accounts or to any subset of accounts.
* To define scope using Tag filtering: Limit the scope within the selected accounts by specifying tags to exclude. For example, if your production and non-production resources are mixed in your cloud accounts, you can leverage this tag-based filtering functionality to limit the deletion based on an environment tag.

### Define the Old Snapshot Time Period Thresholds for Deletion

Specify the age of the snapshot in number of days before deletion.

### Define the Old Snapshot Deletion Actions to Take

To define the Old Snapshot Deletion actions to take, perform the following actions:

1.	Configure users to be notified: Specify the list of recipients who should receive the storage deletion notifications. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.
2.	Delete the actual snapshot.

### Configure the General Old Snapshot Deletion Policy Options

Set the following standard policy configuration options when the Old Snapshot Deletion Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time it is applied whether the policy will take action after user approval versus automatically without user intervention. For details, see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

### Customize the Old Snapshot Deletion Policy

Policy designers can customize the Old Snapshot Deletion Policy definition as they choose.

### Review Actions Taken by the Old Snapshot Deletion Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the Skip approval option.

Any snapshots that meets the conditions specified will be Deleted.

### Notify Users on How to Use the Old Snapshot Deletion Policy
Once the Old Snapshot Deletion Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Unused PaaS Service Termination

Cloud services such as Amazon Web Services (AWS) Elastic Container Service (ECS), Elastic Load Balancing (ELB), and Relational Database Service (RDS) incur wasted cost when sitting idle. Automatically identify idle nodes and, if desired, terminate them to realize savings.

### Configure the Unused PaaS Service Termination Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Unused PaaS Services to Include

Determine which resources to evaluate for underutilization.

* To define scope using Select Accounts: Specify the list of accounts to evaluate. For example, you may wish to limit the termination to non-production accounts or to any subset of accounts.
* To define scope using Tag filtering: Limit the scope within the selected accounts by specifying tags for items to exclude.

### Define the Unused PaaS Service Termination Actions to Take

To define the Unused PaaS Service Termination actions to take, perform the following action:

Configure users to be notified: Specify the list of recipients who should receive the notifications about termination. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.

### Configure the General Unused PaaS Service Termination Policy Options

Set the following standard policy configuration options when the Unused PaaS Service Termination Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time it is applied whether the policy will take action after user approval versus automatically without user intervention. For details, see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

### Customize the Unused PaaS Service Termination Policy

Policy designers can customize the Unused PaaS Service Termination Policy definition in several ways:

* Change the observation period. By default, this policy calculates utilization over a 30-day period. To calculate over a different period of time, you can update the policy template.
* Change the script to draw monitoring data for rightsizing from different monitoring tools (the default is Amazon CloudWatch). Samples are provided for tools such as Datadog in the public GitHub repository.

### Review Actions Taken by the Unused PaaS Service Termination Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the Skip Action Approvals option.

This policy gets a list of Relational Database Service (RDS) instances and uses CloudWatch DBConnection metric to check for connections over a 30-day period. If there are no DBConnections, the policy will terminate the RDS instance.

### Notify Users on How to Use the Unused PaaS Service Termination Policy
Once the Unused Resource Decommissioning Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Unused Resource Decommissioning

When network resources such as Internet Protocol (IP) addresses are unused, they can continue to incur cost. Automatically identify any unassociated IP addresses and take automated or approval-driven action to decommission them and eliminate waste.

### Configure the Unused Resource Decommissioning Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Unused Resources to Include

Determine which resources to evaluate for the Unused Resource Decommissioning Policy.

* To define scope using Select Accounts: Specify the list of accounts to evaluate. For example, you may wish to limit the deletion of resources to non-production accounts or to any subset of accounts.
* To define scope using Whitelisting: Limit the scope within the selected accounts by specifying Internet Provider (IP) addresses to exclude. For example, if your production and non-production resources are mixed in your cloud accounts, you can leverage this whitelisting functionality to prevent the deletion of specific IP addresses.

### Define the Unused Resource Decommissioning Actions to Take

Configure users to be notified: Specify the list of recipients who should receive notifications of Internet Provider (IP) address deletion. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.

### Configure the General Unused Resource Decommissioning General Policy Options

Set the following standard policy configuration options when the Unused Resource Decommissioning Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time it is applied whether the policy will take action after user approval versus automatically without user intervention. For details, see the Skip Action Approvals documentation.

### Customize the Unused Resource Decommissioning Policy

Policy designers can customize the Unused Resource Decommissioning Policy definition as they choose, such as to act on additional network resources.

### Review Actions Taken by the Unused Resource Decommissioning Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the Skip approval option.

Any Internet Provider (IP) address that meets the conditions specified will be Deleted.

### Notify Users on How to Use the Unused Resource Decommissioning Policy
Once the Unused Resource Decommissioning Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Instance Scheduling

Running all Compute instances nonstop is like leaving the lights on in the office after the employees have gone home. Set tags to indicate which instances are required 24/7 and which are only in use during work hours. Then save approximately 65% of instance cost by automatically stopping these Compute instances on nights and weekends. Instance Scheduling is typically one of the largest areas of potential optimization for cloud cost savings.

### Configure Instance Scheduling

You will define the desired schedule for each instance using a tag on the instance. The policy will then look for the tags and start and stop the instances on that schedule.

The tag 'instance:schedule' defines the schedule when you want each instance to run. The schedule consists of a start hour, stop hour, and days of the week. The start and stop hour are in 24-hour format, and the days of the week are two-character abbreviations, for example: MO, TU, WE. Use an optional time zone TZ value to indicate a time zone to stop or start the instance.

### Specify Instance Scheduling Tags

<b>Start and Stop hours:</b> 24-hour format: for example, 8-17 is start at 8 a.m. and stop at 5 p.m.

<b>Days of the week:</b> SU, MO, TU, WE, TH, FR, SA

<b>Time zone:</b> Optionally, use the TZ database name from the [Time Zone List](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). For example, use America/New_York for Eastern time. Times default to Coordinated Universal Time (UTC) if no value is provided in the time zone field.

For example, the tag `instance:schedule=8-17;MO,TU,WE,TH,FR;America/New_York` will start the instance at 8 a.m. and stop it at 5 p.m. Monday-Friday, Eastern Time.

To automate setting default schedule tags, use the [Untagged Resource Policy](https://github.com/rightscale/policy_templates/tree/master/compliance/tags/tag_checker).

### Configure the Instance Scheduling Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Instances to Include for Scheduling

Determine which resources to include in the scheduling policy by clicking Select Accounts to specify the list of accounts to evaluate. You may wish to limit the rightsizing to non-production accounts or to any subset of accounts.

### Define the Instance Scheduling Actions to Take

To define the Instance Scheduling actions to take, perform the following action:

<b>Select users to be notified:</b> Specify the list of recipients who should receive email reports about scheduling. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.

### Configure the General Instance Scheduling Policy Options

Set the following standard policy configuration options when the Instance Scheduling Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time when applied whether the policy will take action after user approval versus automatically without user intervention. Please see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

!!warning*Note*Approvals may delay the start and stop schedule, so it is recommended to operate this policy with Skip Approvals activated.

### Customize the Instance Scheduling Policy

Policy designers can customize the Instance Scheduling Policy definition in several ways:

* Add actions to be taken before stopping the instances, such as snapshotting.
* Allow user input of commands to take before stopping instances.
* Control the order in which actions are taken.
* Provide scheduling of other services, such as Database as a Service (DBaaS) instances.

### Review Actions Taken by the Instance Scheduling Policy

Any instances that meet the conditions specified will be stopped and started at the appropriate times. While the instances are stopped, they will no longer incur charges.

### Notify Users on How to Use the Instance Scheduling Policy

Once the Reservation Expiration Alert Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations that will match those sent out in the emailed report.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Reservation Purchase Recommendation

Buying reservations on Compute instances is a popular cost savings strategy, but it can just as easily create additional waste if the reservations are not well matched to the active instances in your environment. How do you know how many to buy and which kind? We walk you through the options and provide purchase recommendations for Amazon Web Services (AWS) and Azure Reserved Instances to guide your purchase, minimizing risk, and maximizing your savings.

### Define the Scope of the Resources to Include

Determine which resources to evaluate for the policy by clicking Select Accounts to specify the list of accounts to evaluate.

### Define the Reservation Purchase Parameters

Input the following parameters to launch the Reservation Purchase Policy for each vendor.

* <b>Amazon Web Services (AWS) </b>
 * Look Back Period - Specify the number of days of past usage to analyze.
 * Service - Specify the AWS Service to search for Reserved Instances (RIs).
 * EC2 Specification - If the Service is "EC2", specify whether to look for Standard or Convertible RIs. For Services besides EC2, this parameter will be ignored.
 * RI Term - Specify the Term length for the RI.
 * Payment Option - Optionally, specify the payment option for this RI (all upfront, no upfront, etc.).
 * Net Savings Threshold - Specify the minimum Net Savings that should result in an RI purchase recommendation.
* <b>Microsoft Azure</b>
 * Enrollment ID - the Microsoft Azure Enterprise Agreement (EA) enrollment ID.
 * Look Back Period - Specify the number of days of past usage to analyze.
 * Net Savings Threshold - Specify the minimum Net Savings that should result in an RI purchase recommendation.

### Define the Reservation Purchase Actions to Take

To define the Reservation Purchase actions to take, perform the following action:

Configure users to be notified: Specify the list of recipients who should receive the Reserved Instance (RI) purchase plan. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.

### Configure the General Reservation Purchase Policy Options

Set the following standard policy configuration options when the Reservation Purchase Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time when applied whether the policy will take action after user approval versus automatically without user intervention. Please see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

!!warning*Note*This is a reporting-only policy, so the Skip Action Approvals toggle will have no effect.

### Customize the Reservation Purchase Policy

Policy designers can customize the Reservation Purchase Policy definition as they choose.

### Actions Taken by the Reservation Purchase Policy

The Reservation Purchase Policy will produce a purchase plan for buying reservations that meet the conditions specified and an estimation of savings if the purchases are made. The policy does not purchase the recommendations.

### Notify Users on How to Use the Reservation Purchase Policy

Once the Reservation Purchase Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations that will match those sent out in the emailed purchase plan.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Reservation Expiration Alert

Replacing Reserved Instances promptly as they expire is critical to maximizing cost savings, but it can take time to review purchase plans and get approvals. The Reservation Expiration Alert gives you advance notice of pending expirations, so you have time to organize your replacement purchase.

###Configure the Reservation Expiration Alert

To configure the Instance Rightsizing Policy:

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Reserved Instances to Include

Determine which resources to evaluate for the policy by clicking Select Accounts to specify the list of accounts to evaluate.

### Define the Thresholds for Alerting

Having defined a scope, you will need to set a number of days prior to the expiration date to receive an alert.

### Define the Reservation Expiration Alert Actions to Take

Configure users to be notified: Specify the list of recipients who should receive the expiration alert notifications. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.

### Configure the General Reservation Expiration Alert Policy Options

Set the following standard policy configuration options when the Reservation Expiration Alert Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time when applied whether the policy will take action after user approval versus automatically without user intervention. Please see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

!!warning*Note*This is a reporting-only policy, so the Skip Action Approvals toggle will have no effect.

### Customize the Reservation Expiration Alert Policy

Policy designers can customize the Reservation Expiration Alert Policy definition as they choose.

### Actions Taken by the Reservation Expiration Alert Policy

The Reservation Expiration Alert Policy will send out an email notification alerting of any Reserved Instances (RIs) expiring within the specified number of days.

### Notify Users on How to Use the Reservation Expiration Alert Policy
Once the Reservation Expiration Alert Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations that will match those sent out in the emailed purchase plan.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Object Storage Class Optimization

Moving your storage objects to warmer or colder classes according to consumption is an effective savings strategy, but manually assessing the appropriate class for each resource can be complicated and time consuming. Our Object Storage Class Optimization capability assesses observed access patterns after objects have persisted for a given period of time, then offers adjustments to reduce waste.

###Configure the Object Storage Class Optimization Policy

1.	From the Policies screen, select the appropriate policy and click Apply.
2.	Select the options to configure the policy.

### Define the Scope of the Object Storage Resources to Include

Determine which resources to evaluate for underutilization.

* To define scope using Select Accounts: Specify the list of accounts to evaluate. For example, you may wish to limit the action to non-production accounts or to any subset of accounts.
* To define scope using Tag filtering: Limit the scope within the selected accounts by specifying tags to exclude. For example, if your production and non-production resources are mixed in your cloud accounts, you can leverage this tag-based filtering functionality to limit the action based on an environment tag.

### Define the Threshold for Moving to Cooler Storage

Specify the number of days after which the item will be moved to a cooler storage option. You can set different lengths of time for each level of storage.

### Define the Object Storage Class Optimization Actions to Take

To define the Object Storage Class Opimization actions to take, perform the following action:

Configure users to be notified: Specify the list of recipients who should receive notifications about rightsizing. Add as many recipients as you like to the Email addresses of the recipients you wish to notify field. They do not need to be registered as Optima users.

### Configure the General Object Storage Class Optimization Policy Options

Set the following standard policy configuration options when the Object Storage Class Optimization Policy is applied.

* Frequency for policy to run: Specify the frequency the policy will perform the checks, such as weekly, daily, hourly, or every 15 minutes.
* Fully automated vs approval required: Specify at the time when applied whether the policy will take action after user approval versus automatically without user intervention. Please see the [Skip Action Approvals](/policies/users/guides/apply_policy.html#common-policy-configuration-options--skip-action-approvals-) documentation.

###Customize the Object Storage Class Optimization Policy

Policy designers can customize the policy definition as they choose, such as:

* Customize the policy to move to warmer storage classes.
* Leverage log data from cloud provider to determine last access dates.

### Review Actions Taken by the Object Storage Class Optimization Policy

These actions may occur with approval or fully automated depending on whether the policy manager has selected the Skip Action Approvals option.

* Any Amazon Web Services (AWS) storage that meets the conditions specified will be copied to the new type, and the old version will be removed.
* Microsoft Azure and Google storage that meet the conditions specified will be switched directly over to the new type.

### Notify Users on How to Use the Object Storage Class Optimization Policy
Once the Reservation Expiration Alert Policy has been configured and applied, any email addresses specified will receive an email report listing every recommendation triggered on the cadence selected in the Policy Schedule field. Users can also access this information in the Applied Policies section of the Policies menu.

The Incidents section shows any triggered recommendations that will match those sent out in the emailed purchase plan.

If Skip Action Approvals has been activated, optimization actions will be taken automatically. If not, users can click into the incident and a specific account to Approve or Deny the recommended action.

Depending on user access, these policy activity summaries are visible on an account-by-account basis or, for administrators, as an organizational summary.


## Scheduled Report with Forecast

### Scheduled Report with Forecast Functionality

The Scheduled Report email includes a chart of the previous 6 months of utilization based on whichever reporting dimension you select (only bill data and Optima-generated dimensions are supported).

!!success*Best Practice*We recommend running this report on a weekly cadence and applying it to your master account.

The chart includes the following values:

* <b>Daily Average - Weekly:</b> Daily average costs calculated from Monday of the previous week through today
* <b>Daily Average - Monthly:</b> Daily average costs calculated from the 1st of the previous month through today
* <b>Previous - Weekly:</b> Total costs during previous full week (Monday-Sunday)
* <b>Previous - Monthly:</b> Total costs during previous full month
* <b>Current - Weekly:</b> Total costs during current (incomplete) week
* <b>Current - Monthly:</b> Total costs during current (incomplete) month
* <b>Monthly Estimated Cost</b> for each metric for the next 3 months based on previous costs

!!warning*Important Notes*The last 3 days of data in the current week or month will contain incomplete data.<br><br>The account you apply this feature to is unimportant as Optima metrics are scoped to the Organization.

### Scheduled Report with Forecast Cost Metrics

There are four cost metrics to choose from:
1. Unamortized Unblended - One-time and upfront costs are shown at the time of purchase. (AWS Only) Savings from reserved instances are applied first to matching instances in the account where it was purchased.
2. Amortized Unblended - One-time and upfront costs are spread evenly over the term of the item purchased. (AWS Only) Savings from reserved instances are applied first to matching instances in the account where it was purchased.
3. Unamortized Blended - One-time and upfront costs are shown at the time of purchase. (AWS Only) Saving from reserved instances are shared equally by all matching instances in all accounts.
4. Amortized Blended - One-time and upfront costs are spread evenly over the term of the item purchased. (AWS Only) Saving from reserved instances are shared equally by all matching instances in all accounts.

### Scheduled Report with Forecast Input Parameters

This feature requires the following input parameters during configuration.

* Email list - Email addresses of the recipients you wish to notify
* Billing Center List - List of top-level Billing Center names you want to report on. Names must be exactly as shown in Optima. Leave the field blank to report on all top-level Billing Centers.
* Cost Metric - See [Scheduled Report with Forecast Cost Metrics](/optima/guides/automated_optimization.html#scheduled-report-with-forecast-scheduled-report-with-forecast-cost-metrics) for details on selection.
* Graph Dimension - The cost dimension by which to break out the cost data in the embedded bar chart image
Scheduled Report with Forecast Required User Roles

This feature requires permissions to access Optima resources. A user who wishes to configure scheduled reports will require the following role, which should be applied to each account where reporting is desired or to the entire organization. For more information on modifying roles, read the [Governance User Roles documentation](/cm/ref/user_roles.html).

`Optima - billing_center_viewer`

### Scheduled Report with Forecast Supported Clouds

* AWS
* Azure
* Google


## Monthly Actual vs Budgeted Spend Report

This feature allows you to set up scheduled reports that will provide monthly actual vs budgeted cloud cost across all resources in the Billing Center(s) you specify, delivered to any email addresses you specify.

### Monthly Actual vs Budgeted Spend Report Functionality

The scheduled report emails provide a report with a bar chart of actual vs budgeted spend for the current month.

!!success*Best Practices*We recommend running this report on a weekly cadence and applying it to your master account.<br><br>The monthly budget inputs are compared against the current month's actual cloud costs of the applied feature. As a best practice, terminate and reconfigure reports on an annual basis to reflect the current year's monthly budgeted cloud costs.

!!warning*Notes*The last 3 days of data in the current week or month will contain incomplete data.<br><br>The account you apply the feature to is unimportant as Optima metrics are scoped to the Organization.

### Monthly Actual vs Budgeted Spend Report Cost Metrics

There are four cost metrics to choose from.

1. Unamortized Unblended - One-time and upfront costs are shown at the time of purchase. (AWS Only) Savings from reserved instances are applied first to matching instances in the account where it was purchased.
2. Amortized Unblended - One-time and upfront costs are spread evenly over the term of the item purchased. (AWS Only) Savings from reserved instances are applied first to matching instances in the account where it was purchased.
3. Unamortized Blended - One-time and upfront costs are shown at the time of purchase. (AWS Only) Saving from reserved instances are shared equally by all matching instances in all accounts.
4. Amortized Blended - One-time and upfront costs are spread evenly over the term of the item purchased. (AWS Only) Saving from reserved instances are shared equally by all matching instances in all accounts.

### Monthly Actual vs Budgeted Spend Report Input Parameters

This feature requires the following input parameters during configuration.

* <b>Email list:</b>:</b> Email addresses of the recipients you wish to notify
* <b>Billing Center List:</b> List of top-level Billing Center names you want to report on. Names must be exactly as shown in Optima. Leave the field blank to report on all top-level Billing Centers.
* <b>Cost Metric:</b> See Monthly Actual vs Budgeted Spend Report Cost Metrics for details on selection.
* <b>January Budgeted Cost:</b> January budgeted cost for corresponding Billing Center
* <b>February Budgeted Cost:</b> February budgeted cost for corresponding Billing Center
* <b>March Budgeted Cost:</b> March budgeted cost for corresponding Billing Center
* <b>April Budgeted Cost:</b> April budgeted cost for corresponding Billing Center
* <b>May Budgeted Cost:</b> May budgeted cost for corresponding Billing Center
* <b>June Budgeted Cost:</b> June budgeted cost for corresponding Billing Center
* <b>July Budgeted Cost:</b> July budgeted cost for corresponding Billing Center
* <b>August Budgeted Cost:</b> August budgeted cost for corresponding Billing Center
* <b>September Budgeted Cost:</b> September budgeted cost for corresponding Billing Center
* <b>October Budgeted Cost:</b> October budgeted cost for corresponding Billing Center
* <b>November Budgeted Cost:</b> November budgeted cost for corresponding Billing Center
* <b>December Budgeted Cost:</b> December budgeted cost for corresponding Billing Center

### Monthly Actual vs Budgeted Spend Report Required Permissions

This feature requires permissions to access Optima resources. Before applying this feature, add the following role for the user hoping to leverage this functionality. The role should be applied to any individual accounts where the feature will run, or to the entire organization to apply to all accounts. For more information on modifying roles, read the [Governance User Roles documentation](/cm/ref/user_roles.html).

`Optima - billing_center_viewer`

### Monthly Actual vs Budgeted Spend Report Supported Clouds

* AWS
* Azure
* Google

## Budget Alert

This feature is used to determine if a Billing Center or the entire Organization has exceeded its monthly cost budget.

### Budget Alert Functionality

* This feature supports a single target (that is, one specific Billing Center or the entire Organization). To apply a budget alert for multiple targets, you need to apply this feature multiple times.
* Actual Spend budget alerts will raise an incident when the target has exceeded the budget for the month.
* Forecasted Spend budget alerts will raise an incident when the target's run rate is on track to exceed the budget for the month.
Budget Alert Input Parameters

This feature requires the following input parameters during configuration.

* <b>Monthly Budget:</b> Specify the monthly budget. Currency is irrelevant; the feature will default to whichever currency is used in Optima.
* <b>Budget Scope:</b> Organization or Billing Center
* <b>Billing Center Name:</b> If the scope is "Billing Center", supply the name of the target Billing Center.
* <b>Cost Metric:</b> Specify options for amortized vs nonamortized and blended vs unblended costs.
* <b>Budget Alert Type:</b> Actual Spend or Forecasted Spend
* <b>Email addresses of the recipients you wish to notify:</b> A list of email addresses to notify

### Budget Alert Required Permissions

This feature requires permissions to access Optima resources. Before applying this feature, add the following roles for the user hoping to leverage this functionality. The roles should be applied to any individual accounts where the feature will run, or to the entire organization to apply to all accounts. For more information on modifying roles, read the  Governance User Roles documentation.

* `feature_manager`
* `billing_center_viewer` 

!!warning*Note*The `billing_center_viewer` role must be applied at the Organization level.

### Budget Alert Supported Clouds

* AWS
* Azure
* Google


## Billing Center Cost Anomaly Detection

The Cost Anomaly Detection feature analyzes the spend of all Billing Centers in an Organization over a specified time period. If the percentage change of the most recent period compared to the previous period exceeds the specified threshold, then an email alert is sent out to any addresses indicated during configuration.

### Billing Center Cost Anomaly Functionality

* The feature polls all Billing Centers, looking for any that have exceeded the Percent Change threshold.
* The last 2 days are not included in the analysis, due to potential delays of the cloud providers updating their billing data.

### Billing Center Cost Anomaly Input Parameters

* <b>Time Period:</b> Number of days to analyze in each period. For example, if 6 days is set, then the latest time period will be 8 days ago to 3 days ago (to account for cloud provider bill delays) and the previous time period will be 14 days ago to 9 days ago.
 * <b>Minimum Value:</b> 1
 * <b>Maximum Value:</b> 31

* <b>Anomaly Threshold:</b> Percentage change threshold. If the percentage change of Billing Center spend from the latest time period compared to the previous time period exceeds this value, then a report is sent out via email.
* <b>Cost Metric:</b> Specify options for amortized vs nonamortized and blended vs unblended costs
* <b>Email addresses of the recipients you wish to notify:</b> A list of email addresses to notify
Billing Center Cost Anomaly Required Permissions

This feature requires permissions to access Optima resources. Before applying this feature, add the following roles for the user hoping to leverage this functionality. The roles should be applied to any individual accounts where the feature will run, or to the entire organization to apply to all accounts. For more information on modifying roles, read the [Governance User Roles documentation](/cm/ref/user_roles.html).

* `feature_manager`
* `billing_center_viewer` 

###Billing Center Cost Anomaly Supported Clouds

* AWS
* Azure
* Google


## AWS Reserved Instance Coverage Report

This feature retrieves the Reserved Instance coverage data for your account and sends out a coverage report to the email addresses the user specified in the field:  <b>Email addresses of the recipients you wish to notify</b>.

### AWS Reserved Instance Coverage Report Input Parameters

This feature requires the following input parameters during configuration.

* Number of days in the past to view Reserved Instance Coverage - allowed values 7,14,30,90,180,365
* Email addresses of the recipients you wish to notify - A list of email addresses to notify

### AWS Reserved Instance Coverage Report Required Permissions

* <b>Cloud Management:</b> `actor`
* <b>Cloud Management:</b> `observer`
* <b>Cloud Management:</b> `credential_viewer`

### AWS Reserved Instance Coverage Report: AWS Required Permissions

This feature requires permissions to describe AWS Cost Explorer GetReservationCoverage. The Cloud Management Platform automatically creates two Credentials when connecting AWS to Cloud Management: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. The IAM user credentials contained in those credentials require the following permissions:

<pre><code>{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ce:GetReservationCoverage",
            "Resource": "*"
        }
    ]
}
</code></pre>

### AWS Reserved Instance Coverage Report Supported Clouds

AWS


## AWS Reserved Instance Utilization Report

This feature leverages AWS Reserved Instance (RI) data to generate a report. It will notify by email only if utilization of a RI falls below the value specified in the field:  Show RI's with utilization below this value. If any reservations are lower in utilization than the threshold, a report goes out by email to the user(s) specified in:  Email addresses of the recipients you wish to notify.

### AWS Reserved Instance Utilization Report Input Parameters

This feature requires the following input parameters during configuration.

* Show RI's with utilization below this value 
* Email addresses of the recipients you wish to notify - A list of email addresses to notify

!!warning*Note*As a best practice, this feature should only be applied to the Master Account, and not to each individual Account.

### AWS Reserved Instance Utilization Report Required Permissions

This feature requires permissions to access Optima resources. Before applying this feature, add the following roles for the user hoping to leverage this functionality. The roles should be applied to any individual accounts where the feature will run, or to the entire organization to apply to all accounts. For more information on modifying roles, read the  Governance User Roles documentation.

* <b>Cloud Management:</b> `actor`
* <b>Cloud Management:</b> `observer`
* <b>Cloud Management:</b> `credential_viewer`

### AWS Reserved Instance Utilization Report Supported Clouds

AWS


## Azure Reserved Instance Utilization Report

This feature produces reports on the utilization level of Azure Reserved Instances (RI). It leverages the  Azure EA API for Reserved Instance Utilization. It will notify only if utilization of a RI falls below the value specified in the field: <b>Show RI's with utilization below this value</b>. It examines the RI utilization for the prior 7 days (starting from 2 days ago) in making this determination.

It will email the users specified in <b>Email addresses of the recipients you wish to notify</b>.

### Azure Reserved Instance Utilization Report Required Permissions

This feature requires external permissions to access Azure resources. Before applying this feature, add the following role for the user hoping to leverage this functionality.

`AZURE_EA_KEY` - the Azure EA key for the enrollment being checked

### Azure Reserved Instance Utilization Report Input Parameters

This feature has the following input parameters required when launching the feature.

* <b>Enrollment ID:</b> the Azure EA enrollment ID
* <b>Show RI's with utilization below this value.</b>
* <b>Email addresses of the recipients you wish to notify:</b> A list of email addresses to notify
Azure Reserved Instance Utilization Report Feature Actions

The following feature action is taken on any resources found to be out of compliance:
* Send an email report

### Azure Reserved Instance Utilization Report: Optima Required Permissions

* <b>Cloud Management:</b> `actor`
* <b>Cloud Management:</b> `observer`
* <b>Cloud Management:</b> `credential_viewer`

### Azure Reserved Instance Utilization Report: Azure Required Permissions

Microsoft.Consumption/reservationSummaries/read

###Azure Reserved Instance Utilization Report Supported Clouds

Azure


## AWS Instance CloudWatch Utilization

This feature gathers AWS CloudWatch data for instances on 30-day intervals.

!!success*Best Practice*We recommend running the AWS CloudWatch data on a monthly basis.

### AWS Instance CloudWatch Required Permissions

<b>Optima Cloud Management Roles</b> 
* `credential_viewer`, `observer`
* `feature_designer`, `feature_manager`, and `feature_publisher` 

<b>AWS IAM Feature</b>
`CloudWatchReadOnlyAccess`

### AWS Instance CloudWatch Functionality

* This feature identifies all instances reporting performance metrics to CloudWatch whose CPU or Memory utilization is below the thresholds set in the <b>Average used memory percentage</b> and <b>Average used CPU percentage</b> parameters.
* The <b>Exclusion Tag Key</b> parameter is a string value. Only supply the Tag Key. Tag Values are not analyzed and therefore are not needed. If the exclusion tag key is used on an Instance, that Instance is presumed to be exempt from this feature.
* This feature sets the tag defined in the <b>Action Tag Key:Value</b> parameter on the underutilized instances that were identified.
* If you get an <b>N/A</b> in a field, you need to install the CloudWatch Agent on the instance to get those metrics.
* This feature only pulls running instances, as it is unable to get correct monitoring metrics from instances in other states.

### AWS Instance CloudWatch: Windows Support

To enable Windows support, you need to add the following to your cloudwatch config.json and restart the CloudWatch agent.

<pre><code>    "metrics": {
            "append_dimensions": {
                    "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
                    "ImageId": "${aws:ImageId}",
                    "InstanceId": "${aws:InstanceId}",
                    "InstanceType": "${aws:InstanceType}"
  }
}</code></pre>

### AWS Instance CloudWatch Input Parameters

This feature requires the following input parameters during configuration.

* <b>Email addresses of the recipients you wish to notify:</b> A list of email addresses to notify
* <b>Average used memory percentage:</b> Utilization below this percentage will trigger an action to tag the instance. Providing -1 will turn off this metric for consideration.
* <b>Average used CPU percentage:</b> Utilization below this percentage will trigger an action to tag the instance. Providing -1 will turn off this metric for consideration.
* <b>Exclusion Tag Key:</b> An AWS-native instance tag to ignore instances that you don't want to consider for downsizing. Only supply the tag key.
* <b>Action Tag Key:Value:</b> The tag key:value pair to set on an instance that is underutilized.

### AWS Instance CloudWatch: AWS Required Permissions

This feature requires permissions to list Metrics and Get Metric Statistics from the AWS Cloudwatch API. The Cloud Management Platform automatically creates two Credentials when connecting AWS to Cloud Management; `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`. The IAM user credentials contained in those credentials will require the following permissions:
<pre><code>{
  "Version": "2012-10-17",
  "Statement":[{
      "Effect":"Allow",
      "Action":["cloudwatch:GetMetricStatistics","cloudwatch:ListMetrics"],
      "Resource":"*",
      "Condition":{
         "Bool":{
            "aws:SecureTransport":"true"
            }
         }
      }
    
}</code></pre>

### AWS Instance CloudWatch Supported Clouds

AWS

### AWS Instance CloudWatch Observation Period

By default, this feature calculates utilization over a 30-day period.

To calculate over a different period of time, you can update the feature template.

Replace the <b>30</b> wherever you see `var start_date = new Date(new Date().setDate(new Date().getDate() - 30)).toISOString();` with the new number of days you want to use.

Depending on the number of days you choose to collect metrics for, you may need to update the  period  property. For 30 days, we use the value of <b>2592000</b>, which is 30 days in seconds. You will need to update the value wherever you see `'Period': "2592000"`. For more details, see the official [AWS CloudWatch API Documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_GetMetricStatistics.html).