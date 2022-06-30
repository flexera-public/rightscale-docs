---
title: Collectd Plugin Apache Log Monitor
layout: cm_layout
description: The collectd plugin gathers useful information from the Apache log file for both monitoring and alert purposes in the RightScale Cloud Management Platform.
---

## Objective

This plugin gathers useful information from the Apache log file for both monitoring and alert purposes. This plugin tails the Apache access log based on the Apache LogFormat directive that you supply. The Apache plugin will help you get started monitoring more data from the Apache log.

And the dataum to be monitored and plotted are (but is not limited to):

* number of 200 OK hits per second
* number of 301/302 hits per second
* number of 2xx/3xx hits per second
* number of 404 hits per second
* number of 403 hits per second
* number of 4xx hits per second
* number of 5xx hits per second
* response time for every request - (Not viewable by default. Must be enabled. See instructions that follow.)
* response time for 2xx/3xx - (Not viewable by default. Must be enabled. See instructions that follow.)
* response time for 4xx/5xx - (Not viewable by default. Must be enabled. See instructions that follow.)
* response size for every request
* response size for 2xx/3xx
* response size for 4xx/5xx
* response time acceleration - Represents the increase/decrease in responses over time.
* error hits acceleration (both 4xx and 5xx) rate - Represents the increase/decrease in errors over time.

### Example

The **error hits acceleration** and **response time acceleration** can be useful for detecting whether or not there is a problem with how pages are being served to clients or whether a problem will exist in the near future.

For example, if the **response time acceleration** increases (> 0.0), it could be caused by too many hits to the site, which might cause the site to slow down or perhaps it is caused by a problem with the application, etc. You could also use the response time rate to help predict when the server will start to break down if it continues to increase at the same rate.

You can also set up an alert specification so that your system administrator receives an email notification when problems occur.

## Installation and Configuration

Use the following steps to set up the Apache plugin to collect and monitor Apache response time data so that you can use one of the predefined alert specifications to take action when problems related to Apache response times occur.

1. Enable the Collection of Response Time Data.
2. Add the "SYS Monitoring Apache Log Add" RightScript - You must add this script in order to monitor the collected Apache data.
3. Add an Alert Specification.

### Enable the Collection of Response Time Data

Before you can view any of the response time data, you must first modify the Apache configuration. In order to enable the collection of response time data, you must add the "response time" (%D) to the Apache LogFormat Directive and also input the LogFormat to the plugin by using the "-l" option. By default, Apache uses the LogFormat "combined" format:

~~~
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
~~~

and the plugin uses the same format for the "-l" option:

~~~
"-l" "%h %l %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\""
~~~

### Add the "SYS Monitoring Apache Log Add" RightScript

You must add the **SYS Monitoring Apache Log Add** RightScript to your ServerTemplate in order to monitor the Apache response data. Import this [RightScript](http://www.rightscale.com/library/right_scripts/SYS-Monitoring-Apache-Log-Add/lineage/2771) from the MultiCloud Marketplace.

![cm-apache-rightscript.png](/img/cm-apache-rightscript.png)  

### Add an Alert Specification

You may want to set up an alert specification and escalation that sends an email when Apache-related problems occur. You can either use one of the alert specifications related to Apache or create your own. See **Design** > **Alerts** > **Specifications**.

* **rs increase in error status** - If apache-log/gauge-error_hits_acceleration.value > '0.00' for 30 min then escalate to 'warning'.
* **rs increase in response time** - If apache-log/gauge-response_time_acceleration.value > '0.00' for 30 min then escalate to 'warning'.

## Apache-Log Plugin Options

This collectd exec plugin gathers Apache info by parsing the apache log file. This plugin demostrates a simple way to create a custom collectd plugin for monitoring purposes.

 -f, --apache-log FILE  
 This is the absolute path of the Apache access log. (default: /var/log/httpd/access_log)  

-l, --apache-logformat LOGFORMAT  
 Parsing the log requires the Apache LogFormat directive for this log file. (default: Apache 'combined' LogFormat)  

 -b, --backup-log FILE  
 This option sets the path where the file is backed up, which restores the data from last time. (default: /tmp/apache_log_monitor.backup)  

 -i, --hostid INSTANCE ID  
 The instance id of which the data is being collected.  

 -n, --sampling-interval INTERVAL  
 The interval (in seconds) between each sampling. The max interval is 15 seconds. (default: 10 seconds)  

 -a, --acceleration-interval INTERVAL  
 The interval (in seconds) between each acceleration rate sampling. (default: 300 seconds)  

 -h, --help

Once you've installed the plugin, you can find it in /usr/lib\*/collectd/plugin. You can change configuration options by modifying /etc/collectd.d/apache_log_monitor.conf .

### Example

~~~
    <Plugin exec>
      # userid plugin executable plugin args
      Exec "apache" "$collectd_dir/plugins/apache_log_monitor" "-l" "%h %l %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\""
    </Plugin>
~~~

## See also

- [Collectd Plugin:Apache](http://collectd.org/wiki/index.php/Plugin:Apache)
