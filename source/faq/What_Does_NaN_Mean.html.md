---
title: What does NaN mean?
category: general
description: NaN indicates that the monitoring system is not receiving any numeric data. There can be several causes for receiving a NaN.
---

## Background Information

What does NaN mean?

~~~
cpu-0/cpu-idle.value is 'nan', this is == 'NaN' for over 60.00 minute(s)
on server 'X' of deployment 'Y'
~~~

* * *

## Answer

NaN is short for <u>N</u>ot <u>a</u> <u>N</u>umber. NaN indicates that the monitoring system is not receiving any numeric data. There can be several causes for receiving a NaN:

1. The collectd service has stopped running.
2. The Server has crashed due to an application failure.
3. The instance has been corrupted due to a hardware failure from Amazon.

The following debug steps are recommended:

1. Try to SSH into the Server. If you cannot SSH into the instance, make sure that your security group has port 22 open (try to telnet to port 22 to see if the port is open/listening).
2. If you can SSH into the Server then run the following command: service collectd restart
3. A reboot can be instigated with the Reboot button in the dashboard or the reboot command via SSH
4. If you cannot SSH into the Server and TCP&nbsp;port 22 is sufficiently open in a security group used by the instance, consider relaunching the Server as the instance may have a physically failed ( check [http://status.aws.amazon.com/](http://status.aws.amazon.com/) ). Ensure any volatile data is moved/backup-up prior to relaunch
