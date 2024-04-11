---
title: Lifecycle - Launch, Reboot, Stop-Start, Decommission, Terminate
# IMPORTANT: 'alias:' metadata line MUST ONLY BE in LATEST REV, requiring removal of 'alias:' line upon a new latest doc directory revision
alias: [rl/reference/rl10_lifecycle.html, rl10/reference/rl10_lifecycle.html]
description: Describes the lifecycle of a server in the context of RightLink 10 including Launch, Reboot, Stop-Start, Decommission, and Terminate.
version_number: 10.6.4
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_lifecycle.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_lifecycle.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_lifecycle.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_lifecycle.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_lifecycle.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_lifecycle.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_lifecycle.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_lifecycle.html
---

## Launch-Initial Boot

When launching a new server (with a ServerTemplate and MultiCloudImage (MCI)) the following steps occur:

* The MCI and/or Server have tags that specify how the RightScale platform should produce user-data (see also cloud-init info):
  * typically the `rs_agent:type=right_link_lite` tag specifies user-data that will include RightLink 10 appropriate parameters
  * if RightLink 10 is not installed on the image, then typically a `rs_agent:mime_shellscript` tag on Linux or `rs_agent:powershell_url` tag on Windows is used to have cloud agent download and execute the RightLink 10 installer
* If the instance was launched via [RightScale Cloud Appliance for vSphere (RCA-V)](rl10_rcav.html), networking is configured.
* The instance boots and an agent reads and acts on the user-data and metadata. On Linux, this agent is typically cloud-init while on Windows a native agent will be used if available to install RightLink. RightLink then comes bundled with tool to fetch userdata, detailed in the [Userdata Retrieval on Windows](#userdata-retrieval-on-windows) section below.
* The first user-data script places the instance parameters into `/var/lib/rightscale-identity` (Linux) or `C:\ProgramData\RightScale\RightLink\rightscale-identity` (Windows).
* The optional second script installs RightLink 10, which includes the following steps:
  * creates a 'rightlink' (Linux) and 'RightLink' (Windows) user for the rightlink service
  * installs sudoers config for the 'rightlink' user (Linux only)
  * downloads the RightLink 10 archive
  * determines the type of init system (systemd, upstart, or sysvinit) and installs the appropriate startup scripts (Linux) or NSSM is used to install RightLink as a service (Windows)
  * starts the RightLink 10 service
  * ensures that the user-data based "user scripts" (the two scripts discussed here) run on every boot
* The RightLink 10 service starts and authenticates with the platform, it then:
  * retrieves the boot bundle and executes it
    * if all scripts in the boot bundle execute successfully, an 'operational' state is achieved
    * if any script in the boot bundle fails, a 'stranded in booting' state is achieved
  * waits for commands from the platform

When enabling a running instance the following differences exist:

* There is no user-data when the "enable" script starts. Instead of passing down user-data via the cloud as in the "new launch" case, the user-data is generated and fetched directly from the RightScale API. To do this, it first locates the HREF of the currently running instance, or unmanaged server, then turns the instance into a managed RightScale Server by associating that server with a RightScale ServerTemplate.
* Like the new launch case, in order to obtain the right type of user-data the MCI used by the ServerTemplate must have a `rs_agent:type=right_link_lite` tag.

## Userdata Retrieval on Windows

On Windows, public clouds (Ec2, Azure, Google) all have proprietary agents that may run custom Powershell scripts using different methods. For some clouds, these [agents may be leveraged](rl10_install_at_boot_windows.html) to bootstrap the instance. Once RightLink is installed, it includes a userdata fetcher script.

This userdata fetcher is a powershell script located at `C:\Program Files\RightScale\RightLink\userdata-fetcher.ps1`. This script is wrapped as a Windows service named RightScaleUserdata and run at boot, starting RightLink when done. Logs may be viewed at `C:\Program Files\RightScale\Rightlink\userdata-fetcher.log`. Clouds supported include EC2, RCA-V, Google, OpenStack, Softlayer, and Azure.

## Reboot

* If you initiate the reboot through the platform RightLink 10 receives a 'decommission for reboot' message, which is handled differently on Linux and Windows:
  * _Linux_: it initiates an OS reboot (e.g., by changing to runlevel 6 on Linux) which sends a SIGTERM to the rightlink process. The Rightlink process then proceeds to run the decommission bundle if it has reached the 'operational' or 'stranded' state, which happens at the end of the boot bundle. Because of this, decommission scripts have a limited amount of time to run determined by the OS init system. This is set to 3 minutes on Linux though may be modified by changing the timeouts in the service config files for upstart/systemd. If setting the timeout for longer than 50 minutes, see [Terminate](#terminate) and [Stop-Start](#stop-start) sections below.
  * _Windows_: it runs the decommission bundle first, then initiates an OS reboot. This is because Windows has limited dependency management of services during shutdown, and very limited time to stop services. Because of this, _**RightLink will only execute decommission scripts for Windows if the reboot/terminate/stop was initiated via the RightScale API or dashboard and not if it was executed via the cloud console or on the machine**_. There is no timeout on the running of the decommission bundle in the RightLink code. However, see below for timeouts that apply to stop and terminate.
* When the OS starts the shutdown process it sends a kill SIGTERM signal to RightLink 10. For Linux, RightLink 10 fetches and executes the decommission bundle if it has achieved an 'operational' or 'stranded' state then exits. For Windows, the client simply exits immediately as the decommission bundle has already run.
* Decommission scripts detect whether this is a 'shutdown-for-reboot' using a variety of methods described in the [Linux Shutdown Reason](https://github.com/rightscale/rightlink_scripts/blob/master/rll/shutdown-reason.sh) RightScript and the [Windows Shutdown Reason](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/shutdown-reason.ps1).
* When the OS starts again it causes cloud-init or native agent to run.
* Cloud-init (Linux) and UserDataFetcher (Windows) causes user-data to be reloaded (unchanged) and the scripts in it to be re-run.
* The first script causes the rightscale-identity file to be rewritten with the same content.
* The second script detects that RightLink 10 is already installed and does nothing.
* The init scripts/config installed causes RightLink 10 to start after cloud-init finishes.
* RightLink 10 authenticates and runs the boot bundle.

## Terminate

Terminate is the same as the first few steps of a reboot. The only difference is that RightLink 10 tells the RightScale platform to terminate the instance. There is also a core side timeout on how longer an instance can be in a decommissioning state before stop/terminate. Thus if you set the upstart/systemd service stop timeout to be more than 50 minutes, you'll have to set a tag on the instance to tell the core to extend the timeout as well. See the `rs_decommissioning:delay` tag in [List of Rightcale Tags](/cm/ref/list_of_rightscale_tags.html).

## Stop-Start

Stop-start is similar to a reboot except that when the server restarts it is a different instance from the point of view of the RightScale platform. The decommissioning timeout mentioned in the [Terminate](#terminate) section above also applies.

**Note:** Command line stop is not supported on the Azure Service Manager (legacy Azure) cloud. This is due to a limitation in the way Azure treats a stopped instance when done via the command line (allocated versus unallocated). On SoftLayer, command line stop is not supported as the Softlayer API will not return that the instance is stopped.
