---
title: Planned Volume Management
description: Guidelines for planning storage volume management in the RightScale Cloud Management Platform.
---

## Overview

Before RightLink Windows instances run boot scripts, they sometimes perform an extra step known as planned volume management. This step is only performed when running in Amazon EC2; it is designed to compensate for some shortcomings of EBS when used with Windows.

## Problem Statement

Amazon EBS was designed for use with Linux, whose I/O subsystem uses named files such as **/dev/sdk** to represent physical hardware devices. The virtualization-aware block device drivers built into the Linux kernel ensure a consistent mapping between the an EBS volume and its corresponding virtual disk device. The instance boots with a "disk" already attached, and can mount the partitions of that disk whenever it's convenient to do so.

In contrast, the Windows I/O subsystem uses numbered devices; numbers are assigned to disks in the approximate order in which they are discovered during kernel initialization. Although EC2 allows callers to specify pseudo-device names such as **xvdd** when attaching a volume, there is no way for a virtualization-agnostic Windows kernel to ensure a consistent mapping between the EBS volume, a particular disk number, and an eventual drive letter when the disk is mounted.

Furthermore, Windows does not automatically mount volumes on boot unless they contain a valid NTFS partition; blank volumes remain uninitialized until the user takes some action.

## Ensuring Consistent Volume Mappings with RightLink

To support reusable RightScripts, the RightLink agent performs planned volume management when it detects that it is running on Windows in EC2. Planned volume management consists of the following steps, which happen the first time the instance boots:

1. Detach every EBS volume that is already attached.
2. Enumerate all of the volumes that *were* attached, and their device names (**xvdd**, **xvde**, and so forth).
3. Proceeding in device-name order, reattach each volume; wait for a Windows disk device to appear; partition and format the disk, if necessary; and mount it with the designated drive letter.

The result of planned volume management is that RightLink-managed Windows instances behave like their Linux counterparts and your RightScripts can be authored using only drive letters with no concern for device numbers or partition/format readiness.

## Shortcomings of Planned Volume Management

This feature is designed to accommodate the most basic use case for EBS: individual disks containing non-striped volumes that are used to store persistent data across server relaunches.

More advanced users may have other purposes in mind for EBS. Some examples:

* Using an EBS volume stripe as a high-throughput scratch disk
* Coordinated backup and restore of an EBS stripe
* Advanced [LVM](http://en.wikipedia.org/wiki/Logical_volume_management) functionality that requires EBS volumes to be partitioned in a non-standard way

In these cases, boot RightScripts must work directly with the Windows I/O subsystem; planned volume management does not always add value, and can add a significant delay to the Windows boot sequence.

## Disabling Planned Volume Management

*Note*: The following functionality is supported in all versions of RightLink.

If you are designing a ServerTemplate that performs its own volume management, it may be advantageous to disable RightScale's volume management. To do this, simply add the following tag to your ServerTemplate so that it will be inherited by any servers and/or server arrays that are built with the template:

**rs_storage:manage=false**

This instructs the RightScale dashboard not to perform any planned volume management. An audit entry will appear in the Windows boot sequence, but no devices will be detached, attached, partitioned or formatted. The volumes will be left in their initial state and your boot scripts can manage them as required.

If the tag is present on your ServerTemplate and has any value *other* than **false**, then volume management will still be performed.
