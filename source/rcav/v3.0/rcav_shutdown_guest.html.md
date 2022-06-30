---
title: RightScale Cloud Appliance for vSphere (RCA-V) Shutdown Guest Support
description: This guide explains how to configure an existing RCA-V to support Shutdown Guest OS functionality
---

## Overview
This guide explains how to configure an existing RCA-V to support Shutdown Guest OS functionality

!!info*Note:* Your images will need VMWare VMTools installed, open-vm-tools does not support ShutDownGuest until Linux Kernel 3.9.

## Prerequisites
This requires version 3.0.1 or greater. Please see [Upgrade Guide](/rcav/v3.0/rcav_upgrade_to_3_0_1.html)

## Steps
1.	[Setup RCAV per documentation.](/rcav/v3.0/rcav_download_deploy_configure.html)
1.	Two new settings were introduced to the Cloud Configuration - Global Policies Page
1.	Under the VM Policies: 
    *	ShutDown Guest OS – True/False
    *	Timeout For Guest OS ShutDown – Timeout in Seconds before it will send PowerOff command if Shutdown has not completed. 
![RCAV Shutdown Guest](/img/rcav-shutdown-guest-settings.png)
1.	At this point it should start working, however you can restart the vscale service to ensure that the tenants get properly populated with the settings. 
