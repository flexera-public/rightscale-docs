---
title: How to Upgrade to the Latest vScale Appliance
category: vmware
description: For a fresh deployment, you can install the latest version of the appliance using the instructions in the Installation Guide.
---

## How to Upgrade to the Latest Package

!!info*Note:* These instructions are *only* for upgrading within a given release (e.g. version 3.0). Do *not* use these instructions if you want to upgrade to a newer major release (e.g. go from version 2.0 to version 3.0). To upgrade to the latest major release see the upgrade instructions provided with the target release.

For a fresh deployment, you can install the latest RCA-V appliance using the instructions in the [Installation Guide](/rcav/v3.0/rcav_download_deploy_configure.html).

It is also possible to “field-upgrade” the application packages (vscale-admin and vscale) contained in the appliance. 

Use the following steps to perform the upgrade:

!!info*Note:* Before and after each component update, it is recommended to reload the browser (clearing the browser cache is preferred) for the new changes to take effect

1. Using the RCA-V Admin UI, navigate to **RightScale Platform -> Admin Interface** and click **Upgrade**.
2. Download the latest vscale-admin package (in the format vscale-admin_3.0_YYYYMMDD_buildrev).
3. Activate the package that you just downloaded using the **Activate** button.
4. Navigate to the vCenter link on the left navigation column.
5. Click **Upgrade** in the Cloud Appliance (vScale) card.
6. Download the latest vscale package (vscale_3.0_YYYYMMDD_buildrev).
7. Activate the package that you just downloaded using **Activate** button.

