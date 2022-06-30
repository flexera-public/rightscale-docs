---
title: Custom collectd Plug-ins
layout: cm_layout
description: You can customize your monitoring in the RightScale Cloud Management Platform so that you can collect additional data and use RightScale's TSS servers to display those graphs inside the Dashboard.
---

## Overview

In order to collect data for applications that are not handled by collectd's standard plug-ins you'll need to write your own custom plug-ins. By default, RightScale's monitoring scripts enable basic monitoring of common metrics. However, you may want to customize monitoring so that you can collect additional data and use RightScale's TSS servers to display those graphs inside the Dashboard. Writing your own custom collectd plugins allows you to further extend RightScale's default monitoring system for your own applications. Later, you can create alert specifications based on those monitored metrics.

## Adding Plugins to collectd

There are three methods for adding plug-ins to collectd:

1. Write native plug-ins written in C
2. Write plug-ins in perl loaded into collectd
3. Write external plug-ins

We recommend writing external plug-ins because it is generally the most stable method and is also the easiest to test and troubleshoot.

Plug-ins that are written in C tend to have better performance, but unless you're collecting a lot of data, the programming language doesn't seem to make a significant difference. RightScale recommends using "exec plug-ins" as described on [collectd.org](http://collectd.org/documentation/manpages/collectd-exec.5.shtml) because we've experienced compatibility issues with plugins written to the Perl interpreter, which can be embedded into the collectd process.

The operation of exec plug-ins is not fully documented on the collectd site, but there are a few things that you need to know. In the collectd config file, specify that collectd should be launched as an executable as a separate process, read monitoring data from the output of this process, and process this data like all other collected data. It is the responsibility of the plugin executable to determine where to get the data from, to collect it at the appropriate interval, to name it correctly, and to write it to standard output. If the plugin executable terminates, collectd will restart it.

It's important to understand that if you create a custom collectd plug-in, it doesn't mean that you'll be able to view graphs of the collected data under the Monitoring tabs in the Dashboard. Our TSS servers can only draw graphs for [Supported Graphs Types](/cm/rs101/supported_graphs_types.html). Simply adding your custom plug-in to the `types.db` file (Linux) or `monitors` directory (Windows) is not sufficient for drawing graphs for those plug-ins.

## Examples

* [Create Custom Collectd Plug-ins for Linux](/cm/rs101/create_custom_collectd_plug-ins_for_linux.html)
* [Example: memory buffers collectd exec plugin](/cm/rs101/example_memory_buffers_collectd_exec_plugin.html)
* [Custom Windows Monitoring](/cm/windows_guide/windows_monitoring.html#custom-windows-monitoring)

## See Also

* [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html)
