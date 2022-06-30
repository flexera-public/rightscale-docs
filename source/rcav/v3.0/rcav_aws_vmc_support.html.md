---
title: RightScale Cloud Appliance for vSphere (RCA-V) AWS VMC Support
description: This guide explains how to configure an existing RCA-V to support AWS VMC 
---

## Overview
This guide explains how to configure an existing RCA-V to support AWS VMC

## Prerequisites
This requires version 3.0.1 or greater. Please see [Upgrade Guide](/rcav/v3.0/rcav_upgrade_to_3_0_1.html)

## Steps
1.	[Setup RCAV per documentation.](/rcav/v3.0/rcav_download_deploy_configure.html) However do not setup zone or tenants yet.
1.	Under Cloud Configuration -> Global Policies -> VM Policies, you will need to uncheck: MAC Address Allocation: Enforce dynamic MAC address allocation. 
1.	Now we can provision the zone. You will need the resource pool id. You can find it in the address bar when connected to Vsphere.
![RCAV VMC Resource Pool](/img/rcav-vmc-resource-pool.png)
1.	Now you can add a zone, be sure to specify the resource pool id from above.
![RCAV VMC Cloud Configuration](/img/rcav-vmc-cloud-configuration.png)
1.	Now we can provision your Tenant. 
1.	Click Add a tenant, the name must be `Workloads`
1.	Set your password. 
1.	Add the zone you created above, Do not modify the resource pool config here. It should be unchecked. 
![RCAV VMC Tenant Configuration](/img/rcav-unchecked-resource-pool.png)
1.	You are now able to [Register a vSphere Cloud with RightScale](/rcav/v3.0/rcav_register_vsphere_cloud.html).
