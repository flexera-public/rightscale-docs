---
title: Operating System Compatibility
description: Summary of the Linux and Windows operating system compatibility in RightLink 10. Includes links the currently compatible operating system images tested by RightScale.
version_number: 10.6.1
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_os_compatibility.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_os_compatibility.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_os_compatibility.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_os_compatibility.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_os_compatibility.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_os_compatibility.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_os_compatibility.html
---

## Summary

This article provides an overview of Linux and Windows operating system compatibility in RightLink 10 and includes links to the compatible operating system images tested by RightScale. Please see [Operating System, Use Case, and Cloud Support](/rl10/os_use_case_cloud_support.html) for detailed information on which particular RightLink 10 versions support specific use cases and operating system versions.

### Linux

All use cases ('enable running instance', 'install at boot', 'custom image') are regression tested by RightScale to work "out-of-the-box" on a standard install of: Ubuntu 16.04, Ubuntu 14.04, Ubuntu 12.04, RHEL 7, RHEL 6, CentOS 7, CentOS 6, CoreOS.

RightLink 10 is principally supported on most modern Linux distributions that satisfy a few simple pre-requisites. Summary of the Linux prerequisites for RightLink 10 and the standard `rightlink.install.sh` and `rightlink.enable.sh` scripts:

* bash
* curl or wget
* SSL root certificates
* SysV init, systemd, or upstart
* apt or yum (for package management)
* cloud-init (with multipart MIME support)
* useradd

### Windows

All use cases ('enable running instance', 'install at boot', 'custom image') are regression tested by RightScale to work "out-of-the-box" on a standard install of: Windows Server 2012R2, Windows Server 2012, and Windows Server 2008R2.

RightLink 10 is principally supported on most modern Windows distributions that satisfy a few simple pre-requisites. Summary of the Windows prerequisites for RightLink 10 and the standard `rightlink.install.ps1` and `rightlink.enable.ps1` scripts:

* Current SSL root certificates
* .Net 2.0 or newer
* PowerShell 2.0 or newer

## RightScale Tested Images

Each release of RightLink 10 and its associated Base ServerTemplate is tested on a number of clouds using as stock/official an image for each OS as possible. Since these stock/official images are made available by the cloud provider or the OS developer, they can be deregistered and made unavailable at anytime at the discretion of the owner. The following table lists the provenance of the images for the most recent releases. For the exact images used in testing each release, please consult the release notes (e.g. [RightLink 10.6.1 Release](../../releases/rl10_10.6.1_release.html)). Note that the list of tested images is not intended as a recommendation of these images, but as a reference so you can locate known-to-work images and compare with your own images if you are having difficulties.

!!warning*Warning* Since these stock/official images are made available by the cloud provider or the OS developer, they can be deregistered and made unavailable at anytime at the discretion of the owner. It is advised that you create your own [MultiCloud Image](/cm/dashboard/design/multicloud_images/multicloud_images_actions.html) with your own custom image for [linux](rl10_install.html) or [windows](rl10_install_windows.html).

The following images are regression tested by RightScale and known to work. "Known to work" means that the following features operate properly:

* enable a running "bare" instance using the `rightlink.enable.sh` or `rightlink.enable.ps1` scripts
* reboot the instance
* stop and start the enabled instance
* create the 'rightscale' user
* support managed login (Linux only)
* install the RightLink 10 init scripts or Windows services
* install monitoring.

<table border="1" cellpadding="1" cellspacing="1">
	<tbody>
		<tr>
			<td style="background-color: rgb(211, 211, 211);"><strong>OS</strong></td>
			<td style="background-color: rgb(211, 211, 211);"><strong>Clouds</strong></td>
			<td style="background-color:#D3D3D3;"><strong>Image provenance</strong></td>
		</tr>
		<tr>
			<td colspan="1" rowspan="6">Ubuntu 12.04 / 14.04 / 16.04</td>
			<td>AWS</td>
			<td colspan="1">
			<p><a class="external" href="http://cloud-images.ubuntu.com/locator/" title="http://cloud-images.ubuntu.com/locator/">Official Ubuntu image locator</a></p>
			</td>
		</tr>
		<tr>
			<td>Azure</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>AzureRM</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>Google</td>
			<td colspan="1">Official public image</td>
		</tr>
		<tr>
			<td>OpenStack</td>
			<td colspan="1">
			<p><a class="external" href="http://cloud-images.ubuntu.com/" title="http://cloud-images.ubuntu.com/">Official Ubuntu image site</a></p>
			</td>
		</tr>
		<tr>
			<td>Softlayer</td>
			<td colspan="1">Official public image</td>
		</tr>
		<tr>
			<td>VMware (using RCA-V)</td>
			<td>Custom image based off the vanilla&nbsp;OS distro install, cloud-init, open-vm-tools, and A known user/pass or SSH&nbsp;key</td>
		</tr>

		<tr>
			<td colspan="1" rowspan="6">
			<p>CoreOS</p>
			</td>
			<td>AWS</td>
			<td><a class="external" href="https://coreos.com/os/docs/latest/booting-on-ec2.html" rel="freeklink" title="https://coreos.com/os/docs/latest/booting-on-ec2.html">Official public image</a></td>
		</tr>
		<tr>
			<td>Azure</td>
			<td><a class="external" href="https://coreos.com/os/docs/latest/booting-on-azure.html" rel="freeklink" title="https://coreos.com/os/docs/latest/booting-on-azure.html">Official public image</a></td>
		</tr>
		<tr>
			<td>AzureRM</td>
			<td><a class="external" href="https://coreos.com/os/docs/latest/booting-on-azure.html" rel="freeklink" title="https://coreos.com/os/docs/latest/booting-on-azure.html">Official public image</a></td>
		</tr>
		<tr>
			<td>Google</td>
			<td><a class="external" href="https://coreos.com/os/docs/latest/booting-on-google-compute-engine.html" rel="freeklink" title="https://coreos.com/os/docs/latest/booting-on-google-compute-engine.html">Official public image</a></td>
		</tr>
		<tr>
			<td>OpenStack</td>
			<td><a class="external" href="https://coreos.com/os/docs/latest/booting-on-openstack.html" rel="freeklink" title="https://coreos.com/os/docs/latest/booting-on-openstack.html">Official public image</a></td>
		</tr>
		<tr>
			<td>Softlayer</td>
			<td>Official public image. NOTE: Enable running mode only</td>
		</tr>
		<tr>
			<td>VMware (using RCA-V)</td>
			<td><a class="external" href="https://coreos.com/os/docs/latest/booting-on-vmware.html" rel="freeklink" title="https://coreos.com/os/docs/latest/booting-on-vmware.html">Official public image</a>. NOTE: Requires v2.0 of RCA-V for install-at-boot and install on image modes.</td>
		</tr>

		<tr>
			<td colspan="1" rowspan="6">
			<p>CentOS 6 / 7</p>
			</td>
			<td>AWS</td>
			<td><a class="external" href="http://wiki.centos.org/Cloud" rel="freeklink" title="http://wiki.centos.org/Cloud">http://wiki.centos.org/Cloud</a></td>
		</tr>
		<tr>
			<td>Azure</td>
			<td>Official public image. NOTE: Enable running mode only</td>
		</tr>
		<tr>
			<td>AzureRM</td>
			<td>Official public image. NOTE: Enable running mode only</td>
		</tr>
		<tr>
			<td>OpenStack</td>
			<td colspan="1">
			<p><a class="external" href="http://cloud.centos.org/centos/" title="http://cloud.centos.org/centos/">Official CentOS image site</a></p>
			</td>
		</tr>
		<tr>
			<td>Google</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>Softlayer</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>VMware (using RCA-V)</td>
			<td>Custom image based off the vanilla OS distro install, RightScale cloud-init, A known user/pass or SSH key</td>
		</tr>
		<tr>
			<td colspan="1" rowspan="5">
			<p>Windows 2008R2 / 2012 / 2012R2</p>
			</td>
			<td>AWS</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>Azure</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>AzureRM</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>OpenStack</td>
			<td>Custom image</td>
		</tr>
		<tr>
			<td>Google</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>Softlayer</td>
			<td>Official public image</td>
		</tr>
		<tr>
			<td>VMware (using RCA-V)</td>
			<td>Custom image</td>
		</tr>
	</tbody>
</table>
