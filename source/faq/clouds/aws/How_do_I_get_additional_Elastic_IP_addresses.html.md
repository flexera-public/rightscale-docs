---
title: How do I get additional Elastic IP addresses?
category: aws
description: By default Amazon Web Services allows each AWS account to have up to five Elastic IP addresses. If you need reserve more than five Elastic IPs, you must submit a request to Amazon for more Elastic IPs.
---

## Answer

By default Amazon Web Services allows each AWS account to have up to five Elastic IP addresses. If you need reserve more than five Elastic IPs, you must [submit a request](http://aws.amazon.com/contact-us/eip_limit_request/) for more Elastic IPs to Amazon.

Remember, that Elastic IPs are free from Amazon, as long as they are being used (i.e. assigned to a running server instance). However, Amazon discourages users from reserving more Elastic IPs than they need. Since there is a limited pool of IP addresses that are available, Amazon will penalize you if you are not using an Elastic IP. You will be charged on an hourly basis for each Elastic IP that is not being used.

See [Elastic IP (EIP)](http://support.rightscale.com/09-Clouds/AWS/02-Amazon_EC2/Elastic_IP_(EIP)).
