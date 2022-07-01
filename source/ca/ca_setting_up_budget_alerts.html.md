---
title: Setting Up Budget Alerts
---

!!danger*Warning*The features described on this page will soon be deprecated. Refer to the [latest documentation](https://helpnet.flexerasoftware.com/Optima) for information on the latest features.

## Overview

Budget Alerts allow you to notify your managers, finance teams, and other users when there are potential cost overruns. The below information shows you how to leverage Budget Alerts to set budgets — for a team, business unit, application, or any slice of your cloud compute usage — and to get notified when budgets are exceeded.

With Optima you can create two different types of Budget Alerts:

* **Alert Based on Actual Spend** - Set a monthly budget and get an alert if your budget is reached prior to the month end. This type of alert is most useful for steady workloads with little variability from month to month.

* **Alert Based on Projected Spend** - Set a monthly budget and get an alert if your projected monthly spend (based on month-to-date run rate) will exceed the budget. This alert lets you know that your budget will be exceeded before you incur additional costs. The Forecast spend is calculated using the average daily cost month-to-date multiplied by the number of days in the month.

These Alerts can be based on two possible sources of data:

* **Full Cost Alerting** alerts you based on your complete cloud bill on an account-level granularity.
* **Instance Reporting** alerts you based on *compute* costs over any slice of your cloud, such as particular applications, users or deployments.

## Creating Budget Alerts

From Optima you can create Instance-level Budget Alerts for specific applications or create a Full Cost Budget Alert across any accounts.

### Create Instance Budget Alerts for a Specific Application

1. From the navigation bar in Optima select **Analyze**. The Instance Analyzer lets you review past and present cloud spend which helps you determine your overall monthly budget.

    ![Analyze button](/img/ca-analyze-button.png)

2. Filter on the Deployment or appropriate tags to select the Application. (For the full list of filter selections please refer to the [Instance Analyzer](/ca/ca_analyzing_costs.html).) If you select no filters then you will essentially be creating an Instance Budget Alert across all accounts.
3. Once you are ready to proceed click **Create** and select **Budget alert** from the dropdown.  

    ![Analyze chart](/img/ca-analyze-chart.png)

#### Define Budget and Alert Options

Once you’ve specified the application, the next step is to:

1. Give your alert a meaningful name that will appear in the alert.
2. Choose whether to receive alerts on actual spend or forecast spend.
3. Specify the amount of the monthly budget.
4. Specify how often you would like an alert sent, i.e. once a day, week, or month.
5. Decide if you want the alert email to include a CSV containing instance data.
6. By default, you will receive the alerts at the email address associated with your RightScale user account. You can also choose to send alerts to additional email addresses.

The Create Budget alert form shows you the filters that are used by the alert.

![Forecast spend](/img/ca-forecast-spend.png)

### Create Full Cost Cloud Budget Alerts Across any Accounts

To create a Full Cost Budget Alert across any accounts,

1. Select **Budget Alerts** from the navigation bar.

    ![Budget alerts button](/img/ca-budget-alerts-button.png)

2. Click **Create alert** and select **Across All Accounts**.

    ![Create alert dropdown](/img/ca-create-alert-dropdown.png)

3. Select the accounts in the **Alert filters** section. Not selecting any accounts will give you an alert across *all accounts*.

4. Define your budget and alert options as described in the section above **Define Budget and Alert Options**


!!info*Note:* You can also create an instance cloud budget alert across all accounts by using the Instance Analyzer filters as described in the section above and ensuring that no filters are selected.  

## Receiving Budget Alerts

When you receive a budget alert, you can click **Analyze spend in detail** in the email to launch Optima and go directly to the segment of the budget with the issue and analyze the cause. To change or remove the alert, go to Budget Alerts from the navigation bar.

    ![ca-budget-alert.png](/img/ca-budget-alert.png)
