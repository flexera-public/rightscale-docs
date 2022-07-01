---
title: About Volumes
description: Volumes provide persistent, high-performance, and high-availability block-level storage which you can attach to a running Instance in the cloud. 
---

## Overview

**Volumes** provide persistent, high-performance, and high-availability block-level storage which you can attach to a running Instance in the Cloud (in the same zone only). Volumes can be formatted and mounted as a file system. You can attach a Volume to a Server at run-time or schedule it to be attached at boot-time. Multiple volumes can be mounted to the same Instance, but a Volume can *only* be attached to one Instance at a time. You can take Volume Snapshots at a particular point in time and then create multiple Volumes from a snapshot and place them into any zone however. You can also view the lineage of a Volume or Volume Snapshot to see when it was created, as well as any parent/child relationships it has.

Every Cloud infrastructure that provides Volume support has two Volume related entries in its Clouds menu:

1. Volumes
2. Volume Snapshots

!!info*Note:* Some Clouds may have a third entry (e.g. Cloud Types) that is used for size (e.g. Small, Medium, Large) rather than inputting the size manually.

Volumes are created from the New Volume form, which is reached in a number of different ways:

* From the Cloud menu
* From the Volumes index
* From a Volume Snapshot page

New Volumes can be created either blank or from a Volume Snapshot. The Volume size options may change depending on what the user specifies and on the Cloud's capabilities.

Volume Snapshots can be created from Volumes using the "Snapshot" action buttons that appear in the information and index pages for Volumes. When referring to **Attach a Snapshot**, what is meant is that the user may create a new Volume from a Snapshot and then have that new Volume attached automatically.

Both Snapshots and Volumes can be scheduled to be attached to a Server during the boot process. Action buttons for this appear on both the Volume and Snapshot information pages, and take the user to the "New Recurring Volume Attachment" form with values filled in appropriately based on the page where the user pressed the **Attach on Boot** action button. Since attaching a Snapshot really involves creating a Volume from it, you are presented with both Volume creation options (size) and attachment options when scheduling a Recurring Volume Attachment for a Snapshot.

Recurring Volume Attachments specify which Volumes and Snapshots should be attached to a Server the next time that it is launched. All  
of the Volumes and Snapshots so scheduled can be seen in the "Volumes" tab of the "Next" revision timeline of any cloud Server. All of the  
Servers to which a Volume is scheduled to be attached at boot can be seen in the "Recurring Attachments" tab of the Volume itself as well.

The Server to which a Volume is currently attached is shown as fields in its Information tab. The Volumes that are currently attached to a Server can be seen in the "Volumes" tab of the "current" revision of any cloud Server.

## Further Reading
* [Create a Volume Snapshot](/cm/dashboard/clouds/generic/volume_snapshots_concepts.html#creating-a-new-volume-snapshot)
* [Root Volume - Instance Store and EBS Backed](/faq/Root_Volume_Instance_Store_and_EBS_Backed.html)
