---
title: RightScale Cloud Appliance for vSphere (RCA-V) 3.0.1 Upgrade Guide
description: This guide explains how to upgrade an existing v3.0 configuration to v3.0.1. and provides troubleshooting steps.
---

## Overview

This guide explains how to upgrade an existing v3.0 configuration to v3.0.1. There are two services involved in the operation of RCA-V. The Admin Interface that provides the UI and writes the configuration files, and the Vscale Service that processes the configuration file and talks to RightScale and VSphere.

**New Features**
1. VMWare 6.7 support
1. [AWS VMC Support](/rcav/v3.0/rcav_aws_vmc_support.html)
1. [Shutdown Guest Support](/rcav/v3.0/rcav_shutdown_guest.html)

## Upgrading Admin Interface

1.	You will upgrade the vscale admin package to: vscale-admin-3.0.1. 
1.	Log into  the RCAV web interface
1.	Under Connectivity -> RightScale Platform -> Admin Interface, click Upgrade
1.	Look for the package named: vscale-admin-3.0.1, click Download
1.	SSH into the RCAV, credentials can be found here: [Knowing Your Environment](/rcav/v3.0/rcav_troubleshooting_guide.html#knowing-your-environment)
1.	Run `sudo –i su`
1.	Change directory to /home/vscale-admin
1.	Run `chown –R vscale:vscale vscale-admin-3.0.1`
1.	Click Active next to the package, you will get a flash error, ignore it. 
1.	Run `service vscale-admin restart`
1.	At this point it is upgraded, but leave the ssh window open you will need it to upgrade vscale

## Upgrading Vscale Service

1.	You will upgrade the vscale package to: vscale_3.0.1. 
1.	Log into  the RCAV web interface
1.	Under Connectivity -> vCenter -> Cloud Appliance (vscale), Click Upgrade. 
1.	Look for the package named: vscale_3.0.1, click Download
1.	SSH into the RCAV
1.	Run `sudo –i su`
1.	Change directory to /home/vscale
1.	Run `chown –R vscale:vscale vscale_3.0.1`
1.	In the web interface click Activate
1.	Run `service vscale  restart`  from the ssh window
