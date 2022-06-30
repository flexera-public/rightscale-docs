---
title: Add a Custom Monitoring Plugin Automatically with RightScripts or Chef Recipes
description: Steps for creating RightScripts or Chef Recipes that you can use in ServerTemplates so that your custom monitoring plugin(s) will be properly installed on each Windows server that you launch.
---

## Overview

Unfortunately, there are currently no collectd plugins for Windows. To help you get started with monitoring for Windows, RightScale has created a few plugins for common metrics (cpu, disk, and memory). However, if you want to extend monitoring support to include other collectd plugins, you can manually create a monitoring script for your own applications.

This tutorial will help you create RightScripts or Chef Recipes that you can use in ServerTemplates so that your custom monitoring plugin(s) will be properly installed on each Windows server that you launch. If you only want to perform a quick test to verify that your custom monitoring plugin works as expected, you should first complete the [Add a Custom Monitoring Plugin Manually](/cm/windows_guide/add_a_custom_monitoring_plugin_manually.html) tutorial.

Use the procedure outlined below to extend monitoring on Windows servers by using RightScripts or Chef Recipes to add a custom monitoring plugin(s) to a server at boot time so that additional server metrics are monitored and graphed inside the RightScale Dashboard.

## Prerequisites

* 'actor' and 'server_login' user role privileges
* Windows server with RightLink installed

## Steps

### Create a Custom Plugin

Unfortunately, there is a variety of monitoring information which cannot be queried from the Windows Management Instrumentation (WMI), especially for older platforms like Windows Server 2003. In such cases, a script is required to handle the gathering and sending of monitoring information via collectd. There are two different ways that you can create a custom monitoring plugin.

* DSL Option
* Pure Ruby Option

#### DSL Option

The DSL (domain-specific language) plugin option consists of a single file per monitor. Its attribute values can be String, Boolean, Integer or Array and must follow Ruby conventions for declaring literal values (though you do not have to know Ruby).

**Example**

The example below implements a DSL plugin for Memory Usage. For the example 'my-monitor.rb' file, these are the entire contents:

~~~ ruby
wmi_query 'Select FreePhysicalMemory from Win32_OperatingSystem'
wmi_query_send_attributes 'FreePhysicalMemory'
collectd_plugin 'memory'
collectd_type 'memory'
collectd_type_instance 'free'
collectd_units_factor 1024
~~~

**Attributes**

The supported attributes are described in the table below:

| Attribute Name | Description | Type | Default | Example |
| -------------- | ----------- | ---- | ------- | ------- |
| collectd_plugin | Name of the collectd plugin associated with monitor | String | True | collectd_plugin 'memory' |
| collectd_units_factor | Collectd units multiplier for converting the WMI result attribute(s) | Number | False | collectd_units_factor 1024 |
| collectd_sender | Collectd send method which must be one of :gauge, :counter, :derive, :absolute | Symbol or string | Defaults to :gauge | collectd_sender :counter |
| collectd_type | Type of the collectd plugin associated with the monitor | String | True | collectd_type 'memory' |
| collectd_type_instance | Instance for the type of the collectd plugin or else a regular expression which selects the collectd instance type name from the WMI attribute name. In the latter case, the WMI attribute name is first matched by the regular expression which must select the portion of the name to send and then the name is converted to lowercase and underscores if it is camel case. The regular expression allows a single monitor DSL to represent multiple attributes returned from a single WMI query, each of which is sent individually with its value to collectd. The default behavior is not to send any zero values, but this can be overridden by using the wmi_query_required_send parameter (see below). | String or Regexp | True | collectd_type_instance 'free' collectd_type_instance /\A(.\*)RequestsPerSec\z/ |
| priority | Used to prioritize to ensure time-critical monitors run sooner than others. Must be one of :highest, :high, :normal, :low, :lowest | Symbol or string or integer | Default to :normal | priority :high |
| wmi_query | WMI Query string to execute | String | True | wmi_query 'Select FreePhysicalMemory from Win32_OperatingSystem' |
| wmi_query_name\_attribute | Attribute name to get from WMI result and use as collectd plugin instance | String | False | wmi_query_name_attribute 'Name' |
| wmi_query_send_attributes | Names of attributes from WMI result to send | String array or single string value | True | wmi_query_send_attributes 'FreePhysicalMemory' |
| wmi_query_required_send | Array of collectd instance type names used to ensure that a set of attributes are always sent to Sketchy regardless of whether the value is non-zero. Only needed when collectd_type_instance is a regular expression used to convert WMI attribute names to collectd type instance names. | String array or single string value | False | wmi_query_required_send ["get", "post"] |

#### Pure Ruby Option

As an alternative, you can also implement a Pure Ruby option by shelling out to a PowerShell script. However, this option could be costly in terms of processor time and memory usage (which might ultimately affect the perception of the monitored machine's busy state).

The pure Ruby plugin would consist of a single Ruby file with a run function and optionally an init function.

**Example**

The example below implements a Pure Ruby plugin for Disk Usage using the 'gauge' graph type ('counter' is also supported):

~~~ ruby
def run
  drives = execute_wmi_query("Select deviceid, freespace, size from win32_logicaldisk")
  for drive in drives do
    if drive.deviceid =~ /^(\w):$/
      drive_letter = $1
      free_space_val = drive.freespace
      drive_size_val = drive.size
      if is_number?(free_space_val) && is_number?(drive_size_val)
        used_space = drive_size_val.to_i - free_space_val.to_i
        @logger.debug("Drive #{drive_letter}: has #{free_space_val} free and #{used_space} used space")
        gauge('df', '', 'df', "drive_#{drive_letter}", [used_space, free_space_val.to_i])
      end
    end
  end
end
~~~

The content of the plugin file will be instance eval'd into a new instance of a Monitor class. The Monitor class provides the bridge between the monitoring script and the user-defined plugin. This type of plugin is simple for RightScale to implement and fairly straight forward for users to add their own monitoring plugins.

!!info*Note:* Ruby knowledge will be required to implement complex monitors.

### Create a Script to Deploy the Custom Monitoring Plugin

Once you've created a custom monitoring plugin, you can either use a RightScript or Chef Recipe for deployment so that the plugin is installed in the proper directory on the instance at launch time.


Even though RightLink itself is installed to the x64 Program Files location on 64-bit platforms, the custom monitoring plugin must always be deployed to the x86 install location for both 32-bit and 64-bit platforms. For your convenience, RightLink will provide an environment variable called "RS_MONITORS_DIR" which will indicate the proper location on the instance's disk for plugins to be deployed. You should always use this variable instead of trying to hardcode an absolute path.

Inside the directory, you'll find the plugins that RightScale automatically installs by default:

* cpu_load.rb
* disk_usage.rb
* memory.rb  

**RightScript Example**

The following PowerShell code can be used when creating a RightScript with 'my-monitor.rb' as attachment:

~~~
$ErrorActionPreference = "Stop"
$pluginFileName = "my-monitor.rb" $srcPluginFilePath = Join-Path $env:RS_ATTACH_DIR $pluginFileName $dstPluginFilePath = Join-Path $env:RS_MONITORS_DIR $pluginFileName
write-output "Copying from $srcPluginFilePath to $dstPluginFilePath" Copy-Item $srcPluginFilePath $dstPluginFilePath -Force write-output "Monitor copied"
~~~

**Chef Recipe Example**

The following Ruby code can be used when creating a Chef Recipe:

~~~ ruby
require 'fileutils'
ruby 'copy custom monitors' do plugin_file_name = "my-monitor.rb" src_plugin_file_path = File.join(ENV['RS_ATTACH_DIR'], plugin_file_name)
dst_plugin_file_path = File.join(ENV['RS_MONITORS_DIR'], plugin_file_name) FileUtils.cp(src_plugin_file_path, dst_plugin_file_path) end
~~~

### Add the Script to a ServerTemplate

The last step is to add the RightScript or Chef Recipe to a Windows ServerTemplate. When you add the script to your ServerTemplate, be sure to add it as a Boot Script *after* the "sys monitoring" script that installs the default monitoring plugins.

### Test and Verify

Launch a Server using the modified ServerTemplate to test and verify that the custom monitoring plugin was successfully installed and that you can view your custom graphs in the Dashboard.

**Congratulations!** You just created a custom monitoring plugin, created a script to properly deploy the plugin, and added it to one of your Windows ServerTemplates.
