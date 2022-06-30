---
title: Using RightLink 6
layout: rl6_layout
description: Tips and guidelines for using RightLink 6 in your environment.
---

!!warning*Warning!*RightLink 6 [has been EOL'd](/faq/end_of_life_end_of_service.html#schedule-images-rightlink) - please refer to the [RightLink 10 documentation](/rl10)

## Overview

The following sections will assist you in using RighLink 6.

## Command Line Utilities - v6.3

The following command line utilities are useful for setting and getting information between RightLink enabled images and the RightScale platform. These utilities are available for use on instances with RightLink v5.8 and above, for example, if you are using a RightImage (e.g. RightImage_CentOS_5.6_x64_v5.8) or a custom RightScale-enabled image that includes RightLink v5 and above. If you are using older RightImages, some RightLink utilities might not be supported.

!!info*Note*The RightLink command line utilities are currently not available for RightLink 10

### General Information

RightScale's command line utilities are found in `/usr/bin` on Linux systems.  To see all installed "rs" utilities:

~~~
ls /usr/bin/rs_*
~~~

From within a running instance you can issue a "--help" or "-h" command line flag to see synopsis, example and usage information. For example:

~~~
rs_log_level -h
rs_run_recipe --help
~~~

Below is documentation for the more commonly used RightScale command line utilities for Chef.

**Note**: The following utility also exists in the /usr/bin directory.
* `rs_reenroll`, `rs_thunk`, `rs_connect` - *Not* designed to be used by RightScale customers or partners.  (This is an Internal tool used by RightScale.)

#### Windows Support

Although the example screenshots below are from a Linux system, these command line utilities are part of RightLink on Windows systems as well. Usage is the same as Linux systems. Note that `/usr/bin` is part of the PATH environment variable in Linux and is added to the Windows PATH as well.

### rs_log_level

**Synopsis**

RightScale Log Level Manager (`rs_log_level`)
Log Level Manager allows setting and retrieving the RightLink agent log level.

**Usage**

~~~
rs_log_level [-a] [--log-level, -l debug|info|warn|error|fatal]
~~~

**Options**

| Option Flag | Description |
| ----------- | ----------- |
| --log-level, -l LVL | Set log level of RightLink agent |
| --agent, -a | Apply get/set log level to RightLink agent |
| --verbose, -v | Display debug information |

No options prints the current Chef log level. Note the --agent flag is modal. If it's left off, the Chef log level
if affected. If added on, the agent log level is affected.

**Examples**

Retrieve Chef log level:

~~~
rs_log_level
~~~

Retrieve RightLink agent log level:
~~~
rs_log_level -a
~~~

Set Chef log level to debug. Takes effect next Chef converge:
~~~
rs_log_level --log-level debug
rs_log_level -l debug
~~~

Set RightLink agent log level to debug (needs agent restart to take effect)
~~~
rs_log_level -a -l debug
rs_log_level --agent --log-level debug
~~~

**Note**: You have to be logged in as root to set the log level of the RightLink agent.


### rs_ohai

**Synopsis**

RightScale Ohai (rs_ohai) is an implementation of Ohai by RightScale
rs_ohai is a utility that inspects a running instance and discovers relevant system-specific data.
Usage

**Options**

| Option Flag | Description |
| ----------- | ----------- |
| -d,  --directory DIRECTORY | A directory to add to the Ohai search path |
| -f,  --file FILE | A file to run Ohai against |
| -l,  --log_level LEVEL | Set the log level (debug, info, warn, error, fatal) |
| -L,  --logfile LOGLOCATION | Set the log file location, defaults to STDOUT - recommended for daemonizing |

**Examples**

Retrieve system data:

~~~
rs_ohai
~~~

Retrieve system data with debugging information output:

~~~
rs_ohai --log_level debug
rs_ohai -l debug
~~~

**Note**: most commands invoked by Ohai/Chef are logged with the debug severity for easier debugging of troublesome providers or recipes.


### rs_run_recipe

**Synopsis**

rs_run_recipe is a command line tool that allows running recipes from within
an instance. You can also execute recipes on other instances within
the deployment based upon tags.

**Usage**

~~~
rs_run_recipe --name, -n NAME [--json, -j JSON_FILE]
              [--recipient_tags, -r TAG_LIST]
              [--thread, -t THREAD_NAME][--policy -P POLICY][--audit_period -A SECONDS]
              [--scope, -s SCOPE] [--verbose, -v]
              [--timeout, -T SEC]
~~~

**Options**

| Option Flag | Description |
| ----------- | ----------- |
| --name, -n NAME | RightScript or Chef recipe name (overriden by id) |
| --json, -j JSON_FILE | JSON file name for JSON to be merged into attributes before running recipe |
| --thread, -t THREAD | Schedule the operation on a specific thread name -t THREAD for concurrent execution. Thread names must begin with a letter and can consist only of lower-case alphabetic characters, digits, and the underscore character. |
| --policy, -P POLICY | Audits for the executable to be run will be grouped under the given policy name. All detail will be logged on the instance, but limited detail will be audited. (1) |
| --audit_period -a PERIOD_IN_SECONDS | Specifies the period of time that should pass between audits |
| --recipient_tags, r TAG_LIST | Tag for selecting which instances the script will be run on. Instances must be in the same deployment or in an "account" deployment. "account" deployments are deployments where the "Server tag scope" field on the info tab is set to "account".|
| --scope, -s SCOPE | Scope for selecting tagged recipients: single or all (default all) |
| --timeout, -T SEC| Max time to wait for response from RightScale platform. (default 60 sec) |
| --cfg-dir, -c DIR | Set directory containing configuration for all agents |
| --verbose, -v | Display progress information |

1. thread, policy, and audit_period are often specified together. Policy helps to group audit entries for commonly recurring events, such as Chef converges or scheduled backups.

**Examples**

Run daily database backup on its own thread to avoid blocking normal RightScript execution. Group all audits from same month together.
~~~
rs_run_recipe --name mysql::do_backup --thread backup --policy backup --audit_period 2592000
~~~

Run the recipe, web_apache::do_restart on this server.

~~~
rs_run_recipe --name "web_apache::do_restart"
~~~

Run the recipe, web_apache::do_restart on all servers in deployment with the tag, server:type=app.

~~~
rs_run_recipe --name "web_apache::do_restart" -r "server:type=app" --verbose
~~~

Run the recipe, rightscale::setup_hostname with a created node.json override file:

~~~
# ensure root can only read the json file if on a shared system
touch /root/node.json && chmod -v 770 /root/node.json

# simple bash heredoc for creating the node.json
cat <<EOF> /root/node.json
{
  "rightscale" : {
     "timezone":"Australia/Sydney"
  }
}
EOF

# run rs_run_recipe with the node.json created
rs_run_recipe -v --name="rightscale::setup_timezone" --json /root/node.json
~~~


### rs_run_right_script



**Synopsis**

rs_run_right_script is command line tool that allows running RightScripts
from within an instance. You can also execute RightScripts on other
instances within the deployment based upon tags.

**Usage**

~~~
rs_run_right_script [--identity, -i ID |  --name, -n NAME] --parameter, -p NAME=type:VALUE]*
              [--recipient_tags, -r TAG_LIST]
              [--thread, -t THREAD_NAME][--policy -P POLICY][--audit_period -A SECONDS]
              [--scope, -s SCOPE] [--verbose, -v]
              [--timeout, -T SEC]
~~~

**Options**

| Option Flag | Description |
| ----------- | ----------- |
| --identity, -i ID | RightScript or ServerTemplateChefRecipe id. (e.g., in https://my.rightscale.com/acct/1/right_scripts/12345, 12345 is the ID) |
| --name, -n NAME | RightScript or Chef recipe name (overriden by id) |
| --json, -j JSON_FILE | JSON file name for JSON to be merged into attributes before running recipe |
| --parameter, -p NAME=type:VALUE | Define or override RightScript input. Note: Only applies to run_right_script |
| --thread, -t THREAD | Schedule the operation on a specific thread name for the concurrent execution. Thread names must begin with a letter and can consist only of lower-case alphabetic characters, digits, and the underscore character. |
| --policy, -p POLICY | Audits for the executable to be run will be grouped under the given policy name. All detail will be logged on the instance, but limited detail will be audited. Available with RightLink 5.8 and above. (1) |
| --audit_period, -a PERIOD_IN_SECONDS | Specifies the period of time that should pass between audits. Available with RightLink 5.8 and above. |
| --recipient_tags, -r TAG_LIST | Tag for selecting which instances the script will be run on. Instances must be in the same deployment or in an "account" deployment. "account" deployments are deployments where the "Server tag scope" field on the info tab is set to "account". |
| --scope, -s SCOPE | Scope for selecting tagged recipients: single or all (Default: all) |
| --cfg-dir, -c DIR | Set directory containing configuration for all agents |
| --verbose, -v | Display progress information |

1. thread, policy, and audit_period are often specified together. Policy helps to group audit entries for commonly recurring events, such as Chef converges or scheduled backups.

**Note**: If you use `rs_run_right_script` with the -p option, you must pass a COMPLETE set of input values in which case the input values that are defined on the server are not merged. If you omit any inputs, e.g. do not use -p, then the values defined on the server are used. However we do not provide a way to mix and match.

**Examples**

Run RightScript with an ID of 34 and verbose output:

~~~
rs_run_right_script -i 34 -v
rs_run_right_script --identity 34 --verbose
~~~

Run RightScript with name, 'Install Nginx' and verbose output:

~~~
rs_run_right_script -n "Install Nginx" -v
rs_run_right_script --name "Install Nginx" --verbose
~~~

Run RightScript with and ID of 14 and override the input value for 'APPLICATION' with 'Mephisto':

~~~
rs_run_right_script -i 14 -p "APPLICATION=text:Mephisto"
~~~

Run RightScript, 'Hello World' with credential, 'HelloWorldText' for input, HW_TEXT:

~~~
rs_run_right_script -n "Hello World" -p "HW_TEXT=cred:HelloWorldText"
~~~

Run the "register app server" RightScript on the server that is tagged as being a load balancer. This option takes a space-separated list of one or more tags, which will be used to select one or more target servers on which to run the script or recipe.

~~~
rs_run_right_script -n "APP register app server" -r "app:role=load_balancer"
~~~


Run a phone home script with all audits grouped weekly. Only changes in status of script execution (failure|success) will generate new audit entries.
~~~
rs_run_right_script --name "Phone Home" --thread checker --policy checker --audit_period 86400
~~~



### rs_shutdown

**Usage**

~~~
rs_shutdown [options]
~~~

**Options**

| Option Flag | Description |
| ----------- | ----------- |
| --reboot, -r | Request reboot |
| --stop, -s | Request stop (boot volume is preserved) |
| --terminate, -t | Request termination (boot volume is discarded) |
| --immediately, -i | Request immediate shutdown (reboot, stop or terminate) by passing any pending scripts and preserving instance state |
| --deferred, -d | Request deferred shutdown (reboot, stop or terminate) pending finishing of any remaining scripts (default) |
| --verbose, -v | Display progress information |


### rs_tag

**Synopsis**

RightScale Tagger (rs_tag) - Tagger allows listing, adding and removing tags on the current instance and querying for all instances with a given set of tags.

**Note**: Spaces in tags are not supported in RightLink v5.7 and earlier.

**Usage**

~~~
rs_tag (--list, -l | --add, -a TAG | --remove, -r TAG | --query, -q TAG_LIST)
~~~

**Options**

| Option Flags | Description |
| ------------ | ----------- |
| --list, -l | List current instance tags |
| --add, -a TAG NAME | Add tag NAME. |
| --remove, -r TAG NAME | Remove tag NAME |
| --query, -q TAG_LIST | Query tag information about instances in your deployment |
| --die, -e | Exit with error if query/list fails |
| --format, -f FMT | Output format: json, yaml, text |
| --verbose, -v | Display debug information |
| --timeout, -t | Custom timeout parameter (Default = 120 seconds) |

**Examples**

Retrieve all tags:

~~~
rs_tag --list
rs_tag -l
~~~

Add tag 'opinions:tags=awesome' to instance:

~~~
rs_tag --add 'opinions:tags=awesome'
rs_tag -a 'opinions:tags=awesome'
~~~

Remove tag 'opinions:tags=awesome' from instance:

~~~
rs_tag --remove 'opinions:tags=awesome'
rs_tag -r 'opinions:tags=awesome'
~~~

Get and print last tag value for 'opinions:tags':

~~~
tag=$(rs_tag --list | grep 'opinions:tags' | head -n 1) && tag_value=${tag##*=}
echo 'Opinion on tags: '"$tag_value"
~~~

Remove all tags:

~~~
for i in `rs_tag --list --format text`; do $(rs_tag --remove $i) ; done
~~~

In a RightScript, manage a unique tag 'on itself' using an Input value:

~~~
#!/bin/bash -e

# RightScript: Set node DNS hostname tag

# NODE_HOSTNAME can be set to any type text, environment variable, credential etc.
# e.g. EC2_PUBLIC_HOSTNAME

# remove any existing rs_node:dns_hostname tags
tags_remove=$(rs_tag --list --format yaml| grep 'rs_node:dns_hostname' | awk '{ print $2 }')

# remove existing tags
for tag in $tags_remove; do
  echo Removing "$tag"
  rs_tag --remove "$tag"
done

# Add rs_node dns hostname tag
rs_tag --add 'rs_node:dns_hostname='"$NODE_DNS_HOSTNAME"

# get and print 1st/last set rs node dns hostname
tag=$(rs_tag --list --format yaml| grep 'rs_node:dns_hostname' | head -n 1) && node_dns_hostname=${tag##*=}
echo 'Current/latest node dns hostname: '"$node_dns_hostname"

echo 'Done.'
~~~

**Querying for tags:**

Use `rs_tag` with the `--query, -q TAG_LIST` to query tag information about instances in your deployment only. A query will not return instances that are in a different deployment. `TAG_LIST` is a space-delimited list of machine tags. You can use some wildcard functions in the `TAG_LIST` by substituting an asterisk (\*) for the value part of the machine tag -- for example, `rs_tag -q "loadbalancer:app=\*"`.

**Note**: This is not a fully supported wildcard function. Semi-wildcard functions will not work, such as rs_tag -q "loadbalancer:app=prod*"

This returns a JSON object to stdout with the following syntax:

~~~
{ <agentA_id> : { "tags": [ <tag_n> ] } }
~~~
~~~
# rs_tag --query "rs_logging:state=*"
{
  "rs-instance-05c03c0150c3b55b83a63b4eb8c0f2af5156d8ea-5013179": {
    "tags": [
      "rs_launch:type=auto",
      "rs_logging:state=active",
      "rs_login:state=active",
      "rs_monitoring:state=active"
    ]
  },
  "rs-instance-00f2710adb07e72bbabf42092c93c675098a9ef0-5013178": {
    "tags": [
      "rs_launch:type=auto",
      "rs_logging:state=active",
      "rs_login:state=active",
      "rs_monitoring:state=active"
    ]
  },
  "rs-instance-71334da6925feee899ee1e5d58cc8c8b2423a59a-5325028": {
    "tags": [
      "rs_logging:state=active",
      "rs_login:state=active",
      "rs_monitoring:state=active"
    ]
  }
}
~~~

Please note that this is not a full wildcard function. You will receive an error if you attempt to enter the following:

~~~
# rs_tag --query "rs_logging:sta*"
# rs_tag --query "rs_logging:*"
# rs_tag --query "rs_logg*"
~~~

Any of these will instead produce an error about an invalid wildcard statement.


### rs_config

**Synopsis**

RightScale configuration manager (rs_config) - Allows to get, set and list [feature configuration values](rl6_using.html#feature-control).

**Usage**

~~~
rs_config (--list, -l | --set name value | --get name)
~~~

**Options**


| Option Flags | Description |
| ------------ | ----------- |
| --list, -l | Lists features and values. Features are: managed_login_enable, package_repositories_freeze,motd_update, decommission_timeout |
| --format, -f FMT | Output format for list operation(json, yaml, text) |
| --set, -s <name> <value> | Set feature name to specified value. Valid values: integer for decommission_timeout. on/true, off/false for rest of features |
| --get, -g <name>| Outputs the value of the given feature to stdout |

**Examples**

~~~
   # Disable managed login. Only takes effect if set prior to boot (during image rebundle).
   rs_config --set managed_login_enable off

   # Set decommission timeout. Must be set before the decommission bundle is run!
   rs_config --set decommission_timeout 180

   # Get decommission timeout:
   rs_config --get decommission_timeout
~~~


### rs_state

**Synopsis**

RightScale run state reporter (rs_state) - Report current run state of an instance

**Usage**

~~~
rs_state --type <agent|run>
~~~

**Options**

| Option Flags | Description |
| ------------ | ----------- |
| --type, -t TYPE | Display desired state (run or agent) |
| --verbose, -v | Display progress information |


**Examples**
~~~
   # Print the run state:
   # Possible values: booting, booting:reboot, operational, stranded,
   #                  shutting-down:reboot, shutting-down:terminate, shutting-down:stop
   rs_state --type run


   # Print the agent state:
   # Possible values: pending, booting, operational, stranded,
   #                  decommissioning, decommissioned
   rs_state --type agent
~~~


## NTP Time Synchronization

RightLink 6.x enables more flexible and reliable time synchronization between instances and RightLink. RightLink-enabled instances need to have an accurate system clock (+/- 3 minutes) in order to allow reliable, ordered delivery of control messages. Sometimes the cloud's Hypervisor time is not always configured correctly or properly configured for NTP time synchronization. In order to help ensure that an instance has the correct time, RightLink initiates a time sync on boot using the operating system's NTP services.​

RightLink Enhancements:

* Modified NTP resolution algorithm for both Linux and Windows
* Added Linux support for RS_NTP userdata, which is already supported on Windows
* Added support for rs_timeserver

### Setting RS_ntp

Add a tag to your server: `rs_agent:ntp_servers=server1[,server2,...]`
Alternately, edit your MultiCloudImage's userdata and add the following key/value pair: `RS_ntp=server1,[server2,...]`

These both accomplish the same thing, but the tag is easier to apply.


## Proxy Support

### Overview
RightLink v6.x is HTTPS based and communicates back with the RightScale platform in 3 ways:
* HTTPS requests to the RightScale API servers, such as us-3.rightscale.com
* HTTPS requests to the island load balancers (such as island1.rightscale.com) to download attachments, cookbooks, and OS packages.
* Websocket requests to the RightScale routers.

It is highly recommended to use a recent version of the agent (v6.3.2 or newer). v6.3.2 contained important bug fixes to the proxy code. The latest v14 ServerTemplates (v14.2) contain v6.3.3.

With RightLink 6.x, monitoring data is sent via collectd over UDP. Because of the UDP requirement for this version of the agent, monitoring data is not easily proxyable. In order to proxy this data, please use the newer version (RightLink 10) of the agent.

### Usage
To have RightLink go through a proxy, tags must be placed on the Server before launch. The following two tags are supported:

* `rs_agent:http_proxy=<ip:port>` -- Signals to RightLink init scripts that they, and the RightLink agent, should proxy all HTTP/HTTPS traffic. This setting is made available to child processes via the `http_proxy` and `HTTP_PROXY` environment variables.

* `rs_agent:http_no_proxy=<ip1>,<ip2>,<ip3>...` -- Signals the RightLink agent that the listed hosts are exceptions to the proxy setting and should be contacted directly. This setting is made available to child processes via the `no_proxy` environment variable.

**Example**:

~~~
rs_agent:http_proxy=10.0.0.0:3128
rs_agent:http_no_proxy=10.114.114.33
~~~

With RightLink v6.3.2 and later, a user and password may also be included in the proxy URL to facilitate authentication. Only basic authentication is supported:

**Example**:

~~~
rs_agent:http_proxy=http://myuser:mypass@10.0.0.1:3128
~~~

Alternatively, user and password can be specified as separate tags which allows the use of [Credentials]:

* `rs_agent:http_proxy_user=<user>|cred:<CRED>` -- Allows setting the user to use along with the `rs_agent:http_proxy` and `rs_agent:http_proxy_password` tags. Its value can be either a plain text user or a reference to a [Credential]. It must be specified along with `rs_agent:http_proxy_password` and may only be specified when `rs_agent:http_proxy` is specified as well.
* `rs_agent:http_proxy_password=cred:<CRED>` -- Allows setting the password to use along with the `rs_agent:http_proxy` and `rs_agent:http_proxy_user` tags. Its value can be a reference to a [Credential] which allows hiding the sensitive password value when viewing server or server array tags. It must be specified along with `rs_agent:http_proxy_user` and may only specified when `rs_agent:http_proxy` is specified as well.

**Example**:

~~~
rs_agent:http_proxy=10.0.0.0:3128
rs_agent:http_proxy_user=myuser
rs_agent:http_proxy_password=cred:MY_PASS
~~~

You must apply these tags to the server itself. It is possible to use hostnames instead of IP addresses, but this presumes that you have properly configured DNS within your VPC or firewalled environment.

Having tagged the server, you may boot the server freely. The RightLink agent will function as expected. RightLink will write the standard proxy environment variables (http_proxy and no_proxy) to /etc/profile.d/http_proxy.sh so that these variables are available to all subprocesses of the agent including package managers, RightScripts and Chef recipes.

[Credentials]: /cm/dashboard/design/credentials/
[Credential]: /cm/dashboard/design/credentials/

## Feature control

A system administrator can utilize a special configuration file before installing RightLink which will selectively disable certain features of RightLink on that machine. The intended use case is people who build custom images and want RightLink to behave in a certain way for their deployment environment. Feature control is only possible if you create a special YAML file **prior to installing the RightLink package** or running any RightLink init script or program logic - if using a RightImage, it will need to be rebundled for RightLink to be impacted by these configuration changes. The YAML file contains some boolean flags that affect the behavior of the init scripts and the agent at runtime. Specifically, you can:
  * Disable managed login
  * Disable repo freezing
  * Disable MOTD (message of the day) update

To disable one or more of these features, create the following file:`/etc/rightscale.d/right_link/features.yml`
And populate the file, supplying "true" or "false" for each feature as appropriate.
~~~ yaml
motd:
  update: false
package_repositories:
  freeze: false
managed_login:
  enable: false
~~~
**Important!  All features are assumed to be enabled by default unless this file exists and the associated feature is marked as "false" (disabled).** Therefore, you can omit sections for features that should remain enabled.


## File Locations

The following shows RightLink file locations split out by operating system (Linux and Windows).

### Linux Systems

| File | Location |
| ---- | -------- |
| /etc/rightscale.d               | Static configuration, incl. "hints" for init scripts |
| /etc/rightscale.d/right_link    | Static files that customize RightLink behavior |
| /var/spool/cloud                | Cloud-provided metadata & user-data |
| /var/lib/rightscale/right_agent | Persistent config files generated at startup |
| /var/lib/rightscale/right_link  | Persistent RightLink agent state |
| /var/run                        | Transient agent state, e.g. pid files |
| /var/cache                      | Cookbooks, attachments, temp files |
| /usr/bin                        | Public CLI: rs_tag, rs_debug, ... |
| /opt/rightscale/bin             | Private CLI: rnac, rad, cook, ... |
| /opt/rightscale/sandbox         | Private sandbox (Ruby, RubyGems, ...) |

### Windows Systems
Data files – Paths are relative to %COMMON_APPDATA%RightScale

| File | Location |
| ---- | -------- |
| rightscale.d            | Static "hints" for system services |
| spool\cloud             | Cloud-provided metadata & user-data (.sh, .rb, raw formats) |
| RightAgent              | Persistent config files generated at startup |
| right_link              | Persistent RightLink agent state |
| cache                   | Cookbooks, attachments, temp files

Program logic - Paths are relative to %ProgramFiles(x86)%

| File | Location |
| ---- | -------- |
| RightScale\RightLink    | Application logic & support files |
| RightScale\sandbox      | Private sandbox (Ruby, RubyGems, ...) |
