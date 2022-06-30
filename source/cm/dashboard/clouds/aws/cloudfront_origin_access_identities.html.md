---
title: CloudFront Origin Access Identities
description: The CloudFront Origin Access Identities page lists of all Origin Access Identities that were created by the RightScale account.
---

### Overview

The CloudFront Origin Access Identities page lists of all Origin Access Identities that were created by the RightScale account. An Origin Access Identity (OAI) is used for sharing "private" content via CloudFront. The OAI is a virtual user identity that will be used to give your CF distribution permission to fetch a private object from your origin server (e.g. S3 bucket).

To work with Origin Access Identities, navigate to **Clouds** > **AWS Global** > **CF Origin Access Identities**.

**Actions**

The following action buttons are available on the page.

* **New Origin Access Identity** - Create a new OAI object. In order to share private content through CF, you must have an OAI.

Below is more detailed information about your CloudFront Origin Access Identity.

* **Name** - A RightScale-specific name for the OAI.
* **ID** - A unique virtual identity that's used to give your distribution permission to fetch a private object from your origin server S3 bucket.
* **S3 Canonical User ID** - The User ID that's used to grant your OAI permission to access the objects you want to deliver as private content.
* **Caller Reference** - The is a unique value that's designed to prevent accidental replays of your request.
* **Comment** - Provide a description or notes about the OAI.

### Actions

* [Create Amazon CloudFront Key Pairs](/cm/dashboard/clouds/aws/actions/cloudfront_origin_access_identities_actions.html#create-amazon-cloudfront-key-pairs)
* [Serving Private Content](/cm/dashboard/clouds/aws/actions/cloudfront_origin_access_identities_actions.html#serving-private-content)
* [View CloudFront Origin Access Identities](/cm/dashboard/clouds/aws/actions/cloudfront_origin_access_identities_actions.html#view-cloudfront-origin-access-identities)

### Further Reading

* [Amazon CloudFront Getting Started Guide](http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/GettingStarted.html)
* [Amazon CloudFront Developer Guide](http://docs.amazonwebservices.com/AmazonCloudFront/latest/DeveloperGuide/)
