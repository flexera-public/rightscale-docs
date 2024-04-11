---
title: Troubleshooting
description: RightLink 10 Troubleshooting.
version_number: 10.6.0
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_troubleshooting.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_troubleshooting.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_troubleshooting.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_troubleshooting.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_troubleshooting.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_troubleshooting.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_troubleshooting.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_troubleshooting.html
---

## Quick Tips

Symptom | Suggested Solution |
------- | ------------------ |
How to check that RightLink 10 is running | Look for a process called rightlink. |
Server is sitting in the 'booting' state forever | The rightlink process transitions from 'booting' to 'operational' and may not be starting or authenticating with the platform. See troubleshooting tips for "RightLink 10 is not starting at boot (install-at-boot or custom-image use-cases)". |
RightLink 10 is not starting at boot (install-at-boot or custom-image use-cases) | <ul><li>Verify that the instance has the expected user-data (see below)</li><li>Verify that cloud-init (Linux)/userdata-fetcher (Windows) has produced the identity file `/var/lib/rightscale-identity` (Linux) or `C:\ProgramData\RightScale\RightLink\rightscale-identity` on the instance</li><li>If the identity file is missing</li><ul><li>Linux: look that the raw user-data has been pulled-in by cloud-init in /var/lib/cloud/instance/user-data.txt</li><li>check the cloud-init log files in /var/log (they're very long and failures are difficult to spot)</li><li>If log files are present, make sure the [right cloud-init is installed](rl10_cloud_init_installation.html)</li><li>if no log files are present, cloud-init is not installed; if user-data was not pulled in either cloud-init is lacking the module for your cloud or user-data was not produced due to missing tags on the MCI/server</li><li>Windows: Verify that the userdata-fetcher service ran correctly. Check logs in `C:\Program Files\RightScale\RightLink\Logs\userdata-fetcher.log`.</li><li>If no logs are present, RightLink was not pre-installed. Note the install-at-boot use case isn't yet supported for Windows</li></ul></li></li><li>If /var/lib/rightscale-identity is present and has the correct values (double-check against the Server's info page in the case of stop and start)<ul><li>Linux: check that the installation of RightLink 10 was successful in `/var/log/rightlink.log`</li><li>check the log of the OS' init system, for example, `/var/log/upstart/rightlink.log` or `journalctl -u rightlink`</li><li>check to make sure cloud-init runs user-scripts on every boot in `/etc/cloud/cloud.cfg` and that cloud-init runs before RightLink</li><li>Windows: Check installation and run logs in `C:\Program Files\RightScale\RightLink\Logs\`.</li></ul> |
RightLink 10 is not starting in an enable-running use-case | The enable script logs to `/var/log/rightlink.log` on Linux and `c:\Program Files\RightScale\RightLink\Logs\install.log` on Windows. |
Boot/operational scripts are not running | Check the following audit entries in the Cloud Management dashboard: <ul><li>Each runlist/script execution creates an audit entry with the output (stderr & stdout) of the script. On success, such an audit entry is labeled something like "Completed: RL10 Linux Wait For EIP, RL10 Linux Collectd"</li><li>RightLink 10 also produces an audit entry with its own execution log (the same one you may find at `/var/log/upstart/rightlink.log` or `C:\Program Files\RightScale\RightLink\Logs\rightlink.log`). This audit entry is called something like "RightLink 10.3.1 log pid 1251" where '10.3.1' is the version of RightLink 10 and '1251' is the process id (this is helpful when restarting RightLink 10 or rebooting)</li><li>Restarting the RightLink service should help clear the issue</li><li>See some sample RightLink 10 log snippets below</li></ul> |
Scripts are not executing and/or shows as queued forever in the Cloud Management dashboard | Scripts are executed on a (logical) thread, meaning that successive scripts that use the same thread run sequentially. This means that if a script is "stuck", i.e. not exiting, then that blocks future scripts.<ul><li>Scripts initiated from the Cloud Management dashboard use the default thread, check the RightLink 10 log to see whether some script was executed and has not completed. RightLink 10 shows the thread when starting a runlist: `*** Starting runlist '' with 3 executables on thread 'default'` <li>Restarting RightLink 10 is the most expedient way to abort a stuck runlist</li></ul> |
How do I restart RightLink 10, and is it safe? | Yes, it is safe to restart RightLink 10 using `sudo service rightlink restart` on Linux or `Restart-Service rightlink` on Windows.<br>RightLink 10 has very little persistent state. It saves the boot state (whether the boot bundle has completed) to disk (`/var/run/rightlink/state` or `C:\ProgramData\Rightscale\RightLink\state`) so that boot scripts will not be rerun on restart of the service. Any explicitly set environment variables (via /rll/env) are saved to disk as well and restored on restart (see sample log below).<br>If RightLink 10 did not manage to start-up and enroll properly due to some issues on the instance or with networking the easiest way to get it to retry is `sudo service rightlink restart` on Linux or `Restart-Service rightlink` on Windows<br> Any runlists currently being being executed will be lost on restart and will have to be re-executed. Any audit entries that have not yet been sent up to the platform will be lost as well. |
Monitoring data not showing up | See [Monitoring:Troubleshooting](rl10_monitoring.html#troubleshooting) |
RightLink refuses to start after joining a domain with a `logon failure` error | Make sure that the RightLink user is a member of a Domain Admin or Local Administrator group |
RightLink is having trouble running operational scripts on Windows | Ensure that the Hypervisor is set to the same time zone as the server. RightLink can have trouble running operational scripts due to a failed websocket connection if there is a time skew between RightScale and the instance. When the Hypervisor is set to a different timezone than the server it can incorrectly report the time skew. |
RightLink isn't running the boot scripts on reboot or stop / start on Linux | RightLink stores its state file in the /var/run directory which should be symlinked to the /run directory, a temporary filesystem, by default. RightLink expects this directory to be automatically cleared on reboot and stop / start in order to determine if the boot scripts should be run or not. |
A different version of RightLink is being installed at boot on my custom image on Linux | Ensure that your ServerTemplate and MCI are not tagged with rs_agent:mime_include_url=https://rightlink.rightscale.com/rll/.../rightlink.boot.sh. This tag is used to pass data to cloud-init which will download and install the version of RightLink 10 that is specified in the tag. The version specified in the tag will overwrite any versions that exist on the image already. |
Stop / Start isn't working on Softlayer for Windows | Windows requires the appropriate version of PV Drivers installed in order to support instance stop and start. Currently, the SoftLayer provided images for both Windows Server 2008 R2 Datacenter Edition (64bit) and Windows Server 2012 R2 Datacenter Edition (64bit) have the incorrect version of PV Drivers and will have to be updated if these images are used. When attempting to stop an instance with this issue, SoftLayer will return this exception "Failed to perform a clean shutdown because the guest is missing PV drivers."

## Sample User-Data

This user-data comes from a server whose MultiCloud Image (MCI) has the `rs_agent:type` tag to signify RightLink 10 and the `rs_agent:mime_include_url` tag to download RightLink 10 at boot. In the sample below, the bold text highlights the information RightLink 10 needs to connect to the RightScale platform including the URL from which cloud-init needs to download RightLink 10.

  <pre>
  Content-Type: multipart/mixed; boundary=Boundary_fiy12wousrdp4ww3w756uxq83c
  Content-ID: <7z4548ousrdp4ww3w756uxq8go@6g74u6ousrdp4ww3w756uxq8j4.local>
  MIME-Version: 1.0
  --Boundary_fiy12wousrdp4ww3w756uxq83c
  Content-Type: text/x-shellscript
  Content-ID: <3sxsjnousrdp4ww3w756uxq9cw@abl7m4ousrdp4ww3w756uxq9ei.local>
  #! /bin/bash
  cat <<'EOF' >/var/lib/rightscale-identity
  <strong>client_id='16510987008'
  api_hostname='us-3.rightscale.com'
  account='60073'
  client_secret='a67702cc7a1afd2012345674a202abdec1ee'
  EOF</strong>
  chmod 0600 /var/lib/rightscale-identity
  --Boundary_fiy12wousrdp4ww3w756uxq83c
  Content-Type: text/x-include-url
  Content-ID: <6qm8vkousrdp4ww3w756uxq9jk@1fjnx8ousrdp4ww3w756uxq9ky.local>
  <strong>https://rightlink.rightscale.com/rll/10.0.3/rightlink.boot.sh</strong>
  --Boundary_fiy12wousrdp4ww3w756uxq83c--
  </pre>

## Sample RightLink 10 Log Output at Boot

Below is a typical log output file for the boot sequence (with comments added) up to the point RightLink 10 starts running the boot runlist. The log output has been annotated with comments.

  ~~~ bash
  # RL10 Version, build timestamp, build SHA
  2016/10/10 23:04:21 RightLink 10.6.0 - 2016-10-07 17:28:53 - 8d5b5beeaef0b677ba48e4e5ca4e1678f4e32ea0
  2016/10/10 23:04:21 RightLink10 == RightLinkLite == RLL :-)
  2016/10/10 23:04:21 Operating system type: ubuntu
  2016/10/10 23:04:21 Running as user: rightlink
  # Values passed in from user-data. Credentials to connect back to RightScale.
  2016/10/10 23:04:21 Option client_id from environment: 23064017003
  2016/10/10 23:04:21 Option client_secret from environment: e03f0a...
  2016/10/10 23:04:21 Option api_hostname from environment: us-3.rightscale.com
  2016/10/10 23:04:21 Option account from environment: 67972
  # State file, keeps track of whether boot bundle ras run and other runtime state.
  2016/10/10 23:04:21 No state file: this is a fresh boot
  # Temporary cache directories.
  2016/10/10 23:04:21 Attachment spool dir: /var/spool/rightlink/attachments
  2016/10/10 23:04:21 Cookbook spool dir: /var/spool/rightlink/cookbooks
  2016/10/10 23:04:21 Script spool dir: /var/spool/rightlink/scripts
  # Status of authentication back to RightScale platform
  2016/10/10 23:04:21 Connecting to us-3.rightscale.com
  2016/10/10 23:04:21 rsclient.NewClient(us-3.rightscale.com, 67972, master)
  # RightScale will have issues running operational scripts if time skew > several minutes!
  2016/10/10 23:04:21 Time skew: local time - RightScale time = 0.6 secs
  2016/10/10 23:04:21 Next auth not before 2016-10-11T00:04:21.634882024Z
  # We've authenticated, discovered ourself
  2016/10/10 23:04:22 Found self: /api/clouds/6/instances/4UUEHT9D4GB9T
  # Phone home back to RightScale
  2016/10/10 23:04:22 Booter/declare successful agent_id=rs-instance-9242ee...
  2016/10/10 23:04:22 Not a UCA based server: No keep-alive info found for this instance
  2016/10/10 23:04:22 Opening Websocket to wss://rightnet-router3.rightscale.com/router/connect
  # Local http server has been started
  2016/10/10 23:04:22 Started proxy server on 127.0.0.1:51074
  # The base environment ALL scripts inherit
  2016/10/10 23:04:22 Monitoring info from API1.5: server=tss3.rightscale.com id=03-1RMHCFNNPI2SB
  2016/10/10 23:04:22     Base environment:
  2016/10/10 23:04:22       account=67972
  2016/10/10 23:04:22       api_hostname=us-3.rightscale.com
  2016/10/10 23:04:22       PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  2016/10/10 23:04:22       client_id=23064017003
  2016/10/10 23:04:22       USER=rightlink
  2016/10/10 23:04:22       HOME=/home/rightlink
  2016/10/10 23:04:22 Proxy: 51074 554dc...
  2016/10/10 23:04:24 State update (booting) successful
  ~~~


Below is a typical sequence for running the boot runlist:
  ~~~ bash
  # RL10 has retrieved the boot bundle
  2016/10/10 23:04:24 Get boot bundle successful; received (2 keys)
  # Audit entry ID for boot script output
  2016/10/10 23:04:24 Audit id for bundle is 445173544003
  # Where we fetch attachments from
  2016/10/10 23:04:24 Repose servers are [island10.rightscale.com]
  2016/10/10 23:04:24 Executable bundle for thread default is at head of queue
  # We first download all attachments.
  2016/10/10 23:04:24 *** Starting runlist 'boot' with 3 executables on thread 'default'
  2016/10/10 23:04:24     OS packages to install: []
  2016/10/10 23:04:24     Downloading 3 attachments into /var/spool/rightlink/attachments
  2016/10/10 23:04:24         Downloading attachment a15...eef/rightscale_login_policy.te 
  2016/10/10 23:04:24         Downloading attachment ac2...8dd/rs-ssh-keys.sh 
  2016/10/10 23:04:24         Downloading attachment 63e...506/libnss_rightscale.tgz 
  2016/10/10 23:04:24         1.6KB in 0.0s for ac2...8dd/rs-ssh-keys.sh
  2016/10/10 23:04:24         0.5KB in 0.0s for a15...eef/rightscale_login_policy.te
  2016/10/10 23:04:24         18.4KB in 0.0s for 63e...506/libnss_rightscale.tgz
  2016/10/10 23:04:24     Done with 3 attachments: 18KB in 0.0s -> 0.675MB/s
  2016/10/10 23:04:24     No cookbooks to download
  # First RightScript starts executing. All inputs passed to the script are listed, with credentials blacked out.
  # These inputs are on top of the base environment listed above.
  2016/10/10 23:04:24 +++ RightScript: 'RL10 Linux Setup Hostname'
  2016/10/10 23:04:24     SERVER_HOSTNAME = ''
  2016/10/10 23:04:24     Started /var/spool/rightlink/scripts/rll-943807325/__script-0 pid=1344 in /var/spool/rightlink/scripts/rll-943807325
  # Any calls back to the platform the script makes through RL10 local http server are listed here.
  2016/10/10 23:04:24 HTTP proxy: GET /api/sessions/instance
  2016/10/10 23:04:25 PROXY HTTP GET /api/sessions/instance -> 200 OK
  2016/10/10 23:04:25 HTTP proxy: GET /api/clouds/6
  2016/10/10 23:04:25 PROXY HTTP GET /api/clouds/6 -> 200 OK
  2016/10/10 23:04:25     RightScript execution successful
  # Second script starts executing and has several attachments.
  2016/10/10 23:04:25 +++ RightScript: 'RL10 Linux Enable Managed Login'
  2016/10/10 23:04:25     MANAGED_LOGIN = 'auto'
  2016/10/10 23:04:25     Linking attachment /var/spool/rightlink/scripts/rll-238855448/rs-ssh-keys.sh -> ...
  2016/10/10 23:04:25     Linking attachment /var/spool/rightlink/scripts/rll-238855448/libnss_rightscale.tgz -> ...
  2016/10/10 23:04:25     Linking attachment /var/spool/rightlink/scripts/rll-238855448/rightscale_login_policy.te -> ...
  2016/10/10 23:04:25     Started /var/spool/rightlink/scripts/rll-238855448/__script-1 pid=1361 in /var/spool/rightlink/scripts/rll-238855448
  # This script makes some calls to the local http server to enable managed login
  2016/10/10 23:04:29 HTTP proxy: PUT /rll/login/control
  2016/10/10 23:04:29 Managed Login Enabled
  # The managed login script sets a tag subscribing to receive policy changes
  2016/10/10 23:04:29 HTTP proxy: POST /api/tags/multi_add
  2016/10/10 23:04:29 PROXY HTTP POST /api/tags/multi_add -> 204 No Content
  2016/10/10 23:04:29 Get login policy successful; received 26 entries
  # Five users exist in this account, three with server_login rights
  2016/10/10 23:04:29 New users to process (5): tve, rightscale8503, douglas, rightscale45778, hrich 
  2016/10/10 23:04:29 Users allowed to login: tve, douglas, rightscale8503
  2016/10/10 23:04:29 Users skipped to login: 
  2016/10/10 23:04:29     RightScript execution successful
  # Third script starts executing.
  2016/10/10 23:04:29 +++ RightScript: 'RL10 Linux Enable Monitoring'
  2016/10/10 23:04:29     RS_INSTANCE_UUID = '03-1RMHCFNNPI2SB'
  2016/10/10 23:04:29     COLLECTD_SERVER = 'tss3.rightscale.com'
  2016/10/10 23:04:29     MONITORING_METHOD = 'auto'
  2016/10/10 23:04:29     Started /var/spool/rightlink/scripts/rll-116970977/__script-4 pid=1447 in /var/spool/rightlink/scripts/rll-116970977
  2016/10/10 23:05:19 HTTP proxy: PUT /rll/tss/control
  2016/10/10 23:05:19 Monitoring goroutine starting, features=1; plugins=
  2016/10/10 23:05:20 TSS monitoring_enable set to 'util'
  2016/10/10 23:05:20 TSS returned 200 for https://tss3.rightscale.com/push/acct/67972/collectdv5 -- 
  2016/10/10 23:05:20     RightScript execution successful
  # RL10 transitions the server to operational because all three scripts finished successfully
  2016/10/10 23:05:21 State update (operational) successful
  2016/10/10 23:05:21 Entering main loop
  ~~~
