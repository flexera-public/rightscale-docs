---
title: Connect Amazon Web Services Platform to Optima for Cost Reporting
layout: optima_aws_layout_page
description: This page walks you through the steps to connect Amazon Web Services (AWS) to Optima for cost reporting purposes.
alias: ca/ca_connect_aws_compute_to_RightScale_for_cost_reporting.html
alias: clouds/aws/aws_connect_aws_compute_to_RightScale_for_cost_reporting.html
---

## Background

Optima uses **bill data** to provide an accurate view of your costs across accounts and services. This data is consumed by the Optima platform and made available for pre-built and ad-hoc analyses. In order to gather the cost information, certain configuration steps must be performed with specific data and credentials being shared with Optima.

This page describes the configuration and input information needed to connect AWS billing data to Optima.

For instructions on using Optima to add or update billing information, see [the billing information guide](index.html).
For instructions on connecting your cloud accounts to Policy Manager, see the [policy users guide](/policies/users/guides/credential_management.html#provider-specific-credentials--aws-)

If you have any questions and would like assistance, please join our community at [community.flexera.com](https://community.flexera.com/) or email us at [support@flexera.com](mailto:support@flexera.com).

## Overview

This page will walk you through the steps to configure Amazon Web Services for cost reporting purposes in Optima.

The following steps must be completed in order for RightScale to provide insight on your AWS bill:

1. [Enable Cost and Usage Reporting on your AWS account](#enable-cost-and-usage-reporting-on-your-aws-payer-account-)
1. [Cost and Usage Report](#cost-and-usage-report-)
    1. [Use existing AWS Cost and Usage Report](#cost-and-usage-report--use-existing-cost-and-usage-report-) - *Preferred*
    1. [Configure new AWS Cost and Usage Report](#cost-and-usage-report--configure-new-cost-and-usage-report-)
1. [Configure Access to AWS for Optima](#configure-access-to-aws-for-optima-)
    1. [Create IAM Policy](#configure-access-to-aws-for-optima--create-iam-policy--cross-account-role-and-iam-user--)
    1. [Create a cross-account IAM role that can read billing reports](#configure-access-to-aws-for-optima--create-a-cross-account-iam-role--preferred--) - *Preferred*
    1. [Create an IAM user that can read billing reports](#configure-access-to-aws-for-optima--create-an-iam-user--legacy--)
1. [Submit the information to Optima](#submit-the-information-)

Each of the steps above is explained in detail on this page.

## Enable Cost and Usage Reporting on your AWS payer account

In order to obtain all of the detail required to accurately display your cost information, we require you to enable the AWS Cost and Usage report. If your account is part of a consolidated billing group, this action must be performed on the master payer account. This process is detailed in the AWS documentation referenced in the "Cost and Usage Report" subsection below.

## Cost and Usage Report

### Use Existing Cost and Usage Report

If you already have an AWS Cost and Usage report configured, we recommend using it provided it is configured with the following options:

1. `Include resource IDs` enabled
1. `Data refresh settings` enabled
1. `Time granularity` set to `Hourly`
1. `Report versioning` set to `Create new report version`
1. `Compression type` set to GZIP

Once these settings are confirmed, take note of the `S3 bucket` the reports are being sent to as well as the value for `Report Prefix` and continue to the [Configure Access to AWS for Optima](#configure-access-to-aws-for-optima-) section.

### Configure New Cost and Usage Report

If you do not have an existing Cost and Usage Report, or your current one does not have the proper configuration, you will need to create a new one.  The numbered instructions below refer to the steps described in the [AWS documentation](https://docs.aws.amazon.com/cur/latest/userguide/cur-create.html) and will walk you through creating a Cost and Usage Report that is saved to S3.

![create_billing_report.gif](/img/create_billing_report.gif)

1. On the top-right of the console, hover over your name and select `My Billing Dashboard`.
1. Select `Cost & Usage Reports` on the left-hand menu.
1. Click `Create report`.
1. Enter a `Report Name` of your choosing.
1. Check the box for `Include resource IDs`.
1. Ensure the checkbox for `Data refresh settings` is checked.
1. Click `Next`.
1. Select your existing `S3 Bucket` or create one and click `Next`.
    1. Take note of the `S3 Bucket` for later use.
1. Check the box to confirm the bucket policy is correct and click `Save`.
1. Enter a `Report Prefix`.  **Required**: Can be a simple value like "aws-billing-reports"
    1. Take note of the `Report Prefix` for later use.
1. Ensure `Hourly` is selected for `Time granularity`.
1. Ensure `Create new report version` is selected for `Report versioning`.
1. No boxes need to be checked under `Enable report data integration for`.
1. Ensure `GZIP` is selected as the compression type.
1. Click `Next`.
1. Click `Review and Complete`.

## Configure Access to AWS for Optima

In order to digest your bills, we require read access to the S3 bucket that you are exporting the bills to. This can be accomplished via a cross-account role (preferred), or an IAM user (legacy).

If you have elected to use a cross-account role, the following AWS Cloud Formation Template (CFT) automates the creation of the IAM role, IAM policy, and outputs the Role ARN required to submit the billing information to Optima.

1. [Apply CFT in master payer account](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?templateURL=https://s3.amazonaws.com/optima-cft/FlexeraOptimaAccessRole.cft.json&stackName=FlexeraOptimaAccess)
    * [CFT JSON reference](https://s3.amazonaws.com/optima-cft/FlexeraOptimaAccessRole.cft.json)
1. Capture the value for `RoleARN` from the CFT Outputs
1. [Submit the information to Optima](#submit-the-information-)

### Create IAM Policy (Cross-Account Role and IAM User)

To allow read-only access to your S3 billing bucket + metadata about the accounts referenced in your bill, create a new AWS IAM policy with the required Optima permissions. Simply replace the `YOUR_BILLING_BUCKET_NAME_HERE` with your bucket name. Please take care not to delete the trailing `/*` in the `s3:GetObject` permission.

!!warning*TIP*This IAM policy applies to both the cross-account role and IAM user options.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::YOUR_BILLING_BUCKET_NAME_HERE"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::YOUR_BILLING_BUCKET_NAME_HERE/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "organizations:Describe*",
                "organizations:List*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ce:GetReservationUtilization"
            ],
            "Resource": "*"
        }
    ]
}
```

### Create a Cross-Account IAM Role (Preferred)

Use the following steps to create a cross-account role that with read access to the S3 bucket that contains your Cost and Usage Report + metadata about the accounts referenced in your bill:

[AWS Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_cross-account-with-roles.html)

1. In AWS IAM, select Role and then click `Create role`.
1. Select `Another AWS account`
1. For Account ID, enter `451234325714`
1. Check the box for `Require external ID` and enter your Optima organization id.
    1. Your CMOptimaP organization id can be found in the Optima url once you are logged in: `https://analytics.rightscale.com/orgs/<ORG_ID>/dashboard`
1. Click `Next`.
1. Select the Optima role you created previously, or create a new policy by selecting `Create policy`, selecting `JSON` and supplying the IAM policy referenced above.
1. Click `Next: Tags`
1. Provide any tags required by your company policies.
1. Click `Next: Review`
1. Provide a `Role name` and optionally a `Role description`
1. Click `Create role`
1. Find the newly created role and copy the `ARN` for the next step
1. [Submit the information to Optima](#submit-the-information-)

### Create an IAM User (Legacy)

Use the following steps to create an IAM user with read access to the S3 bucket that contains your Cost and Usage Report + metadata about the accounts referenced in your bill:

1. Create a new IAM policy (see example above) which will allow read-only access to your S3 billing bucket, and to metadata about the accounts referenced in your bill.
1. Create a new IAM user which only has the newly created policy attached. AWS has a [tutorial](http://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_managed-policies.html) which documents this process.
1. Capture the `access key id` and `secret access key` for the next step
1. [Submit the information to Optima](#submit-the-information-)

We have also provided an example of this procedure in the animation below:
![ca-add-iam.gif](/img/ca-add-iam.gif)

## Submit the Information

Follow the [billing configuration guide](/optima/guides/billing_configuration.html) to submit the above information to Optima.
