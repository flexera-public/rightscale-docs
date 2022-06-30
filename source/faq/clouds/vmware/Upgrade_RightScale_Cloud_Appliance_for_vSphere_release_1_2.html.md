---
title: Upgrade RightScale Cloud Appliance for vSphere release 1.2
category: vmware
description: While performing the upgrade of RCA-V packages you may run into upgrade errors. These errors leave the RCA-V config file (called vscale.conf) in a format that is unusable by the v1.2 code.
---

<font color=red>Applicability: Applies to situations where field upgrade is performed on vscale and vscale-admin v1.1 packages. Does not apply to fresh deployments of RCA-V 1.2 appliance.</font>

## Overview

While performing the upgrade of RCA-V packages you may run into upgrade errors. These errors leave the RCA-V config file (called vscale.conf) in a format that is unusable by the v1.2 code.  This can happen when upgrading vscale and vscale-admin package with "1.1" release label.

The upgrade process for RCA-V packages (vscale and vscale-admin)  was intended to be automatic so that the config file can be converted from the old format used by v1.1 to the newer format used by v1.2.  In the event you run into an error 500 during the "Activate" portion of the upgrade process or if modifying vscale.conf directly and the service will not come up, please perform the following steps:
Resolution

Login to RCA-V appliance (using 'admin' user)

~~~
$ sudo su
$ sudo su
# cd /home/vscale/current
# bundle exec script/update_availability_zone_ids
# bundle exec script/update_tenant_defaults_with_default_resource_pool_spec
# service vscale restart
# service vscale-admin restart
~~~

You can verify that the config got upgraded by either look at /etc/vscale.conf or  using the **Admin UI -> Cloud Configuration -> Advanced** link.  You should see the "id" field in the "availability_zone" section of the config in the format similar to "domain-c27::datastore-33".
