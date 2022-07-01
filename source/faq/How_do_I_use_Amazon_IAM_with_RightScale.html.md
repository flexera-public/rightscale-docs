---
title: How do I use Amazon IAM with RightScale?
category: general
description: IAM is a feature specific to Amazon Web Services that provides a way of securely controlling access to your AWS services and resources.
---

## Overview

### What is AWS Identity and Access Management (IAM)?

IAM is a feature specific to Amazon Web Services that provides a way of securely controlling access to your AWS services and resources. Simply create users or groups and assign them the desired access permissions. For example, you might want to restrict who can launch and terminate EC2 instances. To learn more, see [AWS Identity and Access Management (IAM)](https://aws.amazon.com/iam/).

### Can I use IAM with RightScale?

Yes. Since RightScale maintains its own database of users for its platform, you cannot enforce individual IAM users and permissions within the RightScale Dashboard itself (assuming those same users have access to log in to the related RightScale account).

## How do I connect my AWS Account to RightScale using IAM?

Perhaps you're currently using IAM to manage your AWS account's resources and services and wish to grant RightScale access to your account by using an IAM user instead of using your account's default security credentials. (e.g. AWS Access Key ID and AWS Secret Access Key)

Follow the steps below to create a user profile in IAM that's specifically designed for use by the RightScale platform to access and manage your account.

1. Log in to the AWS Management Console ( [https://aws.amazon.com](https://aws.amazon.com) )
2. Go to the IAM section.

    ![faq-IAM-Link.png](/img/faq-IAM-Link.png)

3. Go to the **Users** section in the left-hand navigation pane and click **Create New Users**.
4. Create a new user profile that the RightScale platform will use to access and manage your AWS account's resources and services. (e.g. RightScale) Make sure you auto-generate an access key because you will need it to add/update the AWS credentials associated with your RightScale account.
    <div style="border: thin solid #76899A">
        <img src="/img/faq-IAM_Create_User.png" alt="AWS IAM Create User Dialog">
    </div>

5. The next step is to define the User Policy (i.e. user permissions) that will be granted to the new (RightScale) user. There are two primary use-cases -- Cloud Management & Optima, or Optima only each with it's own User Policy.  Below are the recommended Policies, and you should use the one that matches the use-case for the AWS Account you are connecting to RightScale.
<br />
We recommend using an AWS Managed Policy as new features/services are released by AWS and RightScale, you will gain access to the new functionality immediately and AWS will update the policy as needed.  Below are the names of the AWS Managed policies and depending on your use-case you only need to attach one to the IAM User:

&nbsp;          |  Cloud Management & Optima  | Optima Only
 -------------  | ------------- | -------------
AWS Managed Policy Name | `AdministratorAccess`  | `ReadOnlyAccess`
<br />
<i>Alternatively</i>, you can create a custom IAM Policy which is more restrictive and includes only the permissions that RightScale currently needs.  Over time, this will likely need to be updated to gain access to new features/functionality, but this is the current minimum required permissions as of today:
<br />
[[[
### Cloud Management & Optima
``` json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "cloudfront:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "s3:*",
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Action": "elasticloadbalancing:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "sqs:*",
            "Effect": "Allow",
            "Resource": "arn:aws:sqs:*"
        },
        {
            "Action": "rds:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "sns:*",
            "Effect": "Allow",
            "Resource": "arn:aws:sns:*"
        },
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "cloudformation:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "directconnect:*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": "route53:*",
            "Effect": "Allow",
            "Resource": "arn:aws:route53:::*"
        },
        {
            "Action": [
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:ListMetrics"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "iam:DeleteServerCertificate",
                "iam:GetServerCertificate",
                "iam:ListServerCertificates",
                "iam:UpdateServerCertificate",
                "iam:UploadServerCertificate"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:iam::*:server-certificate/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GenerateCredentialReport",
                "iam:GenerateServiceLastAccessedDetails",
                "iam:Get*",
                "iam:List*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "organizations:Describe*",
                "organizations:List*"
            ],
            "Resource": "*"
        }
    ]
}
```
###
### Optima Only
``` json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:Describe*",
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "iam:GenerateCredentialReport",
                "iam:GenerateServiceLastAccessedDetails",
                "iam:Get*",
                "iam:List*"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "organizations:Describe*",
                "organizations:List*"
            ],
            "Resource": "*"
        }
    ]
}
```
###
]]]
&nbsp;6. Save the user's security credentials -- this will be used to connect the AWS Account to a RightScale Account
  - `Access Key ID`
  - `Secret Access Key`

    <div style="border: thin solid #76899A">
    <img src="/img/faq-IAM_User_Creds.png" alt="AWS IAM User Credentials">
    </div>

&nbsp;7. Once you have applied a policy to the User and saved the `Access Key ID` and `Secret Access Key`, you are now ready to <b>[Connect the AWS Account to a RightScale Account](/clouds/aws/aws_quick_start.html#add-aws-add-aws-account-credentials)</b>.


## Additional information

### Common Use Cases

Typically, most users use their account's security credentials when they add AWS to a RightScale account, which effectively grants administrator level access to the RightScale platform. Administrators will then leverage RightScale's [User](http://support.rightscale.com/15-References/Tables/User_Role_Privileges) [Role Privileges](http://support.rightscale.com/15-References/Tables/User_Role_Privileges) to further enforce access permissions on a per-user basis. However, if you do not want to grant the RightScale platform administrative access to your AWS account and thereby restrict what actions can be performed from the RightScale Dashboard/API, you can create a user profile in IAM and associate its security credentials with a RightScale account for more granular access control. For example, you may not want users of your RightScale account to be able to create Amazon S3 buckets or change ACLs of individual objects. In such cases, you can create a 'RightScale' user profile and create a custom user policy that doesn't permit the use of Amazon's S3 object storage service. Once that 'RightScale' user's AWS security credentials are associated with a RightScale account, user functionality within the RightScale Dashboard/API will reflect the new user policy that's being used, so some functionality within the RightScale Dashboard/API may no longer be accessible.

### Will users in IAM have the same permissions in RightScale?

No, not necessarily. In AWS, each user defined in the IAM service will have a unique set of AWS security credentials (Access Key ID and Secret Access Key) as well as a User Policy that's designed to control what that user can do inside the AWS Management Console. However, in the RightScale Cloud Management Dashboard/API, a user's ability to manage the AWS account's resources and services is defined by which AWS security credentials are associated with the RightScale account. See [Sign up for Amazon Web Services (AWS)](http://support.rightscale.com/03-Tutorials/01-RightScale/3._Upgrade_Your_Account/1.5_Sign-up_for_AWS). Therefore, if a user has access to log in to both the AWS Management Console and its associated RightScale account and the security credentials either match or have a user policy that has the same set of permissions, a RightScale user may be able to perform the same functions in both user interfaces. Of course, another factor that must also be taken into consideration is what [User Role Privileges](http://support.rightscale.com/15-References/Tables/User_Role_Privileges) the user has been granted in the RightScale account, which may further restrict what that user can do inside the RightScale Dashboard/API even if the RightScale account itself has the same level of access as their user policy. For example, a RightScale user still needs 'actor' user permissions in a RightScale account in order to launch and terminate instances from the RightScale Dashboard/API.
