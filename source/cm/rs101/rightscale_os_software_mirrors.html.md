---
title: Rightscale OS Software Mirrors
layout: cm_layout
description: The mirror.rightscale.com site is a mirroring service for RubyGems and OS software packages that RightScale provides to its customers.
---

!!warning*Note* Rightscale Mirrors are deprecated.<br>If you're currently using [mirror.rightscale.com](http://mirror.rightscale.com) for your cloud instances, please use public repositories for your needs.

---

## What is [mirror.rightscale.com](http://mirror.rightscale.com)?

It is a mirroring service for RubyGems and OS software packages that RightScale provides to its customers. An array of cloud server instances host this service, enabling faster downloads and higher availability than public OS repositories.

These OS and RubyGems mirrors are used by cloud instances to boot and install OS packages, security updates and other software. You will commonly find a Rightscale mirror URL in the YUM or APT configuration of an instance, which can usually be found in the /etc/apt/ or /etc/yum/ directories somewhere (/etc/apt/.sources.list.d/ and other directories may hold the config files as well). The URLs used by YUM and APT may also be region or zone specific, and may not reflect 'mirror.rightscale.com' in any way. For example, a US-East AWS instance may use the URL:

[http://ec2-us-east-mirror1.rightscale.com/](http://ec2-us-east-mirror.rightscale.com/)

These mirrors all host the same content, so the name change is simply to accommodate higher speeds and latency in specific zones or regions.

## Why Do We Need Another Mirror?

Public RubyGem and OS software repositories often exhibit transient issues that can cause problems when booting and reconfiguring machines through the RightScale Dashboard. Therefore, RightScale offers its own mirrors that it manages and supports in order to increase the robustness and availability of RubyGems and OS packages for our users. The mirrors help us control and remove inconsistencies that external mirrors often have before updating them. The mirror also makes it possible for users to lockdown their open source distribution repositories to a specific date. This provides a more robust and failproof instance or server while using older versions of packages/software, but you will always have the peace of mind that your instance will boot successfully and no upstream changes to packages will affect your servers/instances.

## Who Maintains It?

RightScale mirrors are fully operated and maintained by RightScale.

## How Often is it Updated and What Does the Mirror Contain?

The **mirror is updated nightly** from a few of the well-known repository sources that provide rsync capabilities. The mirror currently contains the following:

- **Standard OS Repositories**
  - **CentOS** - (/centos) CentOS Linux public repositories.
  - **Ubuntu** - (/ubuntu_daily) Ubuntu linux public repositories. Support for apt, which is the Debian package manager similar to yum.
- **Standard third party repositories**
  - **rubyforge.org** - (/rubygems) All RubyGems hosted by rubyforge.org.
  - **EPEL** - (/epel) Fedora EPEL (Extra Packages for Enterprise Linux) Version 5+ with extra packages for Enterprise Linux.
  - **IUS -** (/ius) Packages for RHEL and Centos including PHP, MySQL and other commonly installed software.
- **RightScale software repositories**
  - **RightScale Software** - (/rightscale_software, /rightscale_software_ubuntu) - various packages maintained by RightScale.
  - **RightScale RightLink** - (/rightlink) RightScale RightLink agent software

**Note:** Most, if not all of the above mirrors, should be direct upstream copies of the official mirrors hosted by each OS/distribution/source. Aside from caching a copy of each OS mirror nightly, each cached/dated version, as well as the 'latest' copy, should be the same as the upstream source repository on that given date.

## Browsing the Mirror

You can easily browse the mirror by pointing your browser to [http://mirror.rightscale.com](http://mirror.rightscale.com) and drilling down into any of the various OS or RubyGems directories. For example, the base of the Centos 6 64-bit main 'OS' directory in the Centos repository would be here:

[http://mirror.rightscale.com/centos/6/os/x86_64/](http://mirror.rightscale.com/centos/6/os/x86_64/)

Rightscale archives these upstream repositories nightly, so if you are looking for a specific date, you can drill into the **/archive** directory and several more folders will exist, each by date.

For August 21, 2013, you would navigate to the following folder:

[http://mirror.rightscale.com/centos/6/os/x86_64/archive/20130821/](http://mirror.rightscale.com/centos/6/os/x86_64/archive/20130821/)

The 'latest' nightly copy of the repository can always be found in the **/latest** directory:

[http://mirror.rightscale.com/centos/6/os/x86_64/archive/latest](http://mirror.rightscale.com/centos/6/os/x86_64/archive/latest)

The 'latest' version of rubygems is located here:

[http://mirror.rightscale.com/rubygems/archive/latest/](http://mirror.rightscale.com/rubygems/archive/latest/)

Ubuntu's repositories are laid out slightly differently, however the base repository for August 21, 2013's cached copy of the repository would lie here:

[http://mirror.rightscale.com/ubuntu_daily/2013/08/21/](http://mirror.rightscale.com/ubuntu_daily/2013/08/21/)

## How is Security Handled?

Communication with OS package repositories happens over http. System packages installed through YUM on CentOS/RHEL and Apt on Ubuntu are not set up by default to use HTTPS, as there would be limited benefit. Both package managers support mechanisms to verify packages: all packages are signed with GPG keys by the OS vendors. GPG keys from OS vendors to verify standard distribution and standard third party package repositories are included in all RightImages. Keys for any RightScale created package repositories are bundled with RightLink and imported by default.

## How are the Mirrors Configured on a RightScale Server?

​The package mirrors are configured by RightScale [RightLink](/rl10/index.html) agent on every boot. Several sets of redundant URLs are passed to each booting Server, which RightLink uses to overwrite the existing system configuration. Each OS package manager will fail over between URLs if one of the members of the set is unavailable. Currently two different sets of URLs are passed, referred to as Group A and Group B as follows. The Group A URL set point to a [CDN](http://en.wikipedia.org/wiki/Content_delivery_network), currently Cloudfront, and the Group B URL set points to RightScale Island load balancers. Group B URLs are meant to act as proxies for RightScale Servers with limited egress to the public internet. VPC and private clouds should allow HTTP egress to these servers: see the [About Firewalls](/cm/dashboard/settings/account/index.html#about-rightscale-accounts) section for further details. Island load balancers correspond to the RS_ISLAND user data variable passed down in the RightScale user data OS Package Mirror from the [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html) as well.

## Potential Issue

If you get the following error or similar, it's possible that the Server/ServerTemplate is using an unfrozen repository (one possibility is security update enabled) that is pointing to the **/latest** and it caught the mirrors updating with the source/upstream repository. Usually if customers encounter this issue, we recommend to wait a few minutes and then try launch/re-launch again. If using a frozen date, this shouldn't be a problem.

* ERROR> Execution failed * ERROR> External command error: "/opt/rightscale/sandbox/bin/gem install /var/cache/rightscale/cookbooks/default/821dcc2de7fdeb9107f1d147b8338711/rightscale/recipes/../files/default/rightscale_tools-1.7.42.gem -q --no-rdoc --no-ri -v "1.7.42"" exited with 1, expected 0.The command was run from "/tmp"

* ERROR> Subprocess exited with 1

* RS> boot failed: rightscale::setup_security_updates,* RS> rightscale::install_rightimage_extras, logging::default,

* RS> sys_firewall::default, sys_ntp::default, rightscale::default,

* RS> rightscale::install_tools, block_device::setup_ephemeral,

* RS> memcached::install_server, rightscale::setup_security_update_monitoring,

* RS> rightscale::do_security_updates

By default, all ServerTemplates are frozen to a certain date when they were published. The purpose of the [frozen repositories](/cm/rs101/freezing_software_repositories.html) is to ensure that a server will be launched with the same versions of software regardless of when that server is launched again in the future.

## See Also

- [Freezing Software Repositories](/cm/rs101/freezing_software_repositories.html)
- [Inheritance of Software Repositories](/cm/rs101/inheritance_of_software_repositories.html)
