---
title: Disable a (previously enabled) Server
description: This page outlines the steps for using the rightlink.disable.sh or rightlink.disable.ps1 script to disable previously enabled raw instances.
version_number: 10.5.2
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_disable_enabled_server.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_disable_enabled_server.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_disable_enabled_server.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_disable_enabled_server.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_disable_enabled_server.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_disable_enabled_server.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_disable_enabled_server.html
---

## Overview

This page outlines the steps for using the `rightlink.disable.sh` or `rightlink.disable.ps1` script to disable previously enabled raw instances. The method allows us to revert all the changes that were made to the instance in order to make it a RightScale server. This includes deleting and stopping RightLink, removing the 'rightscale' user which includes the associated credentials and sudoers file, removing all RightLink init scripts, removing user-data, and reverting any changes made to local configuration files.

## Use-cases

* Servers that were previously enabled raw instances using the RightLink enablement script
* Servers that were previously enabled incorrectly (such as using the wrong ServerTemplate)

## Prerequisites

* The disable script must be executed with root/administrator privileges
* A server that was a previously enabled raw instance
* Ability to execute a command-line on the instance
* RightScale OAuth key for the desired account (Settings > Account Settings > API credentials in the dashboard)

## How it Works

1. The command line to run on the instance looks something like this, for version 10.5.2

    ~~~ bash
    curl -s https://rightlink.rightscale.com/rll/10.5.2/rightlink.disable.sh | sudo bash -s -- -k e22f8d37...456
    ~~~

    or

    ~~~ powershell
    $wc = New-Object System.Net.Webclient
    $wc.DownloadFile("https://rightlink.rightscale.com/rll/10.5.2/rightlink.disable.ps1", "$pwd\rightlink.disable.ps1")
    Powershell -ExecutionPolicy Unrestricted -File rightlink.disable.ps1 -k e22f8d37...456
    ~~~

2. The downloaded disable script locates the server details via API 1.5.
3. The script identifies all of the items on the server that will be deleted and/or reverted to their original state.
4. The script prompts you to continue with the disablement.
5. The script makes the disable API call and upon confirmation of disablement, it deletes/reverts all items that were listed.
6. The server will no longer exist in the RightScale dashboard and will now show as a raw instance again.

(Disabled servers that have been returned to raw instances can be enabled again)

For reference (note: this may change):

  ~~~
  $ script/rightlink.disable.sh -h
  Usage: rightlink.disable.sh [-options...]
  Disable a RightScale server that had been a previously enabled server.
    -k refresh_token      RightScale API refresh token from the dash Settings>API Credentials (req.)
    -s server_href        this server's HREF (disables self-detection) (ex. /api/servers/123456789)
    -a api_hostname       the hostname for the RightScale API, default: my.rightscale.com
    -f                    override command prompt confirmation for disablement
    -h                    show this help
  ~~~

**Note**:

* The '-k' option is mandatory.
* The following options are not mandatory and should be automatically detected if run from the instance itself: -s, -x, -a
* The RightLink service should be running and not stopped as stopping RightLink will cause the server to go into a 'decommissioning' state, which is an invalid state for the server to be in during the 'disable' process.
