---
title: CloudFront Distributions - Actions
description: AWS CloudFront reduces web content delivery latency by using a distributed network of servers pushed out to the edge. This tutorial will step you through setting up a CloudFront distribution through the RightScale Cloud Management Dashboard.
---

## Create a New CloudFront Distribution

### Overview

AWS CloudFront reduces web content delivery latency by using a distributed network of servers pushed out to the edge. This tutorial will step you through setting up a CloudFront distribution through the RightScale Dashboard.

To create a CloudFront (CF) distribution that will be used to serve objects stored in an S3 bucket. You can either create a "basic" CF distribution for downloading objects over standard HTTP/HTTPS protocol or a "streaming" distribution for streaming on-demand media files over [RTMP](http://en.wikipedia.org/wiki/Real_Time_Messaging_Protocol)(Real Time Messaging Protocol). Objects can either be shared publicly or privately.

### Prerequisites

* CloudFront is an additional service offering of Amazon's that you must [sign-up](http://aws.amazon.com/cloudfront) in order to use it.
* Before you can create a distribution, you must first sign-up for the Amazon's CloudFront service. If you have not yet signed up, go to [http://aws.amazon.com/cloudfront](http://aws.amazon.com/cloudfront). Be sure to review their detailed [pricing](http://aws.amazon.com/cloudfront/#pricing)information.

### Steps

#### Configure the S3 Bucket and its Objects

First you must properly create/configure an S3 bucket, as well as set the appropriate access permissions for each object that will be available through the distribution.

**Compatible S3 Bucket Names**

In order for an S3 bucket to be compatible with CloudFront, it must conform to DNS requirements. Therefore, you may need to create a new S3 bucket. Follow the naming convention guidelines to create a valid S3 bucket for CloudFront. See [S3 Bucket Names for CloudFront](/cm/dashboard/clouds/aws/cloudfront_distribution.html#s3-bucket-names-for-cloudfront).

**Serving Public or Private Content**

You can either use CloudFront to distribute public or private objects in an S3 bucket.

* **Public** - If you are planning to set up a CloudFront distribution for serving publicly accessible content, be sure to set an object's permissions to 'public-read'. Go to the S3 bucket that will serve as the "origin server" for the distribution and change your objects' permissions accordingly.
* **Private** - If you are planning to set up a CloudFront distribution for serving private content, see [Serving Private Content](/cm/dashboard/clouds/aws/actions/cloudfront_origin_access_identities_actions.html#serving-private-content).

#### Configure a CNAME (optional)

!!info*Note:* If you do not want to use a CNAME, you can skip this step. If you wish to use a CNAME, you must first make sure that you register the domain with your DNS provider.

CloudFront will create a unique ID and url for accessing a distributed object. (e.g. http://mybucket.s3.amazonaws.com/ssh.png) However, if you want to create a link that uses your domain and hides any reference to CloudFront, you can define a CNAME or domain, which will provide another URL for accessing the object. For example, we could define "assets.rightscale.com" as a CNAME for the distribution. You can then access the same object with the following URL: http://assets.rightscale.com/ssh.png.&nbsp; If you configure a CNAME, both URLs can be used to access the object.

You can define up to 10 CNAMEs per distribution. CNAMEs are useful for customizing an object's URL so that it appears as though the file is being served from you and not from AWS.

#### Create a CloudFront Distribution

* Go to **Clouds** > **AWS Global** > **CF Distributions**. When creating a new distribution, you must select which type of distribution that you want to create. Click the appropriate action button below that best serves your needs.
  * **New Basic Distribution** - use for downloading content over HTTP or HTPS
  * **New Streaming** Distribution - use for serving streaming media files over RMTP
* Provide the following information:
  * **Nickname** - A short nickname that helps you recognize the distribution.
  * **Comment** - (optional) Provide a brief description about the distribution. Maximum length of 128 characters. It can be edited at any time.
  * **Origin Type** - The content that's delivered by CloudFront is stored on an origin server. You can either use an S3 bucket as the origin server or select 'custom' to define a different origin server that exists outside of S3.  
  * **S3**
    * **S3 Bucket** - Select the S3 bucket that will serve as the "origin server" for your CF distribution where master copies of the objects are stored. Once you create a distribution, you can't change the S3 bucket that's associated with it. Also, the selected S3 Bucket can only have lower case alphanumeric characters, dots, and dashes in its namespace. By default, only S3 buckets with valid names will be displayed in the dropdown menu.
    * **Origin Access Identity** - (for serving private content only) The virtual identity that will be used to give your CF distribution permission to fetch a private object from your origin server (S3 bucket). Use the OAI to configure the distribution so that end users can only access objects in an Amazon S3 bucket (origin server) through a CloudFront distribution.
  * **Custom**
    * **DNS name** - Specify the origin to associate with the CF distribution. You must use a valid DNS name. Ex: www.site.com
    * **HTTP port** - The HTTP port the custom origin listens on. Ex: 80
    * **HTTPS port** - The HTTPS port the custom origin listens on. Ex: 443
    * **Origin protocol policy** - The original protocol policy to apply to your origin.
      * **http-only** - CF will only access and fetch objects from the origin server using HTTP.
      * **match-viewer** - CF will use either HTTP or HTTPS to access and fetch objects from the origin server based on the protocol of the client request.
  * **CNAME(s)** - (optional) Provide a CNAME(s) to be used to access distributed objects. Associate a CNAME alias with a distribution so that you can include your own domain name in the object's url instead of the one that Amazon assigns it (ex: http://assets.mysite.com/image.jpg). (*Note*: You must first register any domain that you specify as a CNAME with your DNS provider.)
  * **Trusted Signer(s)** - (for serving private content only) Comma-separated list of AWS accounts that have permission to create signed URLs for a given distribution's content.
  * **Default root object** - Designates a default root object that will be served when a client request points to your distribution's root url instead of a specific object in your CF distribution. (Ex: index.html)
  * **Logging bucket** - If you want logging enabled, specify the location of the S3 bucket where gzipped access log data will be stored. (e.g. mybucket.s3.amazonaws.com) Log data will be saved as a gzipped file in a 'logging' folder in the specified S3 bucket. Leave this field blank to disable logging.
  * **Logging prefix** - An optional prefix that can be prepended to the gzipped file name. (e.g. my/log/path/)
    * Example Format: `{Bucket}.s3.amazonaws.com/{OptionalPrefixYouChoose}{Distribution ID}.{YYYY}-{MM}-{DD}-{HH}.{Unique ID}.gz`
    * Example: **`myapplogs`** `.s3.amazonaws.com/myappprefix/EMLARXS993KSTG8.2009-03-17-20.RT4KCN4SGK9.gz`
  * **Enabled** - Add a checkmark to enable the distribution and make it active.
* Click the **Create** action button when ready.

### Troubleshooting

If you see this message... **"InvalidArgument: The parameter Origin does not refer to a valid S3 bucket."** ...you might have to rename your S3 bucket. In order for an S3 bucket to be compatible with CloudFront, it must conform to DNS requirements. See [S3 Bucket Names for CloudFront](/cm/dashboard/clouds/aws/cloudfront_distribution.html#s3-bucket-names-for-cloudfront).

When any changes are made to a distribution, it will take a couple of minutes to take effect. Wait for the status of the distribution to change from "InProgress" to "Deployed."

!!info*Note:* Before an object is available through CloudFront, you must enable the distribution.

## View CloudFront Distributions

### Overview

Use the following procedures to view individual CloudFront Distributions or all existing CloudFront Distributions

### Prerequisites

* CloudFront is an additional service offering of Amazon's that you must [sign-up](http://aws.amazon.com/cloudfront) in order to use.

### Steps

#### View all CloudFront Distributions

* Navigate to **Clouds** > **AWS Global** > **CF Distributions**
  * All CloudFront Distributions are displayed
  * Use the Filter by to help locate a specific distribution if there are many

![cm-index-cloudfront-distribution.png](/img/cm-index-cloudfront-distribution.png)

#### View a Single CloudFront Distribution

* Select a distribution to view more specific details. (That is, select a Nickname link from your CloudFront Distributions (above) to see the detailed distribution information shown and described below.)

![cm-cf-distro-details.png](/img/cm-cf-distro-details.png)

This page displays the following CloudFront information:

* **ID** - Unique ID that is auto-generated by AWS during the creation process.
* **Type** - The type of CF distribution (basic or streaming)
* **Origin type** - The type of storage that will be used as the origin server, which stores master copies of the assets that will be served by CloudFront. (e.g. S3 or custom)
* **Domain** - The CloudFront domain name you need to use when linking to your objects. (e.g. d60472d6047qy9.mysite.com). You will use the domain name to construct a link to an object.
* **DNS name** - The DNS name of the origin server. (e.g. For S3, it would be 'mybucket.s3.amazonaws.com')
* **S3 Bucket** - Name of the S3 bucket that will serve as the "origin server" for your distribution. It will contain the master copies of your objects. (e.g. mybucket)
* **Origin Access Identity** - The virtual identity that will be used to give your CF distribution permission to fetch a private object from your origin server (S3 bucket). Use the OAI to configure the distribution so that end users can only access objects in an Amazon S3 bucket (origin server) through a CloudFront distribution.
* **CNAME(s)** - List of CNAME(s) that will be used for served objects. (e.g. assets.mysite.com)
* **Default root object** - The default root object that will be served when a client request points to your distribution's root url instead of a specific object in your CF distribution. (Ex: index.html)
* **Trusted Signer(s)**: Comma-separated list of AWS accounts that have permission to create signed URLs for a given distribution's content. To add your own AWS account, add 'self' to the list. (You cannot create signed URLs in the Dashboard. However, once you create them in the AWS Console, they will be displayed here.)
* **Active Trusted Signer(s)**: Only trusted signers with valid keys can create signed URLs. (You cannot create a key pair in the Dashboard. However, once you create them in the AWS Console, they will be displayed here.)
* **Logging** - Is logging enabled for this CF distribution? (Enabled or Disabled)
* **Status** - Current status of the distribution. Deployed (ready to use) or InProgress (created or updated, but not quite ready for use)
* **Enabled** - Enabled (distribution is working and accessible) or Disabled (access to this distribution is no longer available)
* **HTTPS only** - If enabled, only HTTPS requests are permitted. If not disabled, both HTTP and HTTPS requests are permitted.
* **Locked** - Lock a distribution to prevent any changes from being made to the distribution's configuration. Objects can still be added to the origin server.
* **Last modified** - Date and timestamp when the distribution was last modified.
* **Comment** - Optional information about the CF distribution. Maximum length of 128 characters. It can be edited at any time.
