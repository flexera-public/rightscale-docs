---
title: RightScale Cloud Appliance for vSphere (RCA-V) 1.3 to 2.0 upgrade guide
description: This guide explains how to configure an existing RCA-V release1.3 configuration to release2.0 and provides troubleshooting steps.
---

## Overview

This guide explains how to configure an existing release1.3 configuration to release2.0

![RCA-V Setup Diagram](/img/rcav-setup-diagram.png)

## Steps

0. RCA-V 2.0 upgrades ruby and system components. You must download a new appliance .ova and install and copy over the old configuration.
1. Download the latest appliance. The link to the latest RCA-V release is in a file called “latest”. Download this file, open it and grab the URL to the latest release.
2. Follow the steps found here, [Download, Deploy, and Configure the RCA-V](rcav_download_deploy_configure.html), up through _RightScale Connectivity - vCenter_.
3. Login to the old release1.3 RCA-V admin UI and go to the "Advanced" section and copy the entire RCA-V config from the "Cloud Configuration" card into the same section on the release2.0 RCA-V admin UI.

## Troubleshooting

**Error**: 'An error occurred: Error validating config: The 'See unowned VMs' option is improperly configured for the following zones. Configure the tenants so at most 1 tenant has the option checked per zone. Zone "zone-iSCSI Cluster" (id: domain-c7::group-p21) has conflicting tenants ["test-us3-2", "test-us3-2-1"]. (status 400).'

**Reason**: RCA-V 2.0 only allows one tenant to have the 'See unowned VMs' option checked per zone. If you receive the above error, go back to the release1.3 RCA-V admin UI. In the tenants section, edit the settings of the list tenants and choose one to have the 'See unowned VMs' option checked. After this is complete, redo step 3 from above. If you get the error for a different zone and tenant list, repeat until all conflicts are resolved.
