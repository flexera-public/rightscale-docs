---
title: Incompatibilities with RightLink 6
description: Describes the breaking changes introduced with RightLink 10 including incompatibilities with RightLink 6.
version_number: 10.6.0
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_incompatibilities_with_rl6.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_incompatibilities_with_rl6.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_incompatibilities_with_rl6.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_incompatibilities_with_rl6.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_incompatibilities_with_rl6.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_incompatibilities_with_rl6.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_incompatibilities_with_rl6.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_incompatibilities_with_rl6.html
---

RightLink 10 breaks compatibility with previous versions of RightLink in areas where cloud usage and technology has changed to the point that the old functionality is no longer compatible with best practices. It is important to remember that with most RightLink 10 usage, RightScripts are intended to help kick off other configuration management processes and are not meant to be the sole configuration management system that they used to be.

### Reduced user-data
User-data only contains the strictly necessary parameters: account, api_hostname, client_id, client_secret for authentication and optionally contact_email, auto_launch, expected_public_ip, http_proxy, and no_proxy for other purposes.

### Reduced RightScript environment
The environment of RightScripts is reset to the same values of cron jobs and augmented only with: (a) the script inputs, (b) the user-data, (c) RS_ATTACH_DIR, RS_SELF_HREF, and (d) explicit global environmental variables set by the user. Most notably, RS_REBOOT and RS_DISTRO are not set. Instead of using these variables, write idempotent scripts using the capabilities of the shell, such as testing for the presence of files. Dispatch based on the presence of tools or file system locations you need instead of a OS type variable.

### No package installation
The "package" field in RightScripts is ignored in RightLink 10.

### No frozen mirrors
Frozen mirrors are ignored as RightLink 10 does not set-up OS mirrors. RightScripts should be used to make desired changes to OS mirror configuration.

### Run decommission scripts during OS shutdown
The shutdown sequence is always: tell the OS to shut down or reboot, the OS initiates its shutdown sequence, RightLink 10 is told to exit as part of this sequence, it runs the decommission scripts and exits when they are done. The decommission sequence is thus subject to any timeouts applied by the OS. This methodology ensures a single consistent shutdown procedure.

### No built-in support for Chef
Chef is not supported as a built-in in RightLink 10, it can be plugged in externally or a RightScript can be used to run Chef Solo or Chef Client.

### No automatic attachment of volumes
RightLink 10 ignores volume attachment info in the boot bundle. Attach volumes using cloud-init or some other mechanism such as RightScripts.

### No hiding of credentials in audit entries
The script logs are not filtered to hide the value of credentials before the logs are sent to audit entries.

### rs_tag, rs_state, etc commands
The specific rs_* commands are gone. RightLink 10 (starting with 10.1.2) now ships with rsc, the [RightScale Client command line tool](https://github.com/rightscale/rsc/tree/master). See the [Github repo for Base ServerTemplate](https://github.com/rightscale/rightlink_scripts) and [Local and Proxied HTTP Requests](rl10_local_and_proxied_http_requests.html) for examples of tool usage.

### RightScript audits
RightLink10 uses different strings for audit entry summaries than RightLink 6 when running RightScripts. With RightLink10, the audit summary will start with `Completed:` if the script completed successfully and `Aborted:` if the script failed to complete successfully (i.e. returned a non-zero exit code). If the script fails during the boot sequence, the summary will start with `Stranded:`. When the audit entry is first created as the script starts running, and while it's running, the audit summary will start with `RightScript: <script_name>`.

### RightScript output not logged to local filesystem
Standard output (STDOUT) and standard error (STDERR) of scripts are sent to [Audit Entries](/cm/dashboard/reports/audit_entries/). Redirecting of STDOUT and STDERR can be [coded into the script](rl10_script_execution.html#background-script-standard-output--stdout--and-standard-error--stderr-).
