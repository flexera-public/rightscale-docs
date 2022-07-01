---
title: RightScale Cloud Appliance for vSphere (RCA-V) Image Requirements 
alias: rcav/guides/rcav_image_requirements.html
description: This guide explains the requirements for a RightScale Cloud Appliance for vSphere (RCA-V) image.
---

## Overview
This guide explains the requirements for a RightScale Cloud Appliance for vSphere (RCA-V) image.

## Requirements
In order for RCA-V to retrieve the instance IP address, the image will need VMware tools installed. RightImages provided by RightScale will already have them installed. Otherwise, you can install [open-vm-tools](https://github.com/vmware/open-vm-tools) provided by your operating system. In cases where open-vm-tools is not available or you experience any problems, you can try using [VMware tools](https://www.vmware.com/support/packages).

### Linux VMware Tools Installation Notes
We have seen issues where the VMware provided VMware tools installer does not correctly account for SELinux configurations. The issue can manifest itself as a very long DHCP configuration of eth0 when watching the console.

If your image has SELinux enabled, check the VMware tools installation as follows:
* Run this command on an instance based on the image: 
  * ls -Z $(readlink -f $(which vmtoolsd))
* Check the output and see if it shows something like this: 
  * -rwxr-xr-x. root root unconfined_u:object_r:**lib_t**:s0   /usr/lib/vmware-tools/sbin64/vmtoolsd
  * If you see the "lib_t" in the output that is not correct in an SELinux enabled server. Instead, it should be "bin_t" and is caused by an issue with the VMware tools installer.
* If you do have SELinux enabled and you see the "lib_t" in the output, then you can run this command to fix the issue.
  * restorecon -v $(readlink -f $(which vmtoolsd))
