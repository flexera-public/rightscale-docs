---
title: Why is my CentOS 4.5 instance so outdated?
category: general
description: Starting on October 13th, 2011, RightScale has started properly mirroring the Centos 5.x base repository, located at /centos/5/.
---

## Background

When using our Centos 5.4 and early 5.6 Rightimages, we use a mirror of the /centos/5.4/ (or /centos/5.6/) repository directly from Centos. These mirrors can be seen online at [http://mirror.rightscale.com](http://mirror.rightscale.com)&nbsp;under the /centos/ directory:

[http://mirror.rightscale.com/centos/5.4/](http://mirror.rightscale.com/centos/5.4/)

[http://mirror.rightscale.com/centos/5.6/](http://mirror.rightscale.com/centos/5.6/)

The way that Centos mirroring works is to release a major epoch version (such a 5.0 or 6.0), then provide "point releases" throughout the major release (such as 5.4 and 5.6). These "point" releases are nothing more than pre-defined "snapshots" of Centos 5.0 or 6.0 with all of the security updates, patches, etc. up to that point in time.

When Centos 5.4 was released, the /5.4/ mirror directory was created and regular updates were made to that repository. When Centos releases it's \*next\* point release (5.5 in this case), the /5.4/ directory STOPPED getting updated by design. The same occurs for /5.5/ when /5.6/ was released, and so forth and so on.

Our RightScale Centos 5.4 images are designed to point to the /centos/5.4/ directory, which by design has been out of date since the release of Centos 5.5. It only has all of the Centos 5.x updates to the point of 5.5 being released, so you may notice that your Centos 5.4 images will not be fully updated with security patches, updates, etc. and if you issue the command 'yum update' it will not pull down the newest packages.

## Answer

Starting on October 13th, 2011, RightScale has started properly mirroring the Centos 5.x base repository, located at /centos/5/ here:

[http://mirror.rightscale.com/centos/5/](http://mirror.rightscale.com/centos/5/)

This repository is a consistently updated Centos 5.x repository with any and all updates to the current point in time for \*ANY\* point release of Centos 5.x (5.4, 5.5, 5.6, etc.)

When using this repository, you can issue a 'yum update' and Centos 5.x will be updated to the very latest packages, security updates, etc. which will essentially make it the latest Centos 5.x Point release (5.7 at the time of this writing).

**WARNING:** Please beware that if you switch to this repository there may be some incompatibilities with various RightScripts on many of our default templates. As we move forward, we will be releasing Centos 5.x images that use this new /5/ repository and our server templates will be able to accommodate for that, but using pre-existing images and templates we may see some anomalies or other issues due to this change.

**<u>How to use it:</u>**

The premise behind using the updated /centos/5/ repository is fairly simple. We just need to update the /etc/yum.repos.d/ files on your instance to point to the correct location. These files should be modified:

~~~
/etc/yum.repos.d/CentOS-Base.repo
/etc/yum.repos.d/CentOS-addons.repo
/etc/yum.repos.d/CentOS-centosplus.repo
/etc/yum.repos.d/CentOS-extras.repo
/etc/yum.repos.d/CentOS-updates.repo
~~~

These files should look something like this by default (notice they are using the /centos/5.4/ repo, not /5/):

~~~
name = none
baseurl = http://ec2-us-west-mirror.rightscale.com/centos/5.4/os/i386/archive/20110317
  http://ec2-us-west-mirror1.rightscale.com/centos/5.4/os/i386/archive/20110317
  http://ec2-us-west-mirror2.rightscale.com/centos/5.4/os/i386/archive/20110317
  http://ec2-us-east-mirror.rightscale.com/centos/5.4/os/i386/archive/20110317
  http://ec2-us-east-mirror1.rightscale.com/centos/5.4/os/i386/archive/20110317
failovermethod=priority
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5
~~~

To us the latest repository in the /5/ branch, we will want to modify these files to look something like this:

~~~
name = none
baseurl = http://ec2-us-west-mirror.rightscale.com/centos/5/os/i386/archive/latest
  http://ec2-us-west-mirror1.rightscale.com/centos/5/os/i386/archive/latest
  http://ec2-us-west-mirror2.rightscale.com/centos/5/os/i386/archive/latest
  http://ec2-us-east-mirror.rightscale.com/centos/5/os/i386/archive/latest
  http://ec2-us-east-mirror1.rightscale.com/centos/5/os/i386/archive/latest
~~~

You can manually edit these files to update them to the latest /5/ branch using any text editor of your choosing. Once updated, issuing a yum update should attempt to update from these latest repos, giving you the latest Centos 5.x packages, security updates, etc.

~~~
yum update
~~~

<u><strong>Automated Script</strong></u>

Below is an automated script that you can run to modify/update any /etc/yum.repos.d/\* files to the /5/ and /archive/latest directory, then it automatically runs a 'yum update' command for you. You can create a RightScript with this code or run it manually or as a boot script if you'd like to automate this repository changeover:

~~~
#!/bin/bash

# CHANGE /MAJOR.MINOR FORMAT REPO URLS TO /MAJOR FORMAT, TO ALLOW ACCESS TO THE LATEST SECURITY UPDATES.
sed -ri 's/centos\/5\.[0-9]/centos\/5/g' /etc/yum.repos.d/CentOS-*.repo
sed -ri 's/archive\/([0-9]*|latest)/archive\/latest/g' /etc/yum.repos.d/CentOS-*.repo

# Issue a YUM UPDATE
yum update
~~~

This script will match any centos/5.x line and replace it with centos/5. The second sed line finds any archive/<date> or /archive/latest folder and replaces it with archive/latest, which indicates that you will always be getting the latest updates, patches, etc. from the /5/ repository (not frozen to a specific date).

**NOTE:** We only have frozen repositories in the /5/ repo starting with 10/14/2011 and moving forward! You will not be able to freeze the /5/ repo branch to anything earlier than 10/14/2011!

<u><strong>Still need help?</strong></u>

Feel free to contact us by opening a ticket in the Top-Right corner of the RightScale dashboard (Support -> Email) or by emailing [support@rightscale.com](mailto:support@rightscale.com "support@rightscale.com") or calling us at (866) 787-2253.
