---
title: I rebooted, stopped or terminated my Server, and it says it has completed but nothing happens. Why?
category: general
description: Rebooting, Stopping or Terminating a Faulty Server.
---

## Background Information

When you reboot, stop or terminate a Server and it says that the task has been completed, but nothing happens. 

## Answer

If you encounter this behavior, you may try to check the following:

	1. Check the health and/or status of the Server in question from your Cloud Provider's Console. Most likely, the Server is in a failed state.<br>
	For example, on AWS failed instance will usually report an error similar to the one below:
		`
		System reachability check failed at June 7, 2015 at 3:24:00 PM UTC+8 (35 minutes ago)
		Instance reachability check failed at June 7, 2015 at 3:24:00 PM UTC+8 (35 minutes ago)
		`

	2. After checking the Cloud Provider's Console and if the Server in a failed state, you can attempt to retry the failed action using the Cloud Provider's Console.<br>
	
	3. If the action continues to fail, re-launching the Server will be the easiest way to bring up a replacement of the failed Server. Keep in mind that relaunching a Server from RightScale will terminate the current instance, destroying all resources associated with it, and launch a new instance.<br>


