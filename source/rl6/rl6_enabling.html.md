---
title: Enabling Existing Workloads with RightLink 6
layout: rl6_layout
description: Steps for enabling existing workloads with RightLink 6 including supported clouds and known limitations.
---

!!warning*Warning!*RightLink 6 [has been EOL'd](/faq/end_of_life_end_of_service.html#schedule-images-rightlink) - please refer to the [RightLink 10 documentation](/rl10)

## Overview

!!info*Note* This section covers enablement using RightLink 6.3+ on Windows only. For enabling Linux workloads, you must use the [RightLink 10](/rl10/getting_started.html) agent.

RightLink 6.3 and above now supports "RightScale-enabling" existing Windows workloads via the RightLink enablement Powershell script. When executed on a running unmanaged (raw) instance, the script will install and run the RightScale RightLink agent, turning the raw instance into a "RightScale Server" which allows monitoring, alerts, configuration management, lifecycle management, and all other services provided by the RightScale platform.
The script is idempotent. If at any point the script fails, raises an error, or does not complete for any reason, the script can be run again after fixing the issue and it will continue executing from the point at which it encountered the error.

The enablement script accomplishes this using the following six steps:

1. Installs any missing prerequisites (.NET 3.5).
2. Locates the instance's unique identifier (such as instance ID) if the instance's HREF is not provided.
3. Locates the ServerTemplate to use through either the inputted name or HREF.
4. Locates the Deployment to use through the existing deployment or inputted name.
5. Associates the ServerTemplate and Deployment with the instance by making a wrap_instance API call to RightScale's API service.
6. Downloads, installs, and starts RightLink.

### Supported Clouds

AWS, Microsoft Azure, OpenStack, SoftLayer, vSphere (RCA-V)

### Supported Operating Systems

Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

### vSphere-Specific Notes

* A single RightScale RCA-V appliance can support multiple tenants, with each tenant associated with a particular RightScale dashboard account. Each of these tenants/accounts generally matches back to one VMware resource pool. In order for a particular RightScale dashboard account to see VMware virtual machines, that virtual machine must be a member of the appropriate resource pool. The vSphere dashboard allows drag-and-drop reassignment of virtual machines between resource pools.
* Stop/start of instances is currently not supported on vSphere. Images stopped and then started outside of a RightScale context will lose management capabilities.
* RightLink has the ability to manage network interfaces on the vSphere cloud for freshly launched RightScale Servers. Servers created via the enablement script will not try to manage the network for you.
* The enablement script will first attempt to look in the OvfEnv to get a unique id for the instance, so it may associate it with the RightScale platform. This requires guestinfo to be enabled for the Template/Image that the VM was created from. If guestinfo is not enabled, the script will look for a public and then private IP address. If you have multiple networks defined with overlapping private IP ranges the wrap_instance call may fail.

### Known Limitations

* ServerTemplates can have more than one MultiCloud Image (MCI) associated with them. The default MCI for a ServerTemplate must have the cloud you are trying to wrap associated with it. For example, if you are wrapping a vSphere instance, the default MCI must include a vSphere image. You can do this by adding a placeholder image to the default MCI. The placeholder image can be any arbitrary image available on the cloud. This placeholder image will be overridden with the name of the actual image when the wrap_instance api call is performed. If this placeholder image is not in place, "500 internal server" errors may be returned by the RightScale API during execution of the rightscale.enable.ps1 script.
* The system time on the instance/VM needs to be synchronized to Internet time in order to process operational scripts reliably. If the system time on the instance differs significantly from actual time, operational scripts will fail.

### Enablement Procedure

Please execute the following steps outlined below:

1. Log into your account on the RightScale dashboard, go to the MultiCloud Marketplace and find the [Base ServerTemplate for Windows (RL 6.3 Enablement) [SAMPLE] ServerTemplate](https://us-3.rightscale.com/library/server_templates/Base-ServerTemplate-for-Window/lineage/52414) and import it into your account. This ServerTemplate is specifically designed for the existing Windows workloads use case. It has a MultiCloud Image (MCI) that is valid for each currently supported cloud.
2. Identify the name of the deployment (or create a new deployment using Manage->Deployments->New from the RightScale dashboard) where you want the RightScale-enabled server to be placed. If the instance is not already in a deployment, an existing deployment name must be supplied to the enablement script.
3. Make sure that the virtual server (instance) you are enabling appears in the RightScale dashboard with the state “running” ("operational" for EC2 instances). This can be done using Clouds-><Your Cloud>->Instances in the RightScale dashboard.
4. Download the rightlink.enable.ps1 script from [https://island1.rightscale.com/rightlink/scripts/rightlink.enable.ps1](https://island1.rightscale.com/rightlink/scripts/rightlink.enable.ps1) onto the Windows virtual server that you want to  RightScale-enable. It is presumed that this virtual server is already running and you have access and permission to download/execute software there. (Note: island1.rightscale.com - an Island load balancer - is a proxy for mirror.rightscale.com which does not support SSL yet, so the island1 download link is preferred.) Private cloud considerations: Private clouds should follow ingress/egress rules defined in [Firewall Configuration Ruleset](/faq/Firewall_Configuration_Ruleset.html).
5. Run the enablement script on the virtual server. It should run to completion. It may take up to 10 minutes to download RightLink from the mirror URL, install RightLink and associated dependencies (.NET 3.5), and start up the client. Note that if the script fails on a particular step, the script is designed to be idempotent. This means that the script can be run again and it will pick up execution at a point after which it last failed.

The enablement script has the following options:

* **RefreshToken** (Required) - RightScale API token. You can get the refresh token for your account from the RightScale dashboard using Settings->Account Settings->API credentials.
* **Cloud** (Required) - Possible values are:  ec2, softlayer, vsphere, openstack, azure.
* **DeploymentName** - Target RightScale deployment where you want the new server to land. This parameter does not need to be supplied if the instance is already placed in a deployment.
* **ServerTemplateName** (Required) - Name of the ServerTemplate that you want to use. Note the known limitations section on ServerTemplates below.
* **ServerTemplateHref** - API HREF of the ServerTemplate to use if the name is ambiguous. This is a HREF parameter available from the dashboard (ex. /api/server_templates/1234).
* **ServerName** - Name that you want to give to the newly enabled server. Defaults to instance name, else RL Enabled.
* **Inputs** - Inputs to the ServerTemplate. Server inputs in the form of NAME=type:value. Separate multiple inputs with commas. Inputs parameter must be a single-quoted string (i.e., 'INPUT_NAME_X=text:foo,INPUT_NAME_Y=cred:BAR' ). See [RightScale API 1.5 reference -> Resources -> Inputs](http://reference.rightscale.com/api1.5/resources/ResourceInputs.html) for the list of input value types.
* **ApiServer** - Hostname of API server to use, default to my.rightscale.com, which is an alias for us-3.rightscale.com. Note that this must match the hostname given as the "Token endpoint" in Settings-> Account Settings->API Credentials or you will get an authentication failure.
* **MirrorUrl** (Optional) - Full URL of where to download the RightLink installer from. Defaults to https://island1.rightscale.com/rightlink
* **RightLinkVersion** (Optional) - Defaults to always getting the latest 6.x version. Manually supplied version must be in a format similar to "6.3.0-0". Minimum version is 6.3.0-0.
* **InstanceHref** - API HREF of the instance. This should only need to be supplied in the case of ambiguous instances, such as the instance not having a unique IP in the vSphere cloud. This is the HREF as displayed in the dashboard, such as /api/clouds/2705/instances/8M1D4PGONQ0P9.
* **Debug** - Prints out additional debugging information such as API calls used, etc.

#### Example

Here is an example of a RightScale enablement script:

~~~ powershell
$wc = New-Object System.Net.Webclient
$wc.DownloadFile("https://island1.rightscale.com/rightlink/scripts/rightlink.enable.ps1", "$pwd/rightlink.enable.ps1")
powershell -executionpolicy unrestricted -file rightlink.enable.ps1 -refreshToken 'ae1...1fe' -deploymentName 'My deployment' -serverTemplateName 'Base ServerTemplate for Windows (v14.1)' -serverName 'My server' -cloud vsphere -inputs "AD_ADMIN_ACCOUNT=text:Adminstrator,AD_ADMIN_PASSWORD=cred:MY_AD_PW,AD_DOMAIN_NAME=text:rightscale.local"
~~~

## Proxy support

Proxy support for the enablement case is currently not supported for RightLink 6. For enablement behind a proxy, use [RightLink 10](/rl10/getting_started.html).
