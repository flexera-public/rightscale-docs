---
title: How do I use an AWS CloudFormation Templates or Azure Resource Manager Templates in a CAT?
category: general
description: Cloud-Native Templates in CAT
---

## Background

You're currently using AWS CloudFormation Templates and/or Azure Resource Manager Templates for provisioning resources and want to know what kind of support RightScale offers for these cloud-native templates.

## Answer

RightScale Plugins allow you to extend the RightScale platform to support resources on cloud providers and 3rd party APIs.  RightScale has published Plugins for both [AWS CloudFormation Templates](https://github.com/rightscale/rightscale-plugins/blob/master/aws/rs_aws_cft) and [ARM Templates](https://github.com/rightscale/rightscale-plugins/blob/master/azure/rs_azure_template), thus allowing AWS CloudFormation Stacks and Azure Deployments to be declared as resources in CATs. This enables you to bring your existing, cloud-native templates (CloudFormation Templates, ARM Templates) to RightScale, and simply wrap them in a CAT to deliver pre-built use cases. These resources can then be provisioned, maintained, and decommissioned, just like any other CAT resource.
