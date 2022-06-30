---
title: S3 Browser
description: In AWS S3, a Bucket is essentially a folder where you can store files. Think of S3 as one big hard drive that everyone shares. As a result, you will have to create unique bucket names.
---

## Overview

In AWS S3, a *Bucket* is essentially a folder where you can store files. Think of S3 as one big hard drive that everyone shares. As a result, you will have to create unique bucket names. You will not be able to create generic bucket names like "files" or "images." Therefore, it is a good idea to add your application name as a prefix to any bucket name (ex: myapp-images).

Inside your S3 bucket you can place all of the MySQL Backups for several MySQL servers by defining a unique prefix for each MySQL Master-DB server that you deploy.

Each AWS account can own up to 100 buckets at a time. Bucket ownership is not transferable but, if a bucket is empty, it can be deleted and its name can be reused. There is no limit to the number of objects that can be stored in a bucket and no variation in performance when using many buckets or just a few. You can store all of your objects in a single bucket or organize them across several buckets. Buckets cannot be nested, meaning buckets cannot be created within buckets.([Bucket Restrictions and Limitations](http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html))

As a rough analogy, you can think of S3 as one large hard drive that everyone shares. Within S3, a 'bucket' is essentially a folder where you can store files. To work with S3 buckets in RightScale navigate to **Clouds** > **AWS Global** > **S3 Browser** The S3 Browser lists all S3 buckets that are associated with this account. Select an individual bucket to view its contents.

## Actions

* [Create a New S3 Bucket](/cm/dashboard/clouds/aws/actions/s3_browser_actions.html#create-a-new-s3-bucket)
* [Delete an S3 Bucket](/cm/dashboard/clouds/aws/actions/s3_browser_actions.html#delete-an-s3-bucket)
* [Run S3 Analysis](/cm/dashboard/clouds/aws/actions/s3_browser_actions.html#run-s3-analysis)
* [Sign-Up for Amazon S3](/cm/dashboard/clouds/aws/actions/s3_browser_actions.html#sign-up-for-amazon-s3)
* [Upload Files to an Amazon S3 Bucket](/cm/dashboard/clouds/aws/actions/s3_browser_actions.html#upload-files-to-an-amazon-s3-bucket)

!!info*Note:* Although S3 buckets are very easy to set up and use, Amazon's Elastic Block Store (EBS), which provides persistent data storage on EC2, offers several tangible advantages including performance gains.
