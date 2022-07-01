---
title: Installing RightLink 6
layout: rl6_layout
description: Guide covering installation of RightLink 6 and tips and info for creating RightImages.
---

!!warning*Warning!*RightLink 6 [has been EOL'd](/faq/end_of_life_end_of_service.html#schedule-images-rightlink) - please refer to the [RightLink 10 documentation](/rl10)

## Overview

This guide is divided into two parts. The first covers installation of RightLink 6 and second has tips and info for creating RightImages.

## Installing RightLink 6

When installing RightLink you must first select your operating system and then select your cloud.
  * For Windows, browse the index below, download the MSI, and install it. The MSI installer will prompt you to select a cloud.
  * For Linux systems, you will install RightLink using the OS package manager. Paste the repository URL into your package manager configuration below, import the RightScale public key, and install the appropriate cloud package:

### Select an Operating System


#### General Availability channels
| Operating System | Repository URL | Index |
| ---------------- | -------------- | ----- |
| Ubuntu | http://mirror.rightscale.com/rightlink/apt​ | [Browse](http://mirror.rightscale.com/rightlink/apt/index.html) |
| CentOS 6 and RHEL 6 | http://mirror.rightscale.com/rightlink/yum/1/el/6/x86_64<br>​http://mirror.rightscale.com/rightlink/yum/1/el/6/SRPMS | [Browse](http://mirror.rightscale.com/rightlink/yum/index.html) |
| CentOS 7 and RHEL 7 | http://mirror.rightscale.com/rightlink/yum/1/el/7/x86_64<br>http://mirror.rightscale.com/rightlink/yum/1/el/7/SRPMS | [Browse](http://mirror.rightscale.com/rightlink/yum/index.html) |
| SLES 11 | http://mirror.rightscale.com/rightlink/zypp/1/suse/11/x86_64<br>http://mirror.rightscale.com/rightlink/zypp/1/suse/11/SRPMS​ | [Browse](http://mirror.rightscale.com/rightlink/zypp/index.html) |
| Windows 2008R2 and 2012 | http://mirror.rightscale.com/rightlink/msi | [Browse](http://mirror.rightscale.com/rightlink/msi/index.html) |


### Select your cloud
There are different subpackages for each cloud. The following are supported.

| Cloud | Cloud Type | Package name |
| ----- | ---------- | ------------ |
| Microsoft Azure | azure | rightlink-cloud-azure |
| Amazon EC2 | ec2 | rightlink-cloud-ec2 |
| Google Compute Engine | google | rightlink-cloud-google |
| OpenStack | openstack | rightlink-cloud-openstack |
| SoftLayer | softlayer | rightlink-cloud-softlayer |
| vSphere | vsphere | rightlink-cloud-vsphere |


### RHEL or CentOS Installation

Import the RightScale public key:
~~~ bash
rpm --import http://mirror.rightscale.com/rightlink/rightscale.pub
~~~

Next, write out the repo configuration using the package manager URL selected above. This example sets up installation from the GA channel for CentOS 6 and CentOS 7, respectively:
~~~ bash
cat > /etc/yum.repos.d/RightLink.repo <<EOF
[rightlink]
name=RightLink
baseurl=http://mirror.rightscale.com/rightlink/yum/1/el/6/x86_64
gpgcheck=1
gpgkey=http://mirror.rightscale.com/rightlink/rightscale.pub
EOF
~~~
~~~ bash
cat > /etc/yum.repos.d/RightLink.repo <<EOF
[rightlink]
name=RightLink
baseurl=http://mirror.rightscale.com/rightlink/yum/1/el/7/x86_64
gpgcheck=1
gpgkey=http://mirror.rightscale.com/rightlink/rightscale.pub
EOF
~~~

Finally, install the appropriate package for your cloud:
~~~ bash
yum install -y rightlink-cloud-ec2
~~~

### Ubuntu Installation

Import the RightScale public key:
~~~ bash
curl http://mirror.rightscale.com/rightlink/rightscale.pub | apt-key add -
~~~

Create an apt source, ensuring that you specify the right architecture and release code name.
For instance, on an amd64 system that is running Ubuntu 12.04 and 14.04 respectively using a GA package:

~~~ bash
# Ubuntu 12.04 (precise)
cat > /etc/apt/sources.list.d/rightlink.sources.list <<EOF
deb [arch=amd64] http://mirror.rightscale.com/rightlink/apt precise main
EOF
apt-get update
~~~

~~~ bash
# Ubuntu 14.04 (trusty)
cat > /etc/apt/sources.list.d/rightlink.sources.list <<EOF
deb [arch=amd64] http://mirror.rightscale.com/rightlink/apt trusty main
EOF
apt-get update
~~~

Finally, install the appropriate package for your cloud:
~~~ bash
apt-get install -y rightlink-cloud-ec2
~~~

### SLES Installation

Import the RightScale public key:
~~~ bash
rpm --import http://mirror.rightscale.com/rightlink/rightscale.pub
~~~

Next, write out the repo configuration using the package manager URL selected above. This example installs from the GA channel for SLES 11:
~~~ bash
cat > /etc/zypp/repos.d/RightLink.repo <<EOF
[rightlink]
name=RightLink
baseurl=http://mirror.rightscale.com/rightlink/zypp/1/suse/11/x86_64/
gpgcheck=1
gpgkey=http://mirror.rightscale.com/rightlink/rightscale.pub
EOF
~~~

Finally, install the appropriate package for your cloud:
~~~ bash
zypper --non-interactive install rightlink-cloud-ec2
~~~

### Windows Installation

The following prerequisites must be installed first:
  * .NET 3.5 SP1
  * Powershell

After prerequisites are met, download and install the MSI from a distribution channel selected above and select your cloud in the dialog box presented.

## Uninstalling RightLink (Linux)

Use the following procedure to uninstall RightLink (v5.6 - v6.3) on Linux

1. Stop RightLink services (RigthLink Agent Controller)

    ~~~ bash
    service rightlink stop
    service rightscale stop
    ~~~

2. Remove RightScale and RightLink packages

    RightLink 5.6-5.8

    ~~~ bash
    # CentOS, RHEL
    yum remove rightscale
    # Debian, Ubuntu
    apt-get remove rightscale
    ~~~

    RightLink 5.9-6.3

    ~~~ bash
    # CentOS, RHEL
    yum remove rightlink6 rightlink6-sandbox
    # Debian, Ubuntu
    apt-get purge rightlink6 rightlink6-sandbox
    ~~~

    **Note**: The uninstaller may show an error while deleting files inside /opt/rightscale/\*. This is normal behavior.

3. Remove all RightLink files (RightLink Agent Controller)

    ~~~ bash
    rm -rf /etc/rightscale.d /opt/rightscale /var/lib/rightscale /etc/init.d/rightimage /var/spool/cloud /var/cache/rightscale
    # verify that you have not left any rightscale files (except /usr/share/zoneinfo/right)
    find / -name right*
    ~~~


## Creating RightLink 6 Enabled Images
<a name="Creating RightLink 6 Enabled Images"></a>

Here are some tips for creating your own custom RightLink-enabled images.

**Important!** - Custom images that are built with RightLink 5.9 and higher are fully supported by RightScale. If you choose to create your own custom images instead of using the ones included in ServerTemplates published by RightScale, please refer to this document for best practices and recommended procedures.

### RCA-V Images
RCA-V images require VMware tools to be installed. Please see [RCA-V Image Requirements](/rcav/v3.0/rcav_image_requirements.html).

### Images Built from Scratch

When creating images from scratch, follow [Installing RightLink 6](rl6_installing.html#installing-rightlink-6) to include the required packages within your image. Installation of the packages will also enable the system services for RightScale/RightLink on boot. After RightLink installation, there are also meta-packages in the RightScale software mirror to install ServerTemplate dependencies.  These packages are optional and meant to improve boot times. Two flavors of meta package currently exist:

* **rightimage-extras-base** - Contains optional dependency packages of the v14 Linux Base ServerTemplate.
* **rightimage-extras** - Contains required dependency packages for v13 ServerTemplates. This package is deprecated for use with v14 ServerTemplates.  It is now recommended to properly declare all dependencies in configuration management systems such as Chef or RightScripts.

#### Ubuntu Instructions:

~~~ bash
# Import RightScale public key
curl http://mirror.rightscale.com/rightlink/rightscale.pub | apt-key add

cat > /etc/apt/sources.list.d/rightscale_extra.sources.list <<-EOF
deb [arch=amd64] http://mirror.rightscale.com/rightscale_software_ubuntu/latest precise main
EOF

apt-get update
apt-get install -y rightimage-extras-base
~~~

For Ubuntu 14.04 and newer only: RightScale's monitoring solution for RightLink 6 is not compatible with collectd 5. To use Collectd 5, install the [RightLink 10](/rl10/getting_started.html) agent instead. Monitoring is needed for graphs, alerts, and for autoscaling arrays.  rightimage-extras-base depends on collectd < 5. To satisfy this dependency, please place the apt configuration file below in "/etc/apt/preferences.d/rightscale-collectd-pin-1001":

~~~
# Collectd 5 is not currently supported by the RightScale monitoring servers
# Pin to previous version from "precise" to avoid issues. These packages are
# available from http://mirror.rightscale.com/rightscale_software_ubuntu
Package: collectd
Pin: version 4.10.1-2.1ubuntu7
Pin-Priority: 1001

Package: collectd-core
Pin: version 4.10.1-2.1ubuntu7
Pin-Priority: 1001
~~~

#### CentOS and Red Hat Enterprise Linux Instructions:

~~~ bash
cat >/etc/yum.repos.d/RightScale-epel.repo<<-EOF
[rightscale-epel]
name=RightScale Software
baseurl=http://mirror.rightscale.com/rightscale_software/epel/6/x86_64/archive/latest/
gpgcheck=1
enabled=1
gpgkey=http://mirror.rightscale.com/rightlink/rightscale.pub
EOF

yum install rightimage-extras-base -y
~~~

For CentOS/RHEL 7 and newer only: RightScale's monitoring solution for RightLink 6 is not compatible with collectd 5. To use Collectd 5, install the [RightLink 10](/rl10/getting_started.html) agent instead. Monitoring is needed for graphs, alerts, and for autoscaling arrays. rightimage-extras-base depends on collectd < 5. To satisfy this dependency, please "yum install -y yum-plugin-versionlock" and place the versionlock configuration file below in "/etc/yum/pluginconf.d/versionlock.list":

~~~
# Collectd 5 is not currently supported by the RightScale monitoring servers
# Use ported version from CentOS 6 to avoid issues. These packages are
# available from http://mirror.rightscale.com/rightscale_software/epel
0:collectd-4.10.9-1.el7.*
0:collectd-rrdtool-4.10.9-1.el7.*
~~~

**Note**: Building a virtual machine image from scratch is out of the scope of this guide, and considered an advanced topic.

### Bundling Running Instances

Before bundling running instances, you should clean-up your instance by deleting or truncating several files stored on the instance disk to ensure that a new instance does not inherit old data. Security is the main reason for performing these steps, as some files (SSH keys/host keys, for example) can leave your newly-bundled image vulnerable, particularly if you chose to publish or distribute it publicly.

While many of these files can be excluded during the bundling process, this guide takes a preventative approach by recommending some best practices for server/instance clean-up prior to the bundling process. A majority of the file removal is applicable to RightScale-managed servers, however these practices also apply to unmanaged instances after installing RightLink.

**Note**: This guide should work with official RightImages that are being rebundled or with custom images built from scratch but it has not been tested with every OS distribution or RightLink version available. If you experience issues, please contact RightScale Support with questions or feedback.

#### Prerequisites

Before working through this section, you should have the following:

* A running cloud instance or server that has RightLink installed and configured and is ready for bundling.
* SSH or RDP access to the server or instance

#### Linux Servers and Instances

The following actions should be taken on all \*nix-based instances and servers (CentOS and Ubuntu tested). Each command should be run from the command line within an SSH terminal/session.

**Stop Services**

Use the following commands to stop NTP and Postfix:

~~~ bash
service ntp stop
service postfix stop
~~~

**Delete Files**

Use the following commands to delete the following files and directories from any \*nix instances. Run each command once from the command prompt:

~~~ bash
# RightScale specific
rm -f /var/spool/cloud/*
rm -f /etc/udev/rules.d/70-persistent-net.rules
rm -rf /var/lib/rightscale
rm -rf ~rightscale/.ssh

rm -rf /tmp/*
rm -rf /tmp/.[^.]*
rm -rf /tmp/..?*
rm -rf /var/cache/*
rm -rf /var/mail/*
rm -rf /var/lib/ntp/ntp.drift
rm -f /etc/hosts.backup.*
rm -rf /etc/pki/tls/private/*
rm -rf /root/.ssh
rm -rf /root/.gem
rm -f /root/*.tar
rm -rf /root/files
rm -f /root/*
rm -f /root/.*_history /root/.vim* /root/.lesshst /root/.gemrc
rm -rf /root/.cache /root/.vim
find /etc -name \*~ -exec rm -- {} \;
find /etc -name \*.backup* -exec rm -- {} \;
~~~

**Truncate and Clear Files**

Zero the following files without deleting them. Note that some services will not recreate their log files if they are deleted.

~~~ bash
find /var/spool -type f -exec cp /dev/null {} \;
find /var/log -type f -exec cp /dev/null {} \;
find /etc/ssh/ssh_host_* -type f -exec cp /dev/null {} \;
~~~

**Remove Empty Password from Root**

The following command removes the empty password from the root user:

~~~ bash
sed -i s/root::/root:\*:/ /etc/shadow
~~~

**Recreate Necessary Directories**

Run the commands below to create the necessary directories. (If the directories do not already exist, they will be recreated.)

~~~ bash
mkdir -p /var/cache/logwatch /var/cache/man /var/cache/nscd
~~~

**Centos/RHEL-Specific Actions**

Remove any custom CentOS Ruby YUM repository:

~~~ bash
rm -f /etc/yum.repos.d/CentOS-ruby-custom.repo
~~~

Ensure that PHP packages are not installed and run YUM Clean:

~~~ bash
yum -y remove php*
yum -y clean all
~~~

**Ubuntu-Specific Actions**

Run apt-get clean:

~~~ bash
apt-get clean
~~~

Create specific directories:

~~~ bash
mkdir -p /var/cache/apt/archives/partial /var/cache/debconf
~~~

Generate APT caches:

~~~ bash
apt-cache gencaches
~~~

**Generate Man Cache and Other Various Actions**

Run the following commands last:

~~~ bash
mandb --create
updatedb
sync
~~~

#### Windows Servers and Instances

When bundling a Windows server or cloud instance, it is recommended to [SysPrep a windows installation](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation). This is specifically done to prepare Windows machines for duplication or reuse by removing system specific data from Windows along with other various tasks.

In addition to this, Rightlink 5.8.8 and above provides a SysPrep provider in its code for SysPrep to initiate a cleanup of all disposable Rightlink data as well, so one must only run a SysPrep command to fully prepare the instance for bundling. Once prepared and SysPrepped, the instance should also be shutdown per best practice prior to bundling into a new image (/shutdown included in sysprep command below).

**Check Rightlink Version and Upgrade if Needed**

This is a **CRUCIAL** step to the process, since the aforementioned SysPrep provider only exists in Rightlink v5.8.8 or higher. If you are running a version of Rightlink prior to this, it is HIGHLY recommended that you upgrade to the latest available stable version of Rightlink.

Newer Rightlink packages can be found on our [mirror](http://mirror.rightscale.com/rightlink/msi/index.html), and directions for upgrading and/or installing the package are found on the [Rightlink 5.8 Installer Page for Windows](http://support.rightscale.com/12-Guides/RightLink_6/RightLink_Legacy_Versions/RightLink_5.8_and_Lower/Create_RightScale-Enabled_Images_with_RightLink_5.8_and_lower/RightLink_Installer_for_Windows_AMIs/index.html) and the [Upgrade Rightlink Version on Windows](http://support.rightscale.com/12-Guides/RightLink_6/RightLink_Legacy_Versions/RightLink_5.8_and_Lower/Create_RightScale-Enabled_Images_with_RightLink_5.8_and_lower/RightLink_Installer_for_Windows_AMIs/Upgrade_RightLink_Version_on_Windows/index.html) page.

**Run SysPrep**

Once we've validated that we are using Rightlink v5.8.8 or higher, it's time to run the SysPrep command. This can be run by opening up a command prompt from an remote desktop session and running the command below:

~~~
%windir%\system32\Sysprep\sysprep /oobe /generalize /shutdown
~~~

**Note**: Only run this command when you are satisfied with the state of the instance and are ready to bundle the image, as it will shutdown the system in preparation for a bundle action.

**Bundle the Instance**

At this point, you can now safely bundle or snapshot the running instance into a new image. Consult the given cloud's documentation on bundling/snapshot capabilities (if supported).

**Create or Update a MultiCloud Image**

When creating or adding the image to an MCI, be sure to add the provides:rs_agent_type=right_link tag to the MCI prior to adding it to a ServerTemplate. The MCI can then be added to any HEAD version of a SeverTemplate and in turn used with RightScale-managed servers.
