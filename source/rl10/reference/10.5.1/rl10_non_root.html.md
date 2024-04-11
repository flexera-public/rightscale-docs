---
title: RightLink as Non-root User
description: Guidelines and rationale for running the RightLink 10 agent as a non-root user.
version_number: 10.5.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_non_root.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_non_root.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_non_root.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_non_root.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_non_root.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_non_root.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_non_root.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_non_root.html
---

## Overview

The RightLink 10 agent has historically run as a root/Administrator user, primarily because it
is a systems management agent and systems management processes often requires root/Administrator
privileges.

Starting with version 10.1.2, RightLink will no longer be run as the root user,
but instead be run under the "rightlink" service account with the ability to
sudo to root as needed. Scripts/recipes run through RightLink will need to sudo
to root as needed.

This was done in order to help provide finer grain control over auditing and
systems management actions via sudo logs and configuration.

Starting with version 10.2.1 for Windows, RightLink will no longer run as the
Administrator user. By default, RightLink will run under a Local Administrator
account called "RightLink". RightLink may also be run under a Domain account,
though the account should have Administrative permissions for the box.

## RightLink operation

On Linux, RightLink can operate without root privileges. The only operations that require sudo are:
* rebooting or shutting down the server
* RightScripts that use sudo to gain security privileges of any user, including 'root'
* in order to change system configuration

On Windows, RightLink should have Administrative privileges to reboot/shutdown the server.

## Usage

Since RightLink now runs without elevated permissions by default, sudo must be
used for any administrative actions in RightScripts. For example:
  ~~~ bash
  apt-get install -y collectd
  ~~~

Will change to:
  ~~~ bash
  sudo apt-get install -y collectd
  ~~~

If a RightScript contains numerous options that require administrative permissions,
the hashbang of the script may be altered to run the entire script as sudo. For
example:
  ~~~ bash
  #!/bin/bash
  ~~~

Can be changed to:
  ~~~
  #!/usr/bin/sudo /bin/bash
  ~~~

## Configuration

During RightLink installation, a "rightlink" user is created for the rightlink service. In order to be able to do systems configuration, sudo permission is given by default to the "rightlink" user.

Sudo permission for the "rightlink" account can be locked down to more specific permissions by altering the
sudo config at `/etc/sudoers.d/90-rightscale`. This file is created during RightLink
installation but is not subsequently modified and may be altered as needed.
If modifying sudo, make sure to add in a minimal set for RightLink to function,
detailed in "RightLink Operation", shown below:

  ~~~
  # Rightlink service startup requires these directives:
  Defaults:root !requiretty
  Defaults:rightlink !requiretty
  Defaults:rightlink !env_reset
  root ALL=(ALL) SETENV:ALL
  # Blanket permissions. If you wish to remove the NOPASSWD:ALL line and tighten
  # permissions, you must add in permissions for lifecycle management (reboot/terminate)
  # via /sbin/init. The single line below would allow this:
  # rightlink ALL=(root) NOPASSWD:/sbin/init
  rightlink ALL=(ALL) SETENV:NOPASSWD:ALL
  ~~~

An example of a more locked down config is show below:

  ~~~
  # Rightlink service startup requires these directives:
  Defaults:root !requiretty
  Defaults:rightlink !requiretty
  Defaults:rightlink !env_reset
  root ALL=(ALL) SETENV:ALL

  # Needed by Rightlink for lifecycle management (reboot/terminate)
  rightlink ALL=(root) NOPASSWD:/sbin/init

  # Some user directives examples.
  # Rightlink can only start/stop services
  rightlink ALL=(ALL) NOPASSWD:/sbin/service
  ~~~

## Upgrade

An in-place upgrade from 10.0.x to 10.2.x using the RightLink Base ServerTemplate upgrade
script is not possible, as the init scripts and Base ServerTemplate scripts have changed
in incompatible ways.

If a running instance was [enabled](rl10_enable_running_instances.html), you may
[disable](rl10_disable_enabled_server.html) the server to completely remove
RightLink, and then [enable](rl10_enable_running_instances.html) the instance
with the a new 10.2.x compatible ServerTemplate.

If you launched a RightScale Server directly by bootstrapping via cloud-init, then
there is currently no way to upgrade from 10.0.x to 10.2.x - you must relaunch a
new server with the RightLink 10 10.2.x Linux / Windows Base ServerTemplate.
