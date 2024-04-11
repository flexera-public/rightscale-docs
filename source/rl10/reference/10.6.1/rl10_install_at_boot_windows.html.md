---
title: Install at Boot for Windows
description: Steps for installing RightLink 10 at boot.
version_number: 10.6.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_install_at_boot_windows.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_install_at_boot_windows.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_install_at_boot_windows.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_install_at_boot_windows.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_install_at_boot_windows.html
---

## Introduction

To install RightLink at boot an agent to interpret userdata or metadata and act on it as needed. Two things are passed to this agent as a executable Powershell block:
1. Credentials (identity parameters) needed to initialize a RightScale Server via user-data.
2. Code to download and install RightLink at boot time if its not already installed.

Each cloud has its own agent. EC2, AzureRM, and Google agents are currently supported. The following methods are used for each cloud:
* EC2 - Ec2ConfigService leveraged to [act on userdata with &lt;powershell&gt; tags](http://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/ec2-instance-metadata.html#user-data-execution)
* Google - Startup script set by using metadata key [windows-startup-script-ps1](https://cloud.google.com/compute/docs/startupscript#providing_a_startup_script_for_windows_instances)
* AzureRM - CustomScriptExtension is added to [run the script](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows)

Other clouds are currently not supported at this time for install at boot. Please create a [custom image](rl10_install_windows.html) for other clouds.

### Launching a Server with a Stock Image

Two tags are needed to install RightLink 10 at boot. The first identifies the instance as RightLink10 based to the RightScale platform. The second causes cloud agents to run a Powershell script to download and install RightLink. The MultiCloudImage (MCI) or Server must be tagged with:
1. `rs_agent:type=right_link_lite`
2. `rs_agent:powershell_url=https://rightlink.rightscale.com/rll/10.6.1/rightlink.boot.ps1`

The second tag above will install version 10.6.1 of RightLink. As a convenience, more generic versions such as "10" or "10.6" may be specified as a way to install the latest GA version for a lineage. For example, add tag `rs_agent:powershell_url=https://rightlink.rightscale.com/rll/10/rightlink.boot.ps1` to install the latest 10.x.x agent. See the [releases](/rl10/releases) page for full list of supported versions to install and release notes.

Since the script/agent are being downloaded and installed at boot time, there must be outbound connectivity to the rightlink.rightscale.com IP addresses. If there is no outbound connectivity for the instance a [proxy should be specified](rl10_proxying_rightlink.html) using the `rs_agent:http_proxy` tag.

It it recommended to use the "RightLink 10.x.x Windows Base" ServerTemplate available from the Marketplace as a starting point. See the [releases](/rl10/releases/) page for links.

### Advanced Usage

See [Advanced Usage](rl10_install_at_boot.html#advanced-usage) for Linux.
