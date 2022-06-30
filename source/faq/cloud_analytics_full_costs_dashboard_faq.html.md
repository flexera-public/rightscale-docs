---
title: Optima full costs dashboard FAQ
category: general
description: The RightScale Optima dashboard is your view into all your costs, across multiple cloud providers. Below is the FAQ for this dashboard.
---

## Background

The Optima dashboard is your view into all your costs, across multiple cloud providers. Below is the FAQ for this dashboard.

### What is the new Optima dashboard and what does it show?
This is our new Optima dashboard, which replaces our old dashboard. The functionality of the old dashboard is still available on the Instance Analyzer.<br><br>
This new dashboard will show you all your AWS costs across all your consolidated bill if you have connected your Payer account to RightScale via [Hourly Cost and Usage CSV Reports](/clouds/aws/aws_connect_aws_compute_to_RightScale_for_cost_reporting.html). It will also show you all your costs across your [Azure Enterprise Agreement](/clouds/azure/azure_connect_azure_enterprise_agreement_to_RightScale_for_cost_reporting.html), and also your full [Google Compute Engine](/clouds/google/getting_started/google_connect_google_compute_engine_to_RightScale_for_cost_reporting.html) costs.<br><br>
The rest of the product is still focused on helping you analyze your instance usage only.

### Who has access to this dashboard and how can I give access?
Anyone who has the [ca_user role](/cm/ref/user_roles.html#-ca_user) role on your RightScale account can see Optima. Please see the [roles](/cm/ref/user_roles.html) page</a>.<br><br>
If you give access to a user to the payer account, they will be able to see full costs of the consolidated bill. If you'd like to give access to only specific accounts, then give permissions at those levels (RightScale child accounts).

### Does this dashboard show my historic costs?
In some cases, it does. [Click here](/ca/ca_costs_explained.html#historical-data-cost) for more information.

### How does this dashboard work?
[Optima Costs Explained](/ca/ca_costs_explained.html#costs-on-the-dashboard)


### How often is the data updated?
The data in the dashboard is updated once every 24 hours. The data on the Instance Analyzer is updated every few hours. The prices within Scenario Builder are updated within a few days of a price change.

### Why does the dashboard not match the Instance Analyzer?
There are a few reasons why the dashboard does not match the Instance Analyzer:
* The dashboard will show you all your costs for AWS, Azure and Google and instance costs from other cloud providers. The Analzye page only shows instance costs for all cloud providers.
* The AWS proportion of the bill marked as 'compute' or 'EC2' in the dashboard also includes EBS costs as this is what AWS return.
* The Instance Analyzer does not take into account upfront payments for Reserved Instances, whereas the dashboard does.
* If you are using AWS Consolidated Billing, make sure that all of your AWS Accounts are connected to your RightScale Accounts.
* RightScale Cloud Management does not currently support AWS Asia Pacific (Seoul), Asia Pacific (Mumbai), and GovCloud (US). Instance usage/costs from these regions are not available in the Instance Analyzer, but account-level costs for these regions are available in the Optima Dashboard.
* Also when looking at the Instance Analyzer, make sure you do not have any filters selected. <br>

If these costs still do not match and the difference is significant, please email [support@rightscale.com](mailto:support@rightscale.com) with the details along with your actual AWS Billing for comparison.

### Why does this dashboard not match my AWS bill?
In some cases, data for Dashboard might be coming from CloudWatch (only if you are set up this way in a legacy setup). In this case:

* AWS does not report subscription charges from CloudWatch. These include Reserved Instance upfront charges, and depending on how you are charged for support costs, these might be missing from CloudWatch also. If you register your AWS account with RightScale, we can poll the AWS API to fetch the EC2 Reserved Instance upfront charges; we only support this for EC2 currently.
* Additionally, CloudWatch doesn't actually report your final bill as a metric, but rather the 'estimated cost'. The final 'estimated cost' datapoints arrive some time after the end of the month, but still are a few percent below the actual final bill. The AWS CloudWatch team are aware that this is not ideal and feature request ID 0059899589 exists to make the final total available through the CloudWatch API. Feel free to contact your AWS account manager and add your support for this feature request.

### Why don't I see AWS account names in Optima?

In order to see AWS account names, the Cost and Usage Report CSV from AWS must be connected to RightScale **and** the IAM policy used must contain the below stanza. Learn more about connecting your bills and find the [complete IAM policy details here](/clouds/aws/aws_connect_aws_compute_to_RightScale_for_cost_reporting.html#create-an-iam-user-for-rightscale).

~~~
    {
        "Effect": "Allow",
        "Action": [
            "organizations:Describe*",
            "organizations:List*"
        ],
        "Resource": "*"
    }
~~~

### Do you have an API for this information?
Yes, please see [Optima API documentation](/ca/analytics_api.html) for details.

### I'd like more information, where can I go?
You can visit [Flexera.com](https://www.flexera.com) for more information about Optima in general, and you can always get in touch with us on [sales@flexera.com](mailto:sales@flexera.com) who are more than happy to give you a live walk through of the entire product.
