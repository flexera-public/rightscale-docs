---
title: Cloud-Init Installation
description: Using the RightScale-provided cloud-init package in RightLink 10.
version_number: 10.6.3
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_cloud_init_installation.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_cloud_init_installation.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_cloud_init_installation.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_cloud_init_installation.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_cloud_init_installation.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_cloud_init_installation.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_cloud_init_installation.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_cloud_init_installation.html
---

## Overview

In order to use RightLink 10 on clouds that are not supported by cloud-init, you will need to use the RightScale-provided cloud-init package. See the supported clouds list below to determine if you need the RightScale-provided cloud-init package to support your desired cloud. RightScale cloud-init differs from the stock cloud-init by adding a plugin for the SoftLayer cloud. RightScale cloud-init will always have RightScale as the package Vendor/Maintainer and "rightscale" in the release name.

| Cloud | Cloud-init Type |
| ----- | --------------- |
| EC2, Azure, Google<sup><a href="#fn2">[2]</a></sup>, OpenStack, RCA-V<sup><a href="#fn1">[1]</a></sup> | Vanilla |
| Softlayer<sup><a href="#fn3">[3]</a></sup> | RightScale |
<sup><a name="fn1">[1]</a></sup> Requires RCA-V version 2.0_20160415_21 or above<br>
<sup><a name="fn2">[2]</a></sup> CentOS 6.x on GCE has a specific note below<br>
<sup><a name="fn3">[3]</a></sup> Ubuntu 14.04 and Ubuntu 16.04 work with vanilla Cloud-init and cloud images comes with them pre-installed. CentOS/RHEL and older Ubuntu versions do not.

## Installing Vanilla Cloud-Init

The installation steps for 'vanilla' cloud-init will vary depending on your operating system. The following sections provide instructions specific to each of the supported operating systems.

### Red Hat Based Systems, Such as CentOS
Depending on the specific version of your system, cloud-init may be part of the "Extras" repo. If not, the packages may be found in the [Fedora Extra Packages for Enterprise Linux](https://fedoraproject.org/wiki/EPEL) repository. Use the following command-line to install cloud-init on Red Hat-based systems.

  ~~~
  yum -y install cloud-init
  ~~~
  
!!info*Note:* CentOS 6x on GCE: We have observed intermittent issues with the CentOS 6.x native version of cloud-init (cloud-init-0.7.5-10.el6.centos.2.src.rpm) hanging prior to our userdata script being executed. The suggested workaround for this is to use the RHEL version of cloud-init [cloud-init-0.7.5-2.el6.src.rpm](http://ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/RH-COMMON/SRPMS/cloud-init-0.7.5-2.el6.src.rpm). To rebuild where epel can not update:
  ~~~
  rpm -Uvh cloud-init-0.7.5-2.el6.src.rpm
  sed -i.orig -e 's/2%{?dist}/20%{?dist}/g' ~/rpmbuild/SPECS/cloud-init.spec
  rpmbuild -ba ~/rpmbuild/SPECS/cloud-init.spec
  rpm -Uvh ~/rpmbuild/RPMS/x86_64/cloud-init-0.7.5-20.el6.x86_64.rpm
  rm -fr ~/rpmbuild
  ~~~

### Debian Based systems, Such as Ubuntu

Use the following command-line to install cloud-init on Debian-based systems.
  ~~~
  apt-get -y update
  apt-get -y install cloud-init
  ~~~

## Installing RightScale Cloud-Init (Softlayer)

The installation steps for RightScale cloud-init will vary depending on your operating system. The following sections provide instructions specific to each of the supported operating systems.

### CentOS 6.x/7.x

  ~~~
  cat <<EOF > /etc/yum.repos.d/RightScale-epel.repo
  [rightscale-epel]
  name=RightScale Software
  baseurl=http://mirror.rightscale.com/rightscale_software/centos/\$releasever/x86_64/archive/latest/
  enabled=1
  gpgcheck=1
  gpgkey=http://mirror.rightscale.com/rightlink/rightscale.pub
  priority=1
  EOF
  yum -y install cloud-init
  ~~~

### Ubuntu 12.04


Ubuntu 12.04 Cloud-Init Install - Part 1

  ~~~
  cat <<EOF > /etc/apt/preferences.d/rightscale-cloud-init-pin-1001
  Package: cloud-init
  Pin: version 0.7.2*
  Pin-Priority: 1001
  EOF
  ~~~

Ubuntu 12.04 Cloud-Init Install - Part 2

  ~~~
  curl http://mirror.rightscale.com/rightlink/rightscale.pub | apt-key add -
  echo "deb [arch=amd64] http://mirror.rightscale.com/rightscale_software_ubuntu/latest precise main" > /etc/apt/sources.list.d/rightscale_extra.sources.list
  apt-get -y update
  apt-get -y --force-yes install cloud-init
  ~~~

For Ubuntu 14.04 and 16.04, please use vanilla cloud-init. Use the stock Ubuntu images provided by Canonical, which come with cloud-init pre-installed, as a reference.
