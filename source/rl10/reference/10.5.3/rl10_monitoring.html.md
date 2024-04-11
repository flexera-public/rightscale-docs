---
title: RightLink Monitoring and Alerts
description: This document describes the steps for setting up monitoring and alerts with RightLink 10. With RightLink 10.1.2 and newer, monitoring and alerts are handled by RightScale Time Series Storage, or TSS.
version_number: 10.5.3
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_monitoring.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_monitoring.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_monitoring.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_monitoring.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_monitoring.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_monitoring.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_monitoring.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_monitoring.html
---

## Overview

With RightLink 10.1.2 and newer, monitoring and alerts are handled by RightScale Time Series Storage, or TSS. TSS is the name for the back-end system for aggregating, displaying, and acting on monitoring data via alerts. TSS is built to work with collectd and HTTPS. This document describes the steps for setting up monitoring and alerts with RightLink 10.

### Requirements
  1. RightLink 10.1.2 or newer
  2. TSS enabled for your account. Contact RightScale Support if not enabled.
  3. Collectd 4.8 or newer (Linux)

### TSS vs Sketchy

RightLink versions prior to 10.1.2 used a different back-end system (Sketchy servers) with a number of limitations. The Sketchy system only worked with Collectd 4 and only accepted UDP traffic. The Sketchy system had some shortcomings, such as UDP traffic not working well with proxies, firewalls, and not being easy to send data securely. For TSS, UDP is supported for backwards compatibility, but HTTPS is strongly preferred. The RightLink process runs a [proxy](rl10_local_and_proxied_http_requests.html) for collectd data on the instance. Collectd data is first sent to the RightLink process on the instance over HTTP. RightLink then adds authentication headers and forwards the monitoring data onto the TSS back-end over HTTPS.

## Linux Setup Procedure

On Linux, monitoring is built on top of collectd, which sends data to the local RightLink process. As a reference, see the [RL10 Linux Enable Monitoring](https://github.com/rightscale/rightlink_scripts/blob/master/rll/enable-monitoring.sh) script which ships as part of "RightLink Linux 10.X.X Base" ServerTemplate (ST). The following steps are performed by this ServerTemplate:

1. **Install collectd**. Collectd 4 and 5 are both supported, though there are differences between them (see [caveats](#usage-caveats)). For RedHat based systems (AWS Linux, CentOS, Fedora, Oracle Linux, etc.) the collectd packages may be found in the [Fedora Extra Packages for Enterprise Linux](https://fedoraproject.org/wiki/EPEL) (EPEL) repository.
2. **Configure any [collectd plugins](https://collectd.org/wiki/index.php/Category:Plugins) needed**. The Base ST configures syslog, interface, cpu, df, disk, memory, load, processes, users and swap plugins by default.
3. **Configure the "write_http" plugin to post data to the RightLink process**. The RightLink process has a HTTP server on a random high port recorded as RS_RLL_PORT in /var/run/rightlink/secret. Sample contents of plugin config, assuming collectd 5 is running. If 4 is running, change the collectdv5 to collectdv4:

  ~~~ xml
    LoadPlugin "write_http"
    <Plugin "write_http">
      URL "http://127.0.0.1:54312/rll/tss/collectdv5"
    </Plugin>
  ~~~

4. **Configure collectd**. The "Hostname" value in the collectd config must be set to ENV:RS_INSTANCE_UUID variable passed in through the ServerTemplate config, formatted like this: 01-3IPDVL6CR0FSK. FQDNLookup must be false as this is a UUID type value and not a FQDN. This value may also be found on the Info tab of your Server. Use the default 20 second interval.
5. **Add `rs_monitoring:state=auth` tag to the Server**. Note that this tag has changed slightly. For pre-TSS accounts, this tag was rs_monitoring:state=active.

### Alternative Linux Monitoring Setup

Some Linux OSs do not have a standard install for collectd, such as CoreOS. By default, running the [RL10 Linux Enable Monitoring](https://github.com/rightscale/rightlink_scripts/blob/master/rll/enable-monitoring.sh) script on CoreOS will install native RightLink monitoring.  With this method of monitoring, RightLink will obtain the same metrics from the operating system as the default install of collectd5 on Ubuntu 14.04 and pass it to TSS.  A caveat of using this method of monitoring is the inability to use collectd plugins except those supported by [Custom Monitoring Plugins with Built In Monitoring](#custom-monitoring-plugins-with-built-in-monitoring).

## Windows Setup Procedure

On Windows, monitoring is built into RightLink. It currently monitors CPU usage, memory usage, disk usage, and network traffic. The monitoring metric names are similar to those of Collectd 5 and has some plugin support with [Custom Monitoring Plugins](#custom-monitoring-plugins-with-built-in-monitoring). As a reference, see the [RL10 Windows Enable Monitoring](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/enable-monitoring.ps1) script which ships as part of the "RightLink Linux 10.X.X Base" ServerTemplate (ST). The following step is performed by this ServerTemplate:

1. **Enable Monitoring**. This can be done with the RightScale API client (rsc), a Go-based API client that ships with RightLink: `rsc rl10 update /rll/tss/control enable_monitoring=all`. This request tells RightLink to start sending monitoring data to TSS and also adds the `rs_monitoring:state=auth` tag to the server.

## Alerts

The RightLink 10 Linux and Windows Base ServerTemplates each come with a set of best practice alert specifications which
are used with the [RightScale Alert System](/cm/rs101/rightscale_alert_system.html). Most of these alerts use monitoring
metrics sent by Collectd or the built-in RightLink monitoring. These alerts can be seen on the Alerts tab of the
ServerTemplates on the Cloud Management dashboard and they are defined in the [rightscale/rightlink_scripts repository]
in the Alerts sections of [rll/base.yml] \(Linux) and [rlw/base.yml] \(Windows) which are ServerTemplate YAML files that
can be used with the [Right ST Tool](rl10_storing_scripts_in_git_svn.html#right-st-tool-method).

[rightscale/rightlink_scripts repository]: https://github.com/rightscale/rightlink_scripts/blob/master/rll/base.yml
[rll/base.yml]: https://github.com/rightscale/rightlink_scripts/blob/master/rll/base.yml
[rlw/base.yml]: https://github.com/rightscale/rightlink_scripts/blob/master/rlw/base.yml

Since these ServerTemplates support multiple clouds and operating system distributions as wells supporting both Collectd
4 and 5 on Linux, the monitoring metrics sent from a RightScale instance running RightLink might not match those in the
alert specifications of the ServerTemplate so the ServerTemplates also provide RightScripts which make the necessary
changes to the alerts on the instance so they match the monitoring metrics which will actually be sent.

On Linux, the [RL10 Linux Setup Alerts](https://github.com/rightscale/rightlink_scripts/blob/master/rll/setup-alerts.sh)
RightScript may modify the following alerts:

* **rs low space in root partition**: If a Linux system is running collectd 4, the metric used for this alert will be
  set to `df/df-root.free` rather than `df-root/df_complex-free.value`.
* **rs high network tx activity** and **rs high network rx activity**: On newer Linux distribution versions (such as
  CoreOS and Ubuntu 16.04) the network interface name is not necessarily `eth0` and there may be more network
  interfaces on the system, so this script will update and add the alerts to match the network interfaces on the
  system.
* **rs low swap space**: If no swap is set up on a Linux system, no swap metrics will be sent. If you enable swap on
  the system at a later point, this script can be rerun to re-enable the alert.

On Windows, the [RL10 Windows Setup Alerts](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/setup-alerts.ps1)
RightScript may modify the following alerts:

* **rs high network tx activity** and **rs high network rx activity**: On Windows the network interface name comes from
  the name of the emulated or virtualized network interface driver which differs between hypervisors and clouds and
  there may be more network interfaces on the system, so this script will update and add the alerts to match the
  network interfaces on the system

## Viewing/Accessing Data

Monitoring graphs should now show up on the "Monitoring" tab of your Server in the Cloud Management dashboard. Alerts may be set up on the "Alerts" tab of your Server. Metrics, alerts and alert actions may be viewed or set via API 1.5: [MonitoringMetric](http://reference.rightscale.com/api1.5/resources/ResourceMonitoringMetrics.html), [Alerts](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html), [AlertSpecs](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html).

## Custom Monitoring Plugins with Built In Monitoring

RightLink's built in monitoring has support for running custom monitoring plugins that are compatible with [collectd's Exec plugin](https://collectd.org/wiki/index.php/Plugin:Exec). For Linux these can be scripts in any installed scripting language and on Windows they can be PowerShell scripts. Just like collectd, RightLink passes in the `COLLECTD_HOSTNAME` (the RightScale instance UUID) and `COLLECTD_INTERVAL` (the monitoring interval in seconds; the defaults is 20) environment variables and expects the scripts to run continuously, but will restart them if they exit at the next monitoring interval.

Here is an example of a Bash script which would be used on Linux:

  ~~~ bash
  #!/bin/bash
  while true; do
    NOW=`date +%s`
    VALUE=do_magic()
    printf "PUTVAL %s/exec-magic/gauge-magic_level interval=%d %d:%g\n" $COLLECTD_HOSTNAME \
      $COLLECTD_INTERVAL $NOW $VALUE
    sleep $COLLECTD_INTERVAL
  done
  ~~~

And, here is an example of a PowerShell script which would be used on Windows:

  ~~~ powershell
  while ($true) {
    $now = [int](Get-Date -UFormat %s)
    $value = Do-Magic()
    Write-Output ("PUTVAL {0}/exec-magic/gauge-magic_level interval={1:d} {2:d}:{3:g}" -f \
      $env:COLLECTD_HOSTNAME, $env:COLLECTD_INTERVAL, $now, $value)
    Sleep $env:COLLECTD_INTERVAL
  }
  ~~~

These custom monitoring scripts can be configured to be run by RightLink through its [HTTP interface](rl10_local_and_proxied_http_requests.html#http-requests-handled-by-rightlink10-itself). The HTTP interface has actions for adding/updating, listing, and removing scripts from the configuration. RightLink stores this configuration so the scripts will be started again if the RightLink service is restarted, but a boot RightScript on a ServerTemplate should be used to ensure it is configured on instance reboot or relaunch. The [RSC](https://github.com/rightscale/rsc) utility which comes with RightLink is the recommended tool for working with the HTTP interface.

Here is an example RightScript that would install our example monitoring script from an attachment and configure it to run under RightLink on Linux:

  ~~~ bash
  #!/bin/bash
  magic_dir='/opt/magic_monitoring'
  magic_script='magic.sh'
  magic_path="$magic_dir/$magic_script"
  sudo install -D "$RS_ATTACH_DIR/$magic_script" $magic_path
  rsc rl10 create /rll/tss/exec/magic executable=$magic_path
  ~~~

And, here is an example RightScript that would install our example monitoring script from an attachment and configure it to run under RightLink on Windows:

  ~~~ powershell
  $magicDir = 'C:\Program Files\Magic Monitoring'
  $magicScript = 'magic.ps1'
  $magicPath = "$magicDir\$magicScript"
  New-Item $magicDir -ItemType Directory
  Copy-Item "${env:RS_ATTACH_DIR}\$magicScript" $magicPath
  rsc rl10 create /rll/tss/exec/magic executable=$magicPath
  ~~~

If the `do_magic` or `Do-Magic` functions existed, running one of these RightScripts on an instance with RightLink 10 monitoring enabled would start showing a `gauge-magic_level` graph under `exec-magic` on the Monitoring tab for the server in the RightScale dashboard.

Some example RightScripts with accompanying monitoring scripts for Windows are available in the [rightscale/rightlink_scripts repository](https://github.com/rightscale/rightlink_scripts):

* [SYS IIS monitoring install](https://github.com/rightscale/rightlink_scripts/blob/master/rlw-examples/iis-monitoring.ps1) installs and configures [iis-monitor.ps1](https://github.com/rightscale/rightlink_scripts/blob/master/rlw-examples/attachments/iis-monitor.ps1) which monitors Microsoft ISS.
* [DB SQLS Install monitors](https://github.com/rightscale/rightlink_scripts/blob/master/rlw-examples/mssql-monitoring.ps1) installs and configures [mssql-monitor.ps1](https://github.com/rightscale/rightlink_scripts/blob/master/rlw-examples/attachments/mssql-monitor.ps1) which monitors Microsoft SQL Server.

## Troubleshooting

If collectd graphs do not appear to be populating, try the following steps:
1. Check the RightLink main process audit log (RightLink 10.X.X log pid NNNN). This should note if data was posted.
2. Run `collectd -T` to check the collectd process configuration. It should return an error or an empty string/status success.
3. Check for the `rs_monitoring:state=auth` tag.
4. Check the collectd config -- the write_http plugin configuration should post to the port specified in /var/run/rightlink/secret.

## Caveats

TSS supports both collectd 4 and 5. There are differences between the versions. See [Collectd v4 to v5 migration guide](https://collectd.org/wiki/index.php/V4_to_v5_migration_guide) for differences in plugin config and data formats. Some of the metric names have changed and will display differently in the dash and will be be different if selected for Alerts or polled [via the API](http://reference.rightscale.com/api1.5/resources/ResourceMonitoringMetrics.html). For example 'interface/if_octets-eth0' was changed to 'interface-eth0/if_octets'.
