---
title: Why is my server "stranded in booting" when I reboot the instance?
category: general
description: Typically, if a server is in an error state that requires a reboot, this is a good indicator that the instance has become unstable.
---

## Background Information

When you reboot the instance, the server is left in the "stranded in booting" state.

* * *

## Answer

RightScale generally does not recommend rebooting a server. Typically, if a server is in an error state that requires a reboot, this is a good indicator that the instance has become unstable. In such cases, it is better to launch a new instance instead of trying to reboot and troubleshoot a problematic server. However, a reboot can be useful for troubleshooting and testing purposes.

When you reboot a server, the boot scripts will be run again.&nbsp; See the [Server States](http://support.rightscale.com/12-Guides/Lifecycle_Management/05_-_Server_Management/Server_States) diagram to understand what happens on the instance during each server state.

There are a few scripts that are not "reboot safe." The best way to determine whether or not a script is reboot safe, is to reboot the server and see if the server has a problem running its boot scripts and becoming fully operational. For example, if you reboot a server and the boot scripts are run a second time (during a reboot and not a first-time server launch), you receive an error and the server immediately stops executing scripts and displays a "stranded" status. In such cases, one or more of your boot scripts is not reboot safe. You will have to disable the script prior to rebooting the server, by selecting the Scripts tab for the "Next" server and deselecting that boot script.

**Note**: If you've already successfully rebooted the server and it is stranded, you can also force the "stranded" server to become operational.

## See also

* [Server States](http://support.rightscale.com/12-Guides/Lifecycle_Management/05_-_Server_Management/Server_States)
