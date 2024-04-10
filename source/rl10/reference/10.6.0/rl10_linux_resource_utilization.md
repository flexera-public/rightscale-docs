---
title: RL10 Linux Resource Utilization(CPU,Memory,Network I/O)
description: RL10 resource utilization on linux.
version_number: 10.6.0
versions:
  - name: 10.6.4
    link: /rl10/reference/10.6.4/rl10_linux_resource_utilization
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_linux_resource_utilization
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_linux_resource_utilization
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_linux_resource_utilization.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_linux_resource_utilization.html
---
## Overview

The intent of this document is to characterize the resource (CPU, memory and network) utilization of the RightLink agent (version 10.6) on Linux.

## Test Setup

* Cloud - AWS
* OS - Ubuntu 16.04
* Instance - t2.micro with 1gb ram
* RightLink Agent - RL10.6

## Data Capture
The resource usage on the Linux server was captured using `htop` which is an `ncurses`-based implementation of the standard Linux `top` utility.  The `htop` utility was used as it allows all threads of a Linux process to be displayed and also facilitates process sorting which enables less cluttered views of the server’s resource utilization.

## Results

The figure below shows the CPU utilization of RightLink (shown as `/usr/local/bin/rightlink` in the **Command** list) after installation on a quiescent Linux Ubuntu server.

![rightlink-10-6-resource-utilization-linux-1.png](/img/rightlink-10-6-resource-utilization-linux-1.png)

The CPU utilization(**CPU%** column) is negligible (shown as `0%`) across all RightLink threads. The above image also shows the memory utilization (**MEM%** column) of RightLink on the same quiescent system. Each RightLink thread is shown as using approximately 1.1% of the available system memory. These threads share some memory so the total usage is significantly less than the sum of the threads shown.  When the collapsed view of `htop` was used (i.e. a single PID displayed per process), the total memory usage was 1.3%, which is approximately 13MB on a t2.micro with 1GB memory.

The image above shows the **normal** state of RightLink when it is installed on a Linux server but is not actively processing any additional user-submitted (or automated) tasks.  To illustrate the resource utilization of RightLink when performing an additional task (in this case, the running of operational scripts, which were manually triggered, but could also be run via automation) two additional scripts were created.  The first runs a CPU-intensive application (`cpuburn`, in particular the `burnP6variant`), and the second downloads a very large file (1GB).  The intent here is to show what happens to RightLink from a CPU and memory perspective when running tasks that tax these resources.  The image below shows the `htop` output for CPU activity with `burnP6running` (and initiated via RightLink by the running of a RightScript on the server):

![rightlink-10-6-resource-utilization-linux-2.png](/img/rightlink-10-6-resource-utilization-linux-2.png)

Please note that `burnP6` appears in the **Command** list (i.e. RightLink initiated the execution -- note the `rightlink` user in the **USER** column -- but RightLink is not the process running `burnP6`). The image below shows all the RightLink threads in the process table while the `burnP6` process is executing:

![rightlink-10-6-resource-utilization-linux-3.png](/img/rightlink-10-6-resource-utilization-linux-3.png)

 Note that the RightLink threads are all still at 0% CPU utilization.  The previous examples illustrate that the CPU utilization of RightLink on a quiescent system as well as a “busy” system (with that “busyness” initiated via RightLink) is negligible on a Linux server. 

 The image below is the `htop` output while a 1GB file is being downloaded (with this download being initiated via RightLink by way of a RightScript manually run on the server):

 ![rightlink-10-6-resource-utilization-linux-4.png](/img/rightlink-10-6-resource-utilization-linux-4.png)

 Please note that red circled region which shows the process performing the download which is consuming approximately 5% of the system memory (as before, the process was initiated by RightLink, but it is not a RightLink thread that is performing the operation).  The next image is the `htop` output showing just the RightLink processes while the download was being performed: 


 ![rightlink-10-6-resource-utilization-linux-5.png](/img/rightlink-10-6-resource-utilization-linux-5.png)

 Please note that the memory utilization of RightLink has not changed significantly and remains at approximately 1.2% (or roughly 12MB on a t2.micro instance). 
 
 The two previous images show that the memory footprint of RightLink is fairly small (less than 20MB) and does not increase when memory usage increases via processes it has initiated.
 
 Here is the network utilization for rightlink 10 using native monitoring.
 
 ![rl10-linux-network-utilization.png](/img/rl10-linux-network-utilization.png)
 
 The above discussion illustrates that the CPU, Memory, Network I/O footprints of RightLink 10.6 on a Linux server are fairly negligible, regardless if the system is quiescent or is under load due to a RightLink-initiated action.
