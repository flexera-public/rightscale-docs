---
title: Advanced Networking for vSphere
description: RightLink 10 now ships with network configuration scripts for RightScale Cloud Appliance for vSphere. These scripts will automatically be installed if VMware tools are installed on the instance and will only run on the VMware hypervisor.
version_number: 10.5.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_rcav.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_rcav.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_rcav.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_rcav.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_rcav.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_rcav.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_rcav.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_rcav.html
---

## Introduction

Starting with RightLink 10.2.1, RightLink now ships with network configuration scripts for [RightScale Cloud Appliance
for vSphere](/rcav) or RCA-V. These scripts will automatically be installed if VMware tools
(or open-vm-tools) are installed on the instance and will only run on the VMware hypervisor. The scripts are run at
startup as the rightscale_network service (Linux) or RightNetwork service (Windows) and read networking information
passed from the RCA-V adaptor to the instance via VMware's extraconfig service.

The networking configuration scripts support [advanced networking](/rcav/v2.0/rcav_administrator.html#vsphere-resources-ip-addresses) features for the RCA-V appliance, allowing configuration of multiple DHCP, Dynamic IP, or Specific IP devices and routes at boot time.

## Requirements

* Extraconfig must be enabled
* VMware tools must be installed on the instance
* Image must be snapshotted with RightLink 10.2.1+ pre-installed
* Server must be launched via the RightScale dashboard so its managed by RCA-V
* CentOS/RHEL 6+, Ubuntu 12.04+, Windows 2008R2+
* Linux: Standard OS dhcp client is installed (dhclient)
* Windows: Powershell 2+, .NET 2.0+

## Overview/Troubleshooting

On Linux, the script is installed to `/usr/local/bin/rightnetwork.sh` and run twice. First, before OS networking is brought up, in order to lay down device configuration files. Second, after DHCP devices are brought up (if they're configured), to finish configuration of routes for those devices. A dhclient hook is installed to either `/etc/dhcp/dhclient.d` or `/etc/dhcp/dhclient-exit-hooks.d`. `/usr/local/bin/rightnetwork.sh` is called in both passes with either the --init or --routes parameter for the first and second run respectively. If having issues related to slow ethernet configuration during OS boot, check the VMware tools installation as per [Linux VMware Tools Installation Notes] (/rcav/v1.3/rcav_image_requirements.html#requirements-linux-vmware-tools-installation-notes).

On Windows, the network configuration script is installed to `C:\Program Files\RightScale\RightNetwork\rightnetwork.ps1` and is written in powershell. The script is wrapped as a service called RightNetwork and run at start.

For logs, see `/var/log/upstart/rightscale_network.log` (Ubuntu), `journalctl -u rightscale_network` (CentOS/RHEL 7+),
`/var/log/rightscale_network.log` (CentOS 6), or `C:\Program Files\RightScale\RightNetwork\Logs\rightscale_network.log` on Windows.
