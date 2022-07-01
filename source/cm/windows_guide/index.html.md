---
title: Windows Guide
description: The RightScale Windows Guide pulls together all the conceptual information, tasks, and reference material for configuring and deploying Windows servers in the Cloud.
---

## Overview

The purpose of this guide is to pull together all the conceptual information, tasks, and reference material for configuring and deploying Windows servers in the Cloud.  The process for deploying Windows servers in the cloud is very similar to launching Linux servers in the Cloud, since the RightScale Dashboard behaves as an abstraction layer, with the OS specifics being defined within the actual ServerTemplate.  However, there are a few clear differences that will be covered in more detail in the other sections of this guide.

## Introduction

If you have existing images, we provide a RightLink installer so that you can make them compatible with RightScale. There are also a number of sample ServerTemplates (published by RightScale) that you can use to get started with launching and managing Windows servers with the RightScale management platform.

All Windows RightImages (published by RightScale) come preinstalled with the PowerShell 2.0 (as well as all the DLLs required to manage SQL server from PowerShell) and ASP.NET Framework 3.5.1. NTP is configured to ensure that the server’s clock is successfully synchronized at boot time and periodically thereafter.

Please note that Powershell runs a 32 bit process, even on 64 bit machines. So there will be times when you're invoking Powershell commands that want to access the 64 bit architecture but are unable to do so because the processes are sandboxed in the 32 bit environment. <a nocheck href='https://msdn.microsoft.com/en-us/library/aa384187%28VS.85%29.aspx'>This article</a> provides a workaround on this issue.

Windows servers support both Chef and Powershell for automating installation and configuration. We also provide a monitoring plugin based on the collectd protocol. This plugin has a simple meta-language that can be used to query many of the WMI statistics available on Windows servers which makes them available directly from the RightScale Dashboard both for displaying graphs and creating alerts.

## Supported Features

* Create ServerTemplates for configuring Windows servers
* Ability to run both RightScripts and Chef Recipes on Windows servers
* Monitoring of Windows servers. See [Windows Monitoring](/cm/windows_guide/windows_monitoring.html).
* Windows-based MultiCloud Images that use v5 RightImages (with RightLink)
* "BlogEngine All-In-One" ServerTemplate - Restore a SqlServer 2005 Express database and set up an ASP.NET 3.5 application. Chef recipes are used to initially configure the server, as well as for taking backups or restoring the database.
* Windows MultiCloud Images for Windows 2003, 2008, and 2012.
* You can now create a RightScale-enabled Windows AMI for launching EC2 instances that has RightLink preinstalled.
* Server Arrays, Alerts, PowerShell 2.0 RightScripts, and Chef Support are all supported.

[[Windows Topics
* [Managing Windows RightImages](/cm/windows_guide/managing_windows_rightimages.html)
* [Configuring Windows Servers](/cm/windows_guide/configuring_windows_servers.html)
* [Managing Windows Updates](/cm/windows_guide/managing_windows_updates.html)
* [Planned Volume Management](/cm/windows_guide/planned_volume_management.html)
* [Windows Monitoring](/cm/windows_guide/windows_monitoring.html)
* [RightScale Powershell Library](/cm/windows_guide/rightscale_powershell_library.html)
]]

[[Windows Tutorials
* [3 Tier Deployment for Windows](/cm/windows_guide/3_tier_deployment_for_windows.html)
* [Add a Custom Monitoring Plugin Automatically with RightScripts or Chef  Recipes](/cm/windows_guide/add_a_custom_monitoring_plugin_automatically_with_rightscripts_or_chef_recipes.html)
* [Add a Custom Monitoring Plugin Manually](/cm/windows_guide/add_a_custom_monitoring_plugin_manually.html)
* [Installing Software Using a PowerShell RightScript](/cm/windows_guide/installing_software_using_a_powershell_rightscript.html)
* [Writing Windows PowerShell RightScripts](/cm/windows_guide/writing_windows_powershell_rightscripts.html)
]]
