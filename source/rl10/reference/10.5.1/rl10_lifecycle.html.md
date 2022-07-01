---
title: Lifecycle - Launch, Reboot, Stop-Start
description: Describes the lifecycle of a server in the context of RightLink 10 including Launch, Reboot, and Stop-Start.
version_number: 10.5.1
versions:
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
  * typically the `rs_agent:type=right_link_lite` tag specifies multi-part mime user-data and will include RightLink 10 appropriate parameters
  * if RightLink 10 is not installed on the image, then typically a `rs_agent:mime_include_url=` tag is used to have cloud agent download and execute the RightLink 10 installer
* If the instance was launched via [RightScale Cloud Appliance for vSphere (RCA-V)](rl10_rcav.html), networking is configured.
* The instance boots and an agent reads and acts on the user-data and metadata. On Linux, this agent is typically cloud-init while on Windows the situation is more complicated. For now, RightLink comes with a service to read userdata, detailed in [Userdata Retrieval on Windows](#userdata-retrieval-on-windows) section below.
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
  * waits for commands from the platform

When enabling a running instance the following differences exist:

* There is no user-data when the "enable" script starts. Instead of passing down user-data via the cloud as in the "new launch" case, the user-data is generated and fetched directly from the RightScale API. To do this, it first locates the HREF of the currently running instance, or unmanaged server, then turns the instance into a managed RightScale Server by associating that server with a RightScale ServerTemplate.
* Like the new launch case, in order to obtain the right type of user-data the MCI used by the ServerTemplate must have a `rs_agent:type=right_link_lite` tag.

## Userdata Retrieval on Windows

On Windows, public clouds (Ec2, Azure, Google) all have proprietary agents that may run custom scripts using different methods. Using these agents to bootstrap RightLink through RightScale is planned, but isn't supported yet. In order to bridge the gap in the meantime, a simple userdata fetching service is bundled with RightLink 10.2.1 and newer for Windows. In order to use this service, RightLink must be [installed](rl10_install_windows.html) and the instance snapshotted to create a new image.

This userdata fetcher is a powershell script located at `C:\Program Files\RightScale\RightLink\userdata-fetcher.ps1`. This script is wrapped as a Windows service named RightScaleUserdata and run at boot, starting RightLink when done. Logs may be viewed at `C:\Program Files\RightScale\Rightlink\userdata-fetcher.log`. Clouds supported include EC2, RCA-V, Google, OpenStack, Softlayer, and Azure.

## Reboot

* If you initiate the reboot through the platform RightLink 10 receives a 'decommission for reboot' message, which is handled differently on Linux and Windows:
  * _Linux_: it initiates an OS reboot (e.g., by changing to runlevel 6 on Linux). Because of this, decommission scripts have a limited amount of time to run determined by the OS init system. This is set to 3 minutes on Linux though may be modified by changing the timeouts in the service config files for upstart/systemd. If setting the timeout for longer than 50 minutes, see [Terminate](#terminate) and [Stop-Start](#stop-start) sections below.
  * _Windows_: it runs the decommission bundle first, then initiates an OS reboot. This is because Windows has limited dependency management of services during shutdown, and very limited time to stop services. Because of this, _**RightLink will only execute decommission scripts for Windows if the reboot/terminate/stop was initiated via the RightScale API or dashboard and not if it was executed via the cloud console or on the machine**_. There is no timeout on the running of the decommission bundle in the RightLink code. However, see below for timeouts that apply to stop and terminate.
* When the OS starts the shutdown process it sends a kill SIGTERM signal to RightLink 10. For Linux, RightLink 10 fetches and executes the decommission bundle then exits. For Windows, the client simply exits immediately as the decommission bundle has already run.
* Decommission scripts detect whether this is a 'shutdown-for-reboot' using a variety of methods described in the [Linux Shutdown Reason](https://github.com/rightscale/rightlink_scripts/blob/master/rll/shutdown-reason.sh) RightScript and the [Windows Shutdown Reason](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/shutdown-reason.ps1).
* When the OS starts again it causes cloud-init or native agent to run.
* Cloud-init (Linux) and UserDataFetcher (Windows) causes user-data to be reloaded (unchanged) and the scripts in it to be re-run.
* The first script causes the rightscale-identity file to be rewritten with the same content.
* The second script detects that RightLink 10 is already installed and does nothing.
* The init scripts/config installed causes RightLink 10 to start after cloud-init finishes.
* RightLink 10 authenticates and runs the boot bundle.

## Terminate or Reboot

Before a RightLink instance can be terminated or rebooted, RightScale attempts to decommission it first. During the decommission process, all scripts in the decommission section of the ServerTemplate are executed and OS shutdown occurs.  There is a server side timeout on how long an instance can be in a decommissioning state before it is marked as failed, and may be terminated. This timeout can clean up failed instances that refuse to terminate correctly, as well as terminate instances that fail to re-enter a booting state after a reboot request. If you need to set the upstart/systemd service stop timeout to be greater than 50 minutes, you'll have to set a tag on the instance to tell the core to extend the server side timeout as well. See the `rs_decommissioning:delay` tag in [List of RightScale Tags](/cm/ref/list_of_rightscale_tags.html). This means any instance that is in a decommissioning state for longer than 50 minutes may be terminated due to this timeout.

## Stop-Start

Stop-start is similar to a reboot except that when the server restarts it is a different instance from the point of view of the RightScale platform. The decommissioning timeout mentioned in the [Terminate or Reboot](#terminate-or-reboot) section above also applies.

**Note:** On clouds that support stop/start, instances only currently support starting the instance from either the RightScale Dashboard or through the API. Additionally, command line stop is not supported on the Azure cloud. This is due to a limitation in the way Azure treats a stopped instance when done via the command line (allocated versus unallocated). On SoftLayer, command line stop is supported, but due to the way SoftLayer detects stopped instances, it may result in undesired behavior by taking much longer than expected to report the stopped state.
