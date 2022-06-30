---
title: How can I use GET-APT on CentOS-based images?
category: general
description: This page contained outdated or otherwise non-applicable product information, and has been deprecated. Please use the RightScale Documentation search feature to search for up-to-date information on this topic.
---

**Warning:** This page contained outdated or otherwise non-applicable product information, and has been deprecated. Please use the RightScale Documentation search feature to search for up-to-date information on this topic.

## Background Information

Can I use the APT package manager on the CentOS-based RightScale images? If so, how?

* * *

## Answer

RightScale does not officially support APT on the CentOS 5 based images. You may have noticed that "yum install apt" results in "nothing to do." However, you can install it using YUM (centos uses YUM instead of APT). Since it requires downloading from a third party source (RPMforge). Please do so at your own risk.

1. Download and install the rpm forge release, which will enable YUM to access:

    `wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.3.6-1.el5.rf.i386.rpm`<br>
    `rpm -i rpmforge-release-0.3.6-1.el5.rf.i386.rpm`

2. After this is installed (it takes a long time), you can install APT.
3. You should now be able to use apt-get and install the apt repositories. You will have to add your sources at /etc/apt/sources.list.d

To get started with RightScale, [try the Free Edition](https://www.rightscale.com/s/cloud-computing-management.php).
