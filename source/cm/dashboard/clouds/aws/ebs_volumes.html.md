---
title: EBS Volumes
layout: cm_layout
description: The Elastic Block Store (EBS) provides persistent, high-performance, and high-availability block-level storage which you can attach to a running EC2 instance in the form of volumes.
---
## Overview

The **Elastic Block Store (EBS)** provides persistent, high-performance, and high-availability block-level storage which you can attach to a running EC2 instance (in the same availability zone) in the form of volumes. There are two types of volumes you can create: Standard and Provisioned IOPS. A Standard volume is best suited for boot volumes and provides roughly 100 IOPS (Input/Output Per Second) on average. Provisioned IOPS volumes are designed to provide predictable, high performance I/O workloads that range up to 2,000 IOPS and are best suited for database workloads. Each EBS volume can be formatted and mounted as a file system. An EBS Volume can only be attached to a single instance at a time. Attach EBS Volumes to instances at run-time or boot-time. Multiple volumes can be mounted to the same instance. Take EBS Snapshots of a volume at a particular point in time and then create multiple volumes from a snapshot and place them into any zone. You can also see the lineage of a volume/snapshot to see when it was created, as well as any parent/child relationships.

!!info*Note:* Changes to EBS Volumes, whether they are creations, attachments, detachments or deletions, often requires several minutes to take effect.

The relationship between an instance and a volume is similar to that of a computer and a thumb drive. If a thumb drive is improperly removed or a computer is shutdown improperly, it can result in data corruption or inconsistent data. You must remember to take frequent snapshots because once a volume is deleted, it is permanently erased.

* EBS Volumes have built-in redundancy.
* User-defined storage size of each EBS Volume: 1GB - 1TB
* Volumes can only be mounted by one instance at any time.
* Instances can only attach EBS Volumes that are in the same Availability Zone.
* Multiple EBS Volumes can be attached to the same instance.
* Create an EBS Snapshot of an EBS Volume at any point in time.
* EBS Snapshots are incrementally saved on S3. But hidden from S3 bucket and file lists.
* Create multiple EBS Volumes from the same EBS Snapshot in any Zone.
* EBS volumes and snapshots are EC2-region specific.
* There is a maximum of 500 EBS snapshots per AWS account. If you require more snapshots, please contact [aws@amazon.com](mailto:aws@amazon.com).  

### Persistent Data

Volumes and instances are essentially separate components. If an instance (with an attached volume) is properly shutdown and the volume is properly unmounted, then the volume will continue to persist in its availability zone and can be mounted on another instance in that zone. A snapshot of a volume can then be made into a volume in any zone later as needed.  

### Snapshots

An EBS Snapshot represents a volume at a particular point in time. You can create a snapshot regardless of whether or not a volume is attached to an instance. When a snapshot is saved to S3, it receives a timestamp and a unique AWS ID (e.g. snap-9cea0df5). Snapshots consist of a series of data blocks that are incrementally saved to S3. Create clones of volumes from any snapshot. You cannot attach the same volume to multiple instances. Instead, you must first take a snapshot of the volume. Then create a clone of the volume from the snapshot and specify the appropriate availability zone.

### Faster Backups

With EBS, backups (snapshots) are no longer performed by the instance. Since the local CPU is no longer involved, performing backups will have less affect on an application's performance. The time needed to freeze a volume and take a snapshot is much shorter than creating a large .tar file.

The snapshot request is a short interruption, and is not affected by the size of the volume. A snapshot will continue to finish long after the server resumes normal operation with little impact on the running volumes.

### Efficient Data Storage

Snapshots provide a more efficient way of storing data and backups, because the data blocks for snapshots are incrementally saved to S3. The first snapshot of a volume contains all blocks of data. Each subsequent snapshot will only save the blocks of data that changed from the previous snapshot. A table of contents is generated for each snapshot and points to the latest version of each data block.

### What are the benefits of EBS?

To better understand the big picture, read our blog posts.

* [Amazon's Elastic Block Store explained](http://blog.rightscale.com/2008/08/20/amazon-ebs-explained/)
* [Why Amazon's Elastic Block Store Matters](http://blog.rightscale.com/2008/08/20/why-amazon-ebs-matters/)  

### How does EBS work?

The diagram below shows the lifecycle of a typical EBS Volume/Snapshot.

![cm-ebs-lifecycle-diagram.gif](/img/cm-ebs-lifecycle-diagram.gif)

### How many volumes can I attach to an instance?

Each account will be limited to 20 EBS volumes. If you require more than 20 EBS volumes, you can make a request using [Amazon's EBS Volume request form](http://aws.amazon.com/contact-us/ebs_volume_limit_request/). Although you can attach up to 20 volumes on a single instance, we recommend attaching no more than 10 volumes, where each volume can range in size (1GB - 1TB). With EBS, you no longer have to use large or x-large instances if you require more than the 160GB that are available on a small instance.

Select one of the preconfigured device names when attaching a volume to an instance.

* /dev/sdj
* /dev/sdk
* /dev/sdl
* /dev/sdm
* xvdd
* xvde
* xvdf
* xvdg
* xvdh

!!info*Note:* Each volume that's attached to an instance must use a unique device name.

![cm-about-elastic-block-store.png](/img/cm-about-elastic-block-store.png)

### How much does EBS cost?

The costs of EBS will be similar to the pricing structure of data storage on S3. There are three types of costs associated with EBS.

**Storage Cost + Transaction Cost + S3 Snapshot Cost = Total Cost of EBS**

!!info*Note:* For current pricing information, be sure to check [Amazon EC2 Pricing](http://aws.amazon.com/ec2/#pricing).

* **Storage Costs** - The cost of an EBS Volume is $0.10/GB per month. You are responsible for paying for the amount of disk space that you reserve, not for the amount of the disk space that you actually use. If you reserve a 1TB volume, but only use 1GB, you will be paying for 1TB.
  * $0.10/GB per month of provisioned storage
  * $0.10/GB per 1 million I/O requests
* **Transaction Costs** - In addition to the storage cost for EBS Volumes, you will also be charged for I/O transactions. The cost is $0.10 per million I/O transactions, where one transaction is equivalent to one read or write. This number may be smaller than the actual number of transactions performed by your application because of the Linux cache for all file systems.
  * $0.10 per 1 million I/O requests
* **S3 Snapshot Costs** - Snapshot costs are compressed and based on altered blocks from the previous snapshot backup. Files that have altered blocks on the disk and then been deleted will add cost to the Snapshots for example. Remember, snapshots are at the data block level.
  * $0.15 per GB-month of data stored
  * $0.01 per 1,000 PUT requests (when saving a snapshot)
  * $0.01 per 10,000 GET requests (when loading a snapshot)

!!info*Note:* Payment charges stop the moment you delete a volume. If you delete a volume and the status appears as "deleting" for an extended period of time, you will not be charged for the time needed to complete the deletion.

### EBS Lineage

Use the Lineage and Snapshots tab of a particular volume to track the history of a volume. Every object in EBS remembers its ancestor. However, EBS has no memory of volumes or snapshots once they are deleted.

In the screenshot below, notice that three snapshots were created of the volume and then the volume was created from a previous snapshot.

![cm-about-elastic-block-store-2.png](/img/cm-about-elastic-block-store-2.png)  

## Actions

* [Attach an EBS Volume to an Instance](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#attach-an-ebs-volume-to-an-instance)
* [Create an EBS Provisioned IOPS Volume From a Snapshot](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#create-an-ebs-provisioned-iops-volume-from-a-snapshot)
* [Create a New EBS Volume](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#create-a-new-ebs-volume)
* [Delete an EBS Volume](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#delete-an-ebs-volume)
* [Detach an EBS Volume from an Instance](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#detach-an-ebs-volume-from-an-instance)
* [Grow the Size of an EBS Volume](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#grow-the-size-of-an-ebs-volume)
* [Initialize or Format an EBS Volume](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#initialize-or-format-an-ebs-volume)
* [Create an EBS Snapshot](/cm/dashboard/clouds/aws/actions/ebs_volumes_actions.html#create-an-ebs-snapshot)

## Further Reading

* [http://aws.amazon.com/ebs/](http://aws.amazon.com/ebs/)
* [Why am I receiving an HTTP 422 error in my audit entry?](/faq/Why_am_I_receiving_an_HTTP_422_error_in_my_audit_entry.html)
