---
title: Setting Up Scheduled Reports
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

## Overview

Scheduled Reports in RightScale Optima lets you schedule daily, weekly, and monthly emails for complete visibility into your cloud costs. Optima supports two types of reports:

* **Full Cost Reporting** that shows you a high level view of your complete costs on an account-level granularity.
* **Instance Reporting** where you can zoom in to see compute costs over any slice of your cloud, such as particular applications, users or deployments.

Once you are logged into Optima, you can schedule reports in a number of ways:

* From the Instant Analyzer, click **Create**  and select **Scheduled report**
* From anywhere in Optima, click on Scheduled Reports in the navigation bar.

## Creating Scheduled Reports

From Optima you can create Instance-level Scheduled Reports for specific Applications (or any other filter) or create a Full Cost Scheduled Report across any or all accounts.

### Create Scheduled Reports for a Specific Application

1. From the navigation bar in Optima select [Analyze](/ca/ca_analyzing_costs.html). Specifying filters from the Instant Analyzer allows for more granular control for targeted reports.
2. Filter by deployment or other tags. You can choose to filter by account tags, instance tags, or deployment tags ([read more about tagging](/cm/rs101/tagging.html)). Applying tag filter will restrict the instances displayed to those which have the tag selected. This filter can be used to create budget alerts, scenarios, and scheduled reports.
3. If you select no filters then you will create a report across all accounts.  
4. Once you are ready to proceed click **Create** and select **Scheduled report** from the dropdown.  

### Define Scheduled Report Options

From the Scheduled Reports page:

1. Give your report a meaningful name.
2. Choose the frequency of the report (daily, weekly, or monthly).
3. By default, you will receive the alerts at the email address associated with your RightScale user account. You can also choose to send alerts to other email addresses or share reports with other people in your organization.
4. Choose if you would like instance data as a CSV attachment.
5. Click **Create Report**.

### Create Full Cost Scheduled Reports across accounts

To create a Scheduled Report across a set of accounts,

1. Select **Scheduled Reports** from the navigation bar. Click **Create report** and select **Full-cost report**
2. Under **Report filters** you can select which accounts will the report be scoped to. Not selecting any accounts will give you a report across *all accounts*.
3. Define your Scheduled Report options as described in the section above.

!!info*Note:* You can also create an instances-only schedule report across all accounts by using the Instant Analyzer filters as described in the section above and ensuring that no filters are selected.  

### Receiving Scheduled Reports

When you receive a Scheduled Report, you can click **Analyze full details** in the email to launch Optima. You can delete or adjust the frequency of this report in **Scheduled Reports**.
