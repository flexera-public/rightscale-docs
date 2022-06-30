---
title: Chef Client for Linux (RightLink 10)
alias: st/rl10/chef-client/overview.html
description: The RightLink 10 ‘base’ ServerTemplate for Linux contains the minimum set of scripts and alerts for optimized server management through the RightScale platform.
---

## Overview

The ‘base’ ServerTemplate for Linux contains the minimum set of scripts and alerts for optimized server management through the RightScale platform such as:

* Install the chef client
* Runs chef recipes with provided runlist.

It’s strongly recommended that you begin custom ServerTemplate development by cloning the ‘base’ ServerTemplate and then modify it to meet your needs.

## Minimum Scripts for Best Practices

Since the “Base” ServerTemplate contains the minimum set of script that are required for optimal server management within the RightScale management platform, it’s recommended that these scripts are not deleted from a ServerTemplate unless you are an advanced user and are aware of the ramifications.

The minimum set of scripts in the "Base" ServerTemplate are found in most ServerTemplates published by RightScale and perform the following setup operations:

### Boot Sequence
See [RightLink 10 Linux Base ](/st/rl10/base_linux/index.html) for details on the default scripts.

* **RL10 Chef Client Install** - This script installs a the chef client.

### Operational scripts
* **RL10 Chef Client Run recipe** - Run a chef recipe with the chef client.

### Decommision sequence
* **Chef Client Delete Node** -   Removes the chef node and client from the chef server.

### Chef Server Inputs
| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|CHEF_ENVIRONMENT|The Chef Server environment to use.  | text:_default |
|CHEF_SERVER_URL|The Chef Server URL|text: https//chef-server.example.com/organizations/example/|
|CHEF_VALIDATION_KEY|The Chef Server Validator Key|cred:CHEF_VALIDATOR_KEY|
|CHEF_VALIDATION_NAME|The Chef Server Validator name|text: example-validator|
|LOG_LEVEL|The log level for the chef client log|text: info|
|VERSION|The version of the chef client to install|text: 12.16|

!!warning*Important* As a general best practice, any new scripts that you add to the ServerTemplate should be added to the bottom of the existing boot script list.
