---
title: RightScale Cloud Appliance for vSphere (RCA-V) High Availability Configuration
alias: rcav/guides/rcav_high_availability.html
description: Steps for setting up vSphere and the RightScale Cloud Appliance for vSphere in a high-availability configuration.
---

## Using vSphere HA

You can set up VM level high availability using the following steps:
* Turn on **vSphere HA** or the vSphere Cluster that the RCA-V is deployed on.
* Turn on **Enable Host Monitoring** and **VM Monitoring** in vSphere HA configuration.

This will enable monitoring at two different levels:
1. If the host goes down, the RCA-V VM on that host will automatically restart on another host that is healthy.
2. If the VM running RCA-V goes down due to an accidental power-off or the guest OS crashing, the RCA-V will restart on the same physical server.

## Using Standby RCA-V

Have another RCA-V pre-configured and ready to go in case the primary RCA-V fails.  
The procedure for creating a secondary RCA-V is:

a. Deploy another instance of RCA-V (called RCA-V-DR)<br>
b. Login to the admin UI for RCA-V-DR and configure the vSphere connectivity section.<br>
c. Copy the following files from primary RCA-V into RCA-V-DR<br>

            `/etc/default/wstuncli`<br>
            `/etc/vscale.conf`<br>

d. Power off RCA-V-DR. In case of failure of RCA-V primary, the RCA-V-DR is ready to get started and taking on requests from RS platform.
