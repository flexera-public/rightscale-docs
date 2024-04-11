---
title: Time Synchronization
description: This page describes how to synchronize time on your RightLink 10 images.
version_number: 10.6.2
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_time_synchronization.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_time_synchronization.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_time_synchronization.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_time_synchronization.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_time_synchronization.html
---

# Overview

Time synchronization is important to proper system functioning. Running of RightScripts will intermittently not work if system time is not properly synchronized. 

Starting with version 10.6.2, the [Linux](https://github.com/rightscale/rightlink_scripts/blob/master/rll/setup-ntp.sh) and [Windows](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/setup-ntp.ps1) Base ServerTemplates now ship with a NTP setup script. By default this script will only configure NTP if it's currently not installed and configured. This is because lots of cloud images (all Google and many Amazon) are pre-configured to use NTP servers on the the local network, which is more friendly in when using a VPC or in other scenarios with limited ingress/egress. This default behavior may be overriden by setting the `SETUP_NTP` input from `if_missing` to `always` and supplying a valid IP or hostname to use as an NTP server.

It is highly recommended that you use Coordinated Universal Time (UTC) for your RightScale Servers, especially Windows servers. Time zone mismatches between hypervisor and instance are a common cause of time-related issues.
