---
title: Configuration Management Integration
layout: general.slim
description: Provides introductory and general usage information on the RightScale Configuration Management Integration.
---

## Overview

RightScale recognizes that most enterprises leverage a variety of different configuration management tools in different application teams across the organization. To provide choice in the configuration tools you use, RightScale offers a “**bring your own configuration management**” approach that integrates with your configuration tool (or tools), including Chef, Puppet, Ansible, Salt, Terraform or others. RightScale also integrates with templating capabilities from cloud providers, such as AWS CloudFormation or Azure Templates. This flexibility enables you to leverage any existing configuration tools that may be in place in your organization.

![RightScale CMP Tools](/img/rightscale-cmp-tools.png)

## About RightScale Provisioning Template

RightScale templates enable modeling for single or multi-cloud provisioning. They also can be used to bootstrap instances and connect those instance to your configuration management systems. In addition, they add consistent policy and governance controls that span all of your clouds regardless of what configuration tooling is being used.

There are two levels of templates: SeverTemplates for individual servers and Cloud Application Templates for complete systems that can combine multiple cloud server and services and even span multiple clouds. 

1. ServerTemplates: A [ServerTemplate](/cm/dashboard/design/server_templates/servertemplates_concepts.html) provides a configuration and automation framework to deploy individual servers across one or more clouds. It leverages RightScripts which are OS-native scripts (e.g. BASH, Python, Powershell, etc) that are run automatically when launching servers. These RightScripts can perform configuration management themselves or can hand off all or parts of the configuration management to systems like Chef, Puppet, Ansible, etc. It can leverage RightScripts, (RightScale native automation) and work in conjunction with configuration tools like Chef, Puppet, Ansible, or Terraform. 

2. Cloud Application Templates (CATs): A [CAT](/ss/reference/) includes both a declarative component to specify resources and a workflow component for orchestrating across one or more VMs or services to deploy any arbitrarily complex application.

Provisioning workflows are created as a script in a CAT. They can be executed from a self-service portal UI, through an API, or on a scheduled basis. You can include policies, such as placement rules, within the provisioning workflow logic. You can also access the RightScale Pricing API in order to find the lowest cost venue. RightScale can provision directly through Cloud APIs, no third party tool is needed. However, if you have existing configuration tools or templates (Chef recipes, AWS Cloud Formation templates, etc), RightScale can work in conjunction with those as well. 

![CAT Diagram](/img/cat-diagram.png)

## Use Cases

Depending on your particular configuration tool and your desired approach, you can integrate RightScale with your configuration tools in a variety of ways. Below are a few common use cases.

### Bootstrap Chef Client and connect to Chef Server

In this use case a RightScale CAT is used to provision one or more Chef client nodes to any cloud. Each node will be bootstrapped using a RightScale ServerTemplate which will provision the instances in any cloud, deploy the appropriate image based on the cloud and region selected, apply any policies, install the Chef client, and connect the Chef client to a Chef Server.

The Chef client on the server then communicates with the Chef Server or Hosted Chef to further configure the server according the appropriate cookbooks. 

### Bootstrap Puppet Client and connected to Puppet Master

This use case is identical to the Chef use case except the ServerTemplate is used to bootstrap the server and install the puppet client and invoke the client to reach out to the Puppet Master.


### Deploy instance and connect to Ansible Tower

In this use case a RightScale CAT is used to deploy one or more instances in any cloud. Each server will be bootstrapped using a RightScale ServerTemplate which will deploy the appropriate image based on the cloud and region selected, apply any policies, and register the server with Ansible Tower. 

Additionally, the CAT can orchestrate with Ansible Tower to execute playbooks on the provisioned servers.

### Provision using RightScale provider with Terraform

There is a [Terraform provider](https://github.com/rightscale/terraform-provider-rightscale) for Rightscale. Using the Terraform provider, you can create Terraform configurations that provision systems using RightScale templates or resources (including CATs or ServerTemplates) and leverage RightScale orchestration and automation, including the RightScale workflow language.

Using the RightScale provider with Terraform a multi-cloud management that seamlessly plugs in to your Terraform environment and adds robust orchestration, governance, policy management and cost management to your existing Terraform workflows.


