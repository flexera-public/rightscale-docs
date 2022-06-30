---
title: Puppet Client for Linux (RightLink 10)
alias: st/rl10/puppet-client/overview.html
description: The RightLink 10 ‘base’ ServerTemplate for Linux contains the minimum set of scripts and alerts for optimized server management through the RightScale platform.
---

## Overview

The ‘base’ ServerTemplate for Linux contains the minimum set of scripts and alerts for optimized server management through the RightScale platform such as:

* Install the puppet client from the PE Server
* Processes the role associated with the agent/node

It’s strongly recommended that you begin custom ServerTemplate development by cloning the ‘base’ ServerTemplate and then modify it to meet your needs.

## Minimum Scripts for Best Practices

Since the “Base” ServerTemplate contains the minimum set of script that are required for optimal server management within the RightScale management platform, it’s recommended that these scripts are not deleted from a ServerTemplate unless you are an advanced user and are aware of the ramifications.

The minimum set of scripts in the "Base" ServerTemplate are found in most ServerTemplates published by RightScale and perform the following setup operations:

### Boot Sequence
See [RightLink 10 Linux Base ](/st/rl10/base_linux/index.html) for details on the default scripts.

* **Puppet Client Install** - This script installs a the puppet client from the PE server and runs role.

### Puppet client Inputs
| Input Name | Description | Example Value |
| ---------- | ----------- | ------------- |
|PUPPET_SERVER|Hostname of the puppet server  | puppet.example.com |
|PUPPET_ROLE|The role that applies to the agent|text: nginx_webserver|

!!warning*Important* As a general best practice, any new scripts that you add to the ServerTemplate should be added to the bottom of the existing boot script list.
