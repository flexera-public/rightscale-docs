---
title: Enable Running Instances for Windows
description: This page describes a method for enabling already running raw instances using the rightlink.enable.ps1 script to provide all the amenities of a RightScale server, including automation, operational scripts, and monitoring.
version_number: 10.5.3
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_enable_running_instances_windows.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_enable_running_instances_windows.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_enable_running_instances_windows.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_enable_running_instances_windows.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_enable_running_instances_windows.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_enable_running_instances_windows.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_enable_running_instances_windows.html
---

## Overview

This page describes a method for enabling already running raw instances using the `rightlink.enable.ps1` script to provide all the amenities of a RightScale server, including automation, operational scripts, and monitoring.

## Benefits

* Turns an instance into a server in the dashboard, making the UI and functionality the same while avoiding the need to work through some of the instance UI pages
* Enables operational and decommission scripts (plus "boot" scripts which are run when RightLink is installed)
* Enables monitoring by installing a bundled collectd-compatible monitoring agent as a boot script.

## Use-cases

* Existing instances that were launched before RightScale was adopted
* Instances launched through an external system, such as SaltStack, AWS Autoscaling, AWS Cloud Formation, etc.
* Images that are being launched where installing RightLink and rebundling is not desirable

## Prerequisites

* The `rightlink.enable.ps1` script must be executed with Administrator privileges.
* A running instance that will be turned into a server
* RDP or WinRM access to this instance or the ability to execute commands from a PowerShell command-line on the instance
* A ServerTemplate with appropriate boot and operational scripts (possibly none) and the rs.image parameter set in vSphere (Right click VM, Edit Settings, VM Options, Advanced, Edit Configuration..., get value from RightScale Images page)
* An MCI that has a `rs_agent:type=right_link_lite` tag
* A deployment into which the server will be placed
* RightScale OAuth key for the desired account (Settings > Account Settings > API credentials in the Cloud Management dashboard)
* Ability to download from a public Amazon S3 bucket to RightScale's platform from the instance

## How it works

1. The command line to install RightLink and run on the instance looks something like this, for version 10.5.3:

~~~ powershell
  $REFRESHTOKEN = "e22f8d37...456"
  $SERVERTEMPLATENAME = "RightLink 10.5.3 Windows Base"
  $DEPLOYMENTNAME = "Staging Deployment"
  $CLOUDTYPE = "amazon"
  $APISERVER = "us-3.rightscale.com"

  $wc = New-Object System.Net.WebClient
  $wc.DownloadFile("https://rightlink.rightscale.com/rll/10/rightlink.enable.ps1", "$pwd\rightlink.enable.ps1") 
  Powershell -ExecutionPolicy Unrestricted -File rightlink.enable.ps1 -refreshToken $REFRESHTOKEN -serverTemplateName $SERVERTEMPLATENAME -deploymentName $DEPLOYMENTNAME -cloudType $CLOUDTYPE -ApiServer $APISERVER
~~~
  
  Additional versions can be found on the [releases](/rl10/releases) page. As a convenience, more generic versions such as "10" or "10.5" may be specified as a way to install the latest GA version for a lineage. For example, https://rightlink.rightscale.com/rll/10/rightlink.enable.ps1 will pull the latest RightLink 10 client.

2. The downloaded `rightlink.enable.ps1` script locates the ServerTemplate provided and locates the instance itself
3. The script then creates a server around the instance using the located ServerTemplate and places it in the deployment provided
4. It then retrieves the userdata for the new server, places it into `C:\ProgramData\RightScale\RightLink` and starts RightLink
5. RightLink comes up as if the server had just booted, runs boot scripts, and transitions to operational

After this process the server looks just like any other server. Please note however that Relaunch is not supported.

For reference (please check the actual script you are using):

~~~ powershell
  PS > .\rightlink.enable.ps1 -Help
  This script will take a unmanaged instance and turn it into a RightScale server.
  Parameters:
    -RefreshToken         RightScale API refresh token from the dash Settings>API
                          Credentials (required)
    -DeploymentName       Name of the pre-existing deployment into which to put
                          the server
    -DeploymentHref       HREF of the deployment to put the server. alternate to
                          the name of the deployment (ex. /api/deployments/123456789)
    -ServerTemplateName   Name of the ServerTemplate to associate with this instance
    -ServerTemplateHref   Alternate to ServerTemplateName. HREF of the ServerTemplate
                          to associate with this instance
                          (ex./api/server_templates/123456789)
    -ServerName           Name to call the server. Default is current Instance name
                          or RightLink Enabled #$pid
    -Inputs               Server inputs in the form of NAME=key:value, separate
                          multiple inputs with commas
    -CloudType            Cloud type the instance is in. Supported values are amazon,
                          azure, azure_v2, google, open_stack_v2,
                          soft_layer, vscale
    -InstanceHref         RightScale API instance HREF (disables self-detection)
                          (ex. /api/clouds/1/instances/123456ABCDEF)
    -ApiServer            Hostname for the RightScale API, Default: my.rightscale.com
    -Proxy                Have RightLink use HTTP proxy. Will also install RightLink
                          through proxy
    -NoProxy              A list of hosts to not proxy. List is inherited by scripts/
                          recipes as an environmental variable
    -Username             RightLink Service User Name (default: RightLink)
    -Password             RightLink Service User Password
                          (default: Randomly generated password)
    -Debug                Verbose output
    -Help                 Display help

  Required Inputs: -RefreshToken
                   -ServerTemplateName or -ServerTemplateHref
                   -DeploymentName or -DeploymentHref
                   -CloudType or -InstanceHref
~~~
