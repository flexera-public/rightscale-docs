---
title: What are valid S3 bucket names?
category: aws
description: Although Amazon will allow you to use capital letters and periods in the namespace, it is not recommended because of the naming restrictions that are enforced by DNS.
---

## Background Information

Amazon S3 has a global namespace. (i.e. No two S3 buckets can have the same name.) It's similar to how DNS works where each domain name must be unique. Therefore, you need to use a unique bucket name when creating S3 buckets. Before you start creating S3 buckets, it's important to first understand valid syntax for bucket names as well as best practices.

* * *

## Answer

Although Amazon will allow you to use capital letters and periods in the namespace, it is not recommended because of the naming restrictions that are enforced by DNS. In order to conform with DNS requirements, we recommend following these additional guidelines when creating buckets:

* Bucket names should not contain upper-case letters
* Bucket names should not contain underscores (_)
* Bucket names should not end with a dash
* Bucket names should be between 3 and 63 characters long
* Bucket names cannot contain dashes next to periods (e.g., "my-.bucket.com" and "my.-bucket" are invalid)
* Bucket names cannot contain periods - Due to our S3 client utilizing SSL/HTTPS, Amazon documentation indicates that a bucket name cannot contain a period, otherwise you will not be able to upload files from our S3 browser in the dashboard. [More info here](http://docs.amazonwebservices.com/AmazonS3/latest/dev/BucketRestrictions.html)

**Valid Examples**

* my-eu-bucket-3
* my-project-x
* 4my-group

There is no limit to the number of objects that can be stored in an S3 bucket and no variation in performance when using many buckets or just a few. You can store all of your objects in a single bucket or organize them across several buckets. Buckets cannot be nested, meaning buckets cannot be created within buckets. The high availability engineering of Amazon S3 is focused on get, put, list, and delete operations. Because bucket operations work against a centralized, global resource space, it is not appropriate to make bucket create or delete calls on the high availability code path of your application. It is better to create or delete buckets in a separate initialization or set up a routine that you run less often.
