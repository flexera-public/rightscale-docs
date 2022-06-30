---
title: RightScript Metadata Comments
layout: cm_layout
description: RightScale provides an in script RightScript Metadata Comments format for describing everything about a RightScript so it can easily be imported into the platform through tools using the RightScale API.
---
## Overview

In order to better support storing RightScripts in external version control systems such as Git or Subversion as well as
editing with your favorite editor, RightScale provides an in script RightScript Metadata Comments format for describing
everything about a RightScript so it can easily be imported into the platform through tools using the RightScale API. In
addition to being supported in the RightScale API, this format is also supported when editing RightScripts on the
RightScale Dashboard.

You can use open source [Right ST] client tool to synchronize RightScripts using this format between the RightScale
platform and your local development environment or CI system.

[Right ST]: https://github.com/rightscale/right_st

## Syntax

The format of the metadata comment is a multiple line block of comments (usually marked with `#` since that is supported
by most scripting languages, but `//` and `--` are also supported for languages that support them) which starts with
`---` and ends with `...`; the metadata between is specified as YAML with the comment marker at the beginning of the
line. For example:

```bash
#!/bin/bash
# ---
# RightScript Name: RL10 Linux Enable Monitoring
# Description: >
#   Chose to either enable built-in RightLink monitoring or install and setup
#   collectd with basic set of plugins. Both methods work with RightScale TSS
#   (Time Series Storage), a backend system for aggregating and displaying
#   monitoring data. Using collectd will sent monitoring data to the RightLink
#   process on the localhost as HTTP using the write_http plugin, which then
#   forwards that data to the TSS servers over HTTPS with authentication.
# Inputs:
#   MONITORING_METHOD:
#     Input Type: single
#     Category: RightScale
#     Description: >
#       Determine the method of monitoring to use, either RightLink monitoring
#       or collectd. Setting to 'auto' will use code to select method.
#     Required: false
#     Advanced: true
#     Default: text:auto
#     Possible Values:
#       - text:auto
#       - text:collectd
#       - text:rightlink
#   RS_INSTANCE_UUID:
#     Input Type: single
#     Category: RightScale
#     Default: env:RS_INSTANCE_UUID
#     Description: If using collectd, the monitoring ID for this server.
#     Required: false
#     Advanced: true
#   COLLECTD_SERVER:
#     Input Type: single
#     Category: RightScale
#     Default: env:RS_TSS
#     Description: >
#       If using collectd, the FQDN or IP address of the remote collectd server.
#     Required: false
#     Advanced: true
# ...
```

Currently only the Inputs top level field is used by the RightScale platform while the other fields are used by client
tools like [Right ST] which interface RightScale through the RightScale API in order to synchronize RightScripts from
the platform to a client file system or to integrate with a source control system such as Git or Subversion.

### Top Level Fields

The Inputs field is required if metadata comments are present while the other fields are optional, but RightScript Name and Description are strongly recommended.

Name            | Description                           | YAML Type             | Acceptable Values
--------------- | ------------------------------------- | --------------------- | -----------------
RightScript Name| the name of the RightScript; this is not used directly by RightScale, but client tools can use it to set the name of the RightScript | string | single line of text
Description     | the description of the RightScript; this is not used directly by RightScale, but client tools can use it to set the description of the RightScript | string | free form text which can be Markdown
Inputs          | the inputs for the RightScript        | associative array     | keys are input name strings and values are associative arrays of input fields
Attachments     | the attachments for the RightScript; this is not used directly by RightScale, but client tools can use it to manage uploading attachments for the RightScript | array of strings | each array value can be the name of an attachment file

### Input Fields

All of the fields in the associative array for Inputs are optional, but at least Category and Description are strongly recommended.

Name            | Description                           | YAML Type             | Acceptable Values
--------------- | ------------------------------------- | --------------------- | -----------------
Category        | the category of the input             | string                | single line of text
Description     | the description of the input          | string                | free form text
Input Type      | the type of the input; an input can either be used to pass a single string value or an array of values to a script | string | `single` or `array`
Required        | whether the input is required in order for the script to run successfully | boolean | `true` or `false`
Advanced        | whether the input is hidden by default as an advanced input; it is strongly recommended that you provide an acceptable default value for advanced inputs | boolean | `true` or `false`
Default Value   | the default value for the input       | string                | any valid [Inputs 2.0 notation](http://reference.rightscale.com/api1.5/resources/ResourceInputs.html#multi_update) value
Possible Values | the possible values for the input which will be displayed in a dropdown menu | array of strings | each array value can be any valid [Inputs 2.0 notation](http://reference.rightscale.com/api1.5/resources/ResourceInputs.html#multi_update) value
