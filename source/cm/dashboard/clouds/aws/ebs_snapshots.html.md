---
title: EBS Snapshots
layout: cm_layout
description: An EC2 EBS Snapshot represents an EBS volume at a particular point in time. You can create a snapshot regardless of whether or not a volume is attached to an instance.
---
## Overview

An **EC2 EBS Snapshot** represents an EBS volume at a particular point in time. You can create a snapshot regardless of whether or not a volume is attached to an instance. When a snapshot is saved to S3, it receives a timestamp and a unique AWS ID (e.g. snap-9cea0df5). Snapshots consist of a series of data blocks that are incrementally saved to S3. Create clones of volumes from any snapshot. You cannot attach the same volume to multiple instances. Instead, you must first take a snapshot of the volume, then create a clone of the volume from the snapshot and specify the appropriate availability zone.

EBS volumes and snapshots are EC2 region-specific. You cannot use a volume/snapshot that you created in EC2-US in a different region like EC2-EU.

![cm-ebs-snapshot-home.png](/img/cm-ebs-snapshot-home.png)

![cm-ebs-snapshot-view.png](/img/cm-ebs-snapshot-view.png)

Similar to AMIs, you can also share EBS Snapshots with other AWS accounts or make them publicly available. Do not be alarmed if you see snapshots listed that do not belong to your account. Snapshots that were created from your account will be labeled "me" under the Owner column. You will also see several publicly available Snapshots from Amazon. In all other cases, the AWS Account Number of the sharing account will be listed.

To work with AWS volume snapshots in the CM dashboard, go to **Clouds** > *AWS Region* > **Volume Snapshots**. To find snapshots that belong to your account, filter by Owner: 'you'

## Actions

* [Attach an EBS Snapshot to an Instance](/cm/dashboard/clouds/aws/actions/ebs_snapshots_actions.html#attach-an-ebs-snapshot-to-an-instance)
* [Bootable EBS Snapshot](/cm/dashboard/clouds/aws/actions/ebs_snapshots_actions.html#create-a-bootable-ebs-snapshot)
* [Create an EBS Standard Volume from an EBS Snapshot](/cm/dashboard/clouds/aws/actions/ebs_snapshots_actions.html#create-an-ebs-standard-volume-from-an-ebs-snapshot)
* [Delete an EBS Snapshot](/cm/dashboard/clouds/aws/actions/ebs_snapshots_actions.html#delete-an-ebs-snapshot)
* [Replicate an EBS Snapshot to a different AWS Region](/cm/dashboard/clouds/aws/actions/ebs_snapshots_actions.html#migrate-an-ebs-snapshot-to-a-different-aws-region)
* [Share an EBS Snapshot](/cm/dashboard/clouds/aws/actions/ebs_snapshots_actions.html#share-an-ebs-snapshot)
