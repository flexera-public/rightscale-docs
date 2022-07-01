---
title: AWS Metadata
layout: aws_layout_page
description: RightScale will automatically download the metadata for your instance into `/var/spool/cloud`. The data can then be used by your scripts by simply sourcing the metadata files in this directory.
---

## Overview

RightScale will automatically download the metadata for your instance into `/var/spool/cloud` (/var/spool/ec2 for RightLink =< 5.6). The data can then be used by your scripts by simply sourcing the metadata files in this directory.

**Note**: For a complete description of EC2 metadata, see the [EC2 Developer Guide: Instance Metadata](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html).

## Sourcing the Metadata

The code samples below show how to source the metadata file. It performs a real-time refresh of an instance's metadata before including them in your environment. Since metadata can change, you might want to make sure that you always use the latest metadata.

However, if you prefer to use the cached value of the metadata from a previous fetch, you can source `/var/spool/meta-data-cache` directly.

### Ruby Example

~~~ ruby
#! /usr/bin/ruby
require '/var/spool/cloud/meta-data.rb'
~~~

### Bash Example

~~~ bash
#! /bin/bash
source /var/spool/ec2/meta-data.sh
~~~

## Metadata as Environment Variables

After sourcing the file as shown above, all of the metadata downloaded from AWS will be made available as ENVIRONMENT variables. However, they are named slightly different than the raw response from the API (see below).

* Ruby example - `ENV['EC2_PUBLIC_HOSTNAME']`
* Bash example - `$EC2_PUBLIC_HOSTNAME`

The naming convention used for these environment variables is as follows. Each variable is prepended with an "EC2_" prefix. Also, any variables that exist in a lower level of the 'tree' such as 'block-device-mapping' will be flattened into a single name using underscores. For example, block-device-mapping/root becomes **$EC2_BLOCK_DEVICE_MAPPING_ROOT**.

Here is an example of metadata that was downloaded for a 32bit small EC2 instance. (Sensitive values have been removed.)
~~~  
EC2_KERNEL_ID='aki-9b00e5f2'
EC2_SECURITY_GROUPS='default'
EC2_AMI_ID='ami-d8a347b1'
EC2_BLOCK_DEVICE_MAPPING_ROOT='/dev/sda1'
EC2_INSTANCE_TYPE='m1.small'
EC2_ANCESTOR_AMI_IDS='ami-08f41161 ami-af3bdec6 ami-5c08ed35'
EC2_PLACEMENT_AVAILABILITY_ZONE='us-east-1a'
EC2_LOCAL_IPV4='10.254.111.17'
EC2_INSTANCE_ID='i-f4c86d9d'
EC2_BLOCK_DEVICE_MAPPING_AMI='sda1'
EC2_BLOCK_DEVICE_MAPPING_EPHEMERAL0='sda2'
EC2_RESERVATION_ID='r-6d8f5804'
EC2_LOCAL_HOSTNAME='domU-12-31-39-00-68-E3.compute-1.internal'
EC2_PUBLIC_KEYS_0_OPENSSH_KEY='xxxx'
EC2_PUBLIC_HOSTNAME='ec2-75-101-250-179.compute-1.amazonaws.com'
EC2_HOSTNAME='domU-12-31-39-00-68-E3.compute-1.internal'
EC2_AMI_MANIFEST_PATH='rightscale_images/CentOS5_0V3_0_0.img.manifest.xml'
EC2_AMI_LAUNCH_INDEX='0'
EC2_PUBLIC_IPV4='75.101.250.179'
EC2_BLOCK_DEVICE_MAPPING_SWAP='sda3'
~~~
