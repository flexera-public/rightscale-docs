---
title: PHP Application Server for Chef Server (RightLink 10)
alias: st/rl10/php/overview.html
description: This RightLink 10 ServerTemplate configures a dedicated PHP application server with Apache. It contains scripts and inputs that allow a PHP application server to connect to MySQL database servers and other resources.
---

## Overview

Configures a dedicated PHP application server with Apache. The ServerTemplate contains scripts and inputs that allow a PHP application server to connect to MySQL database servers as well as allowing connections from load balancing server solutions such as Amazon's Elastic Load Balancing (ELB), or a server launched with RightScale's **Load Balancer with HAProxy** ServerTemplate. The ServerTemplate is one of the core ServerTemplates in a typical a three-tier website architecture.

!!info*Note:* This ServerTemplate requires a Chef Server with the required cookbooks (see below under Requirements) uploaded to the Chef Server to work.

!!info*Note:* For a complete list of the ServerTemplate's features and support, view the detailed description under its <b>Info</b> tab.

## Requirements
* [Chef Server](/st/rl10/chef-server/overview.html) or Hosted Chef
* [rs-application_php](https://github.com/rightscale-cookbooks/rs-application_php) ([2.0.1](https://github.com/rightscale-cookbooks/rs-application_php/releases/tag/v2.0.1))

## Software Application Versions

* Apache
* PHP
* MySQL Client

## Technical Overview

The PHP App Server ServerTemplate install Apache with PHP on a single instance. The application code is downloaded from a git repository and placed into the webserver directory to be hosted. There are recipes to set up tags so the PHP App Server can be found by a Load Balancer and to request that a Load Balancer find it. The PHP App Server can be used in a RightScale autoscaling application server array. Below are descriptions of the various scripts available in the PHP App Server ServerTemplate.

**Boot Sequence:**
See [RightLink 10 Linux Base ](/st/rl10/base_linux/overview.html) for details on the default scripts.
* **Chef Client Install** - This script installs and configures the chef client.  
* **PHP Appserver Install - chef** - Installs PHP and required dependencies and deploys the application code.
* **PHP Appserver Application Backend - chef** - This recipe attaches the application server to the load balancer servers serving the same application name as that of the application server and existing in the same deployment. This recipe schedules the execution of the `HAProxy Frontend - chef` script on the load balancer servers matching the machine tag ‘load_balancers:active_<application_name>=true’.
**Operational Scripts:**

* **PHP Appserver Application Backend - chef** - This recipe attaches the application server to the load balancer servers serving the same application name as that of the application server and existing in the same deployment. This recipe schedules the execution of the `HAProxy Frontend - chef` script on the load balancer servers matching the machine tag ‘load_balancers:active_<application_name>=true’.
* **PHP Appserver Application Backend Detach- chef** - This recipe detaches the application server from the load balancer servers serving the same application name as that of the application server and existing in the same deployment. This recipe schedules the execution of the `HAProxy Frontend - chef` script on the load balancer servers matching the machine tag ‘load_balancers:active_<application_name>=true’.

**Decommission Sequence**
* **PHP Appserver Application Backend Detach- chef** - This recipe detaches the application server from the load balancer servers serving the same application name as that of the application server and existing in the same deployment. This recipe schedules the execution of the `HAProxy Frontend - chef` script on the load balancer servers matching the machine tag ‘load_balancers:active_<application_name>=true’.
* **Chef Client Delete Node** - Removes the node from the Chef Server during termination if the `DELETE_NODE_ON_TERMINATE` is true.

### Retrieval of Application Code

The ServerTemplate contains scripts that support the retrieval of application code from the following locations:

* ROS Container (\*.zip, \*.tgz)
* SVN Repository
* Git Repository
* FTP Server
* Specified URL (http://www.example.com/myapp.zip)
* rsync

The application code will be placed on the local instance in a location that is based upon the values specified for the following inputs.

* **Project App root** - text: /home/webapps (default)
* **Application Name** - text: myapp

In the example above, the root directory for the application code will be stored in: /home/webapps/myapp

## Further Reading

* [PHP Application Server - Tutorial](/st/rl10/php/tutorial.html)
