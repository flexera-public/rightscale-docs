---
title: Upgrade RightLink 10
description: Check whether a RightLink upgrade is available and perform the upgrade.
version_number: 10.5.1
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_upgrade.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_upgrade.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_upgrade.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_upgrade.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_upgrade.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_upgrade.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_upgrade.html
---

## Overview

This page describes how RightLink 10 checks for and performs in-place upgrades of itself.

## Design

RightLink 10 comes with a variety of tools to assist in upgrading the agent on a running machine. The recommended approach is to use an `upgrades` file which contains approved upgrade paths and, using the provided scripts, configure RL 10 to periodically consult that file and automatically upgrade. You can maintain your own `upgrades` file so that you can ensure your applications will continue to work with new versions, or you can use the default RightScale `upgrades` file which contains RightScaled-tested upgrade paths. You can also run a command on a machine to upgrade RL 10 to a specific binary already on the machine.

## Usage

RightLink 10 upgrades can be performed using the provided scripts or manually.

### Using the upgrades file and scripts

The recommended approach for upgrading RightLink 10 is to use the RightScale-provided upgrade script ([Linux](https://github.com/rightscale/rightlink_scripts/blob/master/rll/upgrade.sh), [Windows](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/upgrade.ps1)). Additionally, RightScale provides an "auto-upgrade" script ([Linux](https://github.com/rightscale/rightlink_scripts/blob/master/rll/setup-automatic-upgrade.sh), [Windows](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/setup-automatic-upgrade.ps1)) that will create the needed cron entry/scheduled job to periodically run the upgrade script mentioned previously.

Both of the upgrade scripts above take an input (`UPGRADES_FILE_LOCATION`) which is the location of the `upgrades` file. This file can be the default file provided by RightScale, or a custom file.

#### RightScale-tested upgrades file

As of today, we have not yet built the automation to test upgrade paths of the RL10 agent, so the RightScale-provided `upgrades` file ([located here](https://rightlink.rightscale.com/rightlink/upgrades)) **will not provide any upgrade paths**. In the future, we plan on building such automation and maintaining that file for backwards-compatible upgrades. Details on the `upgrades` file are below.

#### Custom upgrades file

It is recommended that you maintain your own `upgrades` file so that you can ensure that an upgrade doesn't affect your machines and your application. The file should be placed somewhere that all of your instances can access (we recommend an S3 bucket). When a new version of RL10 is released, this gives your team the opportunity to test it, test the upgrade with whatever version you're currently using, and then update the file if the upgrade is successful. Details on the `upgrades` file are below.

#### Upgrades file syntax

The `upgrades` file lists each allowed upgrade path, in the form `<running_version>:<desired_version>`. For example: `10.4.0:10.5.2`. 

!!info*Note*Each `running_version` can only be listed once in the file, or upgrades from that version will fail to start.

When the upgrade script is run, either manually or automatically, RightLink 10 will look through the file, locating the single match for its current version. If it finds the current version, it will use the `desired_version` string to construct the URL to the target binary using the official RightScale RightLink 10 download path (`https://rightlink.rightscale.com/rll/${desiredVersion}/...`).

Example:

~~~ 
# RightScale Rightlink10 Self-Upgrade Manifest
# Each line has the form <current_version>:<desired_version>

10.3.1:10.5.2
10.4.0:10.5.2
10.5.0:10.5.2
~~~

### RightLink 10 upgrade command

For Linux, the upgrade script referenced above uses a [built-in RL10 request](rl10_local_and_proxied_http_requests.html#http-requests-handled-by-rightlink-10-itself) to upgrade the binary. For Windows, this path does not upgrade the binary, but does flush audit entries and verify connectivity.

Using this command, it is possible to update RightLink 10 using a binary already on the filesystem. This approach should be used if you cannot ensure that all instances can reach the `upgrades` file location and allows you to have very explicit control over the binary and the upgrade process.
