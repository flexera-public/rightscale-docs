---
title: Troubleshooting
description: RightLink 10 Troubleshooting.
version_number: 10.5.1
versions:
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
Boot/operational scripts are not running | Check the following audit entries in the Cloud Management dashboard: <ul><li>Each runlist/script execution creates an audit entry with the output (stderr & stdout) of the script. On success, such an audit entry is labeled something like "Completed: RL10 Linux Wait For EIP, RL10 Linux Collectd"</li><li>RightLink 10 also produces an audit entry with its own execution log (the same one you may find at `/var/log/upstart/rightlink.log` or `C:\Program Files\RightScale\RightLink\Logs\rightlink.log`). This audit entry is called something like "RightLink 10.3.1 log pid 1251" where '10.3.1' is the version of RightLink 10 and '1251' is the process id (this is helpful when restarting RightLink 10 or rebooting)</li><li>See some sample RightLink 10 log snippets below</li></ul> |
Scripts are not executing and/or shows as queued forever in the Cloud Management dashboard | Scripts are executed on a (logical) thread, meaning that successive scripts that use the same thread run sequentially. This means that if a script is "stuck", i.e. not exiting, then that blocks future scripts.<ul><li>Scripts initiated from the Cloud Management dashboard use the default thread, check the RightLink 10 log to see whether some script was executed and has not completed. RightLink 10 shows the thread when starting a runlist: `*** Starting runlist '' with 3 executables on thread 'default'` <li>Restarting RightLink 10 is the most expedient way to abort a stuck runlist</li></ul> |
How do I restart RightLink 10, and is it safe? | Yes, it is safe to restart RightLink 10 using `sudo service rightlink restart` on Linux or `Restart-Service rightlink` on Windows.<br>RightLink 10 has very little persistent state. It saves the boot state (whether the boot bundle has completed) to disk (`/var/run/rightlink/state` or `C:\ProgramData\Rightscale\RightLink\state`) so that boot scripts will not be rerun on restart of the service. Any explicitly set environment variables (via /rll/env) are saved to disk as well and restored on restart (see sample log below).<br>If RightLink 10 did not manage to start-up and enroll properly due to some issues on the instance or with networking the easiest way to get it to retry is `sudo service rightlink restart` on Linux or `Restart-Service rightlink` on Windows<br> Any runlists currently being being executed will be lost on restart and will have to be re-executed. Any audit entries that have not yet been sent up to the platform will be lost as well. |
Monitoring data not showing up | See [Monitoring:Troubleshooting](rl10_monitoring.html#troubleshooting) |
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

Below is a typical log output file for the boot sequence (with comments added) up to the point RightLink 10 starts running the boot runlist:

  ~~~
  2015/02/13 19:15:12 RL 10.0.3 - 2015-02-13 18:29:04 - 66841...fb1e4        # RL10 Version, build timestamp, build SHA
  2015/02/13 19:15:12 RightLink 10 == RightLinkLite == RLL :-)
  2015/02/13 19:15:12 Operating system type: ubuntu                          # Host OS
  2015/02/13 19:15:12 Option client_id from environment: 16510987003      # Values passed in from user-data
  2015/02/13 19:15:12 Option client_secret from environment: a67702...
  2015/02/13 19:15:12 Option api_hostname from environment: us-3.rightscale.com
  2015/02/13 19:15:12 Option account from environment: 60073
  2015/02/13 19:15:12 No state file: this is a fresh boot                    # State prevents re-running boot bundle if
                                                                             # RL10 crashes and is restarted
  2015/02/13 19:15:12 Attachment spool dir: /var/spool/rll/attachments       # Spool directories to be used
  2015/02/13 19:15:12 Cookbook spool dir: /var/spool/rll/cookbooks
  2015/02/13 19:15:12 Script spool dir: /var/spool/rll/scripts
  2015/02/13 19:15:12 Connecting to us-3.rightscale.com                      # Starting to connect to RS platform
  2015/02/13 19:15:12 rsclient.NewClient(us-3.rightscale.com, 60073)
  2015/02/13 19:15:13 Time skew: local time - RightScale time = 0.3 secs     # Comparison of local time with HTTP response
                                                                             # timestamp, should be <1 minute!
  2015/02/13 19:15:14 Found self: /api/clouds/1/instances/P4RIKDGBF7KJ       # Instance self-href in API 1.5
  2015/02/13 19:15:14 Opening Websocket to wss://rightnet-router3.rightscale.com/router/connect
  2015/02/13 19:15:15 Started proxy server on localhost:60473                # localhost port for proxy and http server
  2015/02/13 19:15:15 Proxy: 60473 a96c3...                                  # first 5 chars of X-RLL-Secret proxy auth
  2015/02/13 19:15:15 State update (booting) successful                      # confirmed with RS platform that we are re booting
  ~~~

Below is a typical sequence for running the boot runlist:

  ~~~
  2015/02/13 19:15:15 Get boot bundle successful; received (2 keys)          # RL10 has retrieved the boot bundle
  2015/02/13 19:15:15 Audit id for bundle is 325299050003                    # audit entry ID for boot script output
  2015/02/13 19:15:15 Repose servers are [island1.rightscale.com]            # where to fetch cookbooks and attachments
  2015/02/13 19:15:15 Executable bundle for thread default is at head of queue
  2015/02/13 19:15:15 *** Starting runlist '' with 3 executables on thread 'default'  # runlist has 3 scripts
  2015/02/13 19:15:15     OS packages to install: []                         # RL10 does not install OS packages!
  2015/02/13 19:15:15     No attachments to download                         # Attachments for RightScripts
  2015/02/13 19:15:15     Downloading 1 cookbooks into /var/spool/rll/cookbooks
  2015/02/13 19:15:15         Downloading cookbook rll
  2015/02/13 19:15:15         28.5KB in 0.1s for rll
  2015/02/13 19:15:15     Done with 1 cookbooks: 28KB in 0.1s -> 0.301MB/s
  2015/02/13 19:15:15     Unarchiving cookbook /var/spool/rll/cookbooks/b5debc480f76d0567ea41c7e207c4ef6
  2015/02/13 19:15:15       Extracted 9 files                                # Cookbook is cached in the above location
  2015/02/13 19:15:15 +++ Recipe: 'rll::wait-for-eip'                        # First recipe starts executing
  2015/02/13 19:15:15     Base environment:                                  # Base env variables passed to all scripts
  2015/02/13 19:15:15       client_id=16510987003
  2015/02/13 19:15:15       account=60073
  2015/02/13 19:15:15       PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin
  2015/02/13 19:15:15       api_hostname=us-3.rightscale.com
  2015/02/13 19:15:15     Cookbook: rll, Script: wait-for-eip                # Actual script may have .* filename extension
  2015/02/13 19:15:15       Searching /var/spool/rll/cookbooks/b5debc480f76d0567ea41c7e207c4ef6/wait-for-eip.*
  2015/02/13 19:15:15     Started /var/spool/rll/cookbooks/b5debc480f76d0567ea41c7e207c4ef6/wait-for-eip.sh pid=1272
  2015/02/13 19:15:15     RightScript execution successful
  2015/02/13 19:15:15 +++ Recipe: 'rll::init'                                # Second recipe
  2015/02/13 19:15:15     HOSTNAME = 'RL10.0.rc2 Linux Base'                 # Input/attribute passed to script
  2015/02/13 19:15:15     Cookbook: rll, Script: init
  2015/02/13 19:15:15       Searching /var/spool/rll/cookbooks/b5debc480f76d0567ea41c7e207c4ef6/init.*
  2015/02/13 19:15:15     Started /var/spool/rll/cookbooks/b5debc480f76d0567ea41c7e207c4ef6/init.sh pid=1275

                    # Concurrently with executing the boot bundle, RL has retrieved the managed login information:
  2015/02/13 19:15:15 Get login policy successful; received (2 keys)
  2015/02/13 19:15:15 Users allowed to  login: doug, tve, ...                # users with superuser_login permissions
  2015/02/13 19:15:15 Users skipped for login: curt, jason, ...              # users with just server_login permissions

  2015/02/13 19:15:37     RightScript execution successful                   # end of second recipe
  2015/02/13 19:15:37 +++ Recipe: 'rll::collectd'
  2015/02/13 19:15:37     RS_INSTANCE_UUID = '03-9DO9V0RBBV9DD'
  2015/02/13 19:15:37     COLLECTD_SERVER = 'sketchy1-60.rightscale.com'
  2015/02/13 19:15:37     Cookbook: rll, Script: collectd
  2015/02/13 19:15:37       Searching /var/spool/rll/cookbooks/b5debc480f76d0567ea41c7e207c4ef6/collectd.*
  2015/02/13 19:15:37     Started /var/spool/rll/cookbooks/b5debc480f76d0567ea41c7e207c4ef6/collectd.sh pid=1335
  2015/02/13 19:16:01 HTTP proxy: POST /api/tags/multi_add                   # RL10 logs the HTTP proxy request made
  2015/02/13 19:16:02 PROXY HTTP POST /api/tags/multi_add -> 204 No Content  # by script to set the monitoring-active tag
  2015/02/13 19:16:02     RightScript execution successful
  2015/02/13 19:16:05 State update (operational) successful                  # RL10 transitions the server to operational
  2015/02/13 19:16:05 Entering main loop
  ~~~
