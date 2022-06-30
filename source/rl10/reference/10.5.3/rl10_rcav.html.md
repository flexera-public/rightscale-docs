---
title: Advanced Networking for vSphere
description: RightLink 10 now ships with network configuration scripts for RightScale Cloud Appliance for vSphere. These scripts will automatically be installed if VMware tools are installed on the instance and will only run on the VMware hypervisor.
version_number: 10.5.3
versions:
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
for vSphere](/rcav) or RCA-V. By default, these scripts will automatically be installed if VMware tools
(or open-vm-tools) are installed on the instance and will only run on the VMware hypervisor. The scripts are run at
startup as the rightscale_network service (Linux) or RightNetwork service (Windows) and read networking information
passed from the RCA-V adaptor to the instance via VMware's extraconfig service. An "-n" option to rightlink.install.sh and "-NoNetworkingScripts" option to rightlink.install.ps1 can be passed to not install these scripts if they are not desired or you intended to only ever use DHCP to configure network adaptors.

The networking configuration scripts support [advanced networking](/rcav/v2.0/rcav_administrator.html#vsphere-resources-ip-addresses) features for the RCA-V appliance, allowing configuration of multiple DHCP, Dynamic IP, or Specific IP devices and routes at boot time.

## Requirements

* Extraconfig must be enabled
* NetworkManager must NOT be installed
* VMware tools must be installed on the instance
* Image must be snapshotted with RightLink 10.2.1+ pre-installed
* Server must be launched via the RightScale dashboard so its managed by RCA-V
* CentOS/RHEL 6+, Ubuntu 12.04+, Windows 2008R2+
* Linux: Standard OS dhcp client is installed (dhclient)
* Windows: Powershell 2+, .NET 2.0+

## Overview/Troubleshooting

On Linux, the script is installed to `/usr/local/bin/rightnetwork.sh` and run twice. First, before OS networking is brought up, in order to lay down device configuration files. Second, after DHCP devices are brought up (if they're configured), to finish configuration of routes for those devices. A dhclient hook is installed to either `/etc/dhcp/dhclient.d` or `/etc/dhcp/dhclient-exit-hooks.d`. `/usr/local/bin/rightnetwork.sh` is called in both passes with either the --init or --routes parameter for the first and second run respectively. If having issues related to slow ethernet configuration during OS boot, check the VMware tools installation as per [Linux VMware Tools Installation Notes] (/rcav/v1.3/rcav_image_requirements.html#requirements-linux-vmware-tools-installation-notes).

If NetworkManager is installed, the installation of RightScale Network Agent will raise an error. NetworkManager can override the required changes made by the RightScale Network Agent.

If selinux is enabled a `rightscale_routes` policy module will be installed, viewable at /usr/local/share/rightnetwork/rightscale_routes.te. This policy allows dhclient to execute `vmtoolsd` to grab networking metadata and allows it to write log messages to /var/log/rightscale_network.log. One of the more common issues with networking scripts failing to run are improper selinux labels. Starting with RightLink 10.5.2, the installer will fail if it finds the improper labels, which may occur if the VMware tools are installed from CD-ROM rather than from the open-vm-tools package. To fix this, make sure vmtoolsd has the proper context (bin_t rather than lib_t) with the following command: `restorecon -v $(readlink -f $(which vmtoolsd))`. Certain older versions of RHEL/CentOS 6 may also have issues that require keeping the OS up-to-date as well: https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1033693

On Windows, the network configuration script is installed to `C:\Program Files\RightScale\RightNetwork\rightnetwork.ps1` and is written in powershell. The script is wrapped as a service called RightScaleNetwork and run at start.

For logs, see `/var/log/upstart/rightscale_network.log` (Ubuntu), `journalctl -u rightscale_network` (CentOS/RHEL 7+),
`/var/log/rightscale_network.log` (CentOS 6), or `C:\Program Files\RightScale\RightNetwork\Logs\rightscale_network.log` on Windows.


## Files

### Linux

Filepath | Format | Purpose |
---- | ------ | ------- |
/usr/local/bin/rightnetwork.sh | Executable script | Run at startup to write network configuration files and setup routes |
/etc/dhcp/dhclient.d/rightscale_routes.sh<br>/etc/dhcp/dhclient-exit-hooks.d/rightscale_routes | Executable script | Run after DHCP lease is acquired to finish configuring network routes specific to DHCP-based network interfaces |
/etc/init/rightscale_network.conf<br>/etc/init/rightscale_network-wait.conf<br>/etc/systemd/system/rightscale_network.service<br>/etc/init.d/rightscale_network | Service config files | Service config files |
/var/log/rightscale_network.log | Log file | Network configuration script log. Created with root-only permissions. |
/usr/local/share/rightnetwork/rightscale_routes.pp<br>/usr/local/share/rightnetwork/rightscale_routes.sh<br>/usr/local/share/rightnetwork/rightscale_routes.te | selinux policy files | Allow dhclient to run rightnetwork.sh, allow rightnetwork.sh to write /var/log/rightscale_network.log |
/usr/local/share/rightnetwork | Misc | Misc support files, such as the uninstaller (uninstall.sh) |

### Windows

Filepath | Format | Purpose |
---- | ------ | ------- |
C:\Program Files\RightScale\RightLink\nssm.exe | Binary | Non-Sucking Service Manager, used to manage the RightNetwork service. |
C:\Program Files\RightScale\RightNetwork\rightnetwork.ps1 | Powershell script | RightNetwork powershell script, called at startup |
C:\Program Files\RightScale\RightNetwork\Logs\rightscale_network.log | Log file | RightNetwork install log. |
RightScaleNetwork | Windows service | Runs rightnetwork.ps1 at boot to setup networking for RCA-V.|
