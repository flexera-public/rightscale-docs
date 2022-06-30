---
title: Repo Mirror Error causing my Server to fail during provisioning. What should i do?
category: general
description: Error could not retrieve mirrorlist
---

## Background Information

If you see a Repo Mirror Error during Server provisioning as below, you may follow the suggested steps in the Answer section.

~~~
00:36:43: Loading mirror speeds from cached hostfile
00:37:06: Error: Cannot find a valid baseurl for repo: base
00:37:06: Could not retrieve mirrorlist http://mirrorlist.centos.org/?release=6&arch=x86_64&repo=os error was
14: PYCURL ERROR 7 - "Failed to connect to 2a01:c0:2:4:0:acff:fe1e:1e52: Network is unreachable"
~~~

## Answer:

1. The Repo Mirror is unavailable.
	* If this is a public mirror, then the distributor owns the service.
	* If this is RightScale's mirror, then report the error to Support.
2. The package you are downloading has been removed or not available.
	* If the package is hosted at a public mirror, then the distributor owns the package.
	* If the package is hosted at RightScale's mirror, then report the issue to Support.
3. There could also be network latency that may cause connection to the mirrors to fail.
	* Check at Cloud Provider's status page of any on-going outage or maintenance.
	* Check with RightScale Support if all is clear from the Cloud Provider's end.
	
