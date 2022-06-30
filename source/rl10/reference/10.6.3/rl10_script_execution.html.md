---
title: Script Execution
# IMPORTANT: 'alias:' metadata line MUST ONLY BE in LATEST REV, requiring removal of 'alias:' line upon a new latest doc directory revision
alias: [rl/reference/rl10_script_execution.html, rl10/reference/rl10_script_execution.html]
description: Scripts are executed by RightLink 10 as part of a runlist, such as a boot runlist or as operational scripts.
version_number: 10.6.3
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_script_execution.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_script_execution.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_script_execution.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_script_execution.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_script_execution.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_script_execution.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_script_execution.html
---

## Background

Scripts are executed by RightLink 10 as part of a runlist, such as a boot runlist, as operational scripts, or as decommission scripts. Scripts come from RightScripts stored in the RightScale platform (Design > RightScripts menu in the dashboard).

Feature | RightScript |
------- | ---------------------------------- |
Attachments |	`RS_ATTACH_DIR` environment variable set to directory containing all attachments |
Current working directory |	Temporary directory created for each individual script and deleted after the script's termination. |
Interpreter identification in Unix | If the first line starts with '#!/' it is changed to the correct '#! /' (space added) |
Packages |  `RS_PACKAGES` environment variable set to the union of all packages mentioned in the metadata of any RightScript in the runlist. |

### Script Execution Environment

* A few environment variables are pulled from RightLink 10's own environment: `PATH`, `HOME`, `SHELL`, `USER`
* A few environment variables are set by RightLink 10:
    * client_id, account, and api_hostname, http_proxy, no_proxy (these are passed to RightLink 10 as command line flags or environment variables)
    * RS_SELF_HREF is set to the instance's href in RightApi 1.5 (e.g. /api/instances/123456)
    * For RightScripts, `RS_ATTACH_DIR` is set to the directory containing the script's attachments
    * For RightScripts, `RS_PACKAGES` is set to the union of all "packages" listed by any RightScript in the runlist. This can be used to [install packages all at once](https://github.com/rightscale/rightlink_scripts/blob/master/rll-examples/install-packages.sh), near the beginning of the boot sequence, to economize on time spent doing package management. Note that the packages have no meaning to RightScale or RightLink; they are simply whitespace-delimited words to be interpreted by the RightScript that consumes them. The RightScale-provided [example script](https://github.com/rightscale/rightlink_scripts/blob/master/rll-examples/install-packages.sh) implements some suggested semantics for using RightScript package metadata efficiently and in a distro-neutral way
* The RightScript's inputs are assigned to environment variables
* For RightScripts that start with '#!/' (Linux Only).
* For RightScripts that start with '#!/' and the first arrgument contains "powershell" as follows: `#!powershell -Version 2.0` the PowerShell version specified will be used (Windows Only).
* The script is executed by the operating system's `execve` system call, which means that unless the script starts with `#! /some/executable/path` it will not execute (there is no default to execute unmarked files using `$SHELL`)

Note that the script can parse `/var/run/rightlink/secret` to obtain the information necessary to make HTTP requests to RightLink 10 and to RightApi1.5

### Script Termination

* A script is deemed to have finished when the process launched by RightLink 10 exits irrespective of any child processes that may still be running
* The stdout/stderr pipes attached to the script process remain open and RightLink 10 will continue to consume any output produced on them past the script processes' exit (this is possible if the script forks detached child processes) and RightLink 10 will continue to log such output in the audit entry. However, note that such "late" output may become intermixed with the output of successive scripts in the same runlist.
* Script success/failure is determined from the exit code of the script process, specifically 0 => success and non-zero => failure

### Starting Background Processes in Scripts

Any background processes started in a script that are supposed to continue running while letting the script itself exit need to be detached. When using bash a simple way to detach child processes is to launch them using '&' and then detach them using the 'disown' command. Simply 'disown' will detach all child processes. If the background processes are not detached they will be terminated by bash when the script itself exits.  When using powershell a simple way to detach a process is to use the 'Start-Process' command.

### Script Standard Output (STDOUT) and Standard Error (STDERR)

The standard output (STDOUT) and standard error (STDERR) of scripts are sent to [Audit Entries](/cm/dashboard/reports/audit_entries/). If it is desired to have the STDOUT and STDERR of a script sent elsewhere, such as the local filesystem or syslog, this must be coded into the script.

Here is an example of the beginning of a Bash script that sends all STDOUT and STDERR to a file and STDOUT:

~~~ bash
#!/bin/bash
exec > >(tee -a /var/log/script-output.log) 2>&1
echo "Standard Output also sent to file"
echo "Standard Error also sent to file" >&2
~~~

Here is another example of the beginning of a Bash script that sends all STDOUT and STDERR to `logger` only (`logger` is a command used to send messages to syslog):

~~~ bash
#!/bin/bash
exec > >(logger --tag test-script-name) 2>&1
echo "Standard Output redirected to syslog"
echo "Standard Error redirected to syslog" >&2
~~~

### Decommission Runlist

The decommission runlist is executed when RightLink 10 is told that the operating system is shutting down for a reboot, stop, or terminate and during a service restart. It is thus an extension of the operating system's shutdown sequence that runs as part of the init system's shutdown. The decommission runlist is only run if a server has reached an 'operational' or 'stranded' state, which indicates that it has finished executing it's boot bundle. On Windows and Linux, there are differences in when the decommission bundle is run.
  * On Linux, the OS is always told to shut down first. As a result, the OS init system sends a SIGTERM to RightLink which triggers RightLink to run the decommission sequence. Because of this, decommission scripts have a limited amount of time to run determined by the OS init system. This is set to 3 minutes on Linux though may be modified by changing the timeouts in the service config files for upstart/systemd. If setting the timeout to longer than 50 minutes for stop or terminate, see rs_decommissioning:delay tag in [List of Rightcale Tags](/cm/ref/list_of_rightscale_tags.html)
  * On Windows, the decommission runlist is executed before the OS is told to shutdown. This is because Windows has limited dependency management of services during shutdown, and very limited time to stop services. _**RightLink will only execute decommission scripts for Windows if the reboot/terminate/stop was initiated via the RightScale API or dashboard and not if it was executed via the cloud console or on the machine**_. There is no timeout on the running of the decommission bundle in the RightLink code. However, there is a timeout platform side when stopping or terminating instances. See the rs_decommissioning:delay tag in [List of Rightcale Tags](/cm/ref/list_of_rightscale_tags.html). On Windows, it is somewhat more common to do reboots during the boot bundle to install updates or hotfixes. If this is done, it's recommended to issue the shutdown with the <a nocheck href='https://technet.microsoft.com/en-us/library/bb491003.aspx'>shutdown command</a> and then to issue a `try { sleep 60 } finally { sleep 60 }` directly afterwards. The sleep ensures that you continue to pause execution until the terminate signal from the reboot is received by the RightLink process, which can take 10-20 seconds. The finally block is because the currently executing RightScript also receives the terminate signal and will record a spurious failure as a result.
