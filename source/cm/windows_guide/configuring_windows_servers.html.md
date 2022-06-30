---
title: Configuring Windows Servers
description: Notes on configuring Windows Servers in RightScale including creating ServerTemplates and using RightScripts and Chef.
---

## Creating Windows ServerTemplates

All ServerTemplates are built the same way. See [ServerTemplates](/cm/dashboard/design/server_templates/servertemplates.html). In order to build a Windows ServerTemplate you will need to use a MultiCloud Image that references a Windows-based RightImage.

## Using RightScripts

Powershell is the main scripting language used in the Windows environment, and as such is used for both RightScripts and Chef recipes. Chef is just another layer in front of the Powershell scripts.

## Note on Decommission State

Windows server instances follow the new 'decommissioning' phase for v5 RightImages where the decommissioning scripts are explicitly executed in a brief timeframe (up to 180 seconds) before a request is made to Amazon to terminate the instance. See [Server States](/cm/management_guide/server_states.html) for more information.

On rare occasions, a server instance can get stuck in the decommissioning phase while running the sequence of decommission scripts. As a consequence, a request to terminate the instance has not been sent to Amazon. If your Windows server instance becomes stranded in the decommissioning phase, you will need to manually terminate the instance (Clouds > [AWS Region] > EC2 Instances), which will send a termination request directly to Amazon and force the instance to be shut down.

RightScale is currently in the process of improving the shutdown process in order to prevent a server instance from getting stranded in the decommissioning phase.

## Using Chef on Windows-Based Servers

While the principles behind [Chef](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/index.html) remain the same across both Linux/Windows platforms, using Chef on Windows means using different Chef providers. Developing Chef providers on Windows also presents unique challenges as Ruby is not as pervasive and does not give access to critical functionality that many Chef providers may require.

### Available Chef Providers

RightScale's Windows RightImages provide access to the following Chef Providers:

* Powershell, HttpRequest, RubyBlock: fully functional.
* File, Directory, Template, RemoteFile, RemoteDirectory: these providers are all functional however the owner and group attributes are not supported.
* Execute, Script, Ruby: these providers are all functional however the following command arguments are ignored: timeout, user, group and umask.
* Perl, Python: same as above, also Perl and/or Python must be installed and in the path.

In addition to the Chef providers listed above, [RightLink](/rl10/about.html) on Windows allows you to write your own Chef providers all in Powershell. See [Powershell Chef Providers](http://support.rightscale.com/12-Guides/Chef_Cookbooks_Developer_Guide/04-Developer/06-Development_Resources/Powershell_Chef_Providers/index.html).

### Examples

Be sure to check out our public repository for some working examples of PowerShell scripts: [http://github.com/rightscale/cookbooks_public_windows/tree/master/cookbooks/](http://github.com/rightscale/cookbooks_public_windows/tree/master/cookbooks/)
