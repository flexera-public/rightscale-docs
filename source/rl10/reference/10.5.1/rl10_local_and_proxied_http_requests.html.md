---
title: Local and Proxied HTTP Requests
description: Guidelines and steps for performing local and proxied HTTP requests in the context of RightLink 10.
version_number: 10.5.1
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_local_and_proxied_http_requests.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_local_and_proxied_http_requests.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_local_and_proxied_http_requests.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_local_and_proxied_http_requests.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_local_and_proxied_http_requests.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_local_and_proxied_http_requests.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_local_and_proxied_http_requests.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_local_and_proxied_http_requests.html
---

RightLink 10 supports a number of local HTTP requests that broadly fall into two categories. For requests starting with `/api`, RightLink 10 acts as a proxy to the RightScale platform with added authentication (using the instance role that RightLink 10 is granted when it starts up). For requests starting with `/rll`, RightLink 10 itself handles the request. These requests are generally related to configuration or information related to RightLink 10 itself.

## Performing Requests

RightLink 10 listens on a local ephemeral port and requires a special header to be passed for authorization. Both the port and token can be found in `/var/run/rightlink/secret` (Linux) and `C:\ProgramData\RightScale\RightLink` (Windows). If using curl or a similar tool, it is suggested that scripts source that file to populate environment variables. Requests must include an X-RLL-Secret authorization header with the values from the secret file.

Starting with RightLink 10.1.2, RightLink 10 ships with a command line client for making API requests called [RSC](https://github.com/rightscale/rsc), installed at `/usr/local/bin/rsc` (Linux) and `C:\Program Files\RightScale\RightLink\rsc.exe` (Windows). On the command see `rsc rl10 actions` for a list of available local requests handled by RightLink 10. See `rsc --rl10 cm15 actions` for a list of available RightScale API 1.5 actions. For requests proxied by RightLink 10, the credentials of the instance are used, which will be limited to a small subset of API 1.5 calls -- see below for details.

## HTTP Requests Proxied by RightLink 10

RightLink 10 may proxy [API 1.5](http://reference.rightscale.com/api1.5/index.html) requests using its own credentials making it simpler for scripts to perform operations such as adding tags to the instance, attaching volumes, etc. For requests proxied by RightLink 10, the credentials of the instance are used, which will be limited to a small subset of API 1.5 calls, denoted as having a [required role of instance](http://reference.rightscale.com/api1.5/resources/ResourceTags.html#by_tag_required_roles). The following API 1.5 resources and actions are allowed:

| API Resource | Actions allowed |
| ------------ | --------------- |
| [AlertSpecs](http://reference.rightscale.com/api1.5/resources/ResourceAlertSpecs.html) | index, show, create, update, destroy |
| [Alerts](http://reference.rightscale.com/api1.5/resources/ResourceAlerts.html) | index, show, quench, enable, disable |
| [AuditEntries](http://reference.rightscale.com/api1.5/resources/ResourceAuditEntries.html) | index, create, update, append, detail |
| [Backups](http://reference.rightscale.com/api1.5/resources/ResourceBackups.html) | index, show, create, update, cleanup, destroy, restore | |
| [InstanceCustomLodgements](http://reference.rightscale.com/api1.5/resources/ResourceInstanceCustomLodgements.html) | index, show, create, update, destroy |
| [Instances](http://reference.rightscale.com/api1.5/resources/ResourceInstances.html) | index, show |
| [Sessions](http://reference.rightscale.com/api1.5/resources/ResourceSessions.html) | index_instance_session |
| [Tags](http://reference.rightscale.com/api1.5/resources/ResourceTags.html) | by_tag, by_resource, multi_add, multi_delete |
| [Tasks](http://reference.rightscale.com/api1.5/resources/ResourceTasks.html) | show |
| [VolumeAttachments](http://reference.rightscale.com/api1.5/resources/ResourceVolumeAttachments.html) | index, show, create, destroy |
| [VolumeSnapshots](http://reference.rightscale.com/api1.5/resources/ResourceVolumeSnapshots.html) | index, show, create, destroy |
| [VolumeTypes](http://reference.rightscale.com/api1.5/resources/ResourceVolumeTypes.html) | index, show |
| [Volumes](http://reference.rightscale.com/api1.5/resources/ResourceVolumes.html) | index, show, create, destroy |

### Examples

The following sample code sets a tag on the current instance. Note the code must be run from a RightScript as RS_SELF_HREF is automatically populated for RightScripts and is equal to the "Instance HREF" available from a Server's info tab in the Cloud Management dashboard.

Using curl on Linux:
  ~~~ bash
  # Add the RightScale monitoring-active tag via curl
  source /var/run/rightlink/secret
  curl -sS -X POST -H X-RLL-Secret:$RS_RLL_SECRET -g \
     "http://127.0.0.1:$RS_RLL_PORT/api/tags/multi_add?resource_hrefs[]=
     $RS_SELF_HREF&tags[]=rs_monitoring:state=auth"
  ~~~

Using rsc on Linux:
  ~~~ bash
  /usr/local/bin/rsc --rl10 cm15 multi_add /api/tags/multi_add
    resource_hrefs[]=$RS_SELF_HREF tags[]=rs_monitoring:state=auth
  ~~~

Using rsc on Windows:
  ~~~ powershell
  & "C:\Program Files\Rightscale\RightLink\rsc.exe" --rl10 cm15 multi_add
    /api/tags/multi_add resource_hrefs[]=$RS_SELF_HREF tags[]=rs_monitoring:state=auth
  ~~~

The following sample code gets the instance state and instance HREF and stores them in the instance_href and instance_state variables:

  ~~~ bash
  RS_SELF_HREF=$(rsc --rl10 cm15 --x1 ':has(.rel:val("self")).href'
    index_instance_session /api/sessions/instance)
  # instance state "booting", "operational", "stranded in booting", "decommissioning"
  instance_state=$(rsc --rl10 cm15 --x1 '.state' index_instance_session
    /api/sessions/instance)
  ~~~

## HTTP Requests Handled by RightLink 10 Itself

The following requests are handled by RightLink 10. The same X-RLL-Secret header is required for authorization.

#### `/rll/upgrade`
  * Function: Relaunch the RightLink process using a specified binary (Linux only)
  * Actions: upgrade
  * Parameters: exec=\<absolute_path_to_binary>
  * Example:

  ~~~ bash
  rsc rl10 upgrade /rll/upgrade exec=/tmp/rightlink
  ~~~

#### `/rll/env`
  * Function: List all global script environment variables
  * Actions: index
  * Parameters: None
  * Example:

  ~~~ bash
  rsc rl10 index /rll/env
  ~~~

#### `/rll/env/:name`
  * Function: Manipulate the global script environment variables
  * Actions: show, update, delete
  * Parameters: payload=\<variable_value>
  * Example:

  ~~~ bash
  rsc rl10 update /rll/env/RS_DISTRO payload=centos
  ~~~

#### `/rll/run/recipe`
  * Function: Synchronously run a recipe attached to ServerTemplate
  * Actions: run_recipe
  * Parameters: recipe=\<recipe_name> arguments\<INPUT_NAME>=\<type:value>
  * Example:

  ~~~ bash
  rsc rl10 run_recipe /rll/run/recipe recipe=rll:setup_automatic_upgrade
    arguments=ENABLE_AUTO_UPGRADE=text:false
  ~~~

#### `/api/right_net/scheduler/schedule_recipe`
  * Function: Asynchronously run a recipe attached to ServerTemplate
  * Actions: schedule_recipe
  * Parameters: recipe=\<recipe_name> arguments\<INPUT_NAME>=\<type:value>
  * Example:

  ~~~ bash
  rsc --rl10 cm15 schedule_recipe /api/right_net/scheduler/schedule_recipe
    recipe=rll::setup_automatic_upgrade
    arguments=ENABLE_AUTO_UPGRADE=text:false
  ~~~

#### `/rll/run/right_script`
  * Function: Synchronously run a RightScript attached to ServerTemplate
  * Actions: run_right_script
  * Parameters: right_script=\<right_script_name> arguments=\<INPUT_NAME>=\<type:value>
  * Example:

  ~~~ bash
  rsc rl10 run_right_script /rll/run/right_script
    right_script="RL10 Linux Setup Automatic Upgrade"
    arguments=ENABLE_AUTO_UPGRADE=text:false
  ~~~

#### `/api/right_net/scheduler/schedule_right_script`
  * Function: Asynchronously run a RightScript attached to ServerTemplate
  * Actions: schedule_right_script
  * Parameters: right_script=\<right_script_name> arguments=\<INPUT_NAME>=\<type:value>
  * Example:

  ~~~ bash
  rsc --rl10 cm15 schedule_right_script /api/right_net/scheduler/schedule_right_script
    right_script="RL10 Linux Setup Automatic Upgrade"
    arguments=ENABLE_AUTO_UPGRADE=text:false
  ~~~

#### `/rll/proc`
  * Function: List all process variables
  * Actions: index
  * Parameters: None
  * Example:

  ~~~ bash
  rsc rl10 index /rll/proc
  ~~~

#### `/rll/proc/:name`
  * Function: List a specific process variable
  * Actions: show
  * Parameters: None
  * Example:

  ~~~ bash
  rsc rl10 show /rll/proc/shutdown_kind
  ~~~

  Of special note is /rll/proc/shutdown_kind, which is available using RightLink 10.1.3 and newer. During decommission, shutdown_kind will be set to "reboot", "stop", or "terminate" if one of these actions was initiated from the RightScale dashboard or API. It will be an empty string if any of those actions was initiated from the server's command line or the cloud's api/console. See [Linux Shutdown Reason](https://github.com/rightscale/rightlink_scripts/blob/master/rll/shutdown-reason.sh) or [Windows Shutdown Reason](https://github.com/rightscale/rightlink_scripts/blob/master/rlw/shutdown-reason.ps1) on how to query if the server is stopping, rebooting, or terminating.

#### `/rll/tss/hostname`
  * Function: Manipulate the hostname associated with TSS
  * Actions: get_hostname, put_hostname
  * Parameters: hostname=\<hostname_value>
  * Example:

  ~~~ bash
  rsc rl10 put_hostname /rll/tss/put_hostname hostname=tss3.rightscale.com
  ~~~

#### `/rll/tss/control`
  * Function: Manipulate the value of monitoring control
  * Actions: show, update
  * Parameters: enable_monitoring=\<control_value> (true, false, none, util, extra, all)
  * Examples:

  ~~~ bash
  rsc rl10 show /rll/tss/control
  ~~~

  ~~~ bash
  rsc rl10 update /rll/tss/control enable_monitoring=true
  ~~~

#### `/rll/tss/exec`
  * Function: List all configured custom monitoring plugin executables
  * Actions: index
  * Parameters: None
  * Example:

  ~~~ bash
  rsc rl10 index /rll/tss/exec
  ~~~

#### `/rll/tss/exec/:name`
  * Function: Add, update, view, or remove a configured custom monitoring plugin executable
  * Actions: create, show, update, destroy
  * Parameters: executable=\<executable_path> arguments[]=\<executable_argument>
  * Examples:

  ~~~ bash
  rsc rl10 create /rll/tss/exec/haproxy-stat executable='/var/run/haproxy-stat'
    arguments[]='-h' arguments[]='localhost'
  ~~~

  ~~~ bash
  rsc rl10 show /rll/tss/exec/haproxy-stat
  ~~~

  ~~~ bash
  rsc rl10 update /rll/tss/exec/harpoxy-stat executable='/var/run/haproxy-stat'
    arguments[]='-h' arguments[]='localhost' arguments[]='-p' arguments[]='20'
  ~~~

  ~~~ bash
  rsc rl10 destroy /rll/tss/exec/haproxy-stat
  ~~~

#### `/rll/docker/control`
  * Function: Manipulate the Docker integration
  * Actions: show, update
  * Parameters: enable_docker=\<control_value> (none, tags, all) docker_host=<docker_host_or_socket_uri>
  * Examples:

  ~~~ bash
  rsc rl10 show /rll/docker/control
  ~~~

  ~~~ bash
  rsc rl10 update /rll/docker/control enable_docker=tags
  ~~~

  ~~~ bash
  rsc rl10 update /rll/docker/control enable_docker=all
  ~~~
