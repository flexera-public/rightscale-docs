---
title: Can I change my AWS Credentials in the Dashboard?
category: aws
description: Unfortunately, you cannot change the AWS Account Number once you've created a RightScale account.
---

## Background Information

When you added the AWS EC2 cloud to a RightScale account, user-defined credentials were automatically generated for you with the provided AWS credentials. Although you can select and use those credentials just like other user-defined credentials when you define inputs in the Dashboard, they will not be visible or editable under the typical location for user-defined credentials. (Design > Credentials)

There may be several reasons why you may find it necessary to change your AWS credentials at a later time.

* You need to update the RightScale account so that it uses your company's AWS credentials instead of your own personal AWS credentials.
* Your current AWS credentials were compromised and now you have to generate new cloud credentials and associate them with your account.
* You no longer have access to your AWS account's Secret Access Key. (Note: As of [April 21, 2014](http://aws.typepad.com/aws/2014/03/important-aws-account-key-change-coming-on-april-21-2014.html), you will no longer be able to retrieve the existing secret access key(s) for your AWS (root) account via the AWS Management Console.)
* You would like to change the security credentials (AWS Access Key ID and AWS Secret Access Key) associated with the RightScale account to use the security credentials of a user profile that you created using Amazon's Identity and Access Management (IAM) service in order to restrict the level of access that RightScale has to your AWS account.

* * *

## Answer

Unfortunately, you cannot change the AWS Account Number once you've created a RightScale account.

However, you can change your **AWS Access Key ID** , **Secret Access Key** and **x509 certificates** from the dashboard (Settings > Account Settings > Clouds). You must have 'admin' privileges to change cloud credentials. There will be a pencil icon beside the Actions column on the cloud name in any of the AWS Regions, clicking on the icon will popup a window where you can change the above information. (**Note**: If your main motivation is to change the credit card information, you can change it by logging into your AWS Account ( [http://aws.amazon.com](http://aws.amazon.com) ).

![faq-Add_AWS.png](/img/faq-Add_AWS.png)

### See also

* [Credentials](http://support.rightscale.com/12-Guides/Dashboard_Users_Guide/Clouds/AWS_Global/Credentials)
