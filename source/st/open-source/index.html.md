---
title: RightScale Open Source
description: A variety of Open Source ServerTemplates, tools, and other resources are available for use in the RightScale Cloud Management Platform.
---

## Overview

ServerTemplates published by "RightScale Open Source" consist of assets published by RightScale that do not belong to a standard LTS or Infinity branch. They are typically developed by one of the Professional Services, Technical Support or Sales Engineering teams. As such, they do not go through the more rigorous QA and testing cycles. As such, a Service Level Agreement (SLA) does not apply.

!!info*Note:* The [MultiCloud Marketplace](http://www.rightscale.com/library/server_templates/) has many more publications than what is listed here. These are the more recently published and more widely used RightScale Open Source ServerTemplates.

## Popular Open Source ServerTemplates

* [Docker Technology Demo](http://www.rightscale.com/library/server_templates/Docker-Technology-Demo/lineage/53723) - Deploys Docker-based apps to the cloud of your choice. You can use this ServerTemplate to run containers in two ways: - compose many service-containers on a single VM - run a single application inside a container.

* [Siege Load Tester](http://www.rightscale.com/library/server_templates/Siege-Load-Tester/lineage/18308) - Siege is an http load testing and benchmarking utility. It was designed to let web developers measure their code under duress, to see how it will stand up to load on the internet. Siege supports basic authentication, cookies, HTTP and HTTPS protocols. It lets its user hit a web server with a configurable number of simulated web browsers. Those browsers place the server “under siege.”

* [Squid Caching Proxy Server](http://www.rightscale.com/library/server_templates/Squid-Caching-Proxy-Server/lineage/16331) - A basic ServerTemplate to setup a Squid server on Linux. Supports Ubuntu 12.04/10.04 (with RightLink 5.8), more to come.

* [Load Balancer with HAProxy 1.5 (v13.5)](http://www.rightscale.com/library/server_templates/Load-Balancer-with-HAProxy-1-5/lineage/45420) - This ServerTemplate configures an HAProxy 1.5 load balancer. This gives the template SSL support through haproxy without the need for Apache. Various OS parameters are modified for performance tuning.

* [JBoss 7.1 App Server (RSB)](http://www.rightscale.com/library/server_templates/JBoss-7-1-App-Server-RSB-/lineage/47763) - MultiCloud RSB (RightScript-based) ServerTemplate to deploy a JBoss 7 App Server. Currently only the standalone mode is supported.

* [Flynn Node](http://www.rightscale.com/library/server_templates/Flynn-Node/lineage/50044) - This ServerTemplate installs Flynn's dependencies and bootstraps a Flynn node. See [https://flynn.io/](https://flynn.io/) for additional information.

* [RightScale Linux Server RL 5.9](http://www.rightscale.com/library/server_templates/RightScale-Linux-Server-RL-5-9/lineage/46829) - A Chef-based ServerTemplate for a Linux Server. Supports Ubuntu 12.04 and 13.10 with RightLink 5.9.

* [RightScale Windows Server RL 5.8](http://www.rightscale.com/library/server_templates/RightScale-Windows-Server-RL-5/lineage/18296) - Provides a base Microsoft Windows Server including RightScale Monitoring and Chef support.

* [PHP App Server](http://www.rightscale.com/library/server_templates/PHP-App-Server/lineage/21956) - An application server for PHP web applications. Supports Ubuntu 12.04 (with RightLink 5.8).

* [hello, world!](http://www.rightscale.com/library/server_templates/hello-world-/lineage/20237) - Includes a Chef recipe and RightScript that prints 'Hello, world!' or a given string.

## RightScale Community Resources

One of RightScale's most important goals is to help our users deploy and scale effectively by empowering them with the necessary tools to be successful in the cloud. And one of the best ways to scale, especially in the world of software, is to establish a vibrant community of users who build innovative assets and share them with the community. Below is a list of contributions to the RightScale Community. Be sure to review a project's Readme and license information before using it for your own purposes.

### Self-Service

* [rightscale_selfservice gem](https://rubygems.org/gems/rightscale_selfservice) - A gem that can be used as an API client for SS and includes a command-line interface with some utilities such as CAT "includes" and a built-in testing framework for CAT files.
* [rs_selfservice_tools Ruby scripts](https://github.com/ryanoleary/rs-selfservice-tools) - A set of Ruby scripts to help create CAT files - including a script that can export an existing Deployment in RightScale to a CAT file and preliminary work on a conversion utility to convert CloudFormation templates to CAT.
* <a nocheck href='http://selfserviceuniversity.rightscale.com/welcome/1'>Interactive CAT learning tool</a> - An interactive site that teaches CAT file syntax and has many examples of basic and advanced use cases of CAT and RCL.

### Configuration Management

* [berks_to_rightscale](https://github.com/rgeyer/berks_to_rightscale) - Primarily a command-line tool for injesting a Berksfile and uploading the resulting set of cookbooks to a tar.gz file in any storage provider supported by fog. [gem](https://rubygems.org/gems/berks_to_rightscale)
* [chef-taste](https://github.com/arangamani/chef-taste) - Chef Taste is a simple command line utility to check a cookbook's dependency status.
* [cookbooks_internal](https://github.com/rs-services/cookbooks_internal) - Collection of Chef assets published by RightScale's Professional Services department.
* [knife-rightscale](https://github.com/caryp/knife-rightscale) - This is a Knife plugin for RightScale. This plugin gives knife the ability to provision servers on clouds managed by the RightScale platform. It is expected that you already have a Chef Server running or are using a hosted Chef solution from OpsCode. [blog post](http://cpenniman.blogspot.com/2013/04/the-rightscale-plugin-for-knife.html)
* [rightscale_cookbooks](https://github.com/rightscale/rightscale_cookbooks) - Official RightScale cookbooks project. These cookbooks have been tested on multiple clouds and multiple operating systems using ServerTemplates on the RightScale Cloud Management Platform.
* [rightscaleshim](https://github.com/rgeyer/vagrant-plugin-rightscaleshim) - A cookbook designed to work with vagrant-rightscaleshim to allow local vagrant development of RightScale cookbooks. A Vagrant plugin which (along with rightscaleshim) allows the use of RightScale-specific Chef resources (right_link_tag, remote_recipe, server_collection) in a Vagrant VM. ()[vagrant-plugin](https://github.com/rgeyer/vagrant-plugin-rightscaleshim), [image-centos-6.3](https://s3.amazonaws.com/rgeyer/pub/ri_centos6.3_v5.8.8_vagrant.box), [image-centos-6.4](https://s3.amazonaws.com/rgeyer/pub/ri_centos6.4_v13.4.box), [image-ubuntu-12.04](https://s3.amazonaws.com/rgeyer/pub/ri_ubuntu12.04_v5.8.8_vagrant.box), [veewee-rightimage-vagrant](https://github.com/rgeyer/veewee-rightimage-vagrant))
* [yard-chef](https://github.com/rightscale/yard-chef) - A YARD plugin for Chef that adds support for documenting Chef recipes, lightweight resources and providers (LWRP), libraries and definitions. [Click here](https://github.com/rightscale/rightscale_cookbooks/tree/release13.05) to see example output and additional on RightScale Cookbooks.
* [right_chimp](https://github.com/rightscale/right_chimp) - A command-line tool for remote command execution using the RightScale platform, which can be useful for orchestrating intelligent automation during site upgrades/releases.

### RightScale APIs

* [rs_api_examples](https://github.com/flaccid/rs_api_examples) - A collection of useful API examples for sh/curl enthusiasts.
* [rs-api-tools](https://github.com/flaccid/rs-api-tools) - A collection of Ruby-based CLI tools [gem](https://rubygems.org/gems/rs-api-tools)
* [right_aws](https://github.com/rightscale/right_aws) - RightScale AWS gems that provide a fast and secure interface to key AWS resources and services (such as EC2, EBS, S3, SQS, SDB and CloudFront). [gem](https://rubygems.org/gems/right_aws)
* [Terminator](https://github.com/ryancragun/terminator) - Automatically terminate AWS resources (Servers, Arrays, Volumes, Snapshots) based on specified criteria.
* [rs_user_policy](https://github.com/rgeyer/rs_user_policy) - A ruby gem with a command-line tool for managing the permissions of many users in an Enterprise RightScale account. [gem](https://rubygems.org/gems/rs_user_policy), [blog post](http://www.rightscale.com/blog/cloud-management-best-practices/managing-large-scale-user-access-control-rightscale-api)
* [RightScale_API_Client](https://github.com/rightscale/right_api_client) - The right_api_client gem simplifies the use of RightScale's MultiCloud API
* [RightScaleNetAPI](https://github.com/rs-services/RightScaleNetAPI) - A .NET wrapper for the RightScale 1.5 API.
* [RightScale PowerShell](https://github.com/rs-services/RightScalePowerShell) - Several useful examples for the Windows/PowerShell enthusiasts.  Such as the following folders in Git:
  * PowerShell API - Straight forward, practical examples
  * Generic - Idempotent strategies
  * Samples - Automate the build/destruction of a simple 2-server all-in-one deployment and a more complex 4 tier deployment

## Other Helpful Links

* [RightScale Chat Room](http://chat.rightscale.com/)
* [RightScale Cloud Management Blog](http://blog.rightscale.com/)
* [RightScale Engineering Blog](http://eng.rightscale.com/)
* [Twitter](http://twitter.com/Rightscale)
* [Vimeo](<a nocheck href='http://vimeo.com/rightscale'>Vimeo</a>)
* [YouTube](https://www.youtube.com/rightscale)
