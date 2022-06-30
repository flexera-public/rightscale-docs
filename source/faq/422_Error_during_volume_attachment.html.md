---
title: Problem during volume attachment. My Server gets stranded. Why?
category: general
description: 422 Error during volume attachment
---

## Background Information

When you get an error from the Audit Entry that looks like the one below, this would indicate an error from the Cloud Provider when taking an API action. That is the API request to attach the volume. You may follow the steps below to confirm the behavior.

## Steps

1. Check to confirm from Cloud Provider's status page of any on-going issue.
2. Wait until the on-going issue is done before re-trying to re-launch the Server. If after the Server re-launch the error still persists, wait a bit more to allow any issue residue from the Cloud Provider to clear up.
3. If after a long way still you can't get the volume attached, you may raise a support ticket to us to get more help.

	~~~
	# => 422 ClientError | text/html 40 bytes 
	*ERROR> 12:37:40: Could not attach volume to this instance 

	block_device[mysample_device] (block_device::do_primary_restore line 38) had an error: RuntimeError: timeout occurred waiting for attach_volume_retry 
	~~~
