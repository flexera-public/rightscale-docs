---
title: Custom Images with RightLink for Linux
description: This page describes how to install RightLink 10 on your custom images. RightLink has the ability to be installed at boot time using cloud-init.
version_number: 10.5.3
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_install.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_install.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_install.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_install.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_install.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_install.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_install.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_install.html
---

## Overview

This page describes how to install RightLink 10 on your custom images. RightLink has the ability to be installed at boot time using cloud-init. This workflow is recommended as it allows the usage of standardized images released by various vendors such as Canonical. However, RightLink can be pre-installed if needed on a freshly built or snapshotted image.

### Use-cases

Launching RightLink 10 enabled Servers without downloading and installing RightLink at boot time because of:
- Limited outbound connectivity
- Internal policy
- Lack of existing image options on a public or private cloud. For example, while Ubuntu images with cloud-init are generally available as they're provided by Canonical across the board, other operating systems may have [limited availability](/rl10/os_use_case_cloud_support.html).
- Need to use [Advanced networking for RCA-V](rl10_rcav.html) features. Software for this feature will automatically be installed with RightLink 10.2.0 and newer if VMware Tools or open-vm-tools are installed.

### Prerequisites

- Install script: root privileges, tar, and curl.
- RightLink itself: sudo and cloud-init. The standard OS cloud-init will usually work. However, for SoftLayer a custom cloud-init is required. See [Cloud-init Installation](rl10_cloud_init_installation.html) for details. Also, while cloud-init supports Azure, it will not currently work as the RightScale platform does not pass userdata in the correct format to be read by cloud-init.
- RCA-V images require VMware tools to be installed. Please see [RCA-V Image Requirements](/rcav/v3.0/rcav_image_requirements.html). By default, RightScale network configuration scripts for RCA-V are installed along with RightLink 10 if VMware tools are present. These scripts will write your system network configuration files at boot time to enable use of [Advanced Networking for RCA-V](rl10_rcav.html). Pass -n to not install this component.

### Usage

rightlink.install.sh options are:
  ~~~
  $ script/rightlink.install.sh -h
  Usage: rightlink.install.sh [-options...]
  Installs/Upgrades RightLink on an an image.
    -n    skip installation of RightScale network configuration scripts for RCA-V
    -s    start rightlink service at end of this script
    -h    show this help
    -v    verbose mode
  ~~~

Example:
The following will install the latest GA RightLink on a CentOS image.
  ~~~ bash
  yum -y install cloud-init
  curl -s https://rightlink.rightscale.com/rll/10/rightlink.install.sh | sudo bash -s
  ~~~

Example:
The following will install the latest GA RightLink on an Ubuntu image, skipping installation of network configuration scripts for RCA-V.
  ~~~ bash
  apt-get -y update >/dev/null
  apt-get -y install cloud-init python-serial sudo
  curl -s https://rightlink.rightscale.com/rll/10/rightlink.install.sh | sudo bash -s -- -n
  ~~~

rightlink.uninstall.sh options are:
  ~~~
  $ script/rightlink.uninstall.sh -h
  Usage: rightlink.uninstall.sh [-options...]
  Uninstalls RightLink.
    -f                    override command prompt confirmation for uninstall
    -v                    verbose mode
    -h                    show this help
  ~~~

The following example will uninstall RightLink from disk. -f means not to prompt for confirmation.
  ~~~ bash
  curl -s https://rightlink.rightscale.com/rll/10/rightlink.uninstall.sh |
    sudo bash -s -- -f
  ~~~
