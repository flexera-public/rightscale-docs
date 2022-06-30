---
title: RightLink Files
description: RightLink 10 is a single statically compiled Go binary. Outside of the executable, there are a couple runtime files and a few support files for managing the service, detailed below.
version_number: 10.5.1
versions:
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

RightLink 10 is a single statically compiled Go binary. Outside of the executable, there are a couple runtime files and a few support files for managing the service, detailed below.

### Linux
For Linux, Starting with 10.1.rc0, [RightLink runs as the "rightlink"](rl10_non_root.html) user
under the "rightlink" service account.

Filepath | Format | Purpose |
---- | ------ | ------- |
/var/lib/rightscale-identity | bash-style VAR=value assignments | Provide information for RightLink to connect to the RightScale platform. This file is created through cloud-init or the rightlink.enable.sh script with root only permissions. |
/var/run/rightlink/secret | bash-style VAR=value assignments | Provide [local/proxy](rl10_local_and_proxied_http_requests.html) secrets to other scripts/programs running on the instance, such as rsc. This file is created with rightlink only permissions. |
/var/run/rightlink/state | JSON | Stores state information about RightLink. |
/var/spool/rightlink | directory | Directory to store attachments, cookbooks, scripts (code). Created with rightlink only permissions. |
/usr/local/bin/rightlink | Binary | RightLink executable |
/usr/local/bin/rsc | Binary | RightScale API client executable |
/var/log/rightlink.log | Log file | RightLink installation log. Created with root-only permissions. |
/var/log/upstart/rightlink.log<br>journalctl -u rightlink | Log file | The "rightlink" process logs to standard output. This log is also duplicated in the Server's audit entries as an entry named named "RightLink 10 &lt;version&gt; log pid &lt;process pid&gt;". Each init system captures standard out differently. For Upstart, see /var/log/upstart/rightlink.log. For Systemd, use `journalctl -u rightlink`. |
/etc/init/rightlink.conf<br>/etc/init.d/rightlink<br>/etc/systemd/system/rightlink.service | Service config files | Service config files |
/etc/cron.d/rightlink-upgrade | crontab | Created by RL10 Linux Upgrade base ServerTemplate script to periodically upgrade RightLink |
/home/rightlink | Home directory | Default $HOME dir for RightScript executions. |
/etc/sudoers.d/90-rightscale | Sudo config | Sudo configuration for the rightlink (rightlink service) user. Default configuration provides unrestricted sudo permission. |

Enabling "Managed Login" includes other files specific to that feature. View the [Managed SSH Login](rl10_managed_ssh_login.html) document to see that list.


### Windows
For Windows, Starting with 10.2.1, user runs under a configurable account which defaults to an Administrative account named "RightLink".

Filepath | Format | Purpose |
---- | ------ | ------- |
C:\ProgramData\RightScale\RightLink\rightscale-identity | VAR=value assignments | Provide information for RightLink to connect to the RightScale platform. This file is created through the Ec2ConfigService or rightlink.enable.ps1 script. The values are fed into the NSSM service. |
C:\ProgramData\RightScale\RightLink\secret | VAR=value assignments | Provide [local/proxy](rl10_local_and_proxied_http_requests.html) secrets to other scripts/programs running on the instance, such as rsc.exe. This file is created with rightlink only permissions. |
C:\ProgramData\RightScale\RightLink\state | JSON | Stores state information about RightLink. |
Temp dir for "RightLink" user | directory | Directory to store attachments, cookbooks, scripts (code). |
C:\Program Files\RightScale\RightLink\nssm.exe | Binary | Non-Sucking Service Manager, used to manage the RightLink service. |
C:\Program Files\RightScale\RightLink\rightlink.exe | Binary | RightLink executable |
C:\Program Files\RightScale\RightLink\rsc.exe | Binary | RightScale API client executable |
C:\Program Files\RightScale\RightLink\Logs\install.log | Log file | RightLink install log. |
C:\Program Files\RightScale\RightLink\Logs\userdata-fetcher.log | Log file | Since Windows doesn't come with cloud-init, a userdata fetching script that runs at startup ships with RightLink and logs to here. |
C:\Program Files\RightScale\RightLink\Logs\rightlink.log | Log file | RightLink program log. |
Scheduled task | Scheduled task | Created by RL10 Windows Upgrade base ServerTemplate script to periodically upgrade RightLink |
C:\Users\Rightlink | Home directory | Home dir for the "RightLink" user, selected or created at installation time |
