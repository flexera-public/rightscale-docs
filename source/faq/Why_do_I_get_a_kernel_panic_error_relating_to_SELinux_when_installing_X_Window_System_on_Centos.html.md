---
title: Why do I get a kernel panic error relating to SELinux when installing X Window System on CentOS?
category: general
description: This is due to the X Window System installing SELinux as a dependency, and if it isn't needed we normally recommend simply disabling it. This article explains how to accomplish that.
---

## Background

When installing the X Window System on a Centos based instance, you may encounter a kernel panic error similar to this:

~~~
audit(1317965535.759:2): enforcing=1 old_enforcing=0 auid=4294967295
Unable to load SELinux Policy. Machine is in enforcing mode. Halting now.
Kernel panic - not syncing: Attempted to kill init!
~~~

This is due to the X Window System installing SELinux as a dependency, and if it isn't needed we normally recommend simply disabling it. This article will explain how to do that.

## Answer

If you are able to boot and SSH into the instance, you will want to edit the following file:

`/etc/sysconfig/selinux`

When editing this file, change:

**SELINUX=enforcing**

to

**SELINUX=disabled**

Be sure to save the changes and exit the file. Upon reboot, you should no longer see this kernel panic message in the console output.

**NOTE:** You may not be able to get the instance to a stable enough state where you can edit the /etc/sysconfig/selinux file by SSH. If this is the case, we may need to get creative and setup another instance with a script that can dynamically disable SELinux. Feel free to drop us a line at [support@rightscale.com](mailto:support@rightscale.com) or (866) 787-2253 and we'll be happy to do our best to assist.
