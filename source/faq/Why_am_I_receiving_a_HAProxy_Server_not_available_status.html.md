---
title: Why am I receiving a "HAProxy Server not available" status?
category: general
description: If you want HAProxy to perform health checks on your web site, remember to include the health-check file in your application bundle.
---

## Background Information

You receive a "server not available" status message for your HAProxy server even though it is running and operational.

* * *

## Answer

**Warning**: If you want HAProxy to perform health checks on your web site, remember to include the health-check file in your application bundle. If you do not do this, you will receive errors similar to the following in your log file: &nbsp;

~~~
"GET /health_check.jsp HTTP/1.0" 404 1003 "-" "-"
~~~

For more information on this, please see the [Health Check Page](http://support.rightscale.com/12-Guides/Lifecycle_Management/Deployment_Management/Perform_a_Health_Check_Test).

When this is configured correctly, your HTTP access logs should report output similar to:

~~~
"GET /health_check.jsp HTTP/1.0" 200 338 "-" "-"
~~~
