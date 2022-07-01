---
title: How can I stop a RightScript that is stuck in Scheduling execution?
category: general
description: It's important to remember that RightLink executes jobs one after the other so if the current job is stuck, RightLink will not proceed to the next job until the current (running) process exits successfully.
---

## Overview

A RightScript failed (or hung) for some reason and did not exit properly.  As a result, the failed script is preventing the execution of any other scripts such as remaining scripts in a boot/decommission sequence or manually executed/scheduled operational scripts.

## Resolution

It's important to remember that RightLink executes jobs one after the other so if the current job is stuck, RightLink will not proceed to the next job until the current (running) process exits successfully. However, you can cancel or stop a stuck job by grepping for "cook" in the running processes and manually killing the task.

In this example, we have the `cook_runner.rb` running but we need to cancel it by killing the task by specifying its process id ( **20699** ).

~~~
root@ip-10-128-81-107:~# ps aux | grep cook
root 20699 0.0 0.3 10088 6584 ? R 09:46 0:00 /opt/rightscale/sandbox/bin/ruby /opt/rightscale/right_link/scripts/lib/cook_runner.rb
~~~
~~~
root@ip-10-128-81-107:~# kill -9 20699
~~~

If you check again, the process id should not exist anymore.

**Note**: RightLink may have to spawn a new `cook_runner.rb` for some schedule jobs so it's fine if you see the same process name again.
