---
title: About RightLink 6
layout: rl6_layout
description: RightLink is the ruby-based agent pre-installed on every RightImage-based server running in RightScale and it supports the latest automation and monitoring features.
---

!!warning*Warning!*RightLink 6 [has been EOL'd](/faq/end_of_life_end_of_service.html#schedule-images-rightlink) - please refer to the [RightLink 10 documentation](/rl10)


## Overview

RightLink is the ruby-based agent pre-installed on every RightImage-based server running in RightScale and it supports the latest automation and monitoring features. It uses HTTPS as its RightNet communication mode and configuration via RightScripts or Chef. RightLink is preinstalled on all RightImages (Version 5 and above) published by RightScale.

RightLink 6 comes available in standard OS packages (.rpm, .deb, .msi) you can use to create custom RightImages within RightScale. Additionally, you can use RightScale more easily in your private cloud with operating systems that we support but cannot distribute, such as Microsoft Windows® and Red Hat Enterprise Linux (RHEL).

For a list of all the new features added to RightLink in version 6.x (as well as bug fixes), refer to the [RightLink 6 Release Notes on GitHub](https://github.com/rightscale/right_link/blob/master/RELEASES.rdoc).

**Important!** - Custom images that are built with RightLink 5.9 and higher are fully supported by RightScale. If you choose to create your own custom images instead of using the ones included in ServerTemplates published by RightScale, please refer to the following documents for best practices and recommended procedures. See [Create RightLink 6 Enabled Images](rl6_installing.html#creating-rightlink-6-enabled-images).

## Advantages of RightLink

There are several general advantages of using RightLink-enabled RightImages (Version 5 RightImages and later).

* **Performance** - Real-time execution of scripts as opposed to periodic polling. Loosely defined, the technology is closer to push technology than pull (polling).
* **Discovery** - RightLink supports our machine tags, allowing discovery amongst Servers that can be used very pragmatically. For example, application Servers that automatically register with the load balancer upon boot, or slaves locating a master based on machine tags.
* **Robustness** - The architecture that supports RightLink is more reliable because it does not rely on SSH to perform crucial system tasks. The v5 architecture uses a reliable queuing service so no messages are dropped.

## RightLink 6 Features

Features of version 6 include:

* Support for integration with VMware vSphere cloud using the RightScale cloud appliance for vSphere.
* Updated to use Ruby 1.9 and Chef 11. This supports better integration with community cookbooks.
* You can bring your custom images to RightScale
* You can build custom images for any supported operating system and cloud, instead of relying exclusively on RightScale-published RightImages.
* Full source packages for RightLink are provided for RPM and deb formats. You can easily rebuild RightLink to support alternate distros, such as Open SUSE 13.
* You can bundle running cloud instances into RightScale-enabled images.
* Firewall friendliness: Uses HTTPs for communication with the RightScale core site. Mirrors, NTP, and patching will now also go through island load balancers.
* Modified NTP resolution algorithm where instances attempt to perform an NTP time sync with RightLink before they enroll with RightNet brokers. See [NTP Time Synchronization](rl6_using.html#ntp-time-synchronization).

## Supported Clouds

RightLink 6 Supports the following cloud types:

| Cloud Type | Nickname | Support Package |
| ---------- | -------- | --------------- |
| Microsoft Azure | azure | rightlink6-cloud-azure |
| Amazon EC2 | ec2 | rightlink6-cloud-ec2 |
| Google Compute Engine | gce | rightlink6-cloud-gce |
| OpenStack | openstack | rightlink6-cloud-openstack |
| SoftLayer | softlayer | rightlink6-cloud-softlayer |
| vSphere Cloud Appliance (VMware) | vsphere | rightlink6-cloud-vsphere |

## Supported Platforms

RightLink 6 is built for and tested with the following platforms. An additional column ("Known working/best effort") is provided for platforms known to work but are not supported officially; RightSale will provide a best-effort in terms of defect resolution on the specified platforms.

**Note**: Only 64 bit packages are built and published by RightScale.

| Platform Release | Supported by RS | Tested by RS | Known working/best effort |
| ---------------- | --------------- | ------------ | ------------------------- |
| Ubuntu 14.04 (trusty) |	X |	X |	Ø |
| Ubuntu 12.04 (precise) | X | X | Ø |
| CentOS 6 and Red Hat Enterprise Linux 6 | X | X |	Ø |
| CentOS 7 and Red Hat Enterprise Linux 7 | X |	X |	Ø |
| SUSE Linux Enterprise Server 11 SP3 | X | X | Ø |
| SUSE Linux Enterprise Server 11 SP2 | X |	X |	Ø |
| OpenSUSE 13 | Ø |	Ø | X |
| Debian 7 (wheezy) |	Ø |	Ø |	X |
| Debian 6 (squeeze) | Ø | Ø | X |
| Microsoft Windows 2012R2 | X | X | Ø |
| Microsoft Windows 2012 | X | X | Ø |
| Microsoft Windows 2008 R2 SP1 | X | X | Ø |
| Microsoft Windows 2008 (other versions) | X | Ø | Ø |
| Microsoft Windows 2008 (all versions) | X | Ø | Ø |

Legend:
X - Supported feature
Ø - Not supported

## Chef Integration and Support

As part of our integrated configuration management system, you have the option to use Chef cookbooks or scripts to configure your RightScale servers. When using the integrated Chef system, the RightLink agent executes chef-solo using a built-in Chef executable. RightLink also provides additional utilities on top of the integrated Chef executable, exposing Chef resources and providers that are specific to the RightScale management system. The RightLink agent on the running instance can run Chef recipes that install software at boot time and perform operational tasks, such as restarting services or reconfiguring software. When using the integrated Chef implementation, you must use a v5 RightImage or later.

As an alternative to the integrated Chef in RightScale, you can use a standard Chef client on any server. This approach allows you to use any Chef server and version of your choice, but will not have the built in convenience operations that come with the integrated Chef implementation. If you prefer to run Chef natively, you should consider using our [Chef Client ServerTemplate](http://www.rightscale.com/library/server_templates/Chef-Client-Beta-v13-5-/lineage/20349).

The advantages of using Chef include:

* **Remote Recipes** - Enables you to run a Chef Recipe on a remote instance (either by tag or a specific instance ID). You can also create (or delete) a tag in a Recipe run on a remote instance
* **Chef Resources** - RightLink provides several Chef resources that can be used to implement a discovery service by advertising and querying tags. See [Chef Resources](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/04-Developer/06-Development_Resources/Chef_Resources/index.html) for more information

For additional information on developing Chef recipes see the [Chef Cookbooks Developer Guide](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/index.html).

## Source Code

We’ve open-sourced the RightLink codebase to enable others to inspect what we ask them to put on their servers and to be able to leverage all the code that we put in to provide a more efficient and dynamic messaging system. Currently, RightLink may have some RightScale-specific code in it, but we’re open to factoring that out such that others can use the same codebase in other contexts. RightLink is published under the MIT license. See the LICENSE file in the source code.

The source code and license agreement for RightLink can be found at:

[http://github.com/rightscale/right_link](http://github.com/rightscale/right_link)
