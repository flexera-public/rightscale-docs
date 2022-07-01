---
title: Why is my Server stuck in booting?
category: general
description: There many reasons why a RightScale Server would remain in a booting state. This article describes a few of these instances and provides steps for fixing the issue.
---

## Background Information

There many reasons why a Server would remain in a booting state. A few instances are described below.

## Answer

* If you are using a VPC/Private Network that has a restricted outbound connection to the RightScale Backend, a Server may remain in a booting state.
	1. Try to use an EC2-Classic Network for testing purposes or search `VPC Network` in the docs site to get started with VPC.
	2. Search `RightScale firewall` at our docs site to see the list of RightScale IP Blocks that need to be allowed on your VPC/Private Network.
* If you are using a custom Image where the RightLink Agent was not installed or not configured properly, a Server may remain in a booting state.
	1. Try using a supported RightScale Image for your testing purposes or on your production workload.
* If you are using custom ServerTemplate where some basic boot script is missing, a Server may remain in a booting state.
	1. Try using a base RightScale ServerTemplate and see how it performs and go from there.
* If a Server was started/rebooted outside of the RightScale Console, a Server may remain in a booting state.
	1. Reboot the Server from the RightScale Console to see if that addresses the issue.
* If your are using an old and unsupported ServerTemplate or RightScale Image, a Server may remain in a booting state.
	1. Try to use the latest base ServerTemplate or RightScale Image to see if that addresses the issue.
* If a problematic Server was stopped, starting it back up may cause the Server to also remain in booting state.
	1. Check if you can access your Server at the Cloud Provided Console and backup your data.
	2. Afterwards, you may re-launch the Server and restore your Services on it.
