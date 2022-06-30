---
title: AWS Role-Based Onboarding
layout: optima_aws_layout_page
description: Onboarding a customer with AWS role-based access requires the customer to create an IAM role with a policy attached that grants access to the billing bucket. This policy should be attached to a role that has been set up with a trust relationship with the Flexera trusted account, using the customers RightScale Organization ID as the external id.
---

## Overview

[Onboarding a customer with AWS role-based access](/optima/getting_started/bill_connect/aws_rba.html#onboarding) requires the customer to create an IAM role with a policy attached that grants access to the billing bucket. This policy should be attached to a role that has been set up with a trust relationship with the Flexera trusted account, using the customers RightScale Organization ID as the external id.

Role-based onboarding is different from the traditional AWS on-boarding process, which requires the user to create an IAM user with programmatic (access and secret key) access.

AWS Role-Based Onboarding requires the following:
1. [Creating a New AWS IAM Policy for Optima](/optima/getting_started/bill_connect/aws_rba.html#required-setup-create-a-new-aws-iam-policy-for-optima)
2. [Creating an IAM User that Can Read AWS Billing Reports](/optima/getting_started/bill_connect/aws_rba.html#create-an-iam-user-that-can-read-aws-billing-reports)

## Required Setup

### Create a New AWS IAM Policy for Optima

To allow read-only access to your S3 billing bucket + metadata about the accounts referenced in your bill, create a new AWS IAM policy with the required Optima permissions (see example below).

<pre><code>{
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
}</code></pre>

###Create an IAM User that Can Read AWS Billing Reports

For Optima to digest your AWS bills, we require read access via an IAM user to the S3 bucket that you are exporting the bills to.

To create an IAM user that can read AWS billing reports:

1.	Create a New AWS IAM Policy for Optima.
2.	Create a new IAM user who only has the newly created policy attached. AWS has a tutorial that documents this process. For details, see [Creating an IAM User in Your AWS Account](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html).


## Onboarding
<i>To onboard a customer with AWS role-based access:</i>

!!warning*TIP*Steps 3 to 5 are all done at the same time in the AWS UI, which walks you through most of the manual effort shown here.

1.	Create and configure an S3 bucket.
2.	Configure AWS billing reports.
3.	Create a New AWS IAM Policy for Optima.
4.	Create a role in the AWS console and attach the role to the policy created in step 3.
5.	Create a trust relationship within the role and edit the policy JSON to include the following JSON payload:
<pre><code>{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Effect": "Allow",
       "Principal": {"AWS": "arn:aws:iam::451234325714:role/production_customer_access"},
       "Action": "sts:AssumeRole",
       "Condition": {
         "StringEquals": {"sts:ExternalId": "<org id>"}
       }
     }
   ]
 }</code></pre>
<i>Ensure you have the correct Orgnization ID entered where it says</i> `"<org id>"` <i>on line 9.</i>

6. Create a bearer token following this process.
7. Using the ARN for the role you created in step 4 + the bucket name + bucket path you created in step 1, make the following request to set up the bill connection:
<pre><code>curl -X POST -H "Authorization: Bearer <token>" https://onboarding.rightscale.com/api/onboarding/orgs/<org_id>/bill_connects/aws/iam_role -d '{"aws_bill_account_id": "", "aws_bucket_name": 1"","aws_bucket_path": "","aws_sts_role_arn": ""}'</code></pre>

!!danger*IMPORTANT*Make sure that you have completed the JSON payload with the correct values, including the Organization ID.

