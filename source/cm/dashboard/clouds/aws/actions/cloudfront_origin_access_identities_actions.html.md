---
title: CloudFront Origin Access Identities - Actions
description: Common procedures for working with CloudFront Origin Access Identities in the RightScale Cloud Management Platform.
---

## View CloudFront Origin Access Identities

### Overview

Use the following procedure to view an individual or all CloudFront Origin Access Identities.

### Prerequisites

* AWS Account with the CloudFront Services enabled and Origin Access Identities created.

### Steps

* Navigate to **Clouds** > **AWS Global** > **CF Origin Access Identities**. All Origin Access Identities are displayed.
* Select an individual OAI to drill down on the details of a specific OAI. For example, the following information is displayed:

Below is more detailed information about your CloudFront Origin Access Identity.

* **Name** - A RightScale-specific name for the OAI.
* **ID** - A unique virtual identity that's used to give your distribution permission to fetch a private object from your origin server S3 bucket.
* **S3 Canonical User ID** - The User ID that's used to grant your OAI permission to access the objects you want to deliver as private content.
* **Caller Reference** - The is a unique value that's designed to prevent accidental replays of your request.
* **Comment** - Provide a description or notes about the OAI.

## Serving Private Content

### Overview

CloudFront distributions can be used to serve both public and private content. When you use CloudFront to serve "private content, CloudFront basically acts as a secure proxy between the user making the request and the object stored in S3. CloudFront either uses an Origin Access Identity or Signed URLs to validate each request for private content. There are two different ways to serve "private" content.

- **Origin Access Identity** - If you assign an OAI to a CF distribution, private content within the origin server (S3 bucket) can only be accessible via CloudFront. You will also need to add the OAI to a private object's ACL.
- **Trusted Signer(s) and Signed URLs** - You can also create temporary access to a private object by creating a signed URL that can be used to access a "private" object until the link expires (Default = 24 hrs). Only trusted signer(s) with at least one valid CloudFront Key Pair can generated signed URLs. If you are using this option, an Origin Access Identity is not required.

Use the procedure described below to create a CloudFront distribution that can be used for serving "private" objects in the origin server (S3 bucket).

### Prerequisites

* CloudFront is an additional service that's offered by Amazon that you must [sign-up](http://aws.amazon.com/cloudfront) for in order to use.
* Before you can create a distribution, you must first sign-up for the Amazon's CloudFront service. If you have not yet signed up, go to [http://aws.amazon.com/cloudfront](http://aws.amazon.com/cloudfront). Be sure to review their detailed [pricing](http://aws.amazon.com/cloudfront/#pricing)information.

### Steps

#### Create a CloudFront Distribution

Select which option you want to use to serve your "private" content. How you create and configure your CloudFront distribution will vary depending on which option is chosen.

**Option 1: Origin Access Identity**

**Create a New Origin Access Identity (OAI)**

The OAI is a virtual user identity that will be used to give your CF distribution permission to fetch a private object from your origin server (S3 bucket). Use the OAI to configure the distribution so that end users can only access objects in an Amazon S3 bucket (origin server) through a CloudFront distribution.

* Go to **Clouds** > **AWS Global** > **CF Origin Access Identities**.
* Click the **New Origin Access Identity** button. When you create a new OAI, Amazon will automatically assign an "ID" for the OAI, "S3 Canonical User ID" and "Caller Reference ID". You also have the option of providing a Name and Comment.
* Next, you can create the CF distribution. Be sure to select which OAI you want to assign to the distribution.

**Option 2: Trusted Signer(s) and Signed URLs**

You can also generate signed URLs that provide temporary access to a private object until the link expires. Only trusted signers can generate signed URLs. A trusted signer is identified by their AWS Account Number.

When you create a CF distribution, you can add a trusted signer to the distribution by adding a user's AWS account number. You can either include dashes in the account number of omit them. You can also add 'self' so that the current account can generate signed URLs. You must specify a valid AWS Account. See [Create a New CloudFront Distribution](/cm/dashboard/clouds/aws/actions/cloudfront_distribution_actions.html#create-a-new-cloudfront-distribution).

![cm-trusted-signers.png](/img/cm-trusted-signers.png)

The trusted signer must also create a valid key pair. Amazon will keep the private key. Unfortunately, you cannot create CloudFront Key Pairs within the Dashboard. See [Create Amazon CloudFront Key Pairs](/cm/dashboard/clouds/aws/actions/cloudfront_origin_access_identities_actions.html#create-amazon-cloudfront-key-pairs).

Only trusted signers with valid CloudFront Key Pairs will be able to generate signed URLs. In the screenshot below, only the (-8827) AWS Account can generate a signed URL because it has a valid CloudFront Key Pair.

![cm-trusted-signers-keys.png](/img/cm-trusted-signers-keys.png)

#### Configure the S3 Bucket and its Objects

The next step is to properly create/configure the S3 bucket ("origin server"), as well as set the appropriate access permissions for each object that will be available through the distribution. If you are serving private content, the ACL permissions on each object should already be set to 'private'.

**Option 1: Origin Access Identity**

The next step is to add the same OAI to the private object's ACL so that it matches the OAI that's been assigned to the CloudFront distribution. Currently, one way to accomplish this task is to follow the Ruby example below. The long string is the "S3 Canonical User ID" of the OAI. Once you add an OAI to an object's ACL, it can only be accessed via CloudFront.

~~~
#!/usr/bin/rubyrequire 'rubygems'require 'right_aws'origin_access_identity_s3_canonical_id = 'de4361b33dbaf499d3d77159bfa1571d3451eaec25a2b16553de5e534da8089bb8c31a4898d73d1a658155d0e48872a7's3 = Rightscale::S3::new(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)s3_key = s3.bucket('my-bucket').key('images/test.jpg')RightAws::S3::Grantee.new(s3_key, origin_access_identity_s3_canonical_id, ['READ'], :apply)
~~~

Use the CF distribution's domain to construct the url to access the "private" object.

* Domain: s2wy8yil0wmj58.cloudfront.net
* CNAME: assets.mysite.com
* Object: photo.jpg
* URLs to acesss the object
  * http://s2wy8yil0wmj58.cloudfront.net/photo.jpg
  * http://assets.mysite.com/photo.jpg&nbsp; (if using a CNAME)

**Option 2: Trusted Signer(s) and Signed URLs**

Currently, you will need to use a third party program such as S3Fox to generate the signed URLs.

1. Log into S3Fox. Right-click on the private object in the S3 bucket that you want to serve via CloudFront and select the "Get Pre-signed Urls" option.
2. Set the time when the link should expire (default = 24 hrs) and the desired protocol (http or https). The CloudFront Key Pair will be used to generate the signed url. Use the "Generate Urls" button to create multiple signed URLs for the same object.
3. Use the generated URL to provide temporary access to your private content. When the link expires, a user will receive an "Access Denied" message.

Another way to generate URLs for streaming private content from CloudFront is to use the following Ruby script.

* **access_key** - The public CloudFront Key Pair ID (e.g. APKAIPLHIYV3ENOQ3ENOQ)
* **private_key** - The private key that you received when you created the CloudFront key pair.&nbsp; In this example, a global hash config is used to reference the private key.
* **resource** - The CloudFront URL to the object you're trying to serve. (e.g. `http://s2wy8yil0wmj58.cloudfront.net/photo.jpg` or `http://assets.mysite.com/photo.jpg` if using a CNAME.)

~~~
require 'base64'
require 'openssl'
require 'sha1'# The following Ruby script will generate URLs for streaming private content from CloudFront# I have a global config hash for my private key for S3:# The access_key is the CloudFront key id you set up.# The private key is the private key you get when you create the key pair.# resource is the FULL CloudFront URL to the object you're trying to serve.class CloudFront include OpenSSL include PKey def self.generate_cloudfront_url(resource,time_unit=:hours,time_units=2) o = self.sign(resource,time_unit,time_units) "#{resource}?Expires=#{o[:expires]}&Signature=#{o[:signature]}&Key-Pair-Id=#{$S3_CONFIG['streaming']['access_key']}" enddef self.sign(resource,time_unit=:hours,time_units=2) expires = Time.now.advance(time_unit => time_units).to_i request_string = "{\"Statement\":[{\"Resource\":\"#{resource}\",\"Condition\":{\"DateLessThan\":{\"AWS:EpochTime\":#{expires}}}}]}" signature = self.generate_signature(request_string) {:expires => expires, :signature => signature} enddef self.generate_signature(request_string) private_key = RSA.new($S3_CONFIG['streaming']['private_key']) signature = private_key.sign(OpenSSL::Digest::SHA1.new,request_string) Base64.encode64(signature).gsub("\n","").gsub("+","-").gsub("=","_").gsub("/","~") endend
~~~

## Create Amazon CloudFront Key Pairs

### Overview

CloudFront uses access keys to authenticate requests you make to CloudFront. Trusted signers with at least one CloudFront key pair can create signed URLs that can be used to temporarily access private content that's stored in your origin server (S3 bucket).

Unfortunately, you cannot create CloudFront Key Pairs inside the Dashboard. You must create them using the AWS Management Console.

Use the procedure outlined below to generate an Amazon CloudFront key pair so that you can create signed URLs to access private content from a CloudFront distribution.

### Prerequisites

* AWS Account with the CloudFront Service enabled.

### Steps

* Log into your AWS Account at [http://aws.amazon.com](http://aws.amazon.com).
* Go to **Account** > **Security Credentials**.
* Under "Access Credentials" click the **Key Pairs** tab.
* You can either create a new key pair or upload the public key of an existing key pair.

![cm-create-cloudfront-key-pair.png](/img/cm-create-cloudfront-key-pair.png)

Each CloudFront key pair includes a public key, private key, and an ID for the key pair. You can only have up to two key pairs per AWS account.

Here is an example of a signed url:

~~~
http://mybucket.amazonaws.com/image.png?AWSAccessKeyId=YW6OAKIAAKIAJQCRVTSRQ&Expires=1274228859&Signature=OlnE7O5PSMz4pzaE7O5PRKD/ws%3D
~~~

Notice that the signed url contains the public CloudFront Access Key ID and an expiration date (default = 24 hrs).
