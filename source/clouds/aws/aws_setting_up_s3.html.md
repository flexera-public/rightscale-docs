---
title: Setting Up AWS S3
layout: aws_layout_page
description: RightScale is dedicated to providing powerful and intuitive solutions and ways to take full advantage of Amazon Web Services. Deploying on AWS can save you time, money, and administrative effort compared to building and maintaining more traditional systems.
---

Amazon's Simple Storage Service (S3) allows you to create 'buckets' (containers) for storing data such as images, database dump files, and database backups.

### Prerequisites

* Access to log into the AWS console and sign-up for cloud services. You cannot sign-up for the S3 service from the RightScale Dashboard.

### Steps

#### Sign-up for Amazon S3

Before utilizing the remote storage capabilities of AWS S3 from within RightScale, you must Sign-Up for Amazon S3.

#### Create Cloud Credentials

You must specify the following information when you upload objects to an S3 bucket or retrieve "private" objects from a bucket. Fortunately, credentials are automatically created when the AWS cloud is added to a RightScale account.

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

If you are using ServerTemplates published by RightScale, many of them contain scripts for interacting with various remote object storage services like S3. Although, you will not find the following AWS credentials under the common location for user-defined credentials (Design > Credentials), you will be able to select them when you set up inputs.

[![screen_Select_AWS_Key_v1.png](/img/aws-Select-AWS-Key.png)

### Further Reading

* [Create a New S3 Bucket](/cm/dashboard/clouds/aws/actions/s3_browser_actions.html#create-a-new-s3-bucket)
* [Upload Files to an S3 Bucket](/cm/dashboard/clouds/aws/actions/s3_browser_actions.html#upload-files-to-an-amazon-s3-bucket)
* [Can I change my AWS Credentials in the Dashboard?](/faq/clouds/aws/Can_I_change_my_AWS_Credentials_in_the_Dashboard.html)
