---
title: How can I copy an EBS snapshot between different EC2 regions?
category: aws
description: Copy EBS Snapshot from one region to another
---

## Background

You may have noticed that EBS Snapshots are region specific and until recently, they could not be moved from one region to another. This can now be done in few simple steps.

## Answer

Follow the steps below to copy an EBS snapshot from one region to another.

1. Go to the volume where your EBS snapshot resides.
2. Select the EBS snapshot you want to copy to another region and then click on the "Copy Snapshot" button.
3. Put a name and description on the EBS snapshot you want to copy to another region and then select the region you want to copy it to.
4. Submit the request and go to the region where you copied the EBS snapshot, the process should complete shortly and you should see the results.

That's it, you are done!
