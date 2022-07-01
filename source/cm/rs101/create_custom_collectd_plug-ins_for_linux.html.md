---
title: Create Custom collectd Plug-ins for Linux
layout: cm_layout
description: Procedure for writing a custom collectd plugin for Linux instances so that the data can be collected and graphs can be drawn and displayed in the RightScale Cloud Management Dashboard.
---

## Objective

To write a custom collectd plugin for Linux instances so that the data can be collected and graphs can be drawn and displayed in the RightScale Dashboard.

## Steps

### Create the Custom Plugin

Let's try a simple example: a plug-in that collects cpu load by calling 'uptime' and parsing the output (note this is not necessarily the best way to do the data collection, but it's a simple example). Save the contents into the `mycpuload.rb` file.

!!info*Note:* The step must be 20 for all RRDs and data must be sent at 20 second intervals. Anything else is a waste of bandwidth and processing. [Read more about the monitoring system limitations](monitoring_limitations.html).

~~~
#!/usr/bin/env ruby

# The name of the collectd plugin, something like apache, memory, mysql, interface, ...
PLUGIN_NAME = 'mycpuload'
hostname    = ENV['COLLECTD_HOSTNAME'] || "localhost"
interval    = ENV['COLLECTD_INTERVAL'] || 20

def usage
  puts("#{$0} -h <host_id> [-i <sampling_interval>]")
  exit
end

# Main
begin
  # Sync stdout so that it will flush to collectd properly.
  $stdout.sync = true

  # Collection loop
  while true do
    start_run = Time.now.to_i
    next_run = start_run + interval

    # collectd data and print the values
    data = `uptime`[/load average: ([\d.]+)/, 1] # get 5-minute load average
    puts("PUTVAL #{hostname}/#{PLUGIN_NAME}/gauge-5_minute_load #{start_run}:#{data}")

    # sleep to make the interval
    while((time_left = (next_run - Time.now.to_i)) > 0) do
      sleep(time_left)
    end
  end
end
~~~

!!warning*Important!* The value you choose for your `PLUGIN_NAME` variable must be unique and not conflict with any of the existing RigthtScale collectd plugin names. For example, if you use `haproxy`, `cpu`, `df-`, `apache`, or `load` as a plugin name an error will occur and may cause unexpected behavior.

Now when we run this from the command line, this is what it looks like: 

~~~
[root@ip-10-251-70-47 /]# cd /usr/lib/collectd/plugins
[root@ip-10-251-70-47 plugins]# chmod +x mycpuload.rb #give permissions to execute the file
[root@ip-10-251-70-47 plugins]# ./mycpuload.rb #Terminate the script with Ctrl+c
PUTVAL localhost/mycpuload/gauge-5_minute_load 1207188959:0.01
PUTVAL localhost/mycpuload/gauge-5_minute_load 1207188979:0.00
PUTVAL localhost/mycpuload/gauge-5_minute_load 1207188999:0.08
./mycpuload:46:in `sleep': Interrupt
	from ./mycpuload:46
[root@ip-10-251-70-47 plugins]#
~~~

If you look carefully at the timestamps (the 10-digit number), you'll notice that the three lines are all 20 seconds apart. The number at the end of the line is the load reported by uptime. Note that the `localhost` in the output above will be the correct hostname when run with collectd.

Now it's time to explain what the `01-EHII6FZK7KAAB/mycpuload/gauge-5_minute_load` string represents.

The format of this string is `<instance-id>/<plugin>-<plugin_instance>/<type>-<type_instance>`

The meaning of each field is:

* `instance-id`: This is the ID that identifies the server that is sending the data to the monitoring servers. This can be obtained by looking at the env value of `COLLECTD_HOSTNAME` or the Info tab of the Server page.
* `plugin`: identifies the plugin that is typically associated with an application or a resource. Examples include apache, mysql, squid, cpu, memory, etc. NOTE:
* `plugin_instance`: identifies the instance of an application/resource when there are multiple applications/resourse. Examples are cpu-0, cpu-1 on dual-core servers, or df-mnt and df-root for the two filesystems on small instances.
* `type`: identifies the type of data being collected. Your custom plugin must use one of the [Supported Graphs Types](/cm/rs101/supported_graphs_types.html), defined in types.db.
* `type-instance`: the name of the variable being collected, or the instance of the variable of the given type being collected Examples are: (for the cpu type) idle, wait, busy; (for the 'mysql_command' type) selects, updates, executes.

All of this can be pretty confusing at first. To try and make the fields easier to understand, note how a `-` separates plugin and plugin_instance or type and type_instance, while an `_` is sometimes used within any of these four items. The best way to understand how all this works is to look at where each of these identifiers shows up on the web pages.

* Each `<plugin>-<plugin_instance>` combination results in a menu box at the top of the monitoring page
* The graph `<type>` determines how the data is interpreted and how the graphs are drawn by the TSS servers. The preceding example uses the `gauge` type. You must use one of the [Supported Graphs Types](/cm/rs101/supported_graphs_types.html), otherwise TSS will not be able to create any graphs. Either the `counter` or `gauge` graph types are recommended for custom plug-ins.
* The `<type_instance>` shows up in the title of the graph(s)

### Add the New Plugin

Now, you need to link the new plugin into `collectd.conf`. Based on the distribution, you need to create a `mycpuload.conf` file in either `/etc/collectd.d/` (CentOS) or `/etc/collectd/conf/` (Ubuntu) with this content: 

~~~
LoadPlugin exec
<Plugin exec>
  # userid plugin executable plugin args
  Exec "my_user" "/usr/lib/collectd/plugins/mycpuload.rb"
</Plugin>
~~~

Now, we need to create the user `my_user` , used by collectd to run the script:

~~~
[root@ip-10-251-70-47 /]# cd /usr/lib/collectd/plugins/
[root@ip-10-251-70-47 plugins]# useradd my_user -s /sbin/nologin -M
[root@ip-10-251-70-47 plugins]# chown my_user:my_user mycpuload.rb #change owner and group
[root@ip-10-251-70-47 plugins]# ls -l
total 12
-rwxr-xr-x 1 haproxy haproxy 7066 Sep 28 10:23 haproxy
-rwxr-xr-x 1 my_user my_user 1220 Sep 30 15:32 mycpuload.rb
~~~

### Allow my_user in sudoers (optional)

Collectd will not allow plugins to run as root, and in most cases this is fine. However, in the event your plugin requires root privlieges, you will need to write the plugin to sudo the appropriate commands. Generally this is not a recommended practice, but if it is needed, here is an example:

~~~
my_user ALL=(ALL) NOPASSWD:/usr/lib/collectd/plugins/mycpuload.rb
~~~

### Restart collectd

Now we need to restart collectd and check for correct script execution:

~~~
[root@ip-10-251-70-47 plugins]# service collectd restart
Stopping collectd: [OK]
Starting collectd: [OK]
[root@ip-10-251-70-47 plugins]# tail /var/log/messages #/var/log/syslog on Ubuntu
Sep 30 16:00:46 ip-10-251-70-47 collectd[23768]: Exiting normally
Sep 30 16:00:47 ip-10-251-70-47 collectd[23768]: exec plugin: Sent SIGTERM to 23777
Sep 30 16:00:47 ip-10-251-70-47 collectd[23768]: exec plugin: Sent SIGTERM to 23778
[root@ip-10-251-70-47 plugins]# ps aux | grep mycpuload
my_user 23591 0.0 0.1 3528 1936 ? S 15:37 0:00 ruby /usr/lib/collectd/plugins/mycpuload.rb 
~~~

If the script is being executed by `my_user`, you should find the `mycpuload` graph in the Dashboard.

## See also

* [Create a Custom Alert Specification](/cm/rs101/create_a_custom_alert_specification.html)
* [Monitoring System Limitations](monitoring_limitations.html)
