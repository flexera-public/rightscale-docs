---
title: About Amazon Web Services
layout: aws_layout_page
description: RightScale is dedicated to providing powerful and intuitive solutions and ways to take full advantage of Amazon Web Services (AWS). Deploying on AWS can save you time, money, and administrative effort compared to building and maintaining more traditional systems.
---

## Overview

RightScale allows you to discover, provision, take action, and create policies across a wide variety of AWS cloud services, including compute, storage, network, database, middleware, and application services.

Many cloud services are supported out-of-the-box in RightScale while others leverage a plugin. Plugins describe the API of a service provider for the RightScale platform, including defining the parameters which must be specified to interact with the service, the structure of resources in the service, and how RightScale can create and interact with those resources. RightScale continually creates new plugins for cloud services which are shared in a [public repository on GitHub](https://github.com/rightscale/rightscale-plugins). RightScale partners or customers can [create their own plugins](/ss/reference/cat/v20161221/ss_plugins.html).  

There are four approaches that you can leverage to manage cloud services in RightScale:

* Native integration - no plugin is required
* Out-of-the-box plugin - plugin is provided by RightScale. ([GitHub repo](https://github.com/rightscale/rightscale-plugins))
* Custom plugin - [create a plugin](/ss/reference/cat/v20161221/ss_plugins.html) for other cloud services
* http/https - use the [http/https function in Cloud Application Templates](/ss/reference/rcl/v2/ss_RCL_functions.html#http-https-functions) 

## Supported AWS Services

Below is a list of services supported for AWS. Other services can be supported through [custom plugins](/ss/reference/cat/v20161221/ss_plugins.html) or the [http/https function in Cloud Application Templates](/ss/reference/rcl/v2/ss_RCL_functions.html#http-https-functions).

| **AWS Services** | **How Supported** | **Link to Plugin** |
| ----------- | ----------- | --------------------- |
| EC2 | Native |  |
| EBS | Native |  |
| S3 | Native |  |
| VPC | Native and Plugin | [AWS Virtual Private Cloud](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_compute) |
| ELB | Native and Plugin | [AWS Elastic Load Balancer (Classic LB)](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_elb) <br>  [AWS Elastic Load Balancer (Application LB)](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_alb) |
| Lambda | Plugin | [AWS Lambda](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_lambda) |
| CloudFront | Plugin | [AWS CloudFront](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_cloudfront) |
| Route53 | Plugin | [AWS Route53](https://github.com/rightscale/rightscale-plugins/tree/master/aws/rs_aws_route53) |
| EFS | Plugin | [AWS Elastic File System](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_efs) |
| RDS | Native and Plugin | [AWS Relational Database Service](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_rds) |
| Elasticache | Plugin | [AWS ElastiCache](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_elasticache) |
| CloudFormation | Plugin | [AWS CloudFormation](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_cft) |
| SQS | Native |  |
| MQ | Plugin | [AWS MQ](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_mq) |
| EKS | Plugin | [AWS EKS](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_eks) |
| IAM | Plugin | [AWS IAM](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_iam) |
| Any other AWS Services | Custom plugin or http/https support. | &nbsp; |

## Contact Information

### AWS

* **Corporate website:** [http://aws.amazon.com/](http://aws.amazon.com/)
* **Contact AWS Support:** [http://aws.amazon.com/contact-us/](http://aws.amazon.com/contact-us/)

### RightScale

* **Sales** - For information about your account specifics, contact your account manager _or_ email [sales@rightscale.com](mailto:sales@rightscale.com)
* **Support** - Report any bugs related to RightScale, please raise a support ticket from the Dashboard or email [support@rightscale.com](mailto:support@rightscale.com).
