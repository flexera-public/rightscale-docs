---
title: How can I synchronize my server instance times to support monitoring and autoscaling?
category: general
description: This article describes how to resolve issues where system-time discrepancies exist between the RightScale monitoring servers and server instances in a RightScale Deployment.
---

## Background

This article describes how to resolve issues where system-time discrepancies between the [RightScale monitoring servers](http://support.rightscale.com/12-Guides/RightScale_101/08-Management_Tools/Monitoring_System) and server instances in a RightScale Deployment result in the following:

* Graphical monitoring data fails to display for those instances (all monitoring graphs are blank)
* Server Arrays fail to autoscale due to lack of monitoring statistics

**Note**: In general, these issues do not occur on Amazon EC2 instances, due to Amazon's use of Xen to synchronize server instance clocks. They may occur with instances running on other cloud providers, however.

If you encounter these symptoms in your RightScale Deployments and note an out-of-synch system time when you SSH into a running server instance, you should verify that a boot script to install and configure Network Time Protocol (NTP) is associated with your ServerTemplate. If it is not, follow the steps in the next section to create an NTP boot script.

## Answer

If your ServerTemplate does not include a script to install and configure NTP, you can create one by pasting the below into the **Script** field under **Design -> RightScripts -> New**.

~~~
#!/bin/bash -ex
# RightScale (c) 2010-2011
# Install and start NTP
# Clocks out-of-sync can cause numerous problems for the VM's.
# Mostly for collectd and possibly RightLink. All clouds should have their
# times synced properly.

# Skip if already installed
if [-e /etc/ntp.conf] ; then
  echo "NTP is already installed."
  exit 0
fi

if ["$RS_DISTRO" == "centos"]; then
  yum install -y ntp
  chkconfig ntpd on
  ntpdate pool.ntp.org
  service ntpd start
elif ["$RS_DISTRO" == "ubuntu"]; then
  apt-get install -y ntp
  ntpdate pool.ntp.org
  service ntp start
fi
~~~

After saving your new script, add to the relevant ServerTemplate as a boot script. (We recommend that you add it as the first sequential boot script in the list.) If you need guidance in this process, refer to the [Intermediate Example](http://support.rightscale.com/09-Clouds/AWS/Tutorials/01-Beginner_Examples/4._Intermediate_Example) tutorial, which covers these steps.
