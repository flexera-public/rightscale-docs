---
title: Custom Images with RightLink for Windows
description: This page describes how to install RightLink 10 on your custom images. RightLink can be pre-installed and a new image created by snapshotting an existing image.
version_number: 10.5.1
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_install_windows.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_install_windows.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_install_windows.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_install_windows.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_install_windows.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_install_windows.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_install_windows.html
---

## Overview

This page describes how to install RightLink 10 on your custom images. RightLink can be pre-installed and a new image created by snapshotting an existing image. Custom images are not supported across all clouds. While this is our goal the following list shows where Custom images are currently supported:

Cloud  | Supported? | Notes |
------ | -----------| ----- |
EC2 | Yes | |
OpenStack | Yes | |
SoftLayer | Yes | |
RCA-V | Yes | ExtraConfig must be turned on for [Advanced Networking](rl10_rcav.html).|
Google | No* | * Should work but not tested |
Azure | Yes | |

Google clouds should work although they are not tested or certified.

Custom images are tested and supported on Windows 2008R2 and newer.

### Use-cases

Launching RightLink 10 Servers because of:
- Limited outbound connectivity
- Internal policy
- Lack of existing image options on a public or private cloud.
- Need to use [Advanced networking for RCA-V](rl10_rcav.html) features. Software for this feature will automatically be installed with RightLink 10.2.0 and newer if VMware Tools is installed.
- Running RightLink under alternate user account. By default RightLink runs under a local administrator account called "RightLink", but can use [pre-existing Domain accounts](rl10_non_root.html) as well.

### Prerequisites

- Install script: Administrator privileges, PowerShell 2.0+, .NET Framework 2.0+.

### Usage

rightlink.install.ps1 options are:
  ~~~
    Installs/Upgrades RightLink on an image.
    Parameters:
      -Username             RightLink Service User Name (default: RightLink)
      -Password             RightLink Service User Password (default: Randomly generated password)
      -Debug                Verbose output
      -Help                 Display help
  ~~~

If a custom username is supplied, a password must also be supplied. The account must already exist -- domain and then local users will be checked.

Example:
The following will install the latest RightLink on an Windows 2012R2 image.
  ~~~ powershell
  $wc = New-Object System.Net.Webclient
  $wc.DownloadFile("https://rightlink.rightscale.com/rll/10/rightlink.install.ps1",
    "$pwd\rightlink.install.ps1")
  Powershell -ExecutionPolicy Unrestricted -File rightlink.install.ps1
  ~~~

#### Installing Behind a Proxy

The `rightlink.install.ps1` script performs a download of the installation files but is not proxy aware. Therefore, if creating a custom image behind a proxy, the script will fail. In this case download the [installation package](https://rightlink.rightscale.com/rll/10.5.1/rightlink.zip) zip file yourself, unzip it and then run the `install.ps1` script that is part of the zip file.

### Snapshotting and Bundling the Image

After installation of RightLink, the image is ready to be snapshotted.

When bundling a Windows server or cloud instance it is recommended to utilize the Microsoft Windows System Preparation tool (SysPrep). This tool is specifically made to prepare Windows machines for duplication or reuse by removing system specific data from Windows along with other various tasks.

Once prepared and SysPrepped, the instance should also be shutdown per best practice prior to bundling into a new image (/shutdown included in sysprep command below).

!!warning*Warning* It is important that the Out of Box Experience (OOBE) phase is completely automated. Some public cloud providers, such as Amazon Web Services and Microsoft Azure, provide sysprep answer files on their marketplace images that are already preconfigured to automate the OOBE phase. For other environments, it may be necessary to develop your own answer file to be used with the sysprep `/unattend:<file_name>` switch. Here are further details from Microsoft on [Settings for Automating OOBE](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/settings-for-automating-oobe).

  ~~~ powershell
    sysprep /oobe /generalize /shutdown
  ~~~

!!info*Note* Only run this command when you are satisfied with the state of the instance and are ready to bundle the image as it will shutdown the system in preparation for a bundle action. At this point, you can now safely bundle or snapshot the stopped instance into a new image.
