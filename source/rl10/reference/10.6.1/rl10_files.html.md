---
title: RightLink Installation and Configuration Files
description: The installation of RightLink 10 consists of a statically compiled Go binary with supporting binaries, scripts, and configuration files. System configuration files are also updated to allow RightLink to function within the operating system.
version_number: 10.6.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_files.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_files.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_files.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_files.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_files.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_files.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_files.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_files.html
---

## Overview

The installation of RightLink 10 consists of a statically compiled Go binary with supporting binaries, scripts, and configuration files. System configuration files are also updated to allow RightLink to function within the operating system. Details of the installation is below.

### Linux
* Starting with 10.1.rc0, [RightLink runs as the "rightlink" user](rl10_non_root.html). `useradd` is used to create the "rightlink" user and group.
* Installing RightLink 10 for RCA-V includes additional networking scripts and configuration files. View the [Advanced Networking for vSphere (Files/Linux section)](rl10_rcav.html#files-linux) document for details.
* Enabling "Managed Login" includes other files specific to that feature. View the [Managed SSH Login](rl10_managed_ssh_login.html) document to see that list.

The following items are created or updated upon the installation of RightLink 10 on Linux:

Filepath | Format | Purpose |
---- | ------ | ------- |
/var/lib/rightscale-identity | bash-style VAR=value assignments | Provide information for RightLink to connect to the RightScale platform. This file is created through cloud-init or the rightlink.enable.sh script with root only permissions. |
/var/lib/rightlink | directory | Directory to store data files. Created with rightlink write-only permissions. |
/var/run/rightlink | directory | Run-time variable data directory. Created with rightlink only permissions. |
/var/run/rightlink/secret | bash-style VAR=value assignments | Provide [local/proxy](rl10_local_and_proxied_http_requests.html) secrets to other scripts/programs running on the instance, such as rsc. This file is created with rightlink only permissions. |
/var/run/rightlink/state | JSON | Stores state information about RightLink. |
/var/spool/rightlink | directory | Directory to store attachments, scripts (code). Created with rightlink only permissions. |
/usr/local/bin/rightlink | Binary | RightLink executable |
/usr/local/bin/rsc | Binary | RightScale API client executable |
/var/log/rightlink.log | Log file | RightLink installation log. Created with root-only permissions. |
/var/log/upstart/rightlink.log<br>journalctl -u rightlink | Log file | The "rightlink" process logs to standard output. This log is also duplicated in the Server's audit entries as an entry named named "RightLink 10 &lt;version&gt; log pid &lt;process pid&gt;". Each init system captures standard out differently. For Upstart, see /var/log/upstart/rightlink.log. For Systemd, use `journalctl -u rightlink`. |
/etc/init/rightlink.conf<br>/etc/init.d/rightlink<br>/etc/systemd/system/rightlink.service | Service config files | Service config files |
/etc/cron.d/rightlink-upgrade | crontab | Created by RL10 Linux Upgrade base ServerTemplate script to periodically upgrade RightLink |
/home/rightlink | Home directory | Default $HOME dir for RightScript executions. |
/etc/sudoers | Sudo config | Update to include configuration files in /etc/sudoers.d/ directory, 90-rightscale is located. |
/etc/sudoers.d/90-rightscale | Sudo config | Sudo configuration for the rightlink (rightlink service) user. Default configuration provides unrestricted sudo permission. |



### Windows
* Starting with 10.2.1, user runs under a configurable account which defaults to an Administrative account named "RightLink".
* Installing RightLink 10 for RCA-V includes additional networking scripts and configuration files. View the [Advanced Networking for vSphere (Files/Windows section)](rl10_rcav.html#files-windows) document for details.

The following items are installed upon the installation of RightLink 10 on Windows:

Filepath | Format | Purpose |
---- | ------ | ------- |
C:\ProgramData\RightScale\RightLink | directory | Run-time variable data directory |
C:\ProgramData\RightScale\RightLink\rightscale-identity | VAR=value assignments | Provide information for RightLink to connect to the RightScale platform. This file is created through the Ec2ConfigService or rightlink.enable.ps1 script. The values are fed into the NSSM service. |
C:\ProgramData\RightScale\RightLink\secret | VAR=value assignments | Provide [local/proxy](rl10_local_and_proxied_http_requests.html) secrets to other scripts/programs running on the instance, such as rsc.exe. This file is created with rightlink only permissions. |
C:\ProgramData\RightScale\RightLink\state | JSON | Stores state information about RightLink. |
Temp dir for "RightLink" user | directory | Directory to store attachments, scripts (code). |
C:\Program Files\RightScale\RightLink | directory | Install directory for binaries, Powershell scripts, and logs |
C:\Program Files\RightScale\RightLink\nssm.exe | Binary | Non-Sucking Service Manager, used to manage the RightLink service. |
C:\Program Files\RightScale\RightLink\rightlink.exe | Binary | RightLink executable |
C:\Program Files\RightScale\RightLink\rsc.exe | Binary | RightScale API client executable |
C:\Program Files\RightScale\RightLink\userdata-fetcher.ps1 | Powershell script | The equivalent of cloud-init for windows. Runs at startup to fetch userdata containing RightScale instance credentials from the cloud |
C:\Program Files\RightScale\RightLink\Logs\install.log | Log file | RightLink install log. |
C:\Program Files\RightScale\RightLink\Logs\userdata-fetcher.log | Log file | Userdata fetcher script logs to here. |
C:\Program Files\RightScale\RightLink\Logs\rightlink.log | Log file | RightLink program log. |
Scheduled task | Scheduled task | Created by RL10 Windows Upgrade base ServerTemplate script to periodically upgrade RightLink |
C:\Users\Rightlink | Home directory | Home dir for the "RightLink" user, selected or created at installation time |
RightLink | Windows service | Runs rightlink executable (rightlink.exe) |
RightLinkUserData | Windows service | Fetches userdata by calling userdata-fetcher.ps1, then start RightLink service |
