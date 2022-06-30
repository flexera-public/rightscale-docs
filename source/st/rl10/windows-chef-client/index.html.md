---
title: Chef Client for Windows (RightLink 10)
alias: st/rl10/windows-chef-client/overview.html
description: The RightLink 10 ‘base’ ServerTemplate for Windows contains the minimum set of scripts and alerts for optimized server management through the RightScale platform.
---

## Overview

The ‘base’ ServerTemplate for Windows contains the minimum set of scripts and alerts for optimized server management through the RightScale platform such as:

* Install the chef client
* Runs chef recipes with provided runlist.

It’s strongly recommended that you begin custom ServerTemplate development by cloning the ‘base’ ServerTemplate and then modify it to meet your needs.

## Minimum Scripts for Best Practices

Since the “Base” ServerTemplate contains the minimum set of scripts that are required for optimal server management within the RightScale management platform, it’s recommended that these scripts are not deleted from a ServerTemplate unless you are an advanced user and are aware of the ramifications.

The minimum set of scripts in the "Base" ServerTemplate are found in most ServerTemplates published by RightScale and perform the following setup operations:

### Boot Sequence
See [RightLink 10 Windows Base ](/st/rl10/base_windows/index.html) for details on the default scripts.

* **Windows Install Chef Client** - This script installs a the chef client.

* **Windows Configure Chef Client** - This script registers the instance with the chef server and runs knife.

* **Windows Run Chef Client** - This script runs a chef recipe with the chef client.

### Operational scripts
* **Windows Run Chef Client** - This script runs a chef recipe with the chef client.

### Chef Server Inputs
| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|CHEF_CLIENT_ENVIRONMENT|The Chef Server environment to use.  | text:_default |
|CHEF_CLIENT_NODE_NAME|Name which will be used to authenticate the Chef Client on the remote Chef Server. If nothing is specified, the instance FQDN will be used. | text:SERVER1 |
|CHEF_CLIENT_ROLES|Comma-separated list of roles which will be applied to the instance. The Chef Client will execute the roles in the order specified.|text:IISRole |
|CHEF_CLIENT_RUNLIST|A string used to set the permanent run_list for chef-client. If set, this overrides chef/client/roles.|text:recipe[ntp::default], recipe[foobar]|
|CHEF_SERVER_URL|The Chef Server URL|text: https//chef-server.example.com/organizations/example/|
|CHEF_SSL_VERIFY_MODE|Set the verify mode for HTTPS requests. Use :verify_none to do no validation of SSL certificates. Use :verify_peer to do validation of all SSL certificates, including the Chef server connections, S3 connections, and any HTTPS remote_file resource URLs used in the chef-client run. This is the recommended setting. Depending on how OpenSSL is configured, the ssl_ca_path may need to be specified.|text::verify_peer |
|CHEF_VALIDATION_KEY|The Chef Server Validator Key|cred:CHEF_VALIDATOR_KEY|
|CHEF_VALIDATION_NAME|The Chef Server Validator name|text: example-validator|
|CHEF_CLIENT_COMPANY|Company name to be set in the Client configuration file. This attribute is applicable for Opscode Hosted Chef Server. The company name specified in both the Server and the Client configuration file must match.|text:MyCompany|
|CHEF_CLIENT_LOG_LEVEL|The log level for the chef client log|text: info|
|CHEF_CLIENT_LOG_LOCATION|The location of the log file.|text: C:/chef/chef-client.log|

!!warning*Important* As a general best practice, any new scripts that you add to the ServerTemplate should be added to the bottom of the existing boot script list.
