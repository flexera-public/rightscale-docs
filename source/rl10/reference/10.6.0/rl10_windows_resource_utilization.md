---
title: RL10 Windows Resource Utilization(CPU,Memory,Network I/O)
description: RL10 agents memory and cpu footprint on windows.
version_number: 10.6.0
versions:
  - name: 10.6.3
    link: /rl10/reference/10.6.3/rl10_windows_resource_utilization
  - name: 10.6.2
    link: /rl10/reference/10.6.2/rl10_windows_resource_utilization
  - name: 10.6.1
    link: /rl10/reference/10.6.1/rl10_windows_resource_utilization.html
  - name: 10.6.0
    link: /rl10/reference/10.6.0/rl10_windows_resource_utilization.html
---
## Overview

The intent of this document is to characterize the resource (CPU, memory and network) utilization of the RightLink agent (version 10.6) on Windows.

## Test Setup

* Cloud - AWS
* OS - Windows 2012R2
* Instance - t2.medium
* RightLink Agent - RL10.6

## Data Capture
The resource usage on the Windows server was captured using Resource Monitor (part of the standard Performance Monitor, or `PerfMon` utility set standard on many Windows distributions).  (If there is a desire for the use of a different resource monitoring tool, please let us know and we can re-run the tests indicated below.  `PerfMon` was used as it is a standard and more or less **defacto** tool for this purpose.) 

## Results

The figure below shows the CPU utilization of RightLink (shown as `rightlink.exe` in the image list) after installation on a quiescent Windows 2012R2 server.

![rightlink-10-6-resource-utilization-windows-1.png](/img/rightlink-10-6-resource-utilization-windows-1.png)

 The CPU utilization is negligible (shown as `0%`) and the average is 0.01%. The next image shows the memory utilization of RightLink on the same quiescent system: 

![rightlink-10-6-resource-utilization-windows-2.png](/img/rightlink-10-6-resource-utilization-windows-2.png)

The private memory allocation is approximately 6.4MB, and the entire working set is 16.2MB. 

The two images above show the **normal** state of RightLink when it is installed on a Windows server but is not actively processing any additional user-submitted (or automated) tasks.  To illustrate the resource utilization of RightLink when performing an additional task (in this case, the running of operational scripts, which were manually triggered, but could also be run via automation) two additional scripts were created.  The first runs a CPU-intensive application (Prime95, run in **torture** mode), and the second downloads a very large file (1GB).  The intent here is to show what happens to RightLink from a CPU and memory perspective when running tasks that tax these resources.  The image below shows the Resource Monitor graph for CPU activity with Prime95 running (and initiated via RightLink by the running of a RightScript on the server):

![rightlink-10-6-resource-utilization-windows-3.png](/img/rightlink-10-6-resource-utilization-windows-3.png)

 Please note that **prime95.exe** appears in the image list (i.e. RightLink initiated the execution, but RightLink is not the process running **prime95.exe**).  Also note that `rightlink.exe` is still listed as 0% with an average CPU utilization of 0.8% (RightLink used a small number of CPU cycles to initiate the launch of Prime95).  
 
 The previous examples illustrate that the CPU utilization of RightLink on a quiescent system as well as a “busy” system (with that “busyness” initiated via RightLink) is negligible on a Windows server.  
 
 The image below is the memory graph of Resource Monitor while a 1GB file is being downloaded (with this download being initiated via RightLink by way of a RightScript manually run on the server): 

 ![rightlink-10-6-resource-utilization-windows-4.png](/img/rightlink-10-6-resource-utilization-windows-4.png)

 Please note that rightlink.exe has a private allocation of approximately 7.4MB and a working set of approximately 17.2MB.  The other highlighted image in the list is the PowerShell execution that is handling the actual download (again, initiated by RightLink).  The PowerShell working set is 212MB while its committed memory allocation is approximately 1GB (in preparation for the eventual file size).  The next image is the same graph taken a few minutes later while the download is still active:


 ![rightlink-10-6-resource-utilization-windows-5.png](/img/rightlink-10-6-resource-utilization-windows-5.png)

 Please note that the PowerShell execution has a fairly consistent committed allocation, while the working set has grown to over 700MB as the download progresses.  Additionally, the memory utilization of RightLink has not changed significantly (and in fact has gone down slightly). 
 
 The two previous images show that the memory usage of RightLink is fairly small (16-17MB) and does not increase when memory usage increases via processes it has initiated.
 
  Here is the network utilization for rightlink 10 using native monitoring.
  
 ![rl10-windows-network-utilization.png](/img/rl10-windows-network-utilization.png)
 
 The above discussion illustrates that the CPU, Memory and Network I/O footprint of RightLink 10.6 on a Windows server is negligible, regardless if the system is quiescent or is under load due to a RightLink-initiated action.
