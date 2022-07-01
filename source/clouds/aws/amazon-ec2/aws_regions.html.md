---
title: AWS Regions
layout: aws_layout_page
description: This is dedicated to visualizing the differing AWS regions, which are supported by RightScale, which are not, and the differing features each entail. 
---

## Overview

AWS provides a variety of geographic regions and more are sure to come in the future. The best way to understand how different AWS regions are treated inside RightScale is to think of them as essentially separate clouds.


## Supported Amazon Regions

| **Region Name** | **Region** | **Supported by RightScale** |
| ----------- | ----------- | --------------------- |
| US East (N. Virginia) | us-east-1 | **X** |
| US East (Ohio) | us-east-2 | **X** |
| US West (N. California) | us-west-1 | **X** |
| US West (Oregon) | us-west-2 | **X** |
| Asia Pacific (Hong Kong) | ap-east-1 | |
| Asia Pacific (Mumbai) | ap-south-1 | |
| Asia Pacific (Osaka-Local) | ap-northeast-3 | |
| Asia Pacific (Seoul) | ap-northeast-2 | **X** |
| Asia Pacific (Singapore) |ap-southeast-1| **X** |
| Asia Pacific (Sydney) | ap-southeast-2 | **X** |
| Asia Pacific (Tokyo) | ap-northeast-1 | **X** |
| Canada (Central) | ca-central-1 | **X** |
| China (Beijing) | cn-north-1 | **X** |
| China (Ningxia) | cn-northwest-1 | |
| EU (Frankfurt) | eu-central-1 | **X** |
| EU (Ireland) | eu-west-1 | **X** |
| EU (London) | eu-west-2 | **X** |
| EU (Paris) | eu-west-3 | |
| EU (Sotckholm) | eu-north-1 | |
| South America (São Paulo) | sa-east-1 | **X** |
| Gov cloud (US-East) | us-gov-east-1 | |
| Gov cloud (US) | us-gov-west-1 | |


**X -** Supported feature  


## Region-Specific AWS Resources 

Each AWS region has its own set of resources that are specific to that region and cannot be shared. For example, you cannot use a security group that is defined in us-east-1 to launch an instance in eu-central-1. 

RightScale treats each AWS region as a separate cloud.  The RightScale Cloud Management Dashboard UI will display each region as a separate cloud on the Clouds menu and all region-specific resources will be listed under that cloud. 

Since each AWS region has its own set of resources (Security Groups, SSH Keys, Images, Elastic IPs, EBS Volumes/Snapshots, etc.) you must create duplicates of any required resources in a region before you can successfully launch an instance in that region. To avoid confusion, we recommend using the same name for a resource. (i.e. If you have an SSH key in  us-east-1 called 'prod-key-1' you can create 'prod-key-1' in another region. You do not have to add a cloud differentiator in the component name.)

For Elastic Block Store (EBS), volumes and snapshots are also region-specific. You cannot use an EBS Snapshot that was created in us-east-1, to create a volume in us-west-1.


## Global AWS Resources

There are some AWS resources and services that are not region-specific. Since these resources and services can be used across all AWS regions, they are listed in Cloud Management under Clouds -> AWS Global. Some examples of global AWS resources include Amazon S3, Server Certificates and CloudFront.


## Price Differences Between AWS Regions

AWS resources and services may have different prices in different AWS regions. Review Amazon's pricing information for each region you are planning to use. Data transferred between AWS services in different AWS regions will also be charged Data Transfer costs on both sides of the transfer. 
