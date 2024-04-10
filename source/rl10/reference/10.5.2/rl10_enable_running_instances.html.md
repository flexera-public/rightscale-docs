---
title: Enable Running Instances for Linux
description: This page describes a method for enabling already running raw instances using the rightlink.enable.sh script to provide all the amenities of a RightScale server, including managed login, operational scripts, and monitoring.
version_number: 10.5.2
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_enable_running_instances.html
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_enable_running_instances.html
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_enable_running_instances.html
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_enable_running_instances.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_enable_running_instances.html
  - name: 10.5.3
    link: /rl10/reference/10.5.3/rl10_enable_running_instances.html
  - name: 10.5.2
    link: /rl10/reference/10.5.2/rl10_enable_running_instances.html
  - name: 10.5.1
    link: /rl10/reference/10.5.1/rl10_enable_running_instances.html
---

## Overview

This page describes a method for enabling already running raw instances using the `rightlink.enable.sh` script to provide all the amenities of a RightScale server, including managed login, operational scripts, and monitoring.

## Benefits

* Turns an instance into a server in the dashboard, making the UI and functionality the same while avoiding the need to work through some of the instance UI pages
* Enables managed (root) login
* Enables operational and decommission scripts (plus "boot" scripts which are run when RightLink is installed)
* Enables monitoring by installing collectd as a boot script

## Use-cases

* Existing instances that were launched before RightScale was adopted
* Instances launched through an external system, such as SaltStack, AWS Autoscaling, AWS Cloud Formation, etc.
* Images that are being launched where installing RightLink and rebundling is not desirable

## Prerequisites

The `rightlink.enable.sh` script must be executed with root privileges

* A running instance that will be turned into a server
* SSH access to this instance or the ability to execute a command-line on the instance
* A ServerTemplate with appropriate boot and operational scripts (possibly none) and the rs.image parameter set in vSphere (Right click VM, Edit Settings, VM Options, Advanced, Edit Configuration..., get value from RightScale Images page)
* An MCI that has a `rs_agent:type=right_link_lite` tag
* A deployment into which the server will be placed
* RightScale OAuth key for the desired account (Settings > Account Settings > API credentials in the Cloud Management dashboard)
* Ability to download from a public Amazon S3 bucket to RightScale's platform from the instance

## How it works

1. The command line to install RightLink and have it run on the instance looks something like this, for version 10.5.2:
  ~~~ bash
  curl -s https://rightlink.rightscale.com/rll/10.5.2/rightlink.enable.sh | sudo bash -s -- -k "e22f8d37...456" -t "RightLink 10.5.2 Linux Base" -n "Test Server" -d "Staging Deployment" -c "amazon"
  ~~~
  Additional versions can be found on the [releases](/rl10/releases) page. As a convenience, more generic versions such as "10" or "10.5" may be specified as a way to install the latest GA version for a lineage. For example, https://rightlink.rightscale.com/rll/10/rightlink.enable.ps1 will pull the latest RightLink 10 client.

2. The downloaded `rightlink.enable.sh` script locates the ServerTemplate provided and locates the instance itself
3. The script then creates a server around the instance using the located ServerTemplate and places it in the deployment provided
4. It then retrieves the userdata for the new server, places it into /var/lib where it is commonly placed for RightLink and starts RightLink
5. RightLink comes up as if the server had just booted, runs boot scripts, and transitions to operational

After this process the server looks just like any other server. Even a relaunch can function correctly assuming:

1. The image from which the original instance was launched comes up correctly "on its own".
2. The image supports cloud-init such that RightLink will be automatically installed and launched at boot time (or, if the image runs some config management, such as puppet/chef/... the config can be augmented with something that installs RightLink, possibly by running the `rightlink.enable.sh` script).
3. Any existing userdata on the image is compatible with RightScale adding the RightScale userdata.
4. There are no race conditions between the image's own boot-time initialization and RightLink's start-up and boot scripts.

For reference (please check the actual script you are using):

  ~~~
  $ script/rightlink.enable.sh -h
  Usage: rightlink.enable.sh [-options...]
  Enable an instance to become a full RightScale server to get monitoring,
  operational scripts, and managed login.
  -k refresh_token      RightScale API refresh token from the dash
                        Settings>API Credentials (req.)
  -d deployment_name    the name of the pre-existing deployment to put the server
  -e deployment_href    HREF of the deployment to put the server. alternate to
                        the name of the deployment (ex. /api/deployments/123456789)
  -t st_name            the name of the ServerTemplate to use.
  -r st_href            HREF of the ServerTemplate to associate with this instance.
                        alternate to the name of the ServerTemplate
                        (ex. /api/server_templates/123456789)
  -n server_name        the name to call the server, default is current instance name
                        or $DEFAULT_NAME
  -p inputs             the server inputs in the form of NAME=key:value, use multiple
                        flags for multiple inputs (ex. USER=text:user_name)
  -c cloud_type         the cloud type the instance is in. used for self-detection
                        supported values: amazon, azure, azure_v2, google,
                        open_stack_v2, soft_layer, vscale
  -f cloud_name         the cloud to create a UCA instance in
  -x proxy_url          have RightLink use HTTP proxy. Will also install RightLink
                        through proxy
  -y no_proxy           a list of hosts to not proxy. List is inherited by scripts/
                        recipes as an environment variable
  -i instance_href      this instance's HREF (disables self-detection)
                        (ex. /api/clouds/1/instances/123456ABCDEF)
  -s instance_type      the name of the instances type (for UCA clouds), default 'auto'
  -a api_hostname       the hostname for the RightScale API, default: $DEFAULT_SERVER
  -z                    ignore check for cloud-init in order to support snapshotting
                        for custom image
  -h                    show this help

  Required Inputs: -k refresh_token,
                   -t st_name or -r st_href,
                   -d deployment_name or -e deployment_href,
                   -c cloud_type or -i instance_href
  ~~~
