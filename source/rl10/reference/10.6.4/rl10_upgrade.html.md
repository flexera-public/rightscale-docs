---
title: Upgrade RightLink 10
# IMPORTANT: 'alias:' metadata line MUST ONLY BE in LATEST REV, requiring removal of 'alias:' line upon a new latest doc directory revision
alias: [rl/reference/rl10_upgrade.html, rl10/reference/rl10_upgrade.html]
description: Check whether a RightLink upgrade is available and perform the upgrade.
version_number: 10.6.4
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_upgrade.html
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

The recommended approach for upgrading RightLink 10 is to use the RightScale-provided upgrade script ([Linux](https://github.com/rightscale/rightlink_scripts/blob/master/rll/upgrade.sh), [Windows](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/upgrade.ps1)). Additionally, RightScale provides a "setup-automatic-upgrade" script ([Linux](https://github.com/rightscale/rightlink_scripts/blob/master/rll/setup-automatic-upgrade.sh), [Windows](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/setup-automatic-upgrade.ps1)) that will create the needed cron entry/scheduled job to periodically run the upgrade script mentioned previously.

The "upgrade" script takes an input `UPGRADE_VERSION` which is a version to upgrade (or downgrade) to, such as "10.6.4".

The "setup-automatic-upgrade" script takes an input `UPGRADES_FILE_LOCATION` which is the URL of an `upgrades` file. This file can be the default file provided by RightScale, or a custom file.

#### RightScale-tested upgrades file

As of today, we have not yet built the automation to test upgrade paths of the RL10 agent, so the RightScale-provided `upgrades` file ([located here](https://rightlink.rightscale.com/rightlink/upgrades)) **will not provide any upgrade paths**. In the future, we plan on building such automation and maintaining that file for backwards-compatible upgrades. Details on the `upgrades` file are below.

#### Custom upgrades file

It is recommended that you maintain your own `upgrades` file so that you can ensure that an upgrade doesn't affect your machines and your application. The file should be placed somewhere that all of your instances can access (we recommend an S3 bucket). When a new version of RL10 is released, this gives your team the opportunity to test it, test the upgrade with whatever version you're currently using, and then update the file if the upgrade is successful. Details on the `upgrades` file are below.

#### Upgrades file syntax

The `upgrades` file lists each allowed upgrade path, in the form `<running_version>:<desired_version>`. For example: `10.4.0:10.6.4`. 

!!info*Note*Each `running_version` can only be listed once in the file, or upgrades from that version will fail to start.

When the upgrade script is run, either manually or automatically, RightLink 10 will look through the file, locating the single match for its current version. If it finds the current version, it will use the `desired_version` string to construct the URL to the target binary using the official RightScale RightLink 10 download path (`https://rightlink.rightscale.com/rll/${desiredVersion}/...`).

Example:

~~~ 
# RightScale Rightlink10 Self-Upgrade Manifest
# Each line has the form <current_version>:<desired_version>

10.3.1:10.6.4
10.4.0:10.6.4
10.5.0:10.6.4
~~~

### Reverting an Upgrade

If you want to revert an upgrade, it is recommended you re-run the "upgrade" script with `UPGRADE_VERSION` set to the old version of RightLink. Note that the `UPGRADE_VERSION` input was added recently, so please make sure the latest version of the upgrade script for [Linux](https://us-3.rightscale.com/library/right_scripts/RL10-Linux-Upgrade/lineage/55957) and [Windows](https://us-3.rightscale.com/library/right_scripts/RL10-Windows-Upgrade/lineage/55960) is imported from the MultiCloud Marketplace and run as an "Any" script.

## Breaking Changes

Certain RightLink versions may have key breaking changes. The following is summary of major ones:
* 10.6.4 - The script revision will now be printed in the summary.
* 10.5.0 - Managed login changed to [Enhanced Managed Login](rl10_managed_ssh_login.html). Instead of logging in as the `rightscale` user, users now login under their individual usernames. In addition, managed login was changed from an automatic feature to an optional feature. The `RL10 Linux Enable Managed Login` RightScript was added to the 10.5.0 Linux Base ServerTemplate to enable this optional feature. To always enable this feature, this RightScript will have to run and be added to the boot scripts of an upgraded server. Note you can change the revision for [all servers](/cm/dashboard/design/server_templates/servertemplates_actions.html#update-a-servertemplate-revision-on-multiple-servers) attached to a ServerTemplate or for [individual servers](/cm/management_guide/managing_active_current_servers.html#supported-modifications-for-active-servers-that-are-in-the-operational-state).
* 10.2.1 - `rightlink` service changed from root to `rightlink` user. Upgrade of previous versions to this version or later not supported.

### Known Limitations

Please refer to the [release changelogs](/rl10/releases/index.html) for for relevant bug fixes.

* 10.2.1 - When upgrading from 10.2.1 monitoring graphs will disappear if the upgrade script is run. Re-run the 'Enable Monitoring' script to re-enable monitoring.



