---
title: What does "Filter chain halted..." mean in my logs?
category: general
description: This article describes the meaning of a "Filter chain halted..." log entry you may encounter.
---

## Background Information

A sample log entry with a message containing the "filter chain halted..." message is:

~~~
Processing HomeController#server-status (for 127.0.0.1 at 2008-01-23 02:45:12) [GET]
  Session ID: e7e5b4552107447afd2ada002040ac65
  Parameters: {"action"=>"server-status", "controller"=>"home", "auto"=>nil}
Redirected to http://localhost/curtain/intro
Filter chain halted as
[#<ActionController::Filters::ClassMethods::SymbolFilter:0xb6e7ff84
@filter=:curtain_authorize>] returned false.
Completed in 0.00076 (1309 reqs/sec) | DB: 0.00000 (0%) | 302 Found [http://localhost/server-status?auto]
~~~

* * *

## Answer

These requests are not from the load balancer, but from the monitoring tool that tries to get status information about Apache so you can view it in the Monitoring tab of the instance in your Dashboard. If these requests are getting all the way to Rails, it means that the Apache handler for server status is not correctly configured (i.e. these requests should be directly answered by Apache, rather than forwarded to Rails). Since RightScale ServerTemplates automatically configure this by default, an error would be caused by a user misconfiguration. In a nutshell, you have to make sure that `ExtendedStatus` is "ON" and that you have the `/server-status` url enabled and handled by Apache's server-status handler. For example, you could put this snippet into `/etc/httpd/conf.d/status.conf`:

~~~
ExtendedStatus On <location server-status=""> </location>
<location server-status="">SetHandler server-status </location>
<location server-status="">Order deny,allow </location>
<location server-status="">Deny from all </location>
<location server-status="">Allow from localhost </location>
~~~

and then restart apache:  `service httpd graceful`
