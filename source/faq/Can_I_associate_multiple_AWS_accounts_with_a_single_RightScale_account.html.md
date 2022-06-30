---
title: Can I associate multiple AWS accounts with a single RightScale account?
category: general
description: Is it possible to associate a single RightScale account with Multiple AWS accounts? Or can I associate multiple RightScale accounts with the same AWS credentials?
---

## Background

Is it possible to associate a single RightScale account with Multiple AWS accounts? Or can I associate multiple RightScale accounts with the same AWS credentials?

## Answer

An AWS account number can only be associated with a single RightScale account. Alternatively, you cannot have multiple RightScale accounts that use the same AWS credentials (i.e., Access Key, Secret Key, x509, etc) for a given AWS cloud. If your [RightScale subscription](http://www.rightscale.com/products-and-services/products/pricing/) supports the use of multiple RightScale accounts, each RightScale account must be uniquely tied to AWS credentials that are not associated with another RightScale account. However, if you want to consolidate your AWS accounts so that you only receive a single bill at the end of the month for your cloud usage costs, use Amazon's consolidated billing option. See [Consolidated Billing for AWS Accounts](http://aws.amazon.com/about-aws/whats-new/2010/02/09/announcing-consolidated-billing-for-aws-accounts/).

**Questions? Concerns?**

Call us at **(866) 787-2253** or feel free to send in a support request from the RightScale dashboard (Support > Email).
