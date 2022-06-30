---
title: How do the CPU metrics work and what is CPU Steal?
category: general
description: CPU Metrics can be viewed in the Monitoring tab of the RightScale Cloud Management Dashboard.
---

## Background Information

CPU Metrics can be viewed in the Monitoring tab of the RightScale Dashboard.

* * *

## Answer

The cpu metrics are a combination of many CPU values and the "total" of those will add up to 100%.

| Item | Description |
| ---- | ----------- |
| user | CPU used by user applications |
| nice | CPU used to allocate multiple processes demanding more cycles than the CPU can provide |
| system | CPU used by the operating system itself |
| interrupt | CPU allocated to hardware interrupts |
| softirq | CPU servicing soft interrupts |
| wait | CPU waiting for disk IO operations to complete |
| steal\* | Xen hypervisor allocating cycles to other tasks |
| idle | CPU not doing any work |

\*Steal time is the time that the CPU had something runnable, but the XEN hypervisor chose to run something else instead.

Generally it is never possible for user processes to consume ALL of the CPU because as its load increases so does the load from other types of CPU usage listed above. How a particular server uses its CPU depends on a number of factors but in general the real metric we use to determine CPU usage is the idle time.&nbsp;&nbsp;This is the metric that alerts are based from. The idle value is the amount of CPU left not doing any work. If CPU has no idle time it is 100% in use - how that is allocated depends on the server architecture and the application. In some cases it might be all User, System, and Steal. If it is doing a massive database backup it might all be in wait. It just depends.
