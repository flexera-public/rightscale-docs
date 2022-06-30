---
title: Arrays
layout: cm_layout
alias: cm/dashboard/manage/arrays/arrays.html
description: A Server Array in RightScale consists of mostly identical EC2 instances where the number of instances varies over time in response to changing factors.
---

## Overview

A Server Array consists of mostly identical EC2 instances where the number of instances varies over time in response to changing factors. For example, the number of instances can go up based on high CPU usage, or go back down with low CPU usage. A series of alert specifications and escalations are used to define the conditions under which the server array will change, such as launching or terminating servers.

There are two types of server arrays:

* **Alert-based** - These arrays are driven by user-defined alert specifications and escalations. When certain predefined conditions are met (ex: cpu usage > 80%), it triggers an alert escalation that performs a specified action (ex: grow the array) on the server array. An alert-based server array for a web application is commonly used for autoscaling, where additional application servers are launched and added to the server array to compensate for a sudden increase in server requests.
* **Queue-based** - (These are EC2-only) These arrays are driven by queues and worker daemons. Queue-based arrays are commonly used for back-end batch processing tasks where the number of "worker" instances in an array will vary depending on the jobs in the input queue.

Select the **New** action button to create a new Server Array.

## Further Reading

* [Arrays - Concepts](/cm/dashboard/manage/arrays/arrays_concepts.html)
* [Arrays - Actions](/cm/dashboard/manage/arrays/arrays_actions.html)
* [How do I setup autoscaling using Alert Escalations?](http://support.rightscale.com/03-Tutorials/02-AWS/02-Website_Edition/How_do_I_set_up_Autoscaling%3F/index.html)
* [How do I setup autoscaling using Cloud Workflow?](/cm/dashboard/manage/arrays/arrays_cwf.html)