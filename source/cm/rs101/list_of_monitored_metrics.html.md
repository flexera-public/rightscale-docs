---
title: List of Monitored Metrics
layout: cm_layout
description: Here is a complete list of metrics that are monitored by RightScale's Monitoring System.
---

The following is a complete list of metrics that are monitored by RightScale's [Monitoring System](/cm/rs101/monitoring_system.html)

For more information about the different collectd plugins, see collectd's [Table of Plugins](http://collectd.org/wiki/index.php/Table_of_Plugins).

* **apache** - Displays graphs for overall bits/sec and requests/sec served by all of the httpd processes running on the machine. In addition there are individual graphs showing the number of httpd processes in a specific state: closing, dnslookup, finishing, idle-cleanup, keepalive, logging, open, reading, sending, starting, and waiting. There is also a 'scoreboard' graph that summarizes the state information in a single graph with each state identified by a different color.  

* **cpu** - Displays graphs showing the fraction of time cpu 0,1,...,n spends on each state: idle, interrupt, nice, softirq, steal, system, user, and wait. There is also an 'overview' graph that displays all the states in a single graph using different colors. The cpu information displayed by these graphs is similar to that given by unix commands: sar, iostat, or top.  

* **df** - Displays graphs showing the file system disk usage. There are graphs for each of the mounted file partitions showing the amount of used and available disk usage relative to the total amount. Each graph shows statistics for the minimum, average, maximum, and last values.

!!info*Note:* When creating an alert specification for the 'df' category, there are options for specifying Bytes, Kilobytes (KB), Megabytes (MB) and Gigabytes (GB) accordingly. When using one of these options, the number specified on the alert specification will be automatically converted to Bytes for you. Thus, upon viewing the alert specification afterwards, it will _always_ display it's value as Bytes.

* **disk-xxxx** - Displays graphs showing the performance statistics for the attached hard disks. Individual graphs are: read and written bytes/sec (octets), disk operations/sec, merged operations/sec and time for an I/O operation. The 'merged' operations represent the number of logical operations in the queue that could be merged together so that all operations can be satisfied with a single physical disk access. Each graph shows statistics for the average, maximum, and last values.  

* **haproxy** - To view HAProxy status you should navigate to the URL `www.<_MySite.com_>/haproxy-status`. The following status information is displayed:
    
    **(haproxy_status)** the health check status of each instance in each group.
    * 2: Active. The server is active.
    * 1: Down, going Active. The server is going to be active.
    * 0: No check or other.
    * -1: Active, going Down. The server is going down.
    * -2: Down. The server is down.
   
    **(haproxy_traffic)**
    * Requests per second.
    * Response errors per second.
    * Health check errors per second.

    **(haproxy_sessions)**
    * Current sessions of each instance.
    * Queued sessions of each instance.
   
<br />
* **interface** - Displays graphs showing the network interface activity with respect to errors/sec, octets/sec, and packets/sec for both incoming and outgoing interfaces. Each graph shows statistics for the minimum, average, maximum, and last values.  

* **load** - Displays graphs showing the system load as defined by the number of runnable tasks in the run queue. The statistics are running averages over 1, 5, and 15 minutes. Each graph shows statistics for the minimum, average, maximum, and last values.  

* **memory** - Displays graphs showing the allocation of memory for used (currently used by programs), free (not in use), buffers (used by Linux to cache access to block devices), and cached (page cache; used to speed up data access). Each graph shows statistics for the minimum, average, maximum, and last values.  

* **mysql** - Displays graphs showing internal MySQL activity corresponding to the information given by MySQL when given the 'show status' command. The individual graphs can be grouped into the following categories: command statistics, handler statistics, query cache statistics, and thread statistics.  

* **ping** - Displays graphs showing the network latency between the current instance and machines on the following domains: ec2.amazonaws.com, s3.amazonaws.com, and www.rightscale.com domains. Each graph shows statistics for the minimum, average, maximum, and last values.  

* **processes** - Displays graphs showing the number of processes grouped by their state (e.g. blocked, paging, running, sleeping, stopped, or zombie). Each graph shows statistics for the minimum, average, maximum, and last values.  

* **processes-xxxx** - Displays graphs showing the number of processes and associated threads for each of the following applications: 'alert', 'collectd', 'cron', 'haproxy', 'httpd.worker', 'merb', 'mongrel_rails', 'mysqld', 'sshd', and'tomcat'.  

    Which ones are displayed depends on the specific value given to an input on your server/template. The following inputs are used for both Rightscript and Chef based templates:​

  * Rightscript based templates: MON_PROCESSES and MON_PROCESSMATCH​
  * Chef based templates: "Process List" and "Process Match List", available under the 'Rightscale' input category as Advanced Inputs

    MON_PROCESSMATCH and "Process Match List" should be used in a name/regex format. For example: ssh/ssh\*

    Each graph shows statistics for the minimum, average, maximum, and last values.

* **swap** - Displays graphs showing the amount of swap space that is either cached, free, or used. Each graph shows statistics for the minimum, average, maximum, and last values.

!!info*Note:* When creating an alert specification for the 'swap' category, there are options for specifying Bytes, Kilobytes (KB), Megabytes (MB) and Gigabytes (GB) accordingly. When using one of these options, the number specified on the alert specification will be automatically converted to Bytes for you. Thus, upon viewing the alert specification afterwards, it will _always_ display it's value as Bytes.  

* **users** - Displays a graph showing the number of users connected to the instance. Each graph shows statistics for the minimum, average, maximum, and last values.

## See also

* [http://www.collectd.org/documentation.shtml](http://www.collectd.org/documentation.shtml)
* [Windows Monitoring](/cm/windows_guide/windows_monitoring.html)
