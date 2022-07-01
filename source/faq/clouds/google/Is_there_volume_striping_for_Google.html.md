---
title: Is there volume striping for Google?
category: google
description: Since there is no RightScale volume support for Google yet, and we are setting up an LVM on the local ephemeral disk instead.
---

## Answer

Since there is no RightScale volume support for Google yet, and we are setting up an LVM on the local ephemeral disk instead. We're only using one ephemeral disk, even if there are multiple disks. Whatever the dev/sdc device is, we put the LVM up to extend to the entire space on the partition. Any additional ephemeral drives are ignored for now. For example, if you launch with an XL instance type and it has 6 drives on it, we will only use one.
