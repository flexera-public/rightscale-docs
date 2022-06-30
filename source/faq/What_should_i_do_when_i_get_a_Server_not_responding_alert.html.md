---
title: What should I do when I get a Server not responding alert?
category: general
---

## Overview

There are some situations in which a Server could trigger an `Instance not responding` alert similar to the example shown below.

~~~
To: MyServer@alert.com
Subject: Server Alert: critical 'MyTestServer' Instance not responding
Message: This is an auto-generated RightScale alert.  This message will be repeated every 10 minutes while the condition persists.  You may customize this message or add additional actions by logging in at http://www.rightscale.com and navigating to Design -> Alert -> Escalations and selecting the 'critical' escalation.
~~~

## Answer

If you encounter such an alert, execute the steps below.

1. Check to confirm if the Server is indeed not responding.
2. If the Server is up, then it could be two things.
  * There could be a network issue from the Cloud Provider side.
  * Or there is a monitoring backend issue at RightScale side. Multiple alerts may trigger in this scenario. Rarely happens.
3. If either of the above is true, then you can wait for a few moments and restart the collectd service.
   * For Linux - `service collectd restart`
   * For Windows - Restart the Rightlink Service at the Services Console.
4. If the Server is not accessible, then the Server may be in a hang state due to overloading or there may be a problem with the Cloud Provider.
  * You may check the monitoring metrics for a clue for Server overloading; like CPU or Memory spike. If you see one, then it is likely the culprit.
  * If monitoring metrics is clean, then it is likely an issue with the Cloud Provider and the Server will restart after a period of time. You can file a ticket to the Cloud Provider to inquire what may have happened.

If the alert persists after following the steps above, then you can file a report with [RightScale Technical Support](mailto:support@rightscale.com).
